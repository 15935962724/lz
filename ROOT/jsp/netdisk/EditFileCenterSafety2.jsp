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

int filecentersafety=0;
String base=request.getParameter("base");
int filecenter=Integer.parseInt(request.getParameter("filecenter"));
FileCenter obj=FileCenter.find(filecenter);
String role="/",unit="/",member="/";
if(obj.isExtend())
{
  Enumeration e=FileCenterSafety.findByFileCenter(filecenter," AND purview=1");
  while(e.hasMoreElements())
  {
    FileCenterSafety s=FileCenterSafety.find(((Integer)e.nextElement()).intValue());
    member+=s.getMember().substring(1);
    role+=s.getRole().substring(1);
    unit+=s.getUnit().substring(1);
  }
}else
{
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery("SELECT filecentersafety FROM FileCenterSafety WHERE filecenter="+filecenter+" AND purview=1");
    if(db.next())
    {
      filecentersafety=db.getInt(1);
    }
  }finally
  {
    db.close();
  }
  if(filecentersafety>0)
  {
    FileCenterSafety s=FileCenterSafety.find(filecentersafety);
    member=s.getMember();
    role=s.getRole();
    unit=s.getUnit();
  }
}

member=member.substring(1).replaceAll("/","; ");

ArrayList al=new ArrayList();//过虑重复

%><HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script>
function f_load()
{
  form1.role1.focus();
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
</HEAD>
<body onLoad="f_load()">

<h1><%=r.getString(teasession._nLanguage, "编辑权限")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=obj.getAncestor(-1)%></td>
  </tr>
</table>

<form name="form1" action="/servlet/EditFileCenter" method="POST" onsubmit="return f_submit(this);">
<input type="hidden" name="filecenter" value="<%=filecenter%>">
<input type="hidden" name="filecentersafety" value="<%=filecentersafety%>">
<input type="hidden" name="base" value="<%=base%>"/>
<input type="hidden" name="act" value="safety">
<input type="hidden" name="role" value="/">
<input type="hidden" name="unit" value="/">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>角色</td>
<td>
<table>
  <tr><td>
    <select name="role1" size="8" style="width:150px" multiple ondblclick="move(form1.role1,form1.role2,true)">
    <%
    String rs[]=role.split("/");
    for(int i=1;i<rs.length;i++)
    {
      if(al.indexOf(rs[i])==-1)
      {
        AdminRole ar=AdminRole.find(Integer.parseInt(rs[i]));
        if(ar.isExists())
        {
          out.print("<option value="+rs[i]+">"+ar.getName());
        }
        al.add(rs[i]);
      }
    }
    %>
    </select></td>
    <td><input type="button" value="←" onclick="move(form1.role2,form1.role1,true)"><br><input type="button" value="→" onclick="move(form1.role1,form1.role2,true)"></td>
      <td><select name="role2" size="8" style="width:150px"  multiple ondblclick="move(form1.role2,form1.role1,true)">
      <%
      Enumeration e=AdminRole.findByCommunity(teasession._strCommunity,teasession._nStatus);
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
<td>部门</td>
<td>
<table>
<tr><td>
  <select name="unit1" size="8" style="width:150px" multiple ondblclick="move(form1.unit1,form1.unit2,true)">
  <%
  al.clear();
  String us[]=unit.split("/");
  for(int i=1;i<us.length;i++)
  {
    if(al.indexOf(us[i])==-1)
    {
      AdminUnit au=AdminUnit.find(Integer.parseInt(us[i]));
      if(au.isExists())
      {
        out.print("<option value="+us[i]+">"+au.getName());
      }
      al.add(us[i]);
    }
  }
  %>
  </select></td>
<td><input type="button" value="←" onclick="move(form1.unit2,form1.unit1,false)"><br><input type="button" value="→" onclick="move(form1.unit1,form1.unit2,true)"></td>
<td><select name="unit2" size="8" style="width:150px" multiple ondblclick="move(form1.unit2,form1.unit1,false)">
<%
e=AdminUnit.findByCommunity(teasession._strCommunity,"");
while(e.hasMoreElements())
{
  AdminUnit ar=(AdminUnit)e.nextElement();
  int id=ar.getId();
  //if(unit.indexOf("/"+id+"/")==-1)
  {
    out.print("<option value="+id+">"+ar.getPrefix()+ar.getName());
  }
}
%>
  </select>
  </table>
</td>
</tr>
<tr>
  <td>会员</td>
  <td><input name="member" type="text" size="40" value="<%=member%>" readonly>
    <input type="button" value="添加" onclick="window.open('/jsp/user/list/SelMembers.jsp?input=form1.member','','width=600,height=500,scrollbars=1');">
    <input type="button" value="清空" onclick="form1.member.value='';">
  </td>
</tr>
</table>
<input type="submit" value="提交">
<input type="button" value="返回" onClick="window.open('/jsp/netdisk/FileCenters.jsp?community=<%=teasession._strCommunity%>&base=<%=base%>&filecenter=<%=obj.getFather()%>','_self');">
</form>

</body>
</html>
