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
 
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

 <!-- <link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css"> -->

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">

<title>退票申请</title>

</head>
	 <style>
	 .btn-default {
		 color: #333 !important;
		 background-color: #fff !important;
		 border: 1px solid #ccc !important;
		 font-weight: 400 !important;
	 }
	 .btn-default2 {
		 color: #044694 !important;
		 background-color: #fff !important;
		 border: 1px solid #044694 !important;
		 font-weight: 400 !important;
	 }
	 </style>
<body>
<!-- <header class="header">退票申请</header> -->
	<form name="form2" action="/Invoices.do" target="_ajax" method="post">
	<input type="hidden" name="invoiceid" value="<%=invoiceid %>" />
	<input type="hidden" name="act" value="backinvoice" />
	<input type="hidden" name="nexturl" value="<%=nexturl %>" />
	<div class="order-list">
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
				<span class="list-spanr fl-left"><%=MT.f(invoice.getMakeoutdate(),1) %></span>
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
			<li>
				<span class="list-spanr3 fl-left">退票原因：</span>
				<span class="list-spanr fl-left"><textarea style="display: inline-block" class="th-txt" name="backreason" id="backreason" rows="5" cols="30"></textarea></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">退票快递单号：</span>
				<span class="list-spanr fl-left"><input class="th-inp" style="height:32px;line-height: 32px;" type="text" name="backcourierno"  id="backcourierno" alt="快递单号"/></span>
			</li>
		</ul>
	</div>
	<!-- <table id="tableweb" cellspacing="0">
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
		<tr>
			<td class="tdleft">退票原因</td>
			<td class="tdright">
				<textarea name="backreason" id="backreason" rows="5" cols="30"></textarea> 
			</td>
		</tr>
		<tr>
			<td class="tdleft">退票快递单号</td>
			<td class="tdright"><input type="text" name="backcourierno"  id="backcourierno" alt="快递单号"/></td>
		</tr>
		
	</table> -->
	
	<div class="detail-list">
		<p class="detail-tit ft16 fpx-tit">发票详情</p>
		<div class="resultlist">
			<%
				for(int i=0;i<lstdata.size();i++){
					InvoiceData data=lstdata.get(i);//发票
					String orderid=data.getOrderid();//订单id
					ShopOrder order=ShopOrder.findByOrderId(orderid);//订单
					List<ShopOrderData> lstorderdata=ShopOrderData.find(" and order_id="+Database.cite(orderid), 0, 1);//订单详情
					ShopOrderData orderdata=lstorderdata.get(0);//订单详情
			%>
			<ul class="ft14" style="border-bottom:1px solid #ccc;padding-bottom:16px;">
				<li>
					<span class="list-spanr3 fl-left">订单号：</span>
					<span class="list-spanr fl-leftt"><%=MT.f(orderid) %></span>
				</li>
				<li>
					<span class="list-spanr3 fl-left">订单时间：</span>
					<span class="list-spanr fl-left"><%=MT.f(order.getCreateDate(),1) %></span>
				</li>
				<li>
					<span class="list-spanr3 fl-left">订单数量：</span>
					<span class="list-spanr fl-leftt"><%=orderdata.getQuantity() %></span>
				</li>
				<li>
					<span class="list-spanr3 fl-left">订单金额：</span>
					<span class="list-spanr fl-leftt"><%=MT.f(orderdata.getAgent_amount()) %></span>
				</li>
				<li>
					<span class="list-spanr3 fl-left">开票数量：</span>
					<span class="list-spanr fl-leftt"><%=data.getNum() %></span>
				</li>
				<li>
					<span class="list-spanr3 fl-left">开票金额：</span>
					<span class="list-spanr fl-leftt"><%=MT.f(data.getAmount()) %></span>
				</li>
				<!-- <li>
					<span>订单数量：<%=orderdata.getQuantity() %></span>
					<span>订单金额：<%=MT.f(orderdata.getAgent_amount()) %></span>
				</li>
				<li>
					<span>开票数量：<%=data.getNum() %></span>
					<span>开票金额：<%=MT.f(data.getAmount()) %></span>
				</li> -->
			</ul>
			<%		
					
					
				}
			%>
		<div class="btnbottom">
			<em style="flex: 1;"></em>
<%--		<input type="button" class="btn" onclick="fnback()" value="确认退票" />--%>
		<button class="btn btn-default2" type="button" onclick="fnback()">确认退票</button>
			&nbsp;&nbsp;
<%--	 	<input type="button" class="btn" onclick="location='<%=nexturl%>'" value="返回" />--%>

	 	<button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
	 	<em style="flex: 1;"></em>

		</div>
		
		</div>
	</div>
 </form>
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
	
	form2.submit();
}
mt.fit();
</script>
</body>
</html>
