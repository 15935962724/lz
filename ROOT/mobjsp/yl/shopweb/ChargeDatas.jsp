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

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,user-scalable=0">
<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
 <link rel="stylesheet" href="/tea/new/css/style.css">
 <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
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
 </style>

</head>
<body>
<div class="body">
	<div class="detail-list">
		<p class="detail-tit ft16">通知单信息</p>
		<ul class="ft14">
			<li>
				<span class="list-spanr3 fl-left">服务费编号：</span>
				<span class="list-spanr fl-left"><%=charge.getChargecode() %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">医院：</span>
				<span class="list-spanr fl-left"><%=ShopHospital.find(charge.getHospitalid()).getName() %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">创建时间：</span>
				<span class="list-spanr fl-left"><%=MT.f(charge.getCreatedate(),1) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">状态：</span>
				<span class="list-spanr fl-left"><%=Charge.STATUS[charge.getStatus()] %></span>
			</li>
			<%
				if(charge.getStatus()==2){
			%>
			<li>
				<span class="list-spanr3 fl-left">审核不通过原因：</span>
				<span class="list-spanr fl-left"><%=MT.f(charge.getNobackreason()) %></span>
			</li>
			<%
				}
			%>

		</ul>
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
