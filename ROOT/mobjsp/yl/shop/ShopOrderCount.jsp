<%@page import="util.DateUtil"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%@page import="java.text.SimpleDateFormat"%><%
//订单统计 - 企业号
Http h=new Http(request,response);

h.setCook("community", "Home", -1);
String nexturl = h.get("nexturl","/mobjsp/yl/shop/ShopOrderCount.jsp");
	int qywxMember = h.getInt("qywxMember");
	if(qywxMember>0){
		h.member = qywxMember;
	}
if(h.member<1){
  response.sendRedirect("/PhoneProjectReport.do?act=qy&agentid=2&nexturl="+Http.enc(nexturl));
  return;
}

int menu=h.getInt("id");
int category = h.getInt("category",14102669);
StringBuffer sql=new StringBuffer(""),par=new StringBuffer();
par.append("?id="+menu);
sql.append(" AND isLzCategory = 1"); //粒子
String order_id = MT.f(h.get("order_id"),"");
if(order_id.length()>0)
{
  sql.append(" AND so.order_id = "+Database.cite(order_id));
  par.append("&order_id="+order_id);
}

String company = MT.f(h.get("company"),"");
if(company.length()>0)
{
  sql.append(" AND sodh.a_hospital LIKE "+Database.cite("%"+company+"%"));
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
	if(lzhd.length()>0){
	  	sql.append(" AND sod.activity LIKE "+Database.cite("%"+lzhd+"%"));
		par.append("&lzhd="+lzhd);
	}
}

String date1 = MT.f(h.get("date1"),"");
String date2 = MT.f(h.get("date2"),"");
int curD = h.getInt("seldate");
if(curD < 0){
	/* String d2 = DateUtil.curDate();
	String d1 = DateUtil.subMonth(date2, curD);
	
	sql.append(" AND so.createdate > "+Database.cite(d1));
	sql.append(" AND so.createdate < "+Database.cite(d2)); */
}else{
	
	if(date1.length()>0){
	  sql.append(" AND so.createdate > "+Database.cite(date1));
	  par.append("&date1="+date1);
	}
	if(date2.length()>0){
	  sql.append(" AND so.createdate < "+Database.cite(date2));
	  par.append("&date2="+date2);
	}
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

	<form name="form1" action="?">
		<input type="hidden" name="id" value="<%=menu%>"/>
		<input type="hidden" name="tab" value="<%=tab%>"/>
		<input type='hidden' name='category' value="<%= category %>">
		<div class='radiusBox bg'>
			<ul class="seachr">
				<li class='bold'>查询</li>
			 	<%-- <li><span>订单号：</span><input name="order_id" placeholder="订单编号" value="<%=MT.f(order_id)%>"/></li> --%>
			 	<li><span>服务商：</span>
			 	<%-- <input name="consignees" placeholder="服务商"  value="<%= consignees %>"> --%>
			 	<select name="consignees" class='select_' onchange="selhost(this)">
			 		<option value="">全部</option>
			 		<%
			 			List<Profile> plist = Profile.find1(" AND membertype = 2 AND deleted = 0 ", 0, Integer.MAX_VALUE);
			 		for(int i=0;i<plist.size();i++){
			 			Profile p1 = plist.get(i);
			 			out.print("<option "+(consignees.equals(p1.member)?"selected ":"")+" value='"+p1.member+"'>"+p1.member+"</option>");
			 		}
			 		%>
			 	</select>
			 	</li>
			 	<li><span>开票单位：</span>
			 	<%-- <input name="company" placeholder="开票单位" value="<%=MT.f(company)%>"/> --%>
			 	<select id='company' class='select_' name="company" style='width:60%'>
			 		<option value="">全部</option>
			 		<%
			 			List<ShopHospital> slist = ShopHospital.find(" AND addflag = 1 ", 0, Integer.MAX_VALUE);
			 		for(int i=0;i<slist.size();i++){
			 			ShopHospital p1 = slist.get(i);
			 			out.print("<option "+(company.equals(p1.getName())?"selected ":"")+" value='"+p1.getName()+"'>"+p1.getName()+"</option>");
			 		}
			 		%>
			 	</select>
			 	</li>
				<li><span>时间跨度：</span>
					<select name="seldate" class='select_'><option value="0">--请选择--</option>
						<option <%= (curD==-1?"selected ":"") %> value="-1">近一个月</option>
						<!-- <option value="-2">近二个月</option> -->
						<option <%= (curD==-3?"selected ":"") %> value="-3">近三个月</option>
						<option <%= (curD==-6?"selected ":"") %> value="-6">近六个月</option>
						<option <%= (curD==-12?"selected ":"") %> value="-12">近十二个月</option>
					</select>
				</li>
				<li><span>订货日期：</span><input name="date1"  type='date' value="<%= date1 %>" /></li>
				<li><span>至：</span><input name="date2"  type='date' value="<%= date2 %>" /></li>
			<%-- 
			<li><span>发票接收人：</span><input name="consignees" placeholder="发票接收人" value="<%=MT.f(consignees)%>"/></li> --%>
			
			<%-- 	<%
				if(category>1){
					out.print("<li><span>粒子活度：</span><input placeholder='粒子活度' name='lzhd' value='"+lzhd+"' /></li>");
				}
				%> --%>
			  	<li><button type="submit">查询</button></li>
			  
			</ul>
		</div>
	</form>

	<style>
	.newtab{width:100%;}
	.newtab th{background-color:#eee;text-align:left;padding:5px 8px;font-weight:normal;font-size:16px;}
	.newtab td{padding:10px;border-bottom:1px #ddd solid;vertical-align:middle;font-size:18px;; }
	.seachr li span{font-size:18px;}
	</style>

<%
if(curD==0){
	

	int lizinum=0; // 粒子数量
	
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
	
		for(int r=0;r<sodlist.size();r++){
			ShopOrderData sod = sodlist.get(r);
			prices += sod.getAmount();
			if(profile.membertype == 2){
				agent_amount = sod.getAgent_amount();
			}else{
				agent_amount = prices;
			}
			pricesum += agent_amount;
			count += sod.getQuantity(); //数量
		}
		
		lizinum += count; // 粒子数量累计
		
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
	out.print("<div class='radiusBox newlist'>");
		if(sum<1){
		  out.print("<ul class='nenecont'><li>暂无记录!</li></ul>");
		}else{
			out.print("<ul class='total'>");
			out.print("<li><span>粒子数量：<em> "+MT.f(lizinum)+"</em></span></li>");
			out.print("<li><span>开票金额合计：<em> &yen;"+MT.f(pricesum/10000)+"万</em></span></li>");
			out.print("</ul>");
		}
	out.print("</div>");
}else{
	
	
	String myd1 = "";
	String myd2 = "";
	
	Calendar cal=Calendar.getInstance();
	int d=cal.get(Calendar.DATE);
	int y=cal.get(Calendar.YEAR);
	int m=cal.get(Calendar.MONTH);  
	int tom = Math.abs(curD);
	//开始
	/* String mydate = y+"-"+m+"-25";
	if(d>=25){
		mydate = DateUtil.subMonth(mydate,2);
		
	}else{
		mydate = DateUtil.subMonth(mydate,1);
		
	} */
	int nowmonth=m+1;
	String mydate=y+"-"+nowmonth+"-1";//当前月份的第一天
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	//结束
	out.print("<div class='radiusBox bg'>");
	out.print("<table class='newtab'>");
	out.print("<tr><th>日期</th><th>粒子数量</th><th>开票金额合计</th></tr>");
	
	for(int i=0;i<tom;i++){
		StringBuffer mysql = new StringBuffer(sql.toString());
		
		String mydate2 = DateUtil.subMonth(mydate,i*(-1));
		//开始
		//String mydate2 = DateUtil.subMonth(mydate,(i+1)*(-1));
		
		
        //获取当前月份的最后一天
        Calendar calendar = Calendar.getInstance();
		calendar.setTime(sdf.parse(mydate2));
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		Date firstDayOfMonth = calendar.getTime();  
		calendar.add(Calendar.MONTH, 1);
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		Date lastDayOfMonth = calendar.getTime();  
		String mydate1=sdf.format(lastDayOfMonth);
		//结束
		mysql.append(" AND so.createdate >= "+Database.cite(mydate2));
		mysql.append(" AND so.createdate <= "+Database.cite(mydate1));
		
		if(i==0){
		//out.print("==="+mydate1);	
			myd1 = mydate1;
		}
		if(i==tom-1){
			myd2 = mydate2;
			//out.print("==="+mydate2);
		}

		int lizinum=0; // 粒子数量
		
		int sum=0;
		double pricesum = 0;//金额总和
		double tsum = 0;//退款总和
		
		List<ShopOrder> solist = ShopOrder.findOrders(category,mysql.toString(), 0,Integer.MAX_VALUE);
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
		
			for(int r=0;r<sodlist.size();r++){
				ShopOrderData sod = sodlist.get(r);
				prices += sod.getAmount();
				if(profile.membertype == 2){
					agent_amount = sod.getAgent_amount();
				}else{
					agent_amount = prices;
				}
				pricesum += agent_amount;
				count += sod.getQuantity(); //数量
			}
			
			lizinum += count; // 粒子数量累计
			
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
		 //out.print(mydate2+"-"+mydate1+"--"+mysql+"--"+sum+"<br/>");
		 //out.print("<div class='radiusBox newlist'>");
			/* if(sum<1){
			  out.print("<ul class='nenecont'><li>暂无记录!</li></ul>");
			}else{ */
				out.print("<tr><td>"+mydate2+"<br>"+mydate1+"</td><td><em> "+MT.f(lizinum,0)+"</em></td><td><em> &yen;"+(MT.f(pricesum/10000).length()==0?"0":MT.f(pricesum/10000))+"万</em></td></tr>");
				/* out.print("<ul class='total'>");
				out.print("<li>"+mydate2+"-"+mydate1+"</li>");
				out.print("<li><span>粒子数量：<em> &yen;"+MT.f(lizinum,0)+"</em></span></li>");
				out.print("<li><span>开票金额合计：<em> &yen;"+(MT.f(pricesum/10000).length()==0?"0":MT.f(pricesum/10000))+"万</em></span></li>");
				out.print("</ul>"); */
			//}
		//out.print("</div>");
	}
				out.print("</table>");
				out.print("</div>");
	
	
	
	
	
	//out.print(myd2+"-"+myd1);
	sql.append(" AND so.createdate > "+Database.cite(myd2));
	sql.append(" AND so.createdate < "+Database.cite(myd1));
	
	/* if(i==0){
	//out.print("==="+mydate1);	
		myd1 = mydate1;
	}
	if(i==tom-1){
		myd2 = mydate2;
		//out.print("==="+mydate2);
	} */

	
	
	int lizinum=0; // 粒子数量
	
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
	
		for(int r=0;r<sodlist.size();r++){
			ShopOrderData sod = sodlist.get(r);
			prices += sod.getAmount();
			if(profile.membertype == 2){
				agent_amount = sod.getAgent_amount();
			}else{
				agent_amount = prices;
			}
			pricesum += agent_amount;
			count += sod.getQuantity(); //数量
		}
		
		lizinum += count; // 粒子数量累计
		
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
	 //out.print(mydate2+"-"+mydate1+"--"+mysql+"--"+sum+"<br/>");
	 out.print("<div class='radiusBox newlist'>");
		/* if(sum<1){
		  out.print("<ul class='nenecont'><li>暂无记录!</li></ul>");
		}else{ */
			out.print("<ul class='total'>");
			out.print("<li>总计</li>");
			out.print("<li><span>粒子数量：<em> "+MT.f(lizinum,0)+"</em></span></li>");
			out.print("<li><span>开票金额合计：<em> &yen;"+(MT.f(pricesum/10000).length()==0?"0":MT.f(pricesum/10000))+"万</em></span></li>");
			out.print("</ul>");
		//}
	out.print("</div>");
	
	
	//String d1 = DateUtil.subMonth(date2, curD);
}
	%>
	
</body>
<script type="text/javascript">
var myhoss = document.getElementById("company").innerHTML;
function selhost(obj,str){
	if(obj.value==''){
		document.getElementById("company").innerHTML = myhoss;
	}else{
		mt.send("/mobjsp/yl/shop/ajax.jsp?act=selhost&member="+encodeURIComponent(obj.value)+"&str="+encodeURIComponent(str),function(data){
			//alert(data); 
			document.getElementById("company").innerHTML = data;
		});
	}
}
<%
if(consignees.length()>0){
	out.print("selhost(new Option('"+consignees+"','"+consignees+"'),'"+company+"')");
}
%>
</script>
</html>
