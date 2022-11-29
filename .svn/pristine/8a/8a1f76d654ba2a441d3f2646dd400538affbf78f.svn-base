<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %><%@page  import="java.util.*" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%

request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();

%>
<html>
<HEAD>
  <link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
  <link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css"/>
  <script src="/tea/tea.js" type="text/javascript"></script>

</HEAD>
<body id="bodyvl">
<h1>红丝带数据导出</h1>
<form name="form1" action="/servlet/EditVolunteer" method="POST" enctype="multipart/form-data">
<input type="hidden"  value="Volunteerleading"  name="act">
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">

  <tr><td>请勿轻易使用</td></tr>
  <tr><td><input value="导入"  type="submit" /></td></tr>
</table>
</form>
  </body>
</html>
