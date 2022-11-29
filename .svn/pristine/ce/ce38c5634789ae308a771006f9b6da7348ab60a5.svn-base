<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<%
	Http h=new Http(request,response);
	int sid = h.getInt("sid");
	String nexturl = h.get("nexturl");
%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<body>
<form name="form2" action="/Products.do" method="post" target="_ajax" >
<input value="recommendedit" name="act" type="hidden" />
<input value="<%= sid%>" name="sid" type="hidden"/>
<input value="<%= nexturl%>" name="nexturl" type="hidden"/>
	<table id="tablecenter" cellspacing="0">
		<tr id="tableonetr">
			<td>显示数量</td>
			<td><input id="shownum" name="shownum" /></td>
		</tr>
		<tr >
			<td colspan="2"><input type="submit" value="提交" /></td>
		</tr>
	</table>
</form>
</body>
</html>