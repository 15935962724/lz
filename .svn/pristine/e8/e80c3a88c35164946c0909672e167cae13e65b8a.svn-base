<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
/* if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

if(h.isIllegal())
{
  out.println("非法操作！");
  return;
} */

int menu=h.getInt("id");
int category = h.getInt("category",14102669);
StringBuffer sql=new StringBuffer(""),par=new StringBuffer();
par.append("?id="+menu);

String order_id = MT.f(h.get("order_id"),"");
if(order_id.length()>0)
{
  sql.append(" AND so.order_id = "+Database.cite(order_id));
  par.append("&order_id="+order_id);
}

String company = MT.f(h.get("company"),"");
if(company.length()>0)
{
  sql.append(" AND sodh.n_company LIKE "+Database.cite("%"+company+"%"));
  par.append("&company="+company);
}

String consignees = MT.f(h.get("consignees"),"");
if(consignees.length()>0)
{
	sql.append(" AND so.orderUnit LIKE "+Database.cite("%"+consignees+"%"));
  par.append("&consignees="+consignees);
}

	String lzhd = MT.f(h.get("lzhd"),"");
if(category>1){
	if(lzhd.length()>0)
	{
		
	  //sql.append(" AND spm.model LIKE "+Database.cite("%"+lzhd+"%"));
	  	sql.append(" AND sod.activity LIKE "+Database.cite("%"+lzhd+"%"));
		par.append("&lzhd="+lzhd);
	}
}

String date1 = MT.f(h.get("date1"),"");
String date2 = MT.f(h.get("date2"),"");
if(date1.length()>0)
{
  sql.append(" AND so.createdate > "+Database.cite(date1));
  par.append("&date1="+date1);
}
if(date2.length()>0)
{
  sql.append(" AND so.createdate < "+Database.cite(date2));
  par.append("&date2="+date2);
}

int exflag = h.getInt("exflag",0);
if(exflag==0){
	sql.append(" and so.order_id not in (select order_id from ShopExchanged where type = 1 and status = 1) ");
}else{
	sql.append(" and so.order_id in (select order_id from ShopExchanged where type = 1 and status = 1) ");
}
	par.append("&exflag="+exflag);

int tab=h.getInt("tab",0);
par.append("&tab="+tab);

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1><%= (exflag==0?"成功":"退货") %>订单统计</h1>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type='hidden' name='category' value="<%= category %>">
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='6' class='bornone'>查询</td></tr>
</thead>
<tr>
	<td>
		订单号：<input name="order_id" value="<%= order_id %>" />
	</td>
	<td>
		服务商/订货单位：<input name="consignees" value="<%= consignees %>" />
	</td>
	<%-- 
	<td>
		收货单位：<input name="company" value="<%= company %>" />
	</td>
	--%>
	<td>
		订货日期：<input name="date1" onClick='mt.date(this,false)' readonly style='width:100px' class='date' value="<%= date1 %>" />-<input name="date2"  onClick='mt.date(this,false)' readonly style='width:100px' class='date' value="<%= date2 %>" />
	</td>
	<%
	if(category>1){
		out.print("<td>粒子活度：<input name='lzhd' value='"+lzhd+"' /></td>");
	}
	%>
  <td colspan="2" class='bornone'><button class="btn btn-primary" type="submit">查询</button></td>
  
</tr>
</table>
</div>
</form>

<%out.print("<div class='switch'>");

int lizinum=0,othernum=0;

int sum=0;
double pricesum = 0;//金额总和
double tsum = 0;//退款总和
 List<ShopOrder> solist = ShopOrder.findOrders(category,sql.toString(), 0,Integer.MAX_VALUE);
	for(int e = 0;e<solist.size();e++){
		ShopOrder so = solist.get(e);
		Profile profile = Profile.find(so.getMember());
		ShopOrderDispatch sodh = ShopOrderDispatch.findByOrderId(so.getOrderId());
		List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id = "+Database.cite(so.getOrderId()),0,Integer.MAX_VALUE);
		ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
		double prices = 0;
		int count = 0;
		double price = 0;
		double agent_amount = 0;
		if(so.isLzCategory()){
			for(int r=0;r<sodlist.size();r++){
				ShopOrderData sod = sodlist.get(r);
				prices += sod.getAmount();
				if(profile.membertype == 2){
					//服务商开票价
					//ShopPriceSet sps = ShopPriceSet.find(sodh.getA_hospital_id(),sod.getProductId(),0);
					//agent_amount += sps.agentPrice * sod.getQuantity();
					agent_amount = sod.getAgent_amount();
				}else{
					agent_amount = prices;
				}
				pricesum += agent_amount;
			}
		}else{
			for(int r=0;r<sodlist.size();r++){
				ShopOrderData sod = sodlist.get(r);
				prices += sod.getAmount();
				pricesum += prices;
			}
		}
		double tprice = 0;//退款金额
		List<ShopExchanged> selist = ShopExchanged.find(" AND order_id = "+Database.cite(so.getOrderId())+" AND type = 1 and status = 1 ",0,Integer.MAX_VALUE);
		for(int x=0;x<selist.size();x++){
			ShopExchanged sex = selist.get(x);
			ShopOrderData sod = ShopOrderData.find(" AND product_id = "+sex.product_id+" AND order_id = "+Database.cite(so.getOrderId()),0,1).get(0);
			tprice += (sod.getUnit() * sex.quantity);
		}
		tsum += tprice;
}

 
 sum = solist.size();

out.print("<a href='javascript:showtab(14102669)' class='"+(category==14102669?"current":"")+"'>粒子</a>");
out.print("<a href='javascript:showtab(1)' class='"+(category==14102669?"":"current")+"'>其他</a>");
/* List<ShopCategory> spmlist = ShopCategory.find(" AND father = 14102667 ",0,Integer.MAX_VALUE);

for(int i=0;i<spmlist.size();i++)
{ 
	ShopCategory spm = spmlist.get(i);
  out.print("<a href='javascript:showtab("+spm.category+")' class='"+(i==tab?"current":"")+"'>"+spm.name[1]+"</a>");
} */
out.print("</div>");
%>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type='hidden' name='soeid' value=''>
<input type='hidden' name='type' value=''>
<input type="hidden" name="status"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type="hidden" name="id" value="<%=menu %>"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type='hidden' name='remarks'>
<div class='radiusBox mt15'>
<table cellspacing="0" class='newTable'>
<tr>
<th>订货日期</th>
			<th>
				订单号
			</th>
			<th>
				销售编码
			</th>
			<th>用户</th>
			<th>服务商</th>
			<th>
				订货单位
			</th>
			<th>
				收货单位
			</th>
			<%
				if(category>1){
					out.print("<th>购买数量</th>");
					out.print("<th>活度</th>");
				}
			%>
			<%--<th>
				退货
			</th>
			--%>
			<%
			if(exflag>0){
				out.print("<th>退货金额</th>");
				out.print("<th>退货数量</th>");
			}
			if(category>1){
				out.print("<th>单价</th>");
				out.print("<th>总价</th>");
				out.print("<th>开票价</th>");
			}
			%>
			<th>
				开票金额
			</th>
			<th>
				开票日期
			</th>
			<th>
				原发票号
			</th>
			<%
			if(exflag>0){
				out.print("<th>新发票号</th>");
			}
			%>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
}else
{
	 solist = ShopOrder.findOrders(category,sql.toString(), pos,20);
	for(int e = 0;e<solist.size();e++){
		ShopOrder so = solist.get(e);
		Profile profile = Profile.find(so.getMember());
		String uname = MT.f(profile.member);
		ShopOrderDispatch sodh = ShopOrderDispatch.findByOrderId(so.getOrderId());
		List<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id = "+Database.cite(so.getOrderId()),0,Integer.MAX_VALUE);
		ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
		String proname = "";
		double prices = 0;
		int count = 0;
		double price = 0;
		double agent_unit = 0; 		//服务商开票价
		double agent_amount = 0; 	//服务商开票总价
		boolean tflag = false;
		if(so.isLzCategory()){
			for(int r=0;r<sodlist.size();r++){
				ShopOrderData sod = sodlist.get(r);
				proname = sod.getActivity()+"";
				prices += sod.getAmount();
				//pricesum += prices;
				count += sod.getQuantity();
				price = sod.getUnit();
				if(profile.membertype == 2){
					//服务商开票价
					//ShopPriceSet sps = ShopPriceSet.find(sodh.getA_hospital_id(),sod.getProductId(),0);
					price = sod.getAgent_price_s();		//服务商显示价
            		prices = sod.getAgent_price_s() * sod.getQuantity();	//服务商显示总价
					agent_unit = sod.getAgent_price();
					agent_amount = sod.getAgent_amount();
				}else{
					agent_unit = price;
					agent_amount = prices;
				}
			}
		}else{
			for(int r=0;r<sodlist.size();r++){
				ShopOrderData sod = sodlist.get(r);
				proname = sod.getActivity()+"";
				prices += sod.getAmount();
				count += sod.getQuantity();
				price = sod.getUnit();
			}
		}
		
		double tprice = 0;//退款金额
		int tquantity = 0;//退货数量  此处针对粒子
		List<ShopExchanged> selist = ShopExchanged.find(" AND order_id = "+Database.cite(so.getOrderId())+" AND type = 1 and status = 1 ",0,Integer.MAX_VALUE);
		for(int x=0;x<selist.size();x++){
			ShopExchanged sex = selist.get(x);
			ShopOrderData sod = ShopOrderData.find(" AND product_id = "+sex.product_id+" AND order_id = "+Database.cite(so.getOrderId()),0,1).get(0);
			tprice += (sod.getUnit() * sex.quantity);
			tquantity = sex.quantity;
		}
		
		%>
		<tr>
				    <td><%= MT.f(so.getCreateDate(),2) %></td>
				    <td><%= MT.f(so.getOrderId()) %></td>
				    <td><%= MT.f(soe.NO1) %></td>
				    <td><%=profile.membertype!=2?uname:"" %></td>
				    <td><%=profile.membertype!=2?"":uname %></td>
				    <td><%=profile.membertype!=2?MT.f(so.getOrderUnit()):MT.f(sodh.getA_hospital()) %></td>
				    <td><%=profile.membertype!=2?MT.f(sodh.getN_company()):MT.f(sodh.getA_hospital()) %></td>
				    <%
				    if(category>1){
				    	out.print("<td>"+MT.f(count)+"</td>");
				    	out.print("<td>"+MT.f(proname)+"</td>");
				    }
				    %>
				   <!-- <td><%= (tflag?"是":"否") %></td> -->
				   <%
				    if(exflag>0){
				    	out.print("<td>"+MT.f(tprice,2)+"</td>");
				    	out.print("<td>"+tquantity+"</td>");
				    }
				    
				    if(category>1){
				    	out.print("<td>"+MT.f(price,2)+"</td>");
				    }
				    %>
				    <td><%= MT.f(prices,2) %></td>
				    <% if(category>1){ %>
				    <td><%=agent_unit %></td><!-- 开票价 -->
				   	<td><%=agent_amount %></td><!-- 开票价金额 -->
				   	<%} %>
				    <td><%= MT.f(sodh.getN_invoiceTime()) %></td>
				    <td><%= MT.f(sodh.getN_invoiceNo()) %></td>
				    <%
					if(exflag>0){
						out.print("<td>"+MT.f(sodh.getN_invoiceNoNew())+"</td>");
					}
				    %>
  				</tr>
		<%
}
	%>
  <%
  if(sum>20)out.print("<tr><td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
<%
if(sum>0){
	if(exflag>0){
		out.print("<tr><td colspan='20' align='right'>开票金额合计：<span style='font-weight: bold;'>"+pricesum/10000+"万</span>退款金额：<span style='font-weight: bold;'>"+tsum/10000+"万</span>实际获得金额：<span style='font-weight: bold;'>"+(pricesum-tsum)/10000+"万</span></td></tr>");
	}else{
		out.print("<tr><td colspan='20' align='right'>开票金额合计：<span style='font-weight: bold;'>"+pricesum/10000+"万</span></td></tr>");
	}
}
%>
</table>
</div>
<div class='center mt15'><button class="btn btn-primary" type="button" onclick="dcorder()">导出</button></div>

</form>
<form action="/ShopOrders.do" name="form9"  method="post" target="_ajax" >
	<input name="act" value="exp" type="hidden" />
	<input name="exflag" value="<%= exflag %>" type="hidden"/>
	<input type='hidden' name='category' value="<%= category %>">
		<input type='hidden' name="sql" value="<%= sql.toString() %>" />
</form>
</body>
<script type="text/javascript">
	function showtab(num){
		form1.category.value = num;
		form1.submit();
	}
	function dcorder(){
		form9.submit();
	}
</script>
</html>
