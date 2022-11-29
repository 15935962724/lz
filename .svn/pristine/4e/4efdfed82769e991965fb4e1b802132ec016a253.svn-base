<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %>
<%

Http h=new Http(request,response);
if(h.member<1){
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

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
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);

%><!DOCTYPE html><html><head>
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
	<li class="bold" data-resourelist="xinxi" data-slideup="up">订单信息 <cite data-button-open="展开" data-button-close="收起">展开</cite></li>
	<li><span>订单编号：</span><%=MT.f(so.getOrderId()) %></li>
	<li><span>下单时间：</span><%=MT.f(so.getCreateDate(),1) %></li>
	<div id="xinxi-wrapper"style="display:none">
	<%
        int tpflag = 0;
        String hdstr = "";
        String tmstr = "";
	if(sum<1){
	  out.print("<li>暂无记录!</li>");
	}else{
	  	Profile pf = Profile.find(so.getMember());
	  	//根据订单id查询订单详情信息
	  	List<ShopOrderData> sodList = ShopOrderData.find(sql.toString(),pos,Integer.MAX_VALUE);
		ShopOrderData t = sodList.get(0);
        if(t.getExpectedActivity()!=0){
            tpflag = 1;
        }
        hdstr = MT.f(t.getExpectedActivity());
        tmstr = MT.f(t.getExpectedDelivery());

      	out.println("<li><span>粒子活度：</span>"+t.getActivity()+" X "+ t.getQuantity() +"</li>");
      	//out.println("<li><span>购买数量：</span>"+t.getQuantity()+"</li>");
      	out.println("<li><span>校准时间：</span>"+MT.f(t.getCalibrationDate())+"</li>");

		int product_id=t.getProductId();
		ShopProduct sp = ShopProduct.find(product_id);
		ProcurementUnit pu = ProcurementUnit.find(sp.puid);

		out.print("<li><span>商品厂商：</span>"+MT.f(pu.getName())+"</li>");
      	//上海-允许看到价格
      	if(aur.getRole().indexOf("14122306") < 0){
			if(pf.getMembertype()==2){
				if(so.isLzCategory()){
			  		out.println("<li><span>开票价：</span><b> &yen;&nbsp;"+MT.f((double)t.getAgent_price(),2)+"</b></li>");
			 	}else{
			 		out.println("<li><span>开票价：</span> <b>&yen;&nbsp;"+MT.f((double)t.getUnit(),2)+"</b></li>");
			 	}
			}else{
				out.println("<li><span>开票价：</span> <b>&yen;&nbsp;"+MT.f((double)t.getUnit(),2)+" </b></li>");
			}
			out.println("<li><span>开票金额：</span><b>&yen&nbsp;"+MT.f(price,2)+"</b></li>");
      	}
	}
	%>
	<%if(so.getStatus()==5){%>
	<li><span>取消原因：</span><%=MT.f(so.getCancelReason()) %></li>
	<%}%>
	</div>
	</ul>
	  
	    
	<ul>
	    <li class="bold" data-resourelist="shouhuo" data-slideup="up">收货人信息 <cite data-button-open="展开" data-button-close="收起">展开</cite></li>
		<li><span>收货人：</span><%=MT.f(sod.getA_consignees())%></li>
		<li><span>手机号：</span><%=MT.f(sod.getA_mobile())%> <%=MT.f(sod.getA_telphone())%></li>
	    <div id="shouhuo-wrapper" style="display:none">
	    <li><span>医院：</span><%=MT.f(sod.getA_hospital())%></li>
	    <li><span>科室：</span><%=MT.f(sod.getA_department())%></li>
		<li><span>地址：</span><%=MT.f(sod.getA_address())%></li>
		</div>
	</ul>
	<%
	ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
	if(soe.time!=null){
	%>
	<ul>
	    <li class="bold" data-resourelist="fahuo" data-slideup="up">发货信息 <cite data-button-open="展开" data-button-close="收起">展开</cite></li>
	    <li><span>运单号：</span><%=MT.f(soe.express_code)%></li>
	    <li><span>发货日期：</span><%=MT.f(soe.time)%></li>
	    <div id="fahuo-wrapper"style="display:none">
			<li><span>销售编号：</span><%=MT.f(soe.NO1)%></li>
			<li><span>生产批号：</span><%=MT.f(soe.NO2)%></li>
			<li><span>有效期：</span><%=MT.f(soe.vtime)%></li>
			<li><span>发件人：</span><%=MT.f(soe.person)%></li>
			<li><span>联系电话：</span><%=MT.f(soe.mobile)%></li>
			<%
				if(MT.f(soe.express_img).length()>0){

					String imgsr = "";
					if(MT.f(soe.express_img).length()>0){
						String[] imgarr=soe.express_img.split(",");
						for(int i=0;i<imgarr.length;i++){
							Attch attch=Attch.find(Integer.parseInt(imgarr[i]));
							imgsr=attch.path;
						}
					}

					out.print("<li><span>快递图片：</span><a href='#'><img src='"+imgsr+"' width='300px' height='300px' ></a></li>");
				}
			%>
		</div>
	</ul>
	<%}
	if(aur.getRole().indexOf("14122306") < 0){ %>
	<ul>
		<li class="bold" data-resourelist="fapiao" data-slideup="up">发票信息 <cite data-button-open="展开" data-button-close="收起">展开</cite></li>
	   	<li><span>快递单号：</span><%=MT.f(sod.getN_expressNo())%></li>
	   	<li><span>发票接收人：</span><%=MT.f(sod.getN_consignees())%></li>
		<div id="fapiao-wrapper"style="display:none">
		<%
		if(so.getInvoiceStatus()==3){
			ShopOrderExpress seo=ShopOrderExpress.findByOrderId(orderId);
		%>
		<li><span>开票状态：</span>已开具</li>
		<li><span>开票金额：</span><%= price%></li>
		<li><span>发票单号：</span><%=MT.f(sod.getN_invoiceNo())%></li>
		<%
		}else{
		%>
		<li><span>开票状态：</span>未开具</li>
		<li><span>开票金额：</span></li>
		<%
		}
		%>
		<li><span>开票单位：</span><%=MT.f(sod.getN_company())%></li>
		<li><span>联系电话：</span><%=MT.f(sod.getN_telphone())%></li>
		<li><span>地址：</span><%=MT.f(sod.getN_address())%></li>
		</div>
	</ul>
	<%} %>
	
	<ul>
		<li class="bold" data-resourelist="beizhu" data-slideup="up">订单备注 <cite data-button-open="展开" data-button-close="收起">展开</cite></li>
	    <div id="beizhu-wrapper"style="display:none">
			<li><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></li>
	    </div>
	</ul>

    <%
        int mypuid = ShopOrderData.findPuid(so.getOrderId());

        if(Config.getInt("junan")==mypuid){

    %>
    <ul>
        <li class="bold" data-resourelist="fahuo" data-slideup="up">调配信息</li>
        <li><span>是否已调配：</span><%= (tpflag==0?"否":"是") %></li>
            <%
	if(tpflag==1){
		%>
        <li><span>校准时间：</span><%= tmstr %></li>
        <li><span>粒子活度：</span><%= hdstr %></li>
            <%
	}
	%>
    </ul>
            <%
                List<StockOperation> solist = StockOperation.find(" AND oid = "+so.getId()+" AND type = 5 AND isRetreat = 0 ",0, Integer.MAX_VALUE);
            %>
    <ul>
		<li class="bold" data-resourelist="fahuo" data-slideup="up" style="border-bottom: solid 1px #ddd;">库存信息</li>
		<div style="padding:0 10px">
			<table id="tablecenter" cellspacing="0" class="mob-table">
				<tr id="tableonetr">
					<th width="10%">序号</th>
					<th >购买活度</th>
					<th>质检号</th>
					<th>批号</th>
					<th>购买数量</th>
					<th>有效期</th>
				</tr>
				<%
					if(solist.size()==0){
						out.print("<tr><td colspan='6'>暂无记录</td></tr>");
					}else{
						for(int i=0;i<solist.size();i++){
							StockOperation son = solist.get(i);
							ProductStock pss = ProductStock.find(son.getPsid());
							out.print("<tr>");
							out.print("<td>"+(i+1)+"</td>");
							out.print("<td>"+son.getActivity()+"</td>");
							out.print("<td>"+pss.getQuality()+"</td>");
							out.print("<td>"+pss.getBatch()+"</td>");
							out.print("<td>");
							out.print(son.getAmount()+son.getReserve());
							out.print("</td>");
							out.print("<td>"+son.getValid()+"</td>");
							out.print("</tr>");
						}
					}
				%>
			</table>
		</div>
    </ul>
    <%

	}
%>
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
