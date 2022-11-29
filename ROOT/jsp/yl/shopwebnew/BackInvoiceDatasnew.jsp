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

int backid = h.getInt("backid");
BackInvoice back=BackInvoice.find(backid);
String nexturl=h.get("nexturl");
String nexturl2=nexturl+"?member="+h.member;
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
		<td>回款单位：</td>
		<td><%=ShopHospital.find(back.getHospitalid()).getName() %></td>
	</tr>
 <tr>
		<td>状态：</td>
		<td><%=BackInvoice.STATUS[back.getStatus()] %></td>
	</tr>
	
	<tr>
		<td>回款金额：</td>
		<td><%=back.getReplyamount() %></td>
	</tr>
	<tr>
		<td>匹配金额：</td>
		<td><%=back.getMatchamount() %></td>
	</tr>
	<tr>
		<td>挂款金额：</td>
		<td><%=back.getHangamount() %></td>
	</tr>
	<%
	    if(back.getStatus()==2){
	%>
	<tr>
		<td>审核不通过原因：</td>
		<td><%=MT.f(back.getNobackreason()) %></td>
	</tr>
	<%
	    }
	%>
</table>
<table id="tablecenter" cellspacing="0">
	<tr class="tr0"><td colspan="10" align='left'>回款信息</td></tr>
 	<tr>
		<td>回款编号</td>
		<td>回款时间</td>
		<td>回款金额</td>
		<td>类型</td>
		
	</tr>
	<%
		String[] replyidarr=back.getReplyid().split(",");
	    for(int i=0;i<replyidarr.length;i++){
	    	int re=Integer.parseInt(replyidarr[i]);
	    	RemainReplyMoney reply=RemainReplyMoney.find(re);
	    	ReplyMoney rm=ReplyMoney.find(reply.getReplyid());
	    %>
	    	<tr>
	    		<td>
	    			<%
	    				if(reply.getType()==0){
	    					out.print(rm.getCode());
	    				}else if(reply.getType()==1){
	    					out.print(reply.getCode());
	    				}
	    			%>
	    		</td>
	    		<td>
	    			<%
	    				if(reply.getType()==0){
	    					out.print(MT.f(rm.getReplyTime()));
	    				}else if(reply.getType()==1){
	    					out.print(MT.f(reply.getReplyTime()));
	    				}
	    			%>
	    		</td>
	    		<td><%=reply.getAmount() %></td>
	    		<td><%=RemainReplyMoney.typeARR[reply.getType()] %></td>
	    		
	    	</tr>
	    <%
	    }
	%>
	
</table>
<table id="tablecenter" cellspacing="0">
	<tr class="tr0"><td colspan="10" align='left'>发票信息</td></tr>
 	<tr>
		<td>发票编号</td>
		<td>开票数量</td>
		<td>开票金额</td>
		
	</tr>
	<%
		String[] invoiceidarr=back.getInvoiceid().split(",");
	    for(int i=0;i<invoiceidarr.length;i++){
	    	if(invoiceidarr[i].length()>0){
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
	    }
	%>
	
</table>
<table id="tablecenter" cellspacing="0">
	<tr class="tr0"><td colspan="10" align='left'>订单信息</td></tr>
	<tr>
		<td>订单编号</td>
		<td>下单时间</td>
		<td>订单数量</td>
		<td>订单金额</td>
		<td>开票数量</td>
		<td>开票金额</td>
	</tr>
 	<%
 		for(int i=0;i<invoiceidarr.length;i++){
 			if(invoiceidarr[i].length()>0){
 			int in=Integer.parseInt(invoiceidarr[i]);
 			List<InvoiceData> lstidata=InvoiceData.find(" and invoiceid="+in, 0, Integer.MAX_VALUE);
 			for(int j=0;j<lstidata.size();j++){
 				InvoiceData data=lstidata.get(j);
 				String orderid=data.getOrderid();
 	 			ShopOrder order=ShopOrder.findByOrderId(orderid);
 	 			List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+Database.cite(orderid), 0, 1);
 	 			ShopOrderData orderdata=new ShopOrderData(0);
 	 			if(lstdata.size()>0){
 	 				orderdata=lstdata.get(0);
 	 			}
 	 			
 			
 			
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
 		}
 	%>
	
</table>
	
<br>
<button class="btn btn-default" type="button" onclick="history.go(-1)">返回</button>

<script>

mt.fit();
</script>
</body>
</html>
