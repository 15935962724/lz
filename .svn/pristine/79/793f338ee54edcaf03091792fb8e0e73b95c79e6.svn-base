<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
/*if(h.member<1){
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}*/

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
String orderId = h.get("orderId");
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
sql.append(" AND order_id="+DbAdapter.cite(orderId));
par.append("&orderId="+orderId);

int sum=ShopOrderData.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

String nexturl = h.get("nexturl");
//上海管理员  14122306
//AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);

%>
<!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/res/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">

</head>
<body>
	<header class="header"><a href="javascript:history.go(-1)"></a>查看信息</header>

<!-- <h1>订单详细</h1>
 -->
<%
int status = so.getStatus();
String statusContent = "";
if(status==0)
	  statusContent = "待付款";
else if(status==1)
	  statusContent = "待发货";
else if(status==2||status==3)
	  statusContent = "待收货";
else if(status==4)
	  statusContent = "已完成";
else if(status==5)
	  statusContent = "取消订单";

ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());

float price = so.getAmount().floatValue();
if(so.isLzCategory()){
	Profile profile = Profile.find(so.getMember());
	ArrayList sodList = ShopOrderData.find(" AND order_id="+Database.cite(so.getOrderId()),0,Integer.MAX_VALUE);
	if(sodList.size()>0){
		ShopOrderData sorderdata = (ShopOrderData)sodList.get(0); //订单详细
		if(profile.qualification==1 && so.isLzCategory()){
			price=sorderdata.getAmount().floatValue();
		}
		if(profile.membertype==2){//医院代理商价格
			price=sorderdata.getAgent_amount();
		}
	}
}

%>
<div class='radiusBox newlist wSpan'>
	<ul id="tablecenter" >
	<li class="bold" data-resourelist="xinxi" data-slideup="up">订单信息 <!-- <cite data-button-open="展开" data-button-close="收起">展开</cite> --></li>
	<li><span>订单编号：</span><%=MT.f(so.getOrderId()) %></li>
	<li><span>下单时间：</span><%=MT.f(so.getCreateDate(),1) %></li>
	<!-- <div id="xinxi-wrapper"style="display:none"> -->
	<%
	if(sum<1){
	  out.print("<li>暂无记录!</li>");
	}else{
	  	Profile pf = Profile.find(so.getMember());
	  	//根据订单id查询订单详情信息
	  	List<ShopOrderData> sodList = ShopOrderData.find(sql.toString(),pos,Integer.MAX_VALUE);
		ShopOrderData t = sodList.get(0);
      	out.println("<li><span>粒子活度：</span>"+t.getActivity()+" X "+ t.getQuantity() +"</li>");
      	//out.println("<li><span>购买数量：</span>"+t.getQuantity()+"</li>");
      	out.println("<li><span>校准时间：</span>"+MT.f(t.getCalibrationDate())+"</li>");
      	
	}
	%>
	<%if(so.getStatus()==5){%>
	<li><span>取消原因：</span><%=MT.f(so.getCancelReason()) %></li>
	<%}%>
	<!-- </div> -->
	</ul>
	 <ul>
		<li class="bold" data-resourelist="beizhu" data-slideup="up">订单备注 </li>
	   
			<li style="color:red"><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></li>
	    
	</ul> 
	    
	<ul>
	    <li class="bold" data-resourelist="shouhuo" data-slideup="up">收货人信息<!--  <cite data-button-open="展开" data-button-close="收起">展开</cite> --></li>
		<li><span>收货人：</span><%=MT.f(sod.getA_consignees())%></li>
		<li><span>手机号：</span><%=MT.f(sod.getA_mobile())%> <%=MT.f(sod.getA_telphone())%></li>
	    <!-- <div id="shouhuo-wrapper" style="display:none"> -->
	    <li><span>医院：</span><%=MT.f(sod.getA_hospital())%></li>
	    <li><span>科室：</span><%=MT.f(sod.getA_department())%></li>
		<li><span>地址：</span><%=MT.f(sod.getA_address())%></li>
		<!-- </div> -->
	</ul>
	
	<%
	ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
	if(soe.time!=null){
	%>
	<ul>
	    <li class="bold" data-resourelist="fahuo" data-slideup="up">发货信息</li>
	    <li><span>运单号：</span><%=MT.f(soe.express_code)%></li>
	    <li><span>发货日期：</span><%=MT.f(soe.time)%></li>
	    
			<li><span>销售编号：</span><%=MT.f(soe.NO1)%></li>
			<li><span>生产批号：</span><%=MT.f(soe.NO2)%></li>
			<li><span>有效期：</span><%=MT.f(soe.vtime)%></li>
			<li><span>发件人：</span><%=MT.f(soe.person)%></li>
			<li><span>联系电话：</span><%=MT.f(soe.mobile)%></li>
		
	</ul>
	<%}%>
	
	<%-- <ul>
		<li class="bold" data-resourelist="beizhu" data-slideup="up">订单备注 <cite data-button-open="展开" data-button-close="收起">展开</cite></li>
	    <div id="beizhu-wrapper"style="display:none">
			<li><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></li>
	    </div>
	</ul> --%>
</div>

<script type="text/javascript">
	$(".radiusBox ul .bold").on("click", function () {
	    $list = $(this).attr("data-resourelist");
	    if ($(this).attr("data-slideup")) {
	        $(".radiusBox ul div#" + $list + "-wrapper").slideDown();
	        //$("span", this).css("background-image", "url(/furniture/icon-close-dark.png)");
	        $("cite", this).html($("cite", this).attr("data-button-close"));
	        $(this).removeAttr("data-slideup")
	    } else {
	        $(this).attr("data-slideup", "up");
	        $(".radiusBox ul div#" + $list + "-wrapper").slideUp();
	        //$("dfn", this).css("background-image", "url(" + $path + "furniture/icon-open-dark.png)");
	        $("cite", this).html($("cite", this).attr("data-button-open"))
	    }
	});
</script>

</body>
</html>
