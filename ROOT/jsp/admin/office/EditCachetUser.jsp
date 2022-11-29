<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.office.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String _strid=request.getParameter("id");

String nexturl=request.getRequestURI()+"?"+request.getQueryString();

String member=request.getParameter("member");

String role="/";
if(member!=null)
{
  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,member);
  role=aur.getCachet();
}

Resource r=new Resource();


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function f_edit(m)
{
  form1.member.value=m;

  form1.action='?';
  form1.submit();
}
function f_delete(m)
{
  if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>'))
  {
    form1.action=form1.action+"?member="+encodeURIComponent(m);
    form1.submit();
  }
}
function f_s()
{
  if(form1.role1.length==0)
  {
    alert('无效-权限');
    return false;
  }
  var r='/';
  for(var i=0;i<form1.role1.length;i++)
  {
    r=r+form1.role1.options[i].value+'/';
  }
  form1.role.value=r;
  return submitText(form1.member, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>');
}
function LoadWindow(obj)
{
  loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  loc_y=document.body.scrollTop+event.clientY-event.offsetY+210;
  window.showModalDialog("/jsp/sms/psmanagement/FrameGU.jsp?index="+obj+"&type=1&field=member",self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:400px;dialogHeight:320px;dialogTop:"+loc_y+"px;dialogLeft:"+loc_x+"px");
}
</script>
</head>
<body>

<h1>印章权限设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name="form1" action="/servlet/EditCachet" method="post">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="id" value="<%=_strid%>"/>
<input type="hidden" name="act" value="role"/>
<input type="hidden" name="role" value="/">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td nowrap >序号</td>
    <td	nowrap>用户名</td><td nowrap>姓名</td><td nowrap>部门</td><td nowrap>权限</td><td nowrap>操作</td>
  </tr>
<%
Enumeration e=AdminUsrRole.find(teasession._strCommunity," AND cachet!='/'",0,Integer.MAX_VALUE);
for(int j=1;e.hasMoreElements();j++)
{
  String m=(String)e.nextElement();
  AdminUsrRole aur=AdminUsrRole.find(teasession._strCommunity,m);
  Profile p=Profile.find(m);
  String cs[]=aur.getCachet().split("/");
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''><td>"+j);
  out.print("<td align=center>"+m);
  out.print("<td>"+p.getName(teasession._nLanguage));
  out.print("<td>&nbsp;");
  if(aur.getUnit()>0)
  {
    AdminUnit au=AdminUnit.find(aur.getUnit());
    if(au.isExists())
    {
      out.print(au.getName());
    }
  }
  out.print("<td align=center>&nbsp;");
  for(int i=1;i<cs.length;i++)
  {
    Cachet c=Cachet.find(Integer.parseInt(cs[i]));
    if(c.isExists())
    {
      out.print(c.getName()+" - "+c.getType()+"<br>");
    }
  }
  out.print("<td align=center><input type=button value="+r.getString(teasession._nLanguage,"CBEdit")+" onclick=f_edit('"+m+"')><input type=button value="+r.getString(teasession._nLanguage,"CBDelete")+" onclick=f_delete('"+m+"')>");
}
%>
</table>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>会员:</td>
    <td>
      <%
      if(member!=null)
      {
        out.print(member+"<input type=hidden name=member value="+member+">");
      }else
      {
        out.print("<select name='member'><option value=''>------------------");
        Enumeration e2=AdminUsrRole.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
        while(e2.hasMoreElements())
        {
          String m=(String)e2.nextElement();
          out.print("<option value="+m);
          if(m.equals(member))
          out.print(" selected");
          out.print(">"+m);
          out.print("</option>");
        }
        out.print("</select><input type=button value=... onClick=LoadWindow('form1.member','');>");
      }
      %></td>
  </tr>
  <tr>
    <td>权限:</td>
    <td>
    <table>
      <tr align="center">
        <td>选定</td>
        <td>&nbsp;</td>
        <td>备选</td>
      </tr>
      <tr>
        <td>
      <select name="role1" size="10" multiple style="WIDTH:350px;"  ondblclick="move(form1.role1,form1.role2,true);">
      <%
      String rs[]=role.split("/");
      for(int i=1;i<rs.length;i++)
      {
        int id=Integer.parseInt(rs[i]);
        Cachet c=Cachet.find(id);
        if(c.isExists())
        {
          out.print("<option value="+id+">"+c.getName()+" - "+c.getType());
        }
      }
      %>
      </select>
  </td>
  <td>
    <input type="button" value=" ← " onClick="move(form1.role2,form1.role1,true);" >
    <br>
    <input type="button" value=" → "  onClick="move(form1.role1,form1.role2,true);">
  </td>
  <td>
    <select name="role2" ondblclick="move(form1.role2,form1.role1,true);" multiple style="WIDTH:350px;" size="10">
      <%
      Enumeration e3=Cachet.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
      while(e3.hasMoreElements())
      {
        int id=((Integer)e3.nextElement()).intValue();
        if(role.indexOf("/"+id+"/")==-1)
        {
          Cachet c=Cachet.find(id);
          out.print("<option value="+id+">"+c.getName()+" - "+c.getType());
        }
      }
      %>
    </select>

      </td>
      </tr>
    </table>
   </td></tr>
  </table>

<input type="submit" onClick="return f_s()" value="添加或修改">


</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
