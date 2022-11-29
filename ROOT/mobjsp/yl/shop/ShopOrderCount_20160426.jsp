<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%
//订单统计 - 企业号
Http h=new Http(request,response);

h.setCook("community", "Home", -1);
String nexturl = h.get("nexturl","/mobjsp/yl/shop/ShopOrderCount.jsp");
if(h.member<1){
  response.sendRedirect("/PhoneProjectReport.do?act=qy&agentid=2&nexturl="+Http.enc(nexturl));
  return;
}

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



%>
<!DOCTYPE html>
<html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<header class="header"><%= (exflag==0?"成功":"退货") %>订单统计</header>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<input type='hidden' name='category' value="<%= category %>">
<div class='radiusBox bg'>
<ul class="seachr">
<li class='bold'>查询</li>
 <li><span>订单号：</span><input name="order_id" placeholder="订单编号" value="<%=MT.f(order_id)%>"/></li>
 <li><span>订货单位：</span><input name="consignees" placeholder="服务商/订货单位"  value="<%= consignees %>"> </li>
<li><span>订货日期：</span><input name="date1"  type='date' value="<%= date1 %>" /></li>
<li><span>至：</span><input name="date2"  type='date' value="<%= date2 %>" /></li>

<li><span>开票单位：</span><input name="company" placeholder="开票单位" value="<%=MT.f(company)%>"/></li>
<li><span>发票接收人：</span><input name="consignees" placeholder="发票接收人" value="<%=MT.f(consignees)%>"/></li>




	<%-- 
	<td>
		收货单位：<input name="company" value="<%= company %>" />
	</td>
	--%>

	<%
	if(category>1){
		out.print("<li><span>粒子活度：</span><input placeholder='粒子活度' name='lzhd' value='"+lzhd+"' /></li>");
	}
	%>
  <li><button type="submit">查询</button></li>
  
</ul>
</div>
</form>

<%out.print("<div class='switch'><ul style='width:100%'>");

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

out.print("<li><a href='javascript:showtab(14102669)' class='"+(category==14102669?"current":"")+"'>粒子</a></li>");
out.print("<li><a href='javascript:showtab(1)' class='"+(category==14102669?"":"current")+"'>其他</a></li>");
/* List<ShopCategory> spmlist = ShopCategory.find(" AND father = 14102667 ",0,Integer.MAX_VALUE);

for(int i=0;i<spmlist.size();i++)
{ 
	ShopCategory spm = spmlist.get(i);
  out.print("<a href='javascript:showtab("+spm.category+")' class='"+(i==tab?"current":"")+"'>"+spm.name[1]+"</a>");
} */
out.print("</ul></div>");
%>
<!-- 
    <script>
        var sumw = 0;
        var ulWidth = document.getElementById("ulwidth");
        var liWidth = document.getElementById("ulwidth").getElementsByTagName("li");
        for(var i=0;i<liWidth.length;i++){
            var liWidths = liWidth[i].clientWidth;
            sumw += liWidths;
            //alert(liWidths);
            //ulWidth.style.width= liWidths+i;
        }
        ulWidth.style.width=sumw+"px";
        
    </script> -->
    

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
<div class='radiusBox newlist'>

			<%--
				if(category>1){
					out.print("<th></th>");
					out.print("<th></th>");
				}
			%>
			<%
			if(exflag>0){
				out.print("<th></th>");
				out.print("<th></th>");
			}
			if(category>1){
				out.print("<th></th>");
				out.print("<th></th>");
				out.print("<th>开票价</th>");
			}
			%>

			<%
			if(exflag>0){
				out.print("<li>新发票号</li>");
			}
			--%>

<%
if(sum<1){
  out.print("<ul class='nenecont'><li>暂无记录!</li></ul>");
}else{
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
		
		%><ul>
				    <li><span class="pder">订货日期：<%= MT.f(so.getCreateDate(),2) %></span>
				    <span class="titme">订单号：<%= MT.f(so.getOrderId()) %></span></li>
				    <li><span class="pder">销售编码：<%= MT.f(soe.NO1) %></span><span class="titme">用户：<%=profile.membertype!=2?uname:"" %></span></li>
				    <li><span class="pder">服务商：<%=profile.membertype!=2?"":uname %></span><span>订货单位：<%=profile.membertype!=2?MT.f(so.getOrderUnit()):MT.f(sodh.getA_hospital()) %></span></li>
				    
				    <li><span>收货单位：<%=profile.membertype!=2?MT.f(sodh.getN_company()):MT.f(sodh.getA_hospital()) %></span></li>
				    <%
				    if(category>1){
				    	out.print("<li><span class='pder'>购买数量："+MT.f(count)+"</span>");
				    	out.print("<span class='titme'>活度："+MT.f(proname)+"</span></li>");
				    }
				    %>
				   <!-- <td><%= (tflag?"是":"否") %></td> -->
				   <%
				    if(exflag>0){
				    	out.print("<li><span class='pder'>退货金额："+MT.f(tprice,2)+"</span>");
				    	out.print("<span class='titme'>退货数量："+tquantity+"</span></li>");
				    }
				    
				    if(category>1){
				    	out.print("<li><span class=''>单价："+MT.f(price,2)+"</span></li>");
				    }
				    %>
				    <li>总价：<%= MT.f(prices,2) %></li>
				    <% if(category>1){ %>
				    <li>开票价：<%=agent_unit %></li><!-- 开票价 -->
				   	<li>开票金额：<%=agent_amount %></li><!-- 开票价金额 -->
				   	<%} %>
				    <li>开票日期：<%= MT.f(sodh.getN_invoiceTime()) %></li>
				    <li>原发票号：<%= MT.f(sodh.getN_invoiceNo()) %></li>
				    <%
					if(exflag>0){
						out.print("<li>新发票号："+MT.f(sodh.getN_invoiceNoNew())+"</li>");
					}
				    %></ul>
		<%
	}
	%>

	<%
	out.print("<ul class='total'>");
	if(sum>0){
		
		if(exflag>0){
			out.print("<li><span>开票金额合计：<em> &yen;"+pricesum+"</em></span></li><li><span>退款金额：<em>"+tsum+"</em></span></li><li>实际获得金额：<em>"+(pricesum-tsum)+"</em></li>");
		}else{
			out.print("<li><span>开票金额合计：<em> &yen;"+pricesum+"</em></span></li>");
		}
		
	}
	out.print("</ul>");
	%>

<%
  if(sum>20)out.print("<div class='page'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>	
</div>

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
