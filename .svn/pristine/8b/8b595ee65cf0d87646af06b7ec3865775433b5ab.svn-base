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

<h1>考勤数据管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br><br>
<%
	if(teasession.getParameter("d1")!=null)
	{
		out.print("<font color =red>所有上下班登记--删除成功!</font><br><br>");
	}
	if(teasession.getParameter("d2")!=null)
	{
		out.print("<font color =red>所有外出登记--删除成功!</font><br><br>");
	}
	if(teasession.getParameter("d3")!=null)
	{
		out.print("<font color =red>所有请假登记--删除成功!</font><br><br>");
	}
	if(teasession.getParameter("d4")!=null)
	{
		out.print("<font color =red>所有出差登记--删除成功!</font><br><br>");
	}
	if(teasession.getParameter("d5")!=null)
	{
		out.print("<font color =red>所有考勤记录--删除成功!</font><br><br>");
	}
	
 %>
<input  type ="button" name="newbulletin" value="删除所有上下班登记" onClick="if(confirm('确认要删除考勤记录么？这将不可恢复！'))location='/jsp/admin/manage/Disposal.jsp?delete1=delete1';"  ><br><br>
<input  type ="button" name="newbulletin" value="删除所有外出登记" onClick="if(confirm('确认要删除考勤记录么？这将不可恢复！'))location='/jsp/admin/manage/Disposal.jsp?delete2=delete2';"  ><br><br>
<input  type ="button" name="newbulletin" value="删除所有请假登记" onClick="if(confirm('确认要删除考勤记录么？这将不可恢复！'))location='/jsp/admin/manage/Disposal.jsp?delete3=delete3';"  ><br><br>
<input  type ="button" name="newbulletin" value="删除所有出差登记" onClick="if(confirm('确认要删除考勤记录么？这将不可恢复！'))location='/jsp/admin/manage/Disposal.jsp?delete4=delete4';"  ><br><br>
<input  type ="button" name="newbulletin" value="删除以上所有考勤记录" onClick="if(confirm('确认要删除考勤记录么？这将不可恢复！'))location='/jsp/admin/manage/Disposal.jsp?delete5=delete5';"  ><br><br>
<input type="button" value="返回上一页" onClick="location='/jsp/admin/manage/instruction.jsp';" >
</body>
</html>



