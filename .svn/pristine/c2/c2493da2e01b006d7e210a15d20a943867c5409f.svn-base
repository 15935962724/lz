<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>排班管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<input  type ="button" name="newbulletin" value="排班管理" onClick="location='/jsp/admin/manage/rankclass.jsp?community=<%=community %>';">

<h1>考勤数据管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<input  type ="button" name="newbulletin" value="考勤数据管理" onClick="location='/jsp/admin/manage/delete.jsp';"  >

<h1>设置ip限制个人考勤</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<input  type ="button" name="newbulletin" value="设置ip限制个人考勤" onClick="location='/jsp/admin/manage/SettingIp.jsp';"  >

</body>
</html>



