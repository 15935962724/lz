<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

String orderId = MT.dec(h.get("orderId",""));
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
sql.append(" AND order_id="+DbAdapter.cite(orderId));
par.append("&orderId="+orderId);

int sum=ShopOrderData.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

String nexturl = h.get("nexturl");

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
<!DOCTYPE html>
<html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">


</head>
<body>
	<header class="header"><a href="javascript:history.go(-1)"></a>查看信息</header>

<!-- <h1>订单详细</h1>
 -->
<%
int status = so.getStatus();
String statusContent = "";
if(status==0)
	  statusContent = "待付款";
else if(status==1)
	  statusContent = "待发货";
else if(status==2||status==3)
	  statusContent = "待收货";
else if(status==4)
	  statusContent = "已完成";
else if(status==5)
	  statusContent = "取消订单";

ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());

float price = so.getAmount().floatValue();
if(so.isLzCategory()){
	Profile profile = Profile.find(so.getMember());
	ArrayList sodList = ShopOrderData.find(" AND order_id="+Database.cite(so.getOrderId()),0,Integer.MAX_VALUE);
	if(sodList.size()>0){
		ShopOrderData sorderdata = (ShopOrderData)sodList.get(0); //订单详细
		if(profile.qualification==1 && so.isLzCategory()){
			price=sorderdata.getAmount().floatValue();
		}
		if(profile.membertype==2){//医院代理商价格
			price=sorderdata.getAgent_amount();
		}
	}
}

%>
<div class='radiusBox newlist wSpan'>

<ul id="tablecenter" cellspacing="0" >
<li class="bold">订单信息</li>
<li>
	<span>订单编号：</span><%=MT.f(so.getOrderId()) %></li>
<li>
	
	<span>下单时间：</span><%=MT.f(so.getCreateDate(),1) %>
</li>
<li>
	<span>当前状态：</span><%=MT.f(statusContent) %>
	
</li>
<li><span>支付方式：</span><%out.print(so.getPayType()==1?"在线支付":"公司转账"); %>
</li>
<%
if(so.getStatus()==5)
{	
%>
<li>
	<span>取消原因：</span><%=MT.f(so.getCancelReason()) %>
</li>
<%
}
%>
</ul>
<ul>
<li class="bold">收货人信息</li>
<li>
	<span>收货人姓名：</span><%=MT.f(sod.getA_consignees())%>
</li>
<li>	
	<span>手机号：</span><%=MT.f(sod.getA_mobile())%>
</li>
<%
if(MT.f(sod.getA_telphone())!=null&&MT.f(sod.getA_telphone()).length()>0)
{
%>
<li>	
	<span>固定电话：</span><%=MT.f(sod.getA_telphone())%>
</li>
<%
}
%>
<li>	
	<span>邮编：</span><%=MT.f(sod.getA_address())%>
</li>

<%
ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
if(soe.time!=null)
{
%>
</ul>
<ul>
<li class="bold">发货信息</li>
<li>
	<span>快递单号：</span><%=MT.f(soe.express_code)%>
</li>
<li>
	<span>销售编号：</td><td colspan="3" align='left'><%=MT.f(soe.NO1)%>
</li>
<li>
	<span>生产批号：</span'><%=MT.f(soe.NO2)%>
</li>
<li>
	<span>有效期：</span><%=MT.f(soe.vtime)%>
</li>
<li>
	<span>发货日期：</span><%=MT.f(soe.time)%>
</li>
<li>
	<span>发件人：</span><%=MT.f(soe.person)%>
</li>
<li>
	<span>联系电话：</span><%=MT.f(soe.mobile)%>
</li>

<%
}
%>
</ul>
<ul>
<li class="bold">发票信息</li>
<%
if(so.getInvoiceStatus()==3)
{
	ShopOrderExpress seo=ShopOrderExpress.findByOrderId(orderId);
%>
<li>
	<span>开票状态：</span>已开具
</li>
<li>
	<span>开票金额：</span><%= price%>
</li>
<li>
	<span>发票单号：</span><%=MT.f(sod.getN_invoiceNo())%>
</li>
<li>
	<span>快递单号：</span><%=MT.f(sod.getN_expressNo())%>
</li>
<%
}else
{
%>
<li>
	<span>开票状态：</span>未开具
</li>
<li>
	<span>开票金额：</span>
</li>
<%
}
%>
<li>
	<span>开票单位：</span><%=MT.f(sod.getN_company())%>
</li>
<li>
	<span>发票接收人：</span><%=MT.f(sod.getN_consignees())%>
</li>
<li>
	<span>联系电话：</span><%=MT.f(sod.getN_telphone())%>
</li>
<li>
	<span>地址：</span><%=MT.f(sod.getN_address())%>
</li>
</ul>
<%-- <%
if(so.getInvoice()==2)
{
%>
<li>
	<td nowrap align='right' width='10%'>开户行：</td><td align='left'><%=MT.f(sod.getN_openbank()) %></td>
	<td align='right'>账 户</td><td align='left'><%=MT.f(sod.getN_accountNo()) %></td>
</li>
<li>
	<td nowrap align='right'>纳税人识别号</td><td align='left'><%=MT.f(sod.getN_taxpayerid()) %></td>
</li>
<li>
	<td nowrap align='right'>电 话</td><td align='left'><%=MT.f(sod.getN_telphone()) %></td>
	<td nowrap align='right'>邮 编</td><td align='left'><%=MT.f(sod.getN_zip()) %></td>
</li>
<li>
	<td nowrap align='right'>地 址</td><td colspan='3' align='left'><%=MT.f(sod.getN_address()) %></td>
</li>
<%
}
%> --%>
<ul>
<li class='bold'>订单备注</li>
<li><span><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></li>

</ul>
</div>
<style>
.redsize{font-size:12px;padding-right:10px !important;}
.redsize span{font-size:12px !important;}
</style>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act"/>
<div class='radiusBox newlist'>

<ul>
<%
if(sum<1)
{
  out.print("<li>暂无记录!</li>");
}else
{
  Profile pf = Profile.find(so.getMember());
  //根据订单id查询订单详情信息
  Iterator it=ShopOrderData.find(sql.toString(),pos,Integer.MAX_VALUE).iterator();
  for(int i=1;it.hasNext();i++)
  {
	  ShopOrderData t=(ShopOrderData)it.next();
	  
	  //判断product_id是否商品的id，如果不是则为套装id；最后产品或套装中的商品存入list中
      int product_id=t.getProductId();
	  
      ShopProduct sp = ShopProduct.find(product_id);
      ShopPackage spage = new ShopPackage(0);
      List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
      String pname = "";
      boolean isSell = false;
	  if(sp.isExist){
		  pname=sp.getAnchor(h.language);

		  if(t.getActivity()!=null&&!t.getActivity().equals("")){
			  ShopCategory sc = ShopCategory.find(sp.category);
			  pname += "&nbsp;<span style='color:red;'>【"+MT.f(sc.attribute)+"："+t.getActivity()+"】</span>";
		  }
		  if(sp.state==0)
			  isSell = true;
	  }else{
		  spage = ShopPackage.find(product_id);
		  pname="[套装]"+MT.f(spage.getPackageName());
		  ShopProduct s = ShopProduct.find(spage.getProduct_id());
		  if(s.state==0)
			  isSell = true;
		  spagePList.add(0,s);
		  String [] sarr = spage.getProduct_link_id().split("\\|");
		  for(int m=1;m<sarr.length;m++){
			  spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
		  }
	  }
	  
	  out.println("<li>");
	 // out.println("<td align='center'>");
	  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
		  out.println("<img src='"+MT.f(sp.getPicture('b'))+"' alt="+sp.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/>");
	 // out.println("</td>");
	  out.println(pname+"</li>");
	  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals(""))
		  out.println("<li><span style='color:red;'>【校准时间："+MT.f(t.getCalibrationDate())+"】</li>");
	  //out.println("</td>");
	  //out.println("</tr>");
	  
	  //out.println("<tr>");
	  out.println("<li class='redsize'>数量："+t.getQuantity()+"</li>");
	  //out.println("</tr>");
	  
	  if(pf.getMembertype()==2){
		  if(so.isLzCategory()){
			 // out.println("<tr>");
			 // out.println("<li class='redsize'><span>商品单价：</span><em>&yen;&nbsp;"+MT.f((double)t.getAgent_price_s(),2)+"</em></li>");
			//  out.println("</tr>");
			// out.println("<tr>");
			  out.println("<li class='redsize'><span>开票金额：</span><em> &yen;&nbsp;"+MT.f((double)t.getAgent_price(),2)+"</em></li>");
			  //out.println("</tr>");
		  }else{
			//out.println("<tr>");
		  //	out.println("<li class='redsize'><span>商品单价：</span><em> &yen;&nbsp;"+MT.f((double)t.getUnit(),2)+"</em></li>");
		  	//out.println("</tr>");
		  	//out.println("<tr>");
		  	out.println("<li class='redsize'><span>开票金额：</span> <em>&yen;&nbsp;"+MT.f((double)t.getUnit(),2)+"</em></li>");
		  	//out.println("</tr>");
		  }
	  }else{
		//out.println("<tr>");
	  	//out.println("<li class='redsize'><span>商品单价：</span><em> &yen;&nbsp;"+MT.f((double)t.getUnit(),2)+"</em></li>");
	  	//out.println("</tr>");
	  	//out.println("<tr>");
	  	out.println("<li class='redsize'><span>开票金额：</span> <em>&yen;&nbsp;"+MT.f((double)t.getUnit(),2)+" </em></li>");
	  	//out.println("</tr>");
	  }
	  
	  if(!sp.isExist){
		  for(int n=0;n<spagePList.size();n++){
			    ShopProduct s1 = spagePList.get(n);
			    String s1name = s1.getAnchorX(h.language);
			   // out.println("<tr class='tzP'>");
		    	out.println("<li>");
		    	if(s1.picture!=null&s1.picture.length()>0)
		    		out.println("<a href=javascript:parent.location='/xhtml/folder/14110010-1.htm?product="+s1.product+"' target='_blank'><img src='"+MT.f(s1.getPicture('b'))+"' alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
		    	out.println("</li>");
		    	
		    	out.println("<li>"+s1name+"</li>");
		    	out.println("<li><span style='text-decoration:line-through;'>&yen;&nbsp;"+MT.f(s1.price,2)+"</span><span>*"+t.getQuantity()+"</span></li>");
		    	//out.println("</tr>");
  	  	  }
	  }
  }
}
%>
<li class='tagsize redsize'><!-- 商品总价：<span><em>&yen&nbsp;<%=MT.f((double)so.getAmount(),2)%></em></span> -->开票金额：<span><em>&yen&nbsp;<%=price%></em></span></li>
</ul>
</form>


<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,oid,did)
{
  if(a=='refund')
  {
	  window.open("/jsp/yl/shopweb/ShopExchangedAdd.jsp?oid="+oid+"&did="+did);
  }
};

function printView(orderId){
	 window.open("/html/folder/14110866-1.htm?orderId="+orderId);
};
//mt.fit();
</script>
</body>
</html>
