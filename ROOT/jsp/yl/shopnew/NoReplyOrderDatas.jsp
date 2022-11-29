<%@page import="tea.entity.yl.shopnew.ReplyMoney"%>
<%@page import="tea.entity.yl.shopnew.BackInvoice"%>
<%@page import="tea.entity.yl.shopnew.Invoice"%>
<%@page import="tea.entity.yl.shopnew.InvoiceData"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int orderid = h.getInt("orderid");

ShopOrder order = ShopOrder.find(orderid);
int status = order.getStatus();
String statusContent = "";
if(status==0)
	  statusContent = "等待付款";
else if(status==1)
	  statusContent = "等待发货";
else if(status==2||status==3)
	  statusContent = "等待收货";
else if(status==4)
	  statusContent = "已完成";
else if(status==5)
	  statusContent = "取消订单";
int ordernum=0;//开票数量
double orderamount=0;//开票金额
List<ShopOrderData> lstdata=ShopOrderData.find(" and order_id="+Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
if(lstdata.size()>0){
	ShopOrderData data=lstdata.get(0);
	ordernum=data.getQuantity();
	orderamount=data.getAmount();
}
%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看未开票订单</h1>

<form name="form1" action="/ShopOrderDispatchs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="act" value="invoice"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
 <tr>
		<td>订单编号：</td>
		<td><%=MT.f(order.getOrderId()) %></td>
	</tr>
 <tr>
		<td>下单时间：</td>
		<td><%=MT.f(order.getCreateDate(),1) %></td>
	</tr>
	<tr>
		<td>当前状态：</td>
		<td><%=MT.f(statusContent) %> —— 签收人：<%=Profile.getMemberByOpenId(order.getSign_user_openid()) %></td>
	</tr>
	<tr>
		<td>订单数量：</td>
		<td><%=ordernum %></td>
	</tr>
	<tr>
		<td>订单金额：</td>
		<td><%=MT.f(orderamount) %></td>
	</tr>
	<tr>
		<td>支付方式：</td>
		<td><%out.print(order.getPayType()==1?"在线支付":"公司转账"); %></td>
	</tr>
	<tr>
		<td>签收时间：</td>
		<td><%=MT.f(order.getReceiptTime(),1) %></td>
	</tr>
	
	
</table>
<%
    if(order.getInvoiceStatus()>0){
    	List<InvoiceData> lstindata=InvoiceData.find(" and orderid="+Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);
		
%>
<table id="tablecenter" cellspacing="0">
	<tr style="font-weight:bold;"><td colspan="10" align='left'>发票信息</td></tr>
 	<tr>
		<td>发票编号</td>
		<td>发票状态</td>
		<td>索要时间</td>
		<td>开票时间</td>
		<td>开票数量</td>
		<td>开票金额</td>
	</tr>
	<%
	for(int i=0;i<lstindata.size();i++){
		InvoiceData data=lstindata.get(i);
		int invoiceid=data.getInvoiceid();
		Invoice invoice=Invoice.find(invoiceid);
	
	    %>
	    	<tr>
	    		<td><%=MT.f(invoice.getInvoiceno()) %></td>
	    		<td><%=Invoice.STATUS[invoice.getStatus()] %></td>
	    		<td><%=MT.f(invoice.getCreatedate(),1) %></td>
	    		<td><%=MT.f(invoice.getMakeoutdate(),1) %></td>
	    		<td><%=invoice.getNum() %></td>
	    		<td><%=MT.f(invoice.getAmount()) %></td>
	    	</tr>
	    <%
	    }
	%>
	
</table>
<%
    }
%>
<%
	if(order.getMatchnum()>0){
		List<InvoiceData> lstidata=InvoiceData.find(" and orderid="+Database.cite(order.getOrderId()), 0, Integer.MAX_VALUE);//查询当前订单有哪些发票号
		
%>
<table id="tablecenter" cellspacing="0">
	<tr style="font-weight:bold;"><td colspan="10" align='left'>回款信息</td></tr>
 	<tr>
		<td>回款编号</td>
		<td>匹配发票号</td>
		<td>回款时间</td>
		<td>回款单位</td>
		<td>回款金额</td>
		<td>状态</td>
		<td>挂款编号</td>
		<td>挂款金额</td>
	</tr>
	<%
	for(int i=0;i<lstidata.size();i++){
		InvoiceData idata=lstidata.get(i);
		int invoiceid=idata.getInvoiceid();
		List<BackInvoice> lstback=BackInvoice.find(" and invoiceid like "+Database.cite("%"+invoiceid+"%")+" and status = 1 ", 0, Integer.MAX_VALUE);
		if(lstback.size()>0){
			BackInvoice back=lstback.get(0);
			String[] invoiceidarr=back.getInvoiceid().split(",");
			String invoiceno="";
			//挂款
			int hangid=back.getHangid();
			ReplyMoney gk=ReplyMoney.find(hangid);
			float gkamount=gk.getReplyPrice();//挂款金额
			String gkcode=gk.getCode();//挂款编号
			for(int j=0;j<invoiceidarr.length;j++){
				int inid=Integer.parseInt(invoiceidarr[j]);
				Invoice iv=Invoice.find(inid);
				
				if(j==invoiceidarr.length-1){
					invoiceno+=iv.getInvoiceno();
				}else{
					invoiceno+=iv.getInvoiceno()+",";
				}
				
			}
			String[] replyid=back.getReplyid().split(",");
			for(int j=0;j<replyid.length;j++){
				int re=Integer.parseInt(replyid[j]);
				ReplyMoney money=ReplyMoney.find(re);
				ShopHospital hospital=ShopHospital.find(money.getHid());
		
		
	    %>
	    	<tr>
	    		<td><%=MT.f(money.getCode()) %></td>
	    		<td><%=invoiceno %></td>
	    		<td><%=MT.f(money.getReplyTime(),1) %></td>
	    		<td><%=hospital.getName() %></td>
	    		<td><%=MT.f(money.getReplyPrice()) %></td>
	    		<td><%=ReplyMoney.statusARR[money.getStatus()] %></td>
	    		<td><%=gkcode %></td>
	    		<td><%=gkamount %></td>
	    	</tr>
	    <%
		}
		}
	
	}
	%>
	
</table>
<%
	}
%>

<div class="center mt15">
<button class="btn btn-default" type="button" onclick="history.back();">返回</button></div>
</form>
<script type="text/javascript">

</script>
</body>
</html>
