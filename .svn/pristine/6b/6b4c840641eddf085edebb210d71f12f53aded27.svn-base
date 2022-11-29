<%@page import="tea.entity.Http"%>
<%@page import="java.util.List"%>
<%@page import="tea.entity.yl.shop.*"%>
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
String nexturl=h.get("nexturl");
%>
<script src="/tea/mt.js" type="text/javascript"></script>
<body>
	<form  action="/Imgs.do" method="post" enctype="multipart/form-data" onsubmit="return mt.check(this)">
	<input type="hidden" value="<%= nexturl %>" name="nexturl" />
		<input type="hidden" name="act" value="showimg"/>
	<table>
		<tr>
			<td>链接：</td>
			<td><input name="shref" alt="链接"  /></td>
		</tr>	
		<tr>
			<td>图片：</td>
			<td><input type="file" name="file" alt="图片" /></td>
		</tr>	
		<tr>
			<td colspan="2"><input type="submit" value="提交" /></td>
		</tr>
	</table>
	请上传1200×354大小的图片
	</form>
</body>
</html>