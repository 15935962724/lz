<%@page import="tea.entity.yl.shop.ShopCategory"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.axis.encoding.Base64"%>
<%@ page import="tea.entity.Filex" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta name="viewport" content="width=device-width,user-scalable=0">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
	<title>登录</title>
	<style>
	.seachr li{padding:14px 5px;}
	html,body,.lo-head{
		width: 100%;
		height:100%;
	}
	.lo-head{
		background:url(/tea/mobhtml/img/lo-bg.jpg) center no-repeat;
		background-size:cover;
		position: relative;
	}
	</style>
	<script src='/tea/jquery.min.js'></script>
	
</head>
<body>
<script type="text/javascript">
$.post("/LzLogins.do",{"act" : "sendmobile","mob" : "18810037469"},function (result) {
	alert("请求成功。" + result);
});
</script>
</body>
</html>