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
	 .right-tab td,.right-tab th{
		 padding:0px 10px;
		 text-align:left;
	 }
	 .form-control{box-sizing: border-box}
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
	<form name="form2" action="/Invoices.do" target="_ajax" method="post">
	<input type="hidden" name="invoiceid" value="<%=invoiceid %>" />
	<input type="hidden" name="act" value="backinvoice" />
	<input type="hidden" name="nexturl" value="<%=nexturl %>" />
	<table class="right-tab" border="1" cellspacing="0" style="margin:0px;">
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
		<tr>
			<td class="tdleft">退票原因</td>
			<td class="tdright" style="padding:10px;">
				<textarea name="backreason" id="backreason" class="form-control" rows="5" cols="30"></textarea>
			</td>
		</tr>
		<tr>
			<td class="tdleft" nowrap="">退票快递单号</td>
			<td class="tdright" style="padding:5px 10px;"><input style="width:auto;" type="text" name="backcourierno"  class="form-control" id="backcourierno" alt="快递单号"/></td>
		</tr>
		
	</table>
	<p class="right-zhgl" style="margin-top:10px">
		<span>发票详情</span>
	</p>
		<style>
			.tab1 td,.tab1 th{text-align:center;}
		</style>
	<table class="right-tab tab1" border="1" cellspacing="0">
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
		<div class="center text-c pd20">
			<input type="button" class="btn btn-default btn-blue" onclick="fnback()" value="确认退票" />&nbsp;&nbsp;
			<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
		</div>
	</form>

	</div>
</div>

<script>
function fnback(){
	var backreason=document.getElementById("backreason").value;
	if(backreason==""){
		mt.show("“退票原因”不能为空！");
		return false;
	}
	var backcourierno=document.getElementById("backcourierno").value;
	if(backcourierno==""){
		mt.show("“快递单号”不能为空！");
		return false;
	}
	mt.show("是否确定退票？",2);
	mt.ok = function(){
		form2.submit();
	}
}
mt.fit();
</script>
</body>
</html>
