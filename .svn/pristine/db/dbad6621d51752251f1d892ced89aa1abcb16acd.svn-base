<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8");


Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
if(h.isIllegal())
{
  response.sendError(404,request.getRequestURI());
  return;
}

String nexturl=h.get("nexturl");


String key=h.get("role");
AdminRole r=AdminRole.find(Integer.parseInt(MT.dec(key)));


%>
<html>
<head>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
select{width:140px;}
</style>
</head>
<body>
<h1>授权管理 ( <%=r.name%> )</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="/Roles.do" target="_ajax" onsubmit="this.consign.value=mt.value(this.role1,'|');">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="setconsign">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="role" value="<%=key%>">
<input type="hidden" name="consign" value="<%=r.consign%>">

<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr align="center">
    <td>选定角色</td>
    <td>&nbsp;</td>
    <td>备选角色</td>
  </tr>
  <tr>
    <td>
    <select name="role1" size="12" multiple ondblclick="mt.move(form1.role1,form1.role2,true);">
    <%
    String rs[]=r.consign.split("[|]");
    for(int i=1;i<rs.length;i++)
    {
      AdminRole r2=AdminRole.find(Integer.parseInt(rs[i]));
      out.print("<option value="+r2.id+" >"+r2.name);
    }
    %>
  </select>
  </td>
  <td>
  <input type="button" value=" ← " onClick="mt.move(form1.role2,form1.role1,true);" >
  <br>
  <input type="button" value=" → "  onClick="mt.move(form1.role1,form1.role2,true);">    </td>
  <td>
  <select name="role2" ondblclick="mt.move(form1.role2,form1.role1,true);" multiple size="12">
  <%
  StringBuffer sql = new StringBuffer(" AND community="+DbAdapter.cite(h.community));
  AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);
  String roles[]=aur.getRole().split("/");
  if(!roles[1].equals("14100022")){//14100022超级管理员,14111318系统管理员
  	sql.append(" AND id!=14100022 AND id!=14111318");
  }
  Iterator it=AdminRole.find(sql.toString(),0,200).iterator();
  while(it.hasNext())
  {
    AdminRole r2=(AdminRole)it.next();
    if(r2.type==3||r.consign.contains("|"+r2.id+"|"))continue;
    out.print("<option value="+r2.id+" >"+MT.f(r2.name));
  }%>
  </select>
  </td>
  </tr>
</table>

<input type="submit" value="提交">
<input type="button" value="返回" onclick="history.back();">
</form>


</body>
</html>
