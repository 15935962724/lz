<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">

<link href="/res/Home/cssjs/14113995L1.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<title></title>
</head>

<%
Http h=new Http(request,response);
	String orderid = h.get("orderid");
%>
<body>
	<header class="header"><a href="#"></a>取消订单原因</header>

<form name="form2" action="/ShopOrders.do" method="post" target="_ajax" onsubmit="return checkform()">
	<input type="hidden" name="orderId" value="<%= orderid%>"/>
	<input type="hidden" name="status" value="5"/>
	<input type="hidden" name="nexturl" value="/mobjsp/yl/shopweb/ShopOrders_wx.jsp?status=1" />
	<input type="hidden" name="act" value="status"/>
	<div class='radiusBox newlist'>
		<ul class='seachr'>
			<li class='bold'>取消订单原因</li>
			<li><textarea id="cancelReason" placeholder="取消订单原因" name="cancelReason" alt="取消订单原因" title="请填写取消订单原因..." ></textarea></li>
			<li class='subt'><button type="submit" />提交</button></li>
		</ul>
	</div>
</form>
<script type="text/javascript">
	function checkform(){
		var cancelReason = document.getElementById("cancelReason").value;
		if(cancelReason==""){
			alert("取消订单原因不能为空！");
			return false;
		}
		from2.submit();
	}
</script>
</body>
</html>
