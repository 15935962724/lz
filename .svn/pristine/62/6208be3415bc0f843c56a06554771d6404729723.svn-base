<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.resource.Resource"%>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if("POST".equals(request.getMethod()))
{
  String old=request.getParameter("old");
  String ne=request.getParameter("new");
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeUpdate("UPDATE Node SET community="+DbAdapter.cite(ne)+" WHERE community="+DbAdapter.cite(old));
    db.executeUpdate("UPDATE AdminFunction SET community="+DbAdapter.cite(ne)+" WHERE community="+DbAdapter.cite(old));
    db.executeUpdate("UPDATE AdminUnit SET community="+DbAdapter.cite(ne)+" WHERE community="+DbAdapter.cite(old));
    db.executeUpdate("UPDATE AdminRole SET community="+DbAdapter.cite(ne)+" WHERE community="+DbAdapter.cite(old));
    db.executeUpdate("UPDATE AdminUsrRole SET community="+DbAdapter.cite(ne)+" WHERE community="+DbAdapter.cite(old));
  }finally
  {
    db.close();
  }
  return;
}

Resource r=new Resource();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "MoveNode")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form action="?" method="post">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>原名称</td>
    <td><input name="old" type="text"></td>
  </tr>
  <tr>
    <td>新名称</td>
    <td><input name="new" type="text"></td>
  </tr>
</table>
<input type="submit" value="提交">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
