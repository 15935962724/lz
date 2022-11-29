<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.yl.shop.*"%>
<%
	Http h = new Http(request, response);
	if (h.member < 1) {
		response.sendRedirect("/servlet/StartLogin?community="
				+ h.community);
		return;
	}
	String orderid=MT.dec(h.get("orderId"));
	ShopOrder so=ShopOrder.findByOrderId(orderid);
%><!doctype html>
<html>
<head>
<link href="/res/cssjs/base.css" rel="stylesheet" type="text/css" />
<link href="/res/cssjs/my.css" rel="stylesheet" type="text/css" />
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
	var ls = parent.document.getElementsByTagName("HEAD")[0];
	document.write(ls.innerHTML);
	var arr = parent.document.getElementsByTagName("LINK");
	for ( var i = 0; i < arr.length; i++) {
		document
				.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
	}
</script>
</head>
<style>
	.bio .oks{background:none;border:none;}
	.bio .bigtit{background: none;border:none;line-height: 28px;}
	.bio .account{background: rgba(242, 242, 242, 1);border-top:1px solid #FF7E00;padding:25px 0 25px 30px}
	.oks .cos{text-align: center;background: none;height:auto;margin-bottom:0;}
	.oks .cos strong{display: block;background: url(/tea/yl/img/u140.svg) 32% 5px no-repeat;font-size:18px;font-weight: normal;}
	.order-num{text-align: center;font-size:16px;margin-top:15px;color:#000;}
	.order-num span{color:#000;}
	.order-num span em{font-style:normal;color:#F90000;font-size:16px;}
	.cos .order-ts{font-size:14px;color:#A6A6A6;margin-top:10px;}
	.order-zh{margin-top:60px;}
	.bigtit{font-weight:normal;}
	.account li{line-height: 28px;}
	.account li span{display: inline-block;width:60px;text-align: right;margin-right:10px;}
</style>
<body>
	<!-- <ul class="Order_cart" id="Order_cart_S1">
	<li class="step1">1.我的购物车</li>
	<li class="step2">2.填写核对订单信息</li>
	<li class="step3">3.成功提交订单</li>
</ul> -->
	<div class="bio">
		<div class="oks">
			<div class='cos'>
				<strong>提交订单成功！</strong>
				<p class='order-num'>
					<span>订单号：<%=orderid %></span>
					<span style='margin-left:20px;'>订单金额：
						<em>&yen<%=MT.f((double)so.getAmount(),2) %></em>
				</span>
				</p>
<%--				<p class="order-ts">请您在提交订单后7天内完成支付，否则订单会自动取消！</p>--%>
			</div>
		</div>
		<div class="finishPay">
			<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
				<input type="hidden" name="act" value="orderPayment"/>
				<input type="hidden" name="orderId" value="<%=orderid%>"/>
				
				<!-- input type="submit" value="完成支付"/ -->
			</form>
		</div>
		<div class="order-zh">
			<p class="bigtit">请汇款至以下账户：</p>
			<ul class="account">
			<%
					out.print("<li><span>户     名：</span> 中国同辐股份有限公司</li>");
					out.print("<li><span>帐     号：</span> 0200003319245006611</li>");
					out.print("<li><span>开户行：</span> 工商行北京长安支行</li>");
			%>
				
			</ul>
		</div>
<script>
function f_sub(){
	var v=checkwebpaytype();
	if(!v){
		return;
	}
	if(v==1){
		form1.action="/jsp/yl/pay/alipay/index.jsp";
	}else if(v==2){
		form1.action="/jsp/yl/pay/99bill/index.jsp";
	}
	mt.show("/jsp/yl/shopweb/ShopShowTip.jsp",2,'',500,300);
	form1.submit();
}
function checkwebpaytype(){
	 var webpaytype = document.getElementsByName("webpaytype");
	 for(var i=0;i<webpaytype.length;i++){
	  if(webpaytype[i].checked==true){
		  value=webpaytype[i].value;
	      return value;
	  }
	 }
	 mt.show("请选择支付方式");
	 return false;
}
</script>
	</div>
	<script>
		mt.fit();
	</script>
</body>
</html>
