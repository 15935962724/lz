<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page
	import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.yl.shop.*"%>
<%
	Http h = new Http(request, response);
	if(h.member<1){
		String param = request.getQueryString();
		String url = request.getRequestURI();
		if(param != null)
			url = url + "?" + param;
		response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
		return;
	}
	String orderid=MT.dec(h.get("orderId"));
	ShopOrder so=ShopOrder.findByOrderId(orderid);
	
	StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
	sql.append(" AND order_id="+DbAdapter.cite(orderid));
	List<ShopOrderData> sodList = ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE);
	ShopOrderData t = sodList.get(0);
	
%>
<!DOCTYPE html>
<html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

<link href="/res/cssjs/base.css" rel="stylesheet" type="text/css" />
<link href="/res/cssjs/my.css" rel="stylesheet" type="text/css" />
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">

<script src="/tea/mt.js" type="text/javascript"></script>
<title>订单提交成功</title>
<style>
body{background-color:#eee;}
.oks,.hk {
	padding: 17px 0 15px 10px;
	text-align:left;
	background-color:#fff;
	box-shadow:3px 3px 5px #ddd；
	color:#000;
}
.oks .cos {
	padding:15px;
	background-color:#eee;
	color:#16CA16;
}

.oks .cos p{text-align:let;}
.oks .coss{margin-bottom:0px;height:40px;line-height:40px;padding:0 15px;border-bottom:1px dashed #ddd;color:#000;}

.oks .cos strong {
	color: #FF7F27;
	font-size: 14px;
}
.oks{padding-top:0px;}
header{margin-bottom:0px;}
.bio p.p1 {
color: #888888;
padding:0 0 0 0;
text-align:center;
}
.cos p em{font-size:30px;color:#00A2E8;font-style:normal;font-weight:bold;}
.oks{color:#00A2E8;padding:0 0;}
.oks .cos strong{color:#16CA16;}
body{background-color:#fff;}
.button{    background: rgb(1, 162, 232);
    width: 130px;
    text-align: center;
    height: 40px;
    line-height: 40px;
    border-radius: 3px;
    border: none;
    margin: 0 auto;
	margin-top:15px;
	color:#fff;
}.button a{color:#fff;}
</style>
</head>
<header class="header"><!-- <a href="javascript:history.go(-1)"></a> -->订单提交成功</header>

<body>

	<div class="bio">
		<div class="oks">
            <div class='coss'>订单编号：<%=MT.f(orderid) %></div>
            <div class='coss'>下单时间：<%=MT.f(so.getCreateDate(),1) %></div>
            <div class='coss'>粒子活度：<%=t.getActivity() %></div>
            <div class='coss'>购买数量：<%=t.getQuantity() %></div>
            <div class='coss'>校准时间：<%=MT.f(t.getCalibrationDate()) %></div>
        </div>	
        <div class='button'><a href="/mobjsp/yl/shopweb/ShopProductBuy_wx.jsp?product=15010269">返回</a></div>
	</div>

</body>
</html>
