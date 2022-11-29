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



<body topmargin="0" leftmargin="0" onload="view_menu1()">

<h1>车辆使用查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<frameset rows="80,*" frameborder="no" border="0" framespacing="0">
  <iframe id="vehicle_detail" width="715" height="45" src="/jsp/admin/vehicle/query/query.jsp" frameBorder="0" frameSpacing="0" scrolling="yes" align="center"></iframe>
  <frameset rows="80,*" frameborder="NO" border="0" framespacing="0" >
		<iframe name="function_fun" id="vehicle_detail"  width="715" height="400" src="/jsp/admin/vehicle/query/query1.jsp?us=0" frameBorder="0" frameSpacing="0" scrolling="yes" align="center"></iframe>
	</frameset>

</frameset>


</html>
	


