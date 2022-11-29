<%@page import="java.util.Date"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<%
Http h=new Http(request,response);
int hid = h.getInt("did");
ShopHospital hospital = ShopHospital.find(hid);
String nexturl = h.get("nexturl");
%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src='/tea/mt.js'></script>
<script src='/tea/city.js'></script>
<script src='/tea/jquery-1.3.1.min.js'></script>
<body>
	<div>
		<form action="/ShopHospitals.do" name="form2" method="post" target="_ajax" onSubmit="return mt.check(this)" >
			<table id="tablecenter" cellspacing="0" style="background:none;">
				<tr id="type1">
			    	<td>有效期：</td>
			    	<td><input name="expirationDate" readonly alt="有效期" value="<%=MT.f(hospital.getExpirationDate()) %>" onClick="mt.date(this,false,'<%=new Date() %>')" class="date"/></td>
			  	</tr>
			  	<tr>
			  		<td colspan="2"><input type="submit" value="提交" class="btn btn-primary"/></td>
			  	</tr>
			</table>
			<input name="id" type="hidden" value="<%= hid %>" />
			<input name="act" type="hidden" value="setExpirationDate" />
			<input name="nexturl" type="hidden" value="<%= nexturl %>" />
		</form>
	</div>
</body>
</html>