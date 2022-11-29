<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.node.*" %>
<%
	Http h=new Http(request);
	int id =h.getInt("goid");
	Mphoto mp=Mphoto.findPhoto(id);
	String src="";
	if(mp.getPath().length()>1){
		src=mp.getPath();
	}
%>
<html>
<head>
<title>图片详细信息</title>

<script src="/res/<%=h.community %>/cssjs/community.js" type="text/javascript" defer="defer"></script>
<link href="/res/<%=h.community %>/cssjs/community.css" type="text/css" rel="stylesheet">
</head>
<body>
<table cellpadding="0" cellspacing="0" id="tablecenter">
	<tr id="tableonetr">
		<td>作者：</td>
		<td><%=mp.getAuthor() %></td>
	</tr>
	<tr>
		<td>联系方式：</td>
		<td><%=mp.getPhone() %></td>
	</tr>
	<tr>
		<td>作品上传：</td>
		<td><img src="<%=src%>"  width="200" hight="200"/></td>
	</tr>
	<tr>
		<td>图片说明：</td>
		<td><%=mp.getIntroduce() %></td>
	</tr>
	<tr>
		<td>拍摄地点：</td>
		<td><%=mp.getPlace() %></td>
	</tr>
	<tr>
		<td>拍摄时间：</td>
		<td><%=mp.getTime() %></td>
	</tr>
	<tr>
		<td>拍摄参数：</td>
		<td></td>
	</tr>
</body>
</html>