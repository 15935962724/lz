<%@page import="util.Config"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@ page import="tea.entity.yl.shopnew.*" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int backid = h.getInt("backid");

BackInvoice back = BackInvoice.find(backid);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1>查看回款匹配发票</h1>

<form name="form1" action="/ShopOrderDispatchs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="act" value="invoice"/>
<input type="hidden" name="backid" value="<%= backid %>"/>

<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

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
		<td>服务商：</td>
		<td><%=Profile.find(back.getMember()).member %></td>
	</tr>
	<tr>
		<td>回款金额：</td>
		<td><%=ShopHospital.getDecimal((double)back.getReplyamount()) %></td>
	</tr>
	<%
		float deductPrice = HangWith.findDeductPriceBid(backid);
	%>
	<tr>
		<td>实际回款金额：</td>
		<td><%
		float cha = 0;
		if(deductPrice>0){
			cha = back.getHangamount()-deductPrice;
		}
		float replyamount1 = back.getReplyamount() - cha;
		out.print(ShopHospital.getDecimal((double)replyamount1));
		%></td>
	</tr>
	<tr>
		<td>服务商匹配金额：</td>
		<td><%=ShopHospital.getDecimal((double)back.getMatchamount()) %></td>
	</tr>
	<tr>
		<td>应收账款：</td>
		<td><%=ShopHospital.getDecimal((double)back.getOldnoreply()) %></td>
	</tr>
	<tr>
		<td>剩余应收账款：</td>
		<td><%=ShopHospital.getDecimal((double)back.getSoldnoreply()) %></td>
	</tr>
	<tr>
		<td>挂款金额：</td>
		<td><%=ShopHospital.getDecimal((double)back.getHangamount()) %></td>
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
	if(Config.getInt("gaoke")==back.getPuid()){//高科
		if(back.getStatus()==0){
%>
    <tr>
        <td colspan="2">调整服务费比例</td>
    </tr>
    <tr>
        <td>归还服务费比例：</td>
        <td><select name="deductionRecordType"><%= h.options(BackInvoice.deductionRecordTypeARR,back.getDeductionRecordType())%></select></td>
    </tr>
    <tr>
        <td colspan="2"><input onclick="savedeductpricetype()" type="button" value="保存" /></td>
    </tr>
	<tr>
		<td colspan="2">挂款调整</td>
	</tr>
	<tr>
		<td>调整挂款金额：</td>
		<td><input mask='float' name='deductprice' value='<%= deductPrice %>' /></td>
	</tr>
	<tr>
		<td colspan="2"><input onclick="savedeductprice()" type="button" value="保存" /></td>
	</tr>
	<%
		}else{

			int bid = HangWith.findbid(backid);

			if(back.getDeductionRecordType()>0) {//高科
	%>
	<tr>
		<td>归还服务费比例：</td>
		<td><%= BackInvoice.deductionRecordTypeARR[back.getDeductionRecordType()] %></td>
	</tr>
	<%
		}

		float deductprice = HangWith.findDeductPriceBid(bid);
		if(deductprice>0){//高科

	%>
	<tr>
		<td>调整回款金额：</td>
		<td><%= deductprice %></td>
	</tr>
	<%
				}

		}
	}
	%>
</table>
<table id="tablecenter" cellspacing="0">
	<tr style="font-weight:bold;"><td colspan="10" align='left'>回款信息</td></tr>
 	<tr>
		<td>回款编号</td>
		<td>回款时间</td>
		<td>回款金额</td>
		<td>类型</td>
		<td>备注</td>
	</tr>
	<%
		String[] replyidarr=back.getReplyid().split(",");
	    for(int i=0;i<replyidarr.length;i++){
	    	int re=Integer.parseInt(replyidarr[i]);
	    	ReplyMoney reply=ReplyMoney.find(re);
	    %>
	    	<tr>
	    		<td><%=reply.getCode() %></td>
	    		<td><%=MT.f(reply.getReplyTime()) %></td>
	    		<td><%=ShopHospital.getDecimal((double)reply.getReplyPrice()) %></td>
	    		<td><%=ReplyMoney.typeARR[reply.getType()] %></td>
	    		<td><%=MT.f(reply.getContext()) %></td>
	    	</tr>
	    <%
	    }
	%>
	
</table>
<table id="tablecenter" cellspacing="0">
	<tr style="font-weight:bold;"><td colspan="10" align='left'>发票信息</td></tr>
 	<tr>
		<td>发票编号</td>
		<td>开票日期</td>
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
	    		<td><%=MT.f(invoice.getMakeoutdate()) %></td>
	    		<td><%=invoice.getNum() %></td>
	    		<td><%=invoice.getAmount() %></td>
	    	</tr>
	    <%
	    }
	    }
	%>
	
</table>
<table id="tablecenter" cellspacing="0">
	<tr style="font-weight:bold;"><td colspan="10" align='left'>订单信息</td></tr>
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
 		}
 	%>
	
</table>
<%

	String drsql = " AND bid = "+back.getId();
	int drcount = DeductionRecord.count(drsql);

	if(drcount>0){
		%>
		<table id="tablecenter" cellspacing="0">
	<tr style="font-weight:bold;"><td colspan="10" align='left'>扣款信息</td></tr>
	
	<tr>
		<td>序号</td>
		<td>发票编号</td>
		<td>开票日期</td>
		<td>开票数量</td>
		<td>扣款金额</td>
	</tr>
	<%
		//String [] QIANINVOICEIDS = MT.f(back.getQianinvoiceid(),",").split(",");
		List<DeductionRecord> drlist = DeductionRecord.find(drsql,0,Integer.MAX_VALUE);
	for(int i=0;i<drlist.size();i++){
		DeductionRecord dr = drlist.get(i);
		Invoice myin = Invoice.find(dr.getIid());
		out.print("<tr>");
		out.print("<td>"+(i+1)+"</td>");
		out.print("<td>"+myin.getInvoiceno()+"</td>");
		out.print("<td>"+MT.f(myin.getCreatedate(),1)+"</td>");
		out.print("<td>"+myin.getNum()+"</td>");
		out.print("<td>"+dr.getDeductprice()+"</td>");
		out.print("</tr>");
	}
	%>
	<tr>
		<td>总计：</td>
		<td colspan="5"><%= back.getQianamount() %></td>
	</tr>
	</table>
		<%
	}
%>
<%
	if(MT.f(back.getHuanid(),"").length()>0){
		%>
		<table id="tablecenter" cellspacing="0">
	<tr style="font-weight:bold;"><td colspan="10" align='left'>补款信息</td></tr>
	
	<tr>
		<td>序号</td>
		<td>发票编号</td>
		<td>开票日期</td>
		<td>开票数量</td>
		<td>补款金额</td>
	</tr>
	<%
		String [] Huanid = MT.f(back.getHuanid(),",").split(",");
	for(int i=0;i<Huanid.length;i++){
		Invoice myin = Invoice.find(Integer.parseInt(Huanid[i]));
		DeductionRecord dr = DeductionRecord.findByIid(myin.getId());
		float koukuan = dr.getDeductprice();
		//float koukuan = BackInvoice.findQianKuai(","+myin.getId());
		out.print("<tr>");
		out.print("<td>"+(i+1)+"</td>");
		out.print("<td>"+myin.getInvoiceno()+"</td>");
		out.print("<td>"+MT.f(myin.getCreatedate(),1)+"</td>");
		out.print("<td>"+myin.getNum()+"</td>");
		out.print("<td>"+koukuan+"</td>");
		out.print("</tr>");
	}
	%>
	<tr>
		<td>总计：</td>
		<td colspan="5"><%= back.getHuanamount() %></td>
	</tr>
	</table>
		<%
	}
%>
<div class="center mt15">
<button class="btn btn-default" type="button" onclick="history.back();">返回</button></div>
</form>
<script type="text/javascript">
function savedeductprice(){
	mt.send("/mobjsp/yl/shop/ajax.jsp?act=savedeductprice&backid="+form1.backid.value+"&deductprice="+form1.deductprice.value,function(data){
		data = eval('(' + data + ')');
	if(data.type>0){
		mtDiag.close();
		mtDiag.show(data.mes);
		return;
	}else{
		//location = form1.nexturl.value;
        mt.show("保存成功！",1,form1.nexturl.value);
	}});
}
function savedeductpricetype(){
    mt.send("/mobjsp/yl/shop/ajax.jsp?act=savedeductionRecordType&backid="+form1.backid.value+"&deductionRecordType="+form1.deductionRecordType.value,function(data){
        data = eval('(' + data + ')');
        if(data.type>0){
            mtDiag.close();
            mtDiag.show(data.mes);
            return;
        }else{
            mt.show("保存成功！",1,form1.nexturl.value);
            //location = form1.nexturl.value;
        }});
}
</script>
</body>
</html>
