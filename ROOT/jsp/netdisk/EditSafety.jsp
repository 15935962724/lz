<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/NetDisk");

int safety=Integer.parseInt(request.getParameter("safety"));
int style=2,purview=3;
String role="/",unit="/",member="";
if(safety>0)
{
  Safety obj=Safety.find(safety);
  style=obj.getStyle();
  purview=obj.getPurview();
  role=obj.getRole();
  unit=obj.getUnit();
  member=obj.getMember();
  member=member.replaceAll("/","; ");
  if(member.startsWith("; "))
  member=member.substring(2);
}

String path=request.getParameter("path");
NetDisk obj=NetDisk.find(teasession._strCommunity,path);



%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
function f_load()
{
  form1.role1.focus();
}
function f_pur(obj)
{
  var v=1;
  if(obj.value==3&&obj.checked)
  {
    form1.p[1].checked=true;
    v=3;
  }else if(obj.value==2&&!obj.checked)
  {
    form1.p[2].checked=false;
    v=1;
  }else
  {
    v=2;
  }
  form1.purview.value=v;
}
function f_submit(form1)
{
  var v="/";
  var op=form1.role1.options;
  for(var i=0;i<op.length;i++)
  {
    v=v+op[i].value+"/";
  }
  form1.role.value=v;

  v="/";
  op=form1.unit1.options;
  for(var i=0;i<op.length;i++)
  {
    v=v+op[i].value+"/";
  }
  form1.unit.value=v;
}
</script>
</head>
<body onLoad="f_load()">

<h1><%=r.getString(teasession._nLanguage, "????????????")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/servlet/EditSafety" onsubmit="return f_submit(this);">
<input type="hidden" name="path" value="<%=path%>">
<input type="hidden" name="safety" value="<%=safety%>">
<input type="hidden" name="act" value="edit">
<input type="hidden" name="role" value="/">
<input type="hidden" name="unit" value="/">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>??????</td>
    <td>
    <%
      for(int i=0;i<Safety.PUR_TYPE.length;i++)
      {
        out.print("<input type=radio name=purview value="+i);
        if(i==purview)
        out.print(" checked ");
        out.print(">"+Safety.PUR_TYPE[i]);
      }
      %>
    </td>
  </tr>
  <tr>
    <td>?????????</td>
    <td>
      <%
      for(int i=0;i<Safety.APPLY_STYLE.length;i++)
      {
        out.print("<input type=radio name=style value="+i);
        if(i==style)
        out.print(" checked ");
        out.print(">"+Safety.APPLY_STYLE[i]);
      }
      %>
    </td>
  </tr>
<tr>
<td>??????</td>
<td>
<table>
  <tr><td>
    <select name="role1" size="8" style="width:150px"  multiple ondblclick="move(form1.role1,form1.role2,true)">
    <%
    String rs[]=role.split("/");
    for(int i=1;i<rs.length;i++)
    {
      AdminRole ar=AdminRole.find(Integer.parseInt(rs[i]));
      if(ar.isExists())
      out.print("<option value="+rs[i]+">"+ar.getName());
    }
    %>
    </select></td>
    <td><input type="button" value="???" onclick="move(form1.role2,form1.role1,true)"><br><input type="button" value="???" onclick="move(form1.role1,form1.role2,true)"></td>
      <td><select name="role2" size="8" style="width:150px"  multiple ondblclick="move(form1.role2,form1.role1,true)">
      <%
      Enumeration e=AdminRole.find1ByCommunity(teasession._strCommunity,teasession._nStatus);
      while(e.hasMoreElements())
      {
        int id=((Integer)e.nextElement()).intValue();
        if(role.indexOf("/"+id+"/")==-1)
        {
          AdminRole ar=AdminRole.find(id);
          out.print("<option value="+id+">"+ar.getName());
        }
      }
      %>
</select>
</table>
</td>
</tr>
<tr>
<td>??????</td>
<td>
<table>
<tr><td>
  <select name="unit1" size="8" style="width:150px" multiple ondblclick="move(form1.unit1,form1.unit2,true)">
  <%
  String us[]=unit.split("/");
  for(int i=1;i<us.length;i++)
  {
    AdminUnit au=AdminUnit.find(Integer.parseInt(us[i]));
    if(au.isExists())
    out.print("<option value="+us[i]+">"+au.getName());
  }
  %>
  </select></td>
<td><input type="button" value="???" onclick="move(form1.unit2,form1.unit1,true)"><br><input type="button" value="???" onclick="move(form1.unit1,form1.unit2,true)"></td>
<td><select name="unit2" size="8" style="width:150px" multiple ondblclick="move(form1.unit2,form1.unit1,true)">
<%
e=AdminUnit.findByCommunity(teasession._strCommunity,"");
while(e.hasMoreElements())
{
  AdminUnit ar=(AdminUnit)e.nextElement();
  int id=ar.getId();//obj.getId();
  if(unit.indexOf("/"+id+"/")==-1)
  {
    out.print("<option value="+id+">"+ar.getName());
  }
}
%>
  </select>
  </table>
</td>
</tr>
<tr>
  <td>??????</td>
  <td><input name="member" type="text" size="40" value="<%=member%>" readonly>
    <input type="button" value="??????" onclick="window.open('/jsp/user/list/SelMembers.jsp?input=form1.member','','width=600,height=500');">
    <input type="button" value="??????" onclick="form1.member.value='';">
  </td>
</tr>
</table>
<input type="submit" value="??????">
<input type="button" value="??????" onClick="history.back();">
</form>

</body>
</html>
