<%@page import="util.Config"%>
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
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
<link rel="stylesheet" href="/tea/new/css/style.css">
<style>
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(4){
		font-weight: bold;
	}
	.ft16{font-size:16px;}
	.ft14{font-size:14px;}
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=0">
<title>回款管理</title>
</head>
<body style="min-height:800px">

<div class="body">
	<div class="detail-list">
		<p class="detail-tit ft16">发票信息</p>
		<ul class="ft14">
			<li>
				<span class="list-spanr3 fl-left">回款单位：</span>
				<span class="list-spanr fl-left"><%=ShopHospital.find(back.getHospitalid()).getName() %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">状态：</span>
				<span class="list-spanr fl-left"><%=BackInvoice.STATUS[back.getStatus()] %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">回款金额：</span>
				<span class="list-spanr fl-left"><%=ShopHospital.getDecimal((double)back.getReplyamount()) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">匹配金额：</span>
				<span class="list-spanr fl-left"><%=ShopHospital.getDecimal((double)back.getMatchamount()) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">挂款金额：</span>
				<span class="list-spanr fl-left"><%=ShopHospital.getDecimal((double)back.getHangamount()) %></span>
			</li>
			<%
				int bid = HangWith.findbid(backid);

				if(Config.getInt("gaoke")==back.getPuid()&&back.getDeductionRecordType()>0) {//高科
			%>
			<li>
				<span class="list-spanr3 fl-left">归还服务费比例：</span>
				<span class="list-spanr fl-left"><%= BackInvoice.deductionRecordTypeARR[back.getDeductionRecordType()] %></span>
			</li>
			<%
				}

				float deductprice = HangWith.findDeductPriceBid(bid);
				if(Config.getInt("gaoke")==back.getPuid()&&deductprice>0){//高科

			%>
			<li>
				<span class="list-spanr3 fl-left">调整回款金额：</span>
				<span class="list-spanr fl-left"><%= deductprice %></span>
			</li>
			<%
				}
				if(back.getStatus()==2){
			%>
			<li>
				<span class="list-spanr3 fl-left">审核不通过原因：</span>
				<span class="list-spanr fl-left"><%=MT.f(back.getNobackreason()) %></span>
			</li>
			<%
				}
			%>
		</ul>
		<%--</table>--%>
		<table id="tablecenter" cellspacing="0" class="right-tab">
			<tr class="tr0"><td colspan="10" align='left' style="font-size:15px;font-weight:bold;">回款信息</td></tr>
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
					ReplyMoney reply=ReplyMoney.find(re);
			%>
			<tr>
				<td><%=reply.getCode() %></td>
				<td><%=MT.f(reply.getReplyTime()) %></td>
				<td><%=reply.getReplyPrice() %></td>
				<td><%=ReplyMoney.typeARR[reply.getType()] %></td>

			</tr>
			<%
				}
			%>

		</table>
		<table id="tablecenter" cellspacing="0" class="right-tab">
			<tr class="tr0"><td colspan="10" align='left' style="font-size:15px;font-weight:bold;">发票信息</td></tr>
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
		<table id="tablecenter" cellspacing="0" class="right-tab">
			<tr class="tr0"><td colspan="10" align='left' style="font-size:15px;font-weight:bold;">订单信息</td></tr>
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
		<%
			String drsql = " AND bid = "+back.getId();
			int drcount = DeductionRecord.count(drsql);

			if(drcount>0){
		%>
		<table id="tablecenter" cellspacing="0" class="right-tab">
			<tr class="tr0"><td colspan="10" align='left'>扣款信息</td></tr>

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
		<table id="tablecenter" cellspacing="0" class="right-tab">
			<tr class="tr0"><td colspan="10" align='left' style="font-size:15px;font-weight:bold;">补款信息</td></tr>

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

		<div class="center text-c pd20"><button class="btn btn-default" type="button" onclick="history.go(-1)">返回</button></div>


	</div>
</div>


<script>

	mt.fit();
</script>
</body>
</html>
