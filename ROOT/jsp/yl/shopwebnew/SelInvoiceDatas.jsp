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
int member=h.getInt("member");//服务商id
int hid=h.getInt("hid");//医院id

String ids=h.get("ids");//回款id以逗号分隔

float amount=h.getFloat("amount");//选中的回款金额

String nexturl2=nexturl+"?member="+member+"&hid="+hid+"&ids="+ids+"&amount="+amount;
%><!DOCTYPE html><html><head>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>

<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>


</head>
<body>
	<table id="tablecenter" cellspacing="0">
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
			<td class="tdright"><%=MT.f(invoice.getMakeoutdate(),1) %></td>
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
	</table>
	<table id="tablecenter" cellspacing="0">
		<tr class="trtou"><td colspan="10"><h3>发票详情</h3></td></tr>
		<tr  class="trbold">
			<td>订单号</td>
			
			<td>下单时间</td>
			<td>订单数量</td>
			<td>订单金额</td>
			<td>开票数量</td>
			<td>开票金额</td>
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
<button class="btn btn-default" type="button" onclick="location='<%=nexturl2 %>'">返回</button>

<script>

mt.fit();
</script>
</body>
</html>
