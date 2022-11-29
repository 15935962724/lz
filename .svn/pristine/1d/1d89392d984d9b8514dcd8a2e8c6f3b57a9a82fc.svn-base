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

	ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(h.get("orderid"));

List<InvoiceData> lstdata=InvoiceData.find(" and invoiceid="+invoiceid, 0, Integer.MAX_VALUE);
String nexturl=h.get("nexturl");
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
<script src="/tea/jquery-1.11.1.min.js"></script>

</head>
<body>
<h1>发票详情</h1>
	<table id="tablecenter" cellspacing="0">
		<tr>
			<td>发票号</td>
			<td><%=MT.f(invoice.getInvoiceno()) %></td>
		</tr>
		<tr>
			<td>开票数量</td>
			<td><%=MT.f(invoice.getNum()) %></td>
		</tr>
		<tr>
			<td>开票金额</td>
			<td><%=MT.f(invoice.getAmount()) %></td>
		</tr>
		<tr>
			<td>医院</td>
			<td><%=MT.f(invoice.getHospital()) %></td>
		</tr>
		<tr>
			<td>收票人</td>
			<td><%=MT.f(invoice.getConsigness()) %></td>
		</tr>
		<tr>
			<td>地址</td>
			<td><%=MT.f(invoice.getAddress()) %></td>
		</tr>
		<tr>
			<td>电话</td>
			<td><%=MT.f(invoice.getTelphone()) %></td>
		</tr>
		<%
			if(MT.f(invoice.getActivity()).length()>0){
				%>
		<tr>
			<td>开票活度</td>
			<td><%=MT.f(invoice.getActivity()) %></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td>备注</td>
			<td><%=MT.f(invoice.getRemark()) %></td>
		</tr>
		<%

			if(invoice.getPuid()== Config.getInt("gaoke")){
				if(invoice.getMateType()==0)
				{//未匹配发票
%>
		<tr>
			<td colspan="2">服务费调整</td>
		</tr>
		<tr>
			<td>调整服务费金额：</td>
			<td><input mask='float' class="adjustmentService" name='adjustmentService' value='<%= invoice.getAdjustmentService()%>' /></td>
		</tr>
		<tr>
			<td colspan="2"><input onclick="saveadjustmentService('<%= invoice.getId()%>')" type="button" value="保存" /></td>
		</tr>
		<%
				}else{
					%>
		<tr>
			<td colspan="2">服务费调整</td>
		</tr>
		<tr>
			<td>调整服务费金额：</td>
			<td><%= (invoice.getAdjustmentService()==0?"无":invoice.getAdjustmentService())%></td>
		</tr>
		<%
				}

			}

			if(invoice.getStatus()==4){
		%>
		<tr>
			<td>退票原因</td>
			<td><%=MT.f(invoice.getBackreason()) %></td>
		</tr>
		<tr>
			<td>退票快递单号</td>
			<td><%=MT.f(invoice.getBackcourierno()) %></td>
		</tr>
		<%
			}
			if(invoice.getStatus()==3){
		%>
		<tr>
			<td>拒绝开票原因</td>
			<td><%=MT.f(invoice.getReason()) %></td>
		</tr>
		<%
			}
			if(invoice.getStatus()==2&&MT.f(invoice.getNobackreason(),"")!=""){
		%>
		<tr>
			<td>拒绝退票原因</td>
			<td><%=MT.f(invoice.getNobackreason()) %></td>
		</tr>
		<%
			}
		%>
	</table>
	<table id="tablecenter" cellspacing="0">
		<tr><td colspan="10"><h3>发票详情</h3></td></tr>
		<tr>
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
				if(lstorderdata.size()>0){
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
				
			}
		%>
	</table>
<br>
<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>

<script>
function saveadjustmentService(iid){
	mt.send("/mobjsp/yl/shop/ajax.jsp?act=saveadjustmentService&iid="+iid+"&adjustmentService="+$(".adjustmentService").val(),function(d) {
		var d = eval('(' + d + ')');
		location = '<%=nexturl%>';
	});
}
</script>
</body>
</html>
