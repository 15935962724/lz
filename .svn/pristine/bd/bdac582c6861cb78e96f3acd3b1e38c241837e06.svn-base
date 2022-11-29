 <%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%>
 <%@ page import="util.Config" %>
 <%

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


<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
 <script src="/tea/jquery-1.11.1.min.js"></script>
 <link rel="stylesheet" href="/tea/new/css/style.css">
 <script src="/tea/new/js/jquery.min.js"></script>
 <script src="/tea/new/js/superslide.2.1.js"></script>
 <script src="/tea/yl/mtDiag.js"></script>
 <style>
	 .con-left .bd:nth-child(2){
		 display:block;
	 }
	 .con-left .bd:nth-child(2) li:nth-child(3){
		 font-weight: bold;
	 }
	 .tab1 td,.tab1 th{text-align:left;padding:0px 12px;}
	.con-left-list .tit-on1{color:#044694;}

 </style>
</head>
<body>

<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<table class="right-tab tab1" border="1" cellspacing="0" style="margin:0px;">
			<tr>
				<td class="tdleft" width="80">发票号</td>
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
			<%
				if(invoice.getPuid()== Config.getInt("gaoke")){
					%>
			<tr>
				<td class="tdleft">开票活度</td>
				<td class="tdright"><%=MT.f(invoice.getActivity()) %></td>
			</tr>
			<%
				}
			%>
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
				if(MT.f(invoice.getNobackreason(),"")!=""&&invoice.getStatus()!=4){
			%>
			<tr>
				<td class="tdleft">拒绝退票原因</td>
				<td class="tdright"><%=MT.f(invoice.getNobackreason()) %></td>
			</tr>
			<%
				}
			%>
		</table>
		<p class="right-zhgl" style="margin-top:10px">
			<span>订单详情</span>
		</p>
		<table class="right-tab" border="1" cellspacing="0"">
			<tr  class="trbold">
				<th>订单号</th>

				<th>下单时间</th>
				<th>订单数量</th>
				<th>订单金额</th>
				<th>开票数量</th>
				<th>开票金额</th>
			</tr>
			<%
				for(int i=0;i<lstdata.size();i++){
					InvoiceData data=lstdata.get(i);//发票
					String orderid=data.getOrderid();//订单id
					ShopOrder order=ShopOrder.findByOrderId(orderid);//订单
					List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id="+Database.cite(orderid), 0, 1);//订单详情
					ShopOrderData orderdata=lstorderdata.get(0);//订单详情

					out.print("<tr>");
					out.print("<td>"+orderid+"</td>");

					out.print("<td>"+MT.f(order.getCreateDate(),1)+"</td>");
					out.print("<td>"+orderdata.getQuantity()+"</td>");
					out.print("<td>"+orderdata.getAgent_amount()+"</td>");
					out.print("<td>"+data.getNum()+"</td>");
					out.print("<td>"+data.getAmount()+"</td>");
					out.print("</tr>");

				}
			%>
		</table>
	<br>
		<div class="center text-c pd20">
			<button class="btn btn-default" type="button" onclick="history.go(-1)">返回</button>
		</div>
	</div>
</div>
<script>

mt.fit();
</script>
</body>
</html>
