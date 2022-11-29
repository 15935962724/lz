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
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,user-scalable=0">
	<title>提交成功</title>
</head>
<style>
	body{margin:0}
	.bio .oks{background:none;border:none;padding:0 4%;}
	.bio .bigtit{background: none;border:none;line-height: 28px;}
	.bio .account{background:#fef9ee;padding:25px 4%;}
	.oks .cos{text-align: center;background: none;height:auto;margin-bottom:0;}
	.oks .cos strong{display: block;background: url(/tea/yl/img/u140.svg) 32% 5px no-repeat;font-size:18px;font-weight: normal;}
	.order-num{text-align: center;font-size:16px;margin-top:15px;color:#000;}
	.order-num span{color:#000;}
	.order-num span em{font-style:normal;font-size:16px;}
	.cos .order-ts{font-size:14px;color:#A6A6A6;margin-top:10px;}
	.order-zh{margin-top:60px;}
	.bigtit{font-weight:normal;}
	.account li{line-height: 28px;list-style:none;color:#606060;}
	.account li .span1{display: inline-block;width:70px;text-align: right;}
	@media only screen and (max-width: 320px) {
		.account li .span1{}
		.account li .span1{width:64px;}
	}
</style>
<body>
	<!-- <ul class="Order_cart" id="Order_cart_S1">
	<li class="step1">1.我的购物车</li>
	<li class="step2">2.填写核对订单信息</li>
	<li class="step3">3.成功提交订单</li>
</ul> -->
	<div class="bio">
		<p style='text-align:center;margin-top:50px'><img src='/res/lizi/img/icon114.png' style='width:50px;'></p>
		<div class="oks">
			<div class='cos'>
				<p style='font-size:1.1rem;'>提交订单成功！</p>
				<p class='order-num' style='color:#6a6a6a;'>
					<span  style='color:#6a6a6a;'>订单号：<%=orderid %></span>
					<span style='margin-left:20px;color:#6a6a6a;'>订单金额：
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
		<div class="order-zh" style='border-top:1px solid #d2d2d2;padding:0 4%;'>
			<p class="bigtit">请汇款至以下账户：</p>
			<ul class="account">
			<%
				if(Config.getInt("tongfu")==so.getPuid()){
					out.print("<li><span class='span1'>户     名：</span> <span>中国同辐股份有限公司</span></li>");
					out.print("<li><span class='span1'>帐     号：</span> <span></span>0200003319245006611</li>");
					out.print("<li><span class='span1'>开户行：</span> <span>工商行北京长安支行</span></li>");
				}else if(Config.getInt("gaoke")==so.getPuid()){
					out.print("<li><span class='span1'>户     名：</span> <span>原子高科股份有限公司</span></li>");
					out.print("<li><span class='span1'>帐     号：</span><span>0200026609200003075</span> </li>");
					out.print("<li><span class='span1'>开户行：</span><span> 北京市工商行房山支行266分理处</span></li>");
					out.print("<li style='border-top:1px solid #d2d2d2;margin:10px 0'></li>");
					
					out.print("<li><span class='span1'>户     名：</span><span> 原子高科股份有限公司</span></li>");
					out.print("<li><span class='span1'>帐     号：</span><span> 01091448700120105029094</span></li>");
					out.print("<li><span class='span1'>开户行：</span> <span>北京银行中关村海淀园支行</span></li>");
				} if(Config.getInt("junan")==so.getPuid()){
					out.print("<li><span class='span1'>户     名：</span><span> 宁波君安药业科技有限公司</span></li>");
					out.print("<li><span class='span1'>帐     号：</span><span> 82210220101001890</span></li>");
					out.print("<li><span class='span1'>开户行：</span><span> 宁波银行马园支行</span></li>");
				}
			%>
				
			</ul>
		</div>
		<div>

	<p style='height:30px;margin-top:16px;text-align:center;'>
		<a href='/xhtml/folder/19053380-1.htm' style='color:#044694;text-decoration: none;'>返回首页</a>

	</p>
		
		<%--
		<form method=post action="/jsp/yl/pay/alipay/index.jsp" name="form1" target="_blank">
		<input type="hidden" name="orderid" value="<%=orderid%>">
			<div class='zhibox'>
				<%
					Payinstall payobj2 = Payinstall.findpay(2);
					Payinstall payobj3 = Payinstall.findpay(3);

					if (payobj3.getUsename() != null && payobj3.getUsetype() == 1) {
				%>
				<div class='zhifubtn'>
					<label><input type="radio" name="webpaytype" value="2" />&nbsp;&nbsp;&nbsp;<img
						src="/res/Home/structure/14110394.jpg" alt='快钱' /></label>
				</div>
				<%
					}
					//判断活动类型的支付
					if (payobj2.getUsename() != null && payobj2.getUsetype() == 1) {
						//支付宝
				%>
				<div class='zhifubtn'>
					<label><input type="radio" name="webpaytype" value="1" />&nbsp;&nbsp;&nbsp;<img
						src="/res/Home/structure/14110401.jpg" alt='支付宝' /></label>
				</div>
				<%
					}
				%>

			</div>
			<div style='height: 30px; clrar: both; overflow: hidden'></div>
			<div class="submtis">
				<input type="button" onclick="f_sub()" name="" value="下一步" />
			</div>
		</form>
		 --%>
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
