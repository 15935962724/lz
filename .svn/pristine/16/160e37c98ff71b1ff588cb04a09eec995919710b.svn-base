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


<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
 <script src="/tea/jquery-1.11.1.min.js"></script>
 <link rel="stylesheet" href="/tea/new/css/style.css">
 <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
 <script src="/tea/new/js/jquery.min.js"></script>
 <script src="/tea/new/js/superslide.2.1.js"></script>
 <script src="/tea/yl/mtDiag.js"></script>
</head>
<body>

<div class="body">
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
			<%
				if(invoice.getStatus()==4){
			%>
			<li>
				<span class="list-spanr3 fl-left">退票原因：</span>
				<span class="list-spanr fl-left"><%=MT.f(invoice.getBackreason()) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">退票快递单号：</span>
				<span class="list-spanr fl-left"><%=MT.f(invoice.getBackcourierno()) %></span>
			</li>
			<%
				}
				if(MT.f(invoice.getNobackreason(),"")!=""&&invoice.getStatus()!=4){
			%>
			<li>
				<span class="list-spanr3 fl-left">拒绝退票原因：</span>
				<span class="list-spanr fl-left"><%=MT.f(invoice.getNobackreason()) %></span>
			</li>
			<%
				}
			%>
		</table>
		<p class="right-zhgl" style="margin-top:10px">
			<span>订单详情</span>
		</p>
		<table class="right-tab" border="1" cellspacing="0">
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
