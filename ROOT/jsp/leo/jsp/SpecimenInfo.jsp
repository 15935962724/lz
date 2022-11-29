<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%>
<%

Http h=new Http(request,response);
int nodeid=h.getInt("nodeid");	//标本库id
Specimen specimen = Specimen.find(nodeid);

int menuid=h.getInt("id");	//标本库id

%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link href="/res/<%=h.community%>/cssjs/community.css"
			rel="stylesheet" type="text/css" />
		<script src="/tea/tea.js" type="text/javascript"></script>
		<script src="/tea/mt.js" type="text/javascript"></script>
		<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>

	</head>
	<body>
		<h1>
			标本库列表页
		</h1>
		<div id="head6">
			<img height="6" src="about:blank">
		</div>
		<h2>标本信息</h2>
		<br/>
	</body>
</html>
