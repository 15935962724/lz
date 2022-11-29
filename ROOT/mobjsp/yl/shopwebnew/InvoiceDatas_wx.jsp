 <%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int invoiceid = h.getInt("invoiceid");
//根据发票id查询发票和发票详情
Invoice invoice=Invoice.find(invoiceid);

List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid="+invoiceid, 0, Integer.MAX_VALUE);
String nexturl=h.get("nexturl");
%><!DOCTYPE html><html><head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css">
 <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
 

<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<title>发票详情</title>
<style>

.data-but,body{background:none;}
.data-but .btn-default {
	 color: #333 !important;
	 background-color: #fff !important;
	 border: 1px solid #ccc !important;
	 display: inline-block;
	 padding: 6px 12px;
	 margin-bottom: 0;
	 font-size: 14px;
	 line-height: 1.42857143;
	 text-align: center;
	 white-space: nowrap;
	 vertical-align: middle;
	 -ms-touch-action: manipulation;
	 touch-action: manipulation;
	 cursor: pointer;
	 -webkit-user-select: none;
	 -moz-user-select: none;
	 -ms-user-select: none;
	 user-select: none;
	 background-image: none;
	 border-radius: 4px;
	 height: auto;
	 width:auto;
 }
 </style>
</head>
<body>
	 <div class="detail-list">
		 <p class="detail-tit ft16">发票信息</p>
		 <ul class="ft14">
			 <li>
			 	<span class="list-spanr3 fl-left">发票号：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(invoice.getInvoiceno()) %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">快递单号：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(invoice.getCourierno()) %></span>
	 		</li>
			 <li>
			 	<span class="list-spanr3 fl-left">开票日期：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(invoice.getMakeoutdate()) %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">开票数量：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(invoice.getNum()) %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">开票金额：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(invoice.getAmount()) %></span>
			 </li>
			 <%
				 if(MT.f(invoice.getActivity()).length()>0){
			 %>
			 <li>
				 <span class="list-spanr3 fl-left">开票活度：</span>
				 <span class="list-spanr fl-left"><%=MT.f(invoice.getActivity()) %></span>
			 </li>
			 <%
				 }
			 %>
			 <li>
			 	<span class="list-spanr3 fl-left">医院：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(invoice.getHospital()) %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">收票人：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(invoice.getConsigness()) %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">地址：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(invoice.getAddress()) %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">电话：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(invoice.getTelphone()) %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">备注：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(invoice.getRemark()) %></span>
			 </li>
		 </ul>
	 </div>
	<!--<table id="tableweb" cellspacing="0">
		<tr>
			<td class="tdleft">发票号</td>
			<td class="tdright"><%=MT.f(invoice.getInvoiceno()) %></td>
		</tr>
		<tr>
			<td class="tdleft">快递单号</td>
			<td class="tdright"><%=MT.f(invoice.getCourierno()) %></td>
		</tr>
		<tr>
			<td class="tdleft">开票日期</td>
			<td class="tdright"><%=MT.f(invoice.getMakeoutdate()) %></td>
		</tr>
		<tr>
			<td class="tdleft">开票数量</td>
			<td class="tdright"><%=MT.f(invoice.getNum()) %></td>
		</tr>
		<tr>
			<td class="tdleft">开票金额</td>
			<td class="tdright"><%=MT.f(invoice.getAmount()) %></td>
		</tr>
		<tr>
			<td class="tdleft">医院</td>
			<td class="tdright"><%=MT.f(invoice.getHospital()) %></td>
		</tr>
		<tr>
			<td class="tdleft">收票人</td>
			<td class="tdright"><%=MT.f(invoice.getConsigness()) %></td>
		</tr>
		<tr>
			<td class="tdleft">地址</td>
			<td class="tdright"><%=MT.f(invoice.getAddress()) %></td>
		</tr>
		<tr>
			<td class="tdleft">电话</td>
			<td class="tdright"><%=MT.f(invoice.getTelphone()) %></td>
		</tr>
		
		<tr>
			<td class="tdleft">备注</td>
			<td class="tdright"><%=MT.f(invoice.getRemark()) %></td>
		</tr>
		<%
			if(invoice.getStatus()==4){
		%>
		<tr>
			<td class="tdleft">退票原因</td>
			<td class="tdright">
				<%=MT.f(invoice.getBackreason()) %>
			</td>
		</tr>
		<tr>
			<td class="tdleft">退票快递单号</td>
			<td class="tdright"><%=MT.f(invoice.getBackcourierno()) %></td>
		</tr>
		<%
			}
		%>
	</table>-->
	 <div class="detail-list">
		 <p class="detail-tit ft16">订单信息</p>
		 <%
			for(int i=0;i<lstdata.size();i++){
				InvoiceData data=lstdata.get(i);//发票
				String orderid=data.getOrderid();//订单id
				ShopOrder order=ShopOrder.findByOrderId(orderid);//订单
				List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id="+Database.cite(orderid), 0, 1);//订单详情
				ShopOrderData orderdata=lstorderdata.get(0);//订单详情
		%>
		 <ul class="ft14">
			 <li>
				<span class="list-spanr3 fl-left">订单编号：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(orderid) %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">下单时间：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(order.getCreateDate(),1) %></span>
	 		</li>
			 <li>
			 	<span class="list-spanr3 fl-left">订单数量：</span>
			 	<span class="list-spanr fl-left"><%=orderdata.getQuantity() %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">订单金额：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(orderdata.getAgent_amount()) %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">开票数量：</span>
			 	<span class="list-spanr fl-left"><%=data.getNum() %></span>
			 </li>
			 <li>
			 	<span class="list-spanr3 fl-left">开票金额：</span>
			 	<span class="list-spanr fl-left"><%=MT.f(data.getAmount()) %></span>
			 </li>
		 </ul>
		 <%
			}
		%>
	 </div>

<%--	 <div class="conwx-bt"><h3>订单详情</h3></div>--%>
<%--		<div class="resultlist">--%>
<%--		<%--%>
<%--			for(int i=0;i<lstdata.size();i++){--%>
<%--				InvoiceData data=lstdata.get(i);//发票--%>
<%--				String orderid=data.getOrderid();//订单id--%>
<%--				ShopOrder order=ShopOrder.findByOrderId(orderid);//订单--%>
<%--				List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id="+Database.cite(orderid), 0, 1);//订单详情--%>
<%--				ShopOrderData orderdata=lstorderdata.get(0);//订单详情--%>
<%--		%>--%>
<%--			<ul>--%>
<%--				<li>--%>
<%--					<span>订单号：<h3><%=MT.f(orderid) %></h3></span>--%>
<%--					<span><%=MT.f(order.getCreateDate(),1) %></span>--%>
<%--				</li>--%>
<%--				<li>--%>
<%--					<span>订单数量：<%=orderdata.getQuantity() %></span>--%>
<%--					<span>订单金额：<%=MT.f(orderdata.getAgent_amount()) %></span>--%>
<%--				</li>--%>
<%--				<li>--%>
<%--					<span>开票数量：<%=data.getNum() %></span>--%>
<%--					<span>开票金额：<%=MT.f(data.getAmount()) %></span>--%>
<%--				</li>--%>
<%--			</ul>--%>
<%--		<%--%>
<%--			}--%>
<%--		%>--%>
<%--	--%>
<%--      <br>--%>
<%--      --%>
<%--    </div>--%>
	 <div class="data-but">
	 	<button class="btn btn-default" type="button" onclick="history.back(-1)">返回</button>
	 </div>
<script>

mt.fit();
</script>
</body>
</html>
