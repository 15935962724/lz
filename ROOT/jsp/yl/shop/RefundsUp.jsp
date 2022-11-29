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
<form action="/Refunds.do" method="post" target="_ajax" name="form2">
	<table>
		<tr>
			<td>通过审核：</td>
			<td>
			<input name="tstate" onclick="showtext(true);" value="2" checked="checked" type="radio" />是<input value="3" onclick="showtext(false);" name="tstate" type="radio" />否
			</td>
		</tr>
		<tr id="mytr" style="display: none;">
			<td>拒绝原因：</td>
			<td>
			<textarea name="rcont"></textarea>
				<input type="hidden" name="act" value="tstate" />
				<input type="hidden" name="trade" value="<%= trade %>" />
				<input type="hidden" name="nexturl" value="<%= nexturl %>"  />
			</td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="提交" /></td>
		</tr>
	</table>
</form>
</body>
</html>
<script>
	function showtext(flag){
		var mydiv = document.getElementById("mytr");
		if(flag){
			mydiv.style.display = "none";
		}else{
			mydiv.style.display = "block";
		}
	}
</script>