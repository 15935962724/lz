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
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

 <link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css">

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>

<title>回款匹配发票详情</title>
</head>
<body>
<header class="header">回款匹配发票详情</header>
	<table id="tableweb" cellspacing="0">
 <tr>
		<td class="tdleft2">回款单位：</td>
		<td><%=ShopHospital.find(back.getHospitalid()).getName() %></td>
	</tr>
 <tr>
		<td class="tdleft2">状态：</td>
		<td><%=BackInvoice.STATUS[back.getStatus()] %></td>
	</tr>
	
	<tr>
		<td class="tdleft2">回款金额：</td>
		<td><%=back.getReplyamount() %></td>
	</tr>
	<tr>
		<td class="tdleft2">匹配金额：</td>
		<td><%=back.getMatchamount() %></td>
	</tr>
	<tr>
		<td class="tdleft2">挂款金额：</td>
		<td><%=back.getHangamount() %></td>
	</tr>
	<%
	    if(back.getStatus()==2){
	%>
	<tr>
		<td class="tdleft2">审核不通过原因：</td>
		<td><%=MT.f(back.getNobackreason()) %></td>
	</tr>
	<%
	    }
	%>
</table>
<div class="conwx-bt"><h3>回款信息</h3></div>
<div class="resultlist">
	
	<%
		String[] replyidarr=back.getReplyid().split(",");
	    for(int i=0;i<replyidarr.length;i++){
	    	if(replyidarr[i].length()>0){
	    	int re=Integer.parseInt(replyidarr[i]);
	    	RemainReplyMoney reply=RemainReplyMoney.find(re);
	    	ReplyMoney rm=ReplyMoney.find(reply.getReplyid());
	    %>
	    	<ul>
	    		<li>
	    			<span>回款编号：
	    			<%
	    				if(reply.getType()==0){
	    					out.print(rm.getCode());
	    				}else if(reply.getType()==1){
	    					out.print(reply.getCode());
	    				}
	    			%>
	    			</span>
	    			<span>
	    			<%
	    				if(reply.getType()==0){
	    					out.print(MT.f(rm.getReplyTime()));
	    				}else if(reply.getType()==1){
	    					out.print(MT.f(reply.getReplyTime()));
	    				}
	    			%>
	    			</span>
	    		</li>
	    		<li>
	    			<span>回款金额：<%=reply.getAmount() %></span>
	    			<span><%=RemainReplyMoney.typeARR[reply.getType()] %></span>
	    		</li>
	    		
	    	</ul>
	    <%
	    	}
	    }
	%>
</div>	
<div class="conwx-bt"><h3>发票信息</h3></div>
<div class="resultlist">
	<%
		String[] invoiceidarr=back.getInvoiceid().split(",");
	    for(int i=0;i<invoiceidarr.length;i++){
	    	if(invoiceidarr[i].length()>0){
	    	int in=Integer.parseInt(invoiceidarr[i]);
	    	Invoice invoice=Invoice.find(in);
	    %>
	    	<ul>
	    		<li><span>发票编号：<%=invoice.getInvoiceno() %></span></li>
	    		<li>
	    			<span>开票数量：<%=invoice.getNum() %></span>
	    			<span>开票金额：<%=invoice.getAmount() %></span>
	    		</li>
	    		
	    	</ul>
	    <%
	    	}
	    }
	%>
</div>
<div class="conwx-bt"><h3>订单信息</h3></div>

<div class="resultlist" style="margin-bottom: 70px;">
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
 				<ul>
 					<li>
 						<span>订单编号：<%=orderid %></span>
 						<span><%=MT.f(order.getCreateDate(),1) %></span>
 					</li>
 					<li>
 						<span>订单数量：<%=orderdata.getQuantity() %></span>
 						<span>订单金额：<%=orderdata.getAgent_amount() %></span>
 					</li>
 					
 					<li>
 						<span>开票数量：<%=data.getNum() %></span>
 						<span>开票金额：<%=data.getAmount() %></span>
 					</li>
 					
 				</ul>
 			<%
 			}
 			}
 		}
 	%>
	
</div>
	
<br>
<div class="btnbottom">
<%-- <button class="btn btn-default" type="button" onclick="location='<%=nexturl2 %>'">返回</button> --%>
<button class="btn btn-default" type="button" onclick="history.back(-1)">返回</button>
</div>
<script>

mt.fit();
</script>
</body>
</html>
