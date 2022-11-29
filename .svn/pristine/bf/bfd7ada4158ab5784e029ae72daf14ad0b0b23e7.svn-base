<%@page import="tea.entity.yl.shop.ShopPackage"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.yl.shop.ShopExchanged"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%

Http h=new Http(request,response);
	if(h.member<1){
		String param = request.getQueryString();
		String url = request.getRequestURI();
		if(param != null)
			url = url + "?" + param;
		response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
		return;
	}
String act=h.get("act","");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

sql.append(" AND member="+h.member);
par.append("?member="+h.member);

int menuid=h.getInt("id");
int seid=h.getInt("seid");
if(request.getMethod().equals("POST")){
	if("finish".equals(act)){
		ShopExchanged.find(seid).set("status","1");
	}
}
int tab=h.getInt("tab");
par.append("&tab="+tab);

//String[] TAB={"全部","内部专家","外部专家"};
String[] TAB={"全部","等待退换货","已完成"};
String[] SQL={""," AND status=0"," AND status=1"};
int pos=h.getInt("pos");
par.append("&pos=");
int size=20;
String exchanged_code=h.get("exchanged_code","");
if(exchanged_code.length()>0)
{
  sql.append(" AND exchanged_code LIKE "+DbAdapter.cite("%"+exchanged_code+"%"));
  par.append("&exchanged_code="+exchanged_code);
}
String orderid=h.get("orderid","");
if(orderid.length()>0)
{
  sql.append(" AND order_id LIKE "+DbAdapter.cite("%"+orderid+"%"));
  par.append("&orderid="+orderid);
}
Date beginDate=h.getDate("beginDate");
Date endDate=h.getDate("endDate");
if(beginDate!=null)
{
  sql.append(" AND time>="+DbAdapter.cite(beginDate));
  par.append("&beginDate="+beginDate);
}
if(endDate!=null)
{
  sql.append(" and time<"+DbAdapter.cite(endDate));
  par.append("&endDate="+endDate);
}

int count=ShopExchanged.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<h1>订单列表</h1><!--列表-->
<div id="head6"><img height="6" src="about:blank"></div>

<!-- <h2>查询</h2> -->
<form name="form1" action="?" style="display:none" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="td">订单编号：</td><td><input name="orderid" value="<%=orderid%>"/></td>
  <td class="td">退换货编号：</td><td><input name="exchanged_code" value="<%=exchanged_code%>"/></td>
  <td class="td" >退换货下单时间：</td><td><input name="beginDate" value="<%=MT.f(beginDate)%>" id="time_c" style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_c');"/><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_c');">至<input name="endDate" value="<%=MT.f(endDate) %>" id="time_d" style="cursor:pointer" readonly="readonly" onclick="new Calendar().show('form1.time_d');"/><img style="margin-bottom:-8px;" src="/tea/image/bbs_edit/table.gif" onclick="new Calendar().show('form1.time_d');"></td>
  
</tr>
<tr>
  <td colspan="6" align="center"><input type='submit' value='查询' /></td>
</tr>
</table>
</form>
<script>
sup.hquery();
</script>

<%-- <h2>列表&nbsp;（<%=count%>） </h2> --%>
<form name="form2" action="?" method="post">
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="seid"/>
<input type="hidden" name="id" value="<%=menuid %>"/>
<%
out.print("<div class='switch'>");
for(int i=0;i<TAB.length;i++)
{ 
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(i==tab?"current":"")+"'>"+TAB[i]+"（"+ShopExchanged.count(sql.toString()+SQL[i])+"）</a>");
}
out.print("</div>");
%>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">

  <td align="center">序号</td>
  <td align="center">订单编号</td>
  <td align="center">退换货单编号</td>
  <td align="center">商品名称</td>
  <td align="center">退单类型</td>
  <td align="center">退单商品数量</td>
  <td align="center">提交时间</td>
</tr>
<%
sql.append(SQL[tab]);

int sum=ShopExchanged.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='20' align='center'>暂无记录!</td></tr>");
}else
{
	sql.append(" order by status asc,time desc");
    ArrayList list = ShopExchanged.find(sql.toString(),pos,size);
    for (int i = 0;i<list.size(); i++) {
		ShopExchanged se = (ShopExchanged) list.get(i);
		ShopProduct sp=ShopProduct.find(se.product_id);
		ShopPackage spage = new ShopPackage(0);
	    List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
		String pname = "";
		if(sp.isExist){
			pname=sp.getAnchor(h.language);
		}else{
			spage = ShopPackage.find(se.product_id);
			pname="[套装]"+MT.f(spage.getPackageName());
			spagePList.add(0,ShopProduct.find(spage.getProduct_id()));
			String [] sarr = spage.getProduct_link_id().split("\\|");
			for(int m=1;m<sarr.length;m++){
			    spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
			}
		}
		
  %>
  <tr>
    
    <td align="center"><%=i+pos+1 %></td>
    <td align="center"><%=se.orderId %></td>
		<td align="center" ><a href="###" onclick=mt.act('view',"<%=se.id %>")><%=se.exchanged_code %></a></td>
		<td align="center">
			<%
			if(sp.isExist){
				out.print(pname);
			}else{
				out.println("<table width='100%'>");
				out.println("<tr><td>"+pname+"</td></tr>");
				for(int n=0;n<spagePList.size();n++){
					ShopProduct s1 = spagePList.get(n);
					out.println("<tr style='text-align:right;'><td style='text-align:right;'>"+s1.getAnchorX(h.language)+"</td></tr>");
				}
				out.println("</table>");
			}
			%>
		</td>
		<td align="center"><%=se.type==1?"退货":"换货" %></td>
		<td align="center"><%=se.quantity %></td>
		<td align="center"><%=MT.f(se.time,1) %></td>
  </tr>
  
  
  
  <%
  }
  out.print("<td colspan='20' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,size));
}%>
</table>
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id){
	form2.act.value=a;
	form2.seid.value=id;
	if(a=='view'){
		mt.show("/jsp/yl/shop/ShopExchangedDetail.jsp?seid="+id,1,"退换单明细",410,250);
		return;
	}else if(a=="finish"){
		mt.show("确认完成吗？",2,"form2.submit()");
	}
	
}

setFreeze(document.getElementsByTagName('TABLE')[1],0,1);
</script>
</body>
</html>
