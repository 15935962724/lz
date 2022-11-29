<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.yl.shopnew.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

sql.append(" AND fmember="+h.member);


Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND createdate>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND createdate<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

String[] TAB={"未开票催缴","未回款催缴"};
String[] SQL={" AND type = 0 "," AND type = 1 "};

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");

int pos2=h.getInt("pos2",1);

%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
.con-left-list .tit-on1{color:#044694;}

	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(6){
		font-weight: bold;
	}

.mt_data td,.mt_data th{padding:3px}
.btn-primary{width: 77px;height: 34px;background: #044694;color: #fff;border-radius: 5px;border: none;text-align: center;line-height: 34px;font-size: 14px;margin-right: 25px;margin-top: 35px;cursor: pointer;}
</style>
</head>
<body style='min-height:800px'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<form name="form1" action="?">
			<input type="hidden" name="tab" value="<%=tab%>"/>
			<div class="con-right-box con-right-box2">
				<div class="right-line1">
					<p>
						<span>催缴时间：</span>
						<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
						<span style="padding:0 8px">至</span>
						<input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>

					</p>
				</div>
				<input type="submit" class="right-search right-search2" value="查询">
			</div>

		</form>
		<div class="right-list">
		<%out.print("<ul class='right-list-zt'>");
			for(int i=0;i<TAB.length;i++)
			{
				out.print("<li><a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"("+UrgedRecord.count(sql.toString()+SQL[i])+")</a></li>");
			}
			out.print("</ul>");
		%>
		</div>
		<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
			<input type="hidden" name="orderId"/>
			<input type="hidden" name="status"/>
			<input type="hidden" name="cancelReason"/>
			<input type="hidden" name="tab" value="<%=tab%>"/>
			<input type="hidden" name="nexturl"/>
			<input type="hidden" name="act"/>
			<div class="results">
				<table class="right-tab" border="1" cellspacing="0">
					<tr id="tableonetr">
						<th>序号</th>
						<th>催缴时间</th>
						<%if(tab==0){%>
						<th>订单编号</th>
						<%}else {%>
						  <th>发票号</th>
						<%}%>
						<th>医院</th>
						<th>数量</th>
						<%if(tab==0){%>
						<th>下单时间</th>
						<%}else {%>
						<th>发票金额</th>
						<th>开票时间</th>
						<%}%>

						<th>状态</th>

					</tr>
					<%
						sql.append(SQL[tab]);

						int sum=UrgedRecord.count(sql.toString());
						if(sum<1)
						{
							if(tab==0){
							    out.print("<tr><td colspan='7' align='center'>暂无记录!</td></tr>");
							}else {
								out.print("<tr><td colspan='8' align='center'>暂无记录!</td></tr>");
							}
						}else
						{

							List<UrgedRecord> lstrecord=UrgedRecord.find(sql.toString()+" order by createdate desc ",pos,1);
							for(int i=0;i<lstrecord.size();i++)
							{
								UrgedRecord record=lstrecord.get(i);
								String orderids=record.getOrderid();
								String[] orderidarr=orderids.split(",");
								int size=orderidarr.length;
								if(orderidarr.length>10){
									size=10;
								}
								int endpage=pos2*size;
								if(endpage>orderidarr.length){
									endpage=orderidarr.length;
								}
								for(int j=(pos2-1)*10;j<endpage;j++){

									String orderid=orderidarr[j];
									ShopOrder t=ShopOrder.findByOrderId(orderid);

									ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(t.getOrderId());

									String querySql = " AND order_id="+DbAdapter.cite(t.getOrderId());
									List<ShopOrderData> sodList = ShopOrderData.find(querySql,0,Integer.MAX_VALUE);
									ShopOrderData odata=new ShopOrderData(0);
									if(sodList.size()>0){
										odata=sodList.get(0);
									}
									String uname = MT.f(Profile.find(t.getMember()).member);
									int status = t.getStatus();
									String statusContent = "";
									if(status==0)
										statusContent = "等待付款";
									else if(status==1||status==2)
										statusContent = "等待发货";
									else if(status==3)
										statusContent = "等待收货";
									else if(status==4)
										statusContent = "已完成";
									else if(status==5)
										statusContent = "<a href='###' onclick=\"layer.alert('"+MT.f(t.getCancelReason())+"');\">已取消</a>";
					%>
					<tr>
						<%
							if(j==(pos2-1)*10){
						%>
						<td rowspan="<%=orderidarr.length %>"><%=(i+1) %></td>
						<td rowspan="<%=orderidarr.length %>"><%=MT.f(record.getCreatedate(),1) %></td>
						<%
							}if(tab==0){%>
						<td><%=MT.f(t.getOrderId()) %></td>
						<%}else {
							List<InvoiceData> list = InvoiceData.find("AND orderid="+DbAdapter.cite(t.getOrderId()),0,Integer.MAX_VALUE);
							String invoiceno="";
							if(list.size()>0){
							    int invoice_id = list.get(0).getInvoiceid();//发票id
								Invoice invoice = Invoice.find(invoice_id);//获取发票类
								invoiceno = invoice.getInvoiceno();//获取发票号
							}
						%>
						<%=MT.f(invoiceno)%>
							    <%--发票号--%>
						<%}
						%>

						<td><%=MT.f(sod.getA_hospital()) %></td>
						<td><%=odata.getQuantity() %></td>
						<%if(tab==0){%>
						<td><%=MT.f(t.getCreateDate(),1) %></td>
						<%}else {
							String makeOutDate="";
							String amount="";
							List<InvoiceData> list = InvoiceData.find("AND orderid="+DbAdapter.cite(t.getOrderId()),0,Integer.MAX_VALUE);
							if(list.size()>0){
								int invoice_id = list.get(0).getInvoiceid();//发票id
								Invoice invoice = Invoice.find(invoice_id);//获取发票类
								 makeOutDate = MT.f(invoice.getMakeoutdate());//     日期makeoutdate
								amount = MT.f(list.get(0).getAmount());//开票金额
							}

						%>
						<td><%=makeOutDate%></td>
						<td><%=amount%></td>

						    <%--发票金额，开票时间--%>
						<%}%>

						<td><%=statusContent %></td>
					</tr>

					<%
						}
						int orderlength=orderidarr.length;
						if(orderlength>10){
							int totalpage=0;
							if(orderlength%10==0){
								totalpage=orderlength/10;
							}else{
								totalpage=orderlength/10+1;
							}
					%>
					<tr>
						<td colspan="20">
							<%
								if(pos2!=1){
									out.print("<a href='/jsp/yl/shopwebnew/ListUrged.jsp?tab="+tab+"&pos="+pos+"&time0="+time0+"&time1="+time1+"&pos2="+(pos2-1)+"'>上一页</a>");
								}
								if(totalpage<=10){
									for(int p=1;p<=totalpage;p++){
										if(pos2==p){
											out.print("<a><span style='color:#666'>"+p+"</span></a>&nbsp;");
										}else{
							%>

							<a href='/jsp/yl/shopwebnew/ListUrged.jsp?tab=<%=tab %>&pos=<%=pos %>&time0=<%=time0 %>&time1=<%=time1 %>&pos2=<%=p %>'><%=p %></a>&nbsp;


							<%
									}
								}
							}else{

								int jiedian0=1;//开始
								int jiedian=10;//最后
								if(pos2<=jiedian){
									jiedian=10;
									jiedian0=1;
								}else if(pos2>jiedian){
									if(pos2%jiedian!=0){
										jiedian0=(pos2/jiedian)*jiedian+1;
										jiedian=jiedian0+9;

									}else if(pos2%jiedian==0){
										jiedian0=((pos2-1)/jiedian)*jiedian+1;
										jiedian=jiedian0+9;
									}

								}
								if(jiedian>totalpage){
									jiedian=totalpage;
								}
								for(int p=jiedian0;p<=jiedian;p++){
									if(pos2==p){
										out.print("<a><span style='color:#666'>"+p+"</span></a>&nbsp;");
									}else{
							%>

							<a href='/jsp/yl/shopwebnew/ListUrged.jsp?tab=<%=tab %>&pos=<%=pos %>&time0=<%=time0 %>&time1=<%=time1 %>&pos2=<%=p %>'><%=p %></a>&nbsp;


							<%
										}
									}

								}
								if(pos2!=totalpage){
									out.print("<a href='/jsp/yl/shopwebnew/ListUrged.jsp?tab="+tab+"&pos="+pos+"&time0="+time0+"&time1="+time1+"&pos2="+(pos2+1)+"'>下一页</a>");
								}
							%>
						</td>
					</tr>
					<%
								}
							}
							if(sum>1)out.print("<tr><td class='fenye' colspan='10' align='right' id='ggpage'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,1));

						}%>
				</table>
			</div>

			<div class='center text-c pd20'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button></div>

		</form>
		<form action="/ShopOrders.do" name="form3"  method="post" target="_ajax" >
			<input name="act" value="exp_urged" type="hidden" />

			<input type='hidden' name="sql" value="<%= sql.toString() %>" />
		</form>
	</div>


<script>

function dcorder(){
	form3.submit();
}
mt.fit();
</script>
</body>
</html>
