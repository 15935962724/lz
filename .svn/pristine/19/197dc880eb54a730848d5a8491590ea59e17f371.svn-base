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
String names = teasession.getParameter("MANAGERS");
	Attemper.create(names,teasession._strCommunity,teasession._rv);
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

<div id=old style="display:none">
<h1>INFO</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>您的信息已成功提交</td></tr>
</TABLE>

<div id="head6"><img height="6" src="about:blank"></div>
</div>

<script>

if(parent.location!=self.location&&parent.showDialog)
	parent.showDialog("您的修改信息已成功提交","/jsp/admin/vehicle/attemper.jsp");
else
{
	old.style.display="";
	if("/jsp/admin/vehicle/attemper.jsp"!=null)
	{
		setTimeout('window.location.replace("/jsp/admin/vehicle/attemper.jsp");',2000);
	
	}
}
</script>

</body>




</html>



