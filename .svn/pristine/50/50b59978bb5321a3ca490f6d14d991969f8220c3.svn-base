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

int chargeid = h.getInt("chargeid");
Charge charge = Charge.find(chargeid);
String nexturl=h.get("nexturl");
%><!DOCTYPE html><html><head>


<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
 <link rel="stylesheet" href="/tea/new/css/style.css">
 <script src="/tea/new/js/jquery.min.js"></script>
 <script src="/tea/new/js/superslide.2.1.js"></script>
 <script src="/tea/yl/mtDiag.js"></script>
 <style>
	 .con-left .bd:nth-child(2){
		 display:block;
	 }
	 .con-left .bd:nth-child(2) li:nth-child(5){
		 font-weight: bold;
	 }
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
		<table class="right-tab" border="1" cellspacing="0" style="margin-top:0px;">
			<tr>
				<td width="100" align="right">服务费编号：</td>
				<td align="left"><%=charge.getChargecode() %></td>
			</tr>
			<tr>
				<td align="right">医院：</td>
				<td align="left"><%=ShopHospital.find(charge.getHospitalid()).getName() %></td>
			</tr>


			<tr>
				<td align="right">创建时间：</td>
				<td align="left"><%=MT.f(charge.getCreatedate(),1) %></td>
			</tr>
			<tr>
				<td align="right">状态：</td>
				<td align="left"><%=Charge.STATUS[charge.getStatus()] %></td>
			</tr>
			<%
				if(charge.getStatus()==2){
			%>
			<tr>
				<td align="right" nowrap="">审核不通过原因：</td>
				<td align="left"><%=MT.f(charge.getNobackreason()) %></td>
			</tr>
			<%
				}
			%>

		</table>
		<%
			int backid=charge.getBackid();//BackInvoice的id
		%>
		<table class="right-tab" border="1" cellspacing="0">
			<tr class="tr0"><td colspan="10" align='left' style="font-size:15px;">回款信息</td></tr>
			<tr>
				<th>回款编号</th>
				<th>回款时间</th>
				<th>回款金额</th>
				<th>类型</th>
				<th>备注</th>
			</tr>
			<%



				BackInvoice back=BackInvoice.find(backid);
				String[] replyidarr=back.getReplyid().split(",");
				for(int i=0;i<replyidarr.length;i++){
					int re=Integer.parseInt(replyidarr[i]);
					ReplyMoney reply=ReplyMoney.find(re);

			%>
			<tr>
				<td><%=reply.getCode() %></td>
				<td><%=MT.f(reply.getReplyTime()) %></td>
				<td><%=reply.getReplyPrice() %></td>
				<td><%=ReplyMoney.typeARR[reply.getType()] %></td>
				<td><%=MT.f(reply.getContext()) %></td>
			</tr>
			<%
				}

			%>

		</table>
		<table class="right-tab" border="1" cellspacing="0">
			<tr class="tr0"><td colspan="10" align='left' style="font-size:15px;">发票信息</td></tr>
			<tr>
				<th>发票编号</th>
				<th>开票数量</th>
				<th>开票金额</th>

			</tr>
			<%

				String[] invoiceidarr=MT.f(back.getInvoiceid(),",").split(",");
				for(int i=0;i<invoiceidarr.length;i++){
					int in=Integer.parseInt(invoiceidarr[i]);
					Invoice invoice=Invoice.find(in);
			%>
			<tr>
				<td><%=invoice.getInvoiceno() %></td>
				<td><%=invoice.getNum() %></td>
				<td><%=invoice.getAmount() %></td>
			</tr>
			<%
				}

			%>

		</table>
		<table class="right-tab" border="1" cellspacing="0">
			<tr class="tr0"><td colspan="10" align='left' style="font-size:15px;">订单信息</td></tr>
			<tr>
				<th>订单编号</th>
				<th>下单时间</th>
				<th>订单数量</th>
				<th>订单金额</th>
				<th>开票数量</th>
				<th>开票金额</th>
			</tr>
			<%


				for(int i=0;i<invoiceidarr.length;i++){
					int in=Integer.parseInt(invoiceidarr[i]);
					List<InvoiceData> lstidata=InvoiceData.find(" and invoiceid="+in, 0, Integer.MAX_VALUE);
					for(int j=0;j<lstidata.size();j++){
						InvoiceData data=lstidata.get(j);
						String orderid=data.getOrderid();
						ShopOrder order=ShopOrder.findByOrderId(orderid);
						List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+Database.cite(orderid), 0, 1);
						ShopOrderData orderdata=lstdata.get(0);


			%>
			<tr>
				<td><%=orderid %></td>
				<td><%=MT.f(order.getCreateDate(),1) %></td>
				<td><%=orderdata.getQuantity() %></td>
				<td><%=orderdata.getAgent_amount() %></td>
				<td><%=data.getNum() %></td>
				<td><%=data.getAmount() %></td>
			</tr>
			<%
					}
				}

			%>

		</table>

		<div class="center text-c pd20">
			<button class="btn btn-default" type="button" onclick="history.back();">返回</button>
		</div>
	</div>
</div>

<script>

mt.fit();
</script>
</body>
</html>
