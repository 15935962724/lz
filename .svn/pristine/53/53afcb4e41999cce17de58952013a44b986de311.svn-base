<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@ page import="util.Config" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

String orderId = MT.dec(h.get("orderId"));
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

<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>


</head>
<body>
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
<table id="tablecenter" cellspacing="0" >
<tr style="font-weight:bold;"><td colspan="4" align='left' style="border:none;padding-top:15px;">订单信息</td></tr>
<tr>
	<td width="10%" align='right'>订单编号:</td><td align='left' colspan="3"><%=MT.f(so.getOrderId()) %></td>
	
</tr>
<tr>
	
	<td align='right'>下单时间:</td><td align='left' colspan="3"><%=MT.f(so.getCreateDate(),1) %></td>
</tr>
<tr>
	<td width="10%" align='right'>当前状态:</td><td align='left' colspan="3"><%=MT.f(statusContent) %></td>
	
</tr>
<tr>
	
	<td width="10%" align='right'>支付方式:</td><td align='left' colspan="3"><%out.print(so.getPayType()==1?"在线支付":"公司转账"); %></td>
</tr>
<%
if(so.getStatus()==5)
{	
%>
<tr>
	<td width="10%" align='right'>取消原因:</td><td colspan='3' align='left'><%=MT.f(so.getCancelReason()) %></td>
</tr>
<%
}
%>
<tr style="font-weight:bold;"><td colspan="4" align='center' style="border:none;background:#f2f2f2;height:10px;padding:0px;"></td></tr>
<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>收货人信息</td></tr>
<tr>
	<td nowrap align='right'>收货人姓名:</td><td align='left' colspan='3'><%=MT.f(sod.getA_consignees())%></td>
</tr>
<tr>	
	<td nowrap align='right'>手机号:</td><td align='left' colspan='3'><%=MT.f(sod.getA_mobile())%></td>
</tr>
<%
if(MT.f(sod.getA_telphone())!=null&&MT.f(sod.getA_telphone()).length()>0)
{
%>
<tr>	
	<td nowrap align='right'>固定电话:</td><td align='left' colspan='3'><%=MT.f(sod.getA_telphone())%></td>
</tr>
<%
}
%>
<tr>	
	<td nowrap align='right'>邮编:</td><td align='left' colspan='3'><%=MT.f(sod.getA_zipcode())%></td>
</tr>
<tr>
	<td nowrap align='right'>地址:</td><td colspan="3" align='left'><%=MT.f(sod.getA_address())%></td>
</tr>

<%
ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
if(soe.time!=null)
{
%>
<tr style="font-weight:bold;"><td colspan="4" align='center' style="border:none;background:#f2f2f2;height:10px;padding:0px;"></td></tr>
<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>发货信息</td></tr>
<tr>
	<td nowrap align='right'>快递单号:</td><td colspan="3" align='left'><%=MT.f(soe.express_code)%></td>
</tr>
<tr>
	<td nowrap align='right'>销售编号:</td><td colspan="3" align='left'><%=MT.f(soe.NO1)%></td>
</tr>
<tr>
	<td nowrap align='right'>生产批号:</td><td colspan="3" align='left'><%=MT.f(soe.NO2)%></td>
</tr>
	<%
		if(Config.getInt("junan")!=so.getPuid()){
%>
	<tr>
		<td nowrap align='right'>有效期:</td><td colspan="3" align='left'><%=MT.f(soe.vtime)%></td>
	</tr>
	<%
		}
	%>
<tr>
	<td nowrap align='right'>发货日期:</td><td colspan="3" align='left'><%=MT.f(soe.time)%></td>
</tr>
<tr>
	<td nowrap align='right'>发件人:</td><td colspan="3" align='left'><%=MT.f(soe.person)%></td>
</tr>
<tr>
	<td nowrap align='right'>联系电话:</td><td colspan="3" align='left'><%=MT.f(soe.mobile)%></td>
</tr>
<%
}
%>
<tr style="font-weight:bold;"><td colspan="4" align='center' style="border:none;background:#f2f2f2;height:10px;padding:0px;"></td></tr>
<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>发票信息</td></tr>
<%
if(so.getInvoiceStatus()==3)
{
	ShopOrderExpress seo=ShopOrderExpress.findByOrderId(orderId);
%>
<tr>
	<td nowrap align='right'>开票状态:</td><td colspan="3" align='left'>已开具</td>
</tr>
<tr>
	<td nowrap align='right'>开票金额</td><td colspan="3" align='left'><%= price%></td>
</tr>
<tr>
	<td nowrap align='right'>发票单号:</td><td colspan="3" align='left'><%=MT.f(sod.getN_invoiceNo())%></td>
</tr>
<tr>
	<td nowrap align='right'>快递单号:</td><td colspan="3" align='left'><%=MT.f(sod.getN_expressNo())%></td>
</tr>
<%
}else
{
%>
<tr>
	<td nowrap align='right'>开票状态:</td><td colspan="3" align='left'>未开具</td>
</tr>
<tr>
	<td nowrap align='right'>开票金额</td><td colspan="3" align='left'></td>
</tr>
<%
}
%>
<tr>
	<td nowrap align='right'>开票单位:</td><td colspan="3" align='left' ><%=MT.f(sod.getN_company())%></td>
</tr>
<tr>
	<td nowrap align='right'>发票接收人:</td><td colspan="3" align='left'><%=MT.f(sod.getN_consignees())%></td>
</tr>
<tr>
	<td nowrap align='right'>联系电话:</td><td colspan="3" align='left'><%=MT.f(sod.getN_telphone())%></td>
</tr>
<tr>
	<td nowrap align='right'>地址:</td><td colspan="3" align='left' ><%=MT.f(sod.getN_address())%></td>
</tr>

<%-- <%
if(so.getInvoice()==2)
{
%>
<tr>
	<td nowrap align='right' width='10%'>开户行</td><td align='left'><%=MT.f(sod.getN_openbank()) %></td>
	<td align='right'>账 户</td><td align='left'><%=MT.f(sod.getN_accountNo()) %></td>
</tr>
<tr>
	<td nowrap align='right'>纳税人识别号</td><td align='left'><%=MT.f(sod.getN_taxpayerid()) %></td>
</tr>
<tr>
	<td nowrap align='right'>电 话</td><td align='left'><%=MT.f(sod.getN_telphone()) %></td>
	<td nowrap align='right'>邮 编</td><td align='left'><%=MT.f(sod.getN_zip()) %></td>
</tr>
<tr>
	<td nowrap align='right'>地 址</td><td colspan='3' align='left'><%=MT.f(sod.getN_address()) %></td>
</tr>
<%
}
%> --%>
<tr style="font-weight:bold;"><td colspan="4" align='center' style="border:none;background:#f2f2f2;height:10px;padding:0px;"></td></tr>
<tr style="font-weight:bold;"><td colspan="4" align='left' style='border:none;padding-top:15px'>订单备注</td></tr>
<tr><td colspan="4" align='left'><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></td></tr>

</table>
<style>
.redsize{font-size:12px;padding-right:10px !important;}
.redsize span{font-size:12px !important;}
</style>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
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
	  
	  out.println("<tr>");
	  out.println("<td align='center'>");
	  if(sp.isExist&&sp.picture!=null&sp.picture.length()>0)
		  out.println("<a href='/html/folder/14110010-1.htm?product="+sp.product+"' target='_blank'><img src='"+MT.f(sp.getPicture('b'))+"' alt="+sp.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
	  out.println("</td>");
	  out.println("<td align='left'>"+pname);
	  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals(""))
		  out.println("&nbsp;<span style='color:red;'>【校准时间："+MT.f(t.getCalibrationDate())+"】</span>");
	  out.println("</td>");
	  out.println("</tr>");
	  
	  out.println("<tr>");
	  out.println("<td colspan='6' align='right' class='redsize'>数量："+t.getQuantity()+"</td>");
	  out.println("</tr>");
	  
	  if(pf.getMembertype()==2){
		  if(so.isLzCategory()){
			  out.println("<tr>");
			  out.println("<td colspan='6' align='right' class='redsize'><span style='font-size:13px;'>商品单价：&yen;</span>"+MT.f((double)t.getAgent_price_s(),2)+"</td>");
			  out.println("</tr>");
			  out.println("<tr>");
			  out.println("<td colspan='6' align='right' class='redsize'><span style='font-size:13px;'>开票金额：&yen;</span>"+MT.f((double)t.getAgent_price(),2)+"</td>");
			  out.println("</tr>");
		  }else{
			out.println("<tr>");
		  	out.println("<td colspan='6' align='right' class='redsize'><span style='font-size:13px;'>商品单价：&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
		  	out.println("</tr>");
		  	out.println("<tr>");
		  	out.println("<td colspan='6' align='right' class='redsize'><span style='font-size:13px;'>开票金额：&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
		  	out.println("</tr>");
		  }
	  }else{
		out.println("<tr>");
	  	out.println("<td colspan='6' align='right' class='redsize'><span style='font-size:13px;'>商品单价：&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
	  	out.println("</tr>");
	  	out.println("<tr>");
	  	out.println("<td colspan='6' align='right' class='redsize'><span style='font-size:13px;'>开票金额：&yen;</span>"+MT.f((double)t.getUnit(),2)+"</td>");
	  	out.println("</tr>");
	  }
	  
	  if(!sp.isExist){
		  for(int n=0;n<spagePList.size();n++){
			    ShopProduct s1 = spagePList.get(n);
			    String s1name = s1.getAnchorX(h.language);
			    out.println("<tr class='tzP'>");
		    	out.println("<td style='text-align:center;'>");
		    	if(s1.picture!=null&s1.picture.length()>0)
		    		out.println("<a href=javascript:parent.location='/xhtml/folder/14110010-1.htm?product="+s1.product+"' target='_blank'><img src='"+MT.f(s1.getPicture('b'))+"' alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' height='30'/></a>");
		    	out.println("</td>");
		    	
		    	out.println("<td style='text-align:left;'>"+s1name+"</td>");
		    	out.println("<td style='text-align:center;'><span style='text-decoration:line-through;'>&yen&nbsp;"+MT.f(s1.price,2)+"</span><span>*"+t.getQuantity()+"</span></td>");
		    	out.println("</tr>");
  	  	  }
	  }
  }
}
//商品总价改为开票金额
%>
<tr><td colspan="6" style="text-align:right;" class='tagsize redsize'>商品总价：<span>&yen<%=price%></span>
&nbsp;&nbsp;&nbsp;&nbsp;开票金额：<span>&yen&nbsp;<%=price%></span></td>
</table>
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
mt.fit();
</script>
</body>
</html>
