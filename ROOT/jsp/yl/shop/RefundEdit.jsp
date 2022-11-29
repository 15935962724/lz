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

int trade=h.getInt("trade");
String nexturl = h.get("nexturl");
%>
<body>
<style>
td{padding:5px 0px;}
</style>
<form action="/Refunds.do" method="post" target="_ajax" name="form2">
	<table cellspacing="0" cellpadding="0" border="0" width="90%" style="margin:0 auto;">
		<tr>
			<td align="left" style="font-size:14px;">退款原因：</td>
            </tr>
            <tr>
			<td>
				<textarea style="width:100%;height:100px;" name="rcont"></textarea>
				<input type="hidden" name="tstate" value="1" />
				<input type="hidden" name="act" value="tstate" />
				<input type="hidden" name="trade" value="<%= trade %>" />
				<input type="hidden" name="nexturl" value="<%= nexturl %>"  />
			</td>
		</tr>
		<tr>
			<td align="center"><input type="submit" value="提交" /></td>
		</tr>
	</table>
</form>
</body>
</html>