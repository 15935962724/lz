<%@page import="tea.entity.Attch"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<%
boolean ispass = false;
String url = request.getParameter("url").trim();
String aid = request.getParameter("alt");
String realPath = this.getServletConfig().getServletContext().getRealPath("/").trim();
	try{
		File file = new File(realPath+url);  
	    if (file.isFile() && file.exists()) {  
	        ispass = file.delete();  
	    }
	    Attch.find(Integer.parseInt(aid)).delete();
	}catch(Exception e){
		out.print("");
		return;
	}
	if(ispass){
		out.print("ok");
	}else{
		out.print("");
	}
%>
</body>
</html>