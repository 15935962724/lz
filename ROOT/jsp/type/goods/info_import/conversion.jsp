<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/card.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<script>
	function ls(){
	//form1.jieguo.value =form1.l.value ;
	var L = form1.l.value;

	form1.jieguo.value = L*1000;

	}
</script>
<body>
<h1>重量换算信息<h1>
<div id="head6"><img height="6" alt=""></div>
<form name ="form1">
	<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
		<tr>
			<td>L换算:<input type="text" name="l" onpropertychange="ls();"></td>
			<td>KG换算<input type="text" name="kg"></td>
			<td>换算结果<input type="text" name="jieguo"></td>
		</tr>
	</table>
</form>
</body>

</html>
