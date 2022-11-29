<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="tea.entity.Http"%>
<%
	Http h = new Http(request, response);
	int nodeInt = h.getInt("node");
	int lh = h.language;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	</head>

	<body>
		<form action="FileUpLoad.do?node=<%=nodeInt %>&lh=<%=lh %>" method="post" enctype="multipart/form-data">
			选择文件:
			<input type="file" name="upfile" />
			<br>
			<input type="submit" value="上传" />
			<input type="reset" value='取消' />
		</form>
	</body>
</html>
