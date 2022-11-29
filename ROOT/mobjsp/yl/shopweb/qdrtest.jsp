<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%
Http h=new Http(request,response);
h.setCook("openid", "olZbajlNccs4yNbxzkuPyJ0cV7Is", -1);
String openid=h.getCook("openid",null);
	
%>
<body>
<h1>test<%= "=="+openid %></h1>
</body>
</html>