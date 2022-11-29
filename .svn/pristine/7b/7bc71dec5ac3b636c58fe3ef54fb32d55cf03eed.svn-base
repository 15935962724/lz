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

StringBuffer sql=new StringBuffer();

String orderId = h.get("orderId");
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
sql.append(" AND order_id="+DbAdapter.cite(orderId));

int sum=ShopOrderData.count(sql.toString());

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
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<!-- <script language="javascript">
var hkey_root,hkey_path,hkey_key
hkey_root="HKEY_CURRENT_USER"
hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"
//设置网页打印的页眉页脚为空

try{
var RegWsh = new ActiveXObject("WScript.Shell")
hkey_key="header" 
RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
hkey_key="footer"
RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
}catch(e){}
</script> -->
<script type="text/javascript">
//设置网页打印的页眉页脚为空
var hkey_root,hkey_path,hkey_key
	hkey_root="HKEY_CURRENT_USER"
	hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\"

</script>
</head>
<body>
<%
int status = so.getStatus();
String statusContent = "";
if(status==0)
	  statusContent = "等待付款";
else if(status==1)
	  statusContent = "等待发货";
else if(status==2)
	  statusContent = "等待收货";
else if(status==3)
	  statusContent = "已完成";
else if(status==4)
	  statusContent = "取消订单";

ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());
%>
<div class='tits'>订单详情</div>
<table id="tablecenter" cellspacing="0">
<tr>
	<td width="10%" nowrap align='right'>订单编号</td><td align='left'><%=MT.f(so.getOrderId()) %></td>
	<td nowrap width="10%" align='right'>下单时间</td><td align='left'><%=MT.f(so.getCreateDate(),1) %></td>
</tr>
<tr>
	<td nowrap align='right'>当前状态</td><td align='left'><%=MT.f(statusContent) %></td>
	<td nowrap align='right'>支付方式</td><td align='left'><%out.print(so.getPayType()==1?"在线支付":"公司转账"); %></td>
</tr>
<%
if(so.getStatus()==4)
{	
%>
<tr>
	<td align='right'>取消原因</td><td colspan="3"><%=MT.f(so.getCancelReason()) %></td>
</tr>
<%
}
%>
<tr style="font-weight:bold;"><td colspan="4" align='left'>收货人信息</td></tr>
<tr>
	<td nowrap width="10%" align='right'>收货人</td><td align='left'><%=MT.f(sod.getA_consignees())%></td>
	<td align='right'>手机号</td><td align='left'><%=MT.f(sod.getA_mobile())%></td>
</tr>
<tr>
	<td nowrap width="10%" align='right'>固定电话</td><td align='left'><%=MT.f(sod.getA_telphone())%></td>
	<td align='right'>邮编</td><td align='left'><%=MT.f(sod.getA_zipcode())%></td>
</tr>
<tr>
	<td align='right'>地址</td><td colspan='3' align='left'><%=MT.f(sod.getA_address())%></td>
</tr>
<tr style="font-weight:bold;"><td colspan="4" align='left'>发票信息</td></tr>
<tr>
	<td align='right'>发票类型</td><td align='left' colspan="3"><%out.print(so.getInvoice()==1?"增值税普通发票":"增值税专用发票"); %></td>
</tr>
<tr>
	<td align='right'>医院名称</td><td align='left' colspan="3"><%=MT.f(sod.getN_company())%></td>
</tr>
<%
if(so.getInvoice()==33)
{
%>
<tr>
	<td nowrap width="10%" align='right'>开户行</td><td align='left'><%=MT.f(sod.getN_openbank()) %></td>
	<td nowrap width="10%" align='right'>账 户</td><td align='left'><%=MT.f(sod.getN_accountNo()) %></td>
</tr>
<tr>
	<td align='right'>纳税人识别号</td><td align='left'><%=MT.f(sod.getN_taxpayerid()) %></td>
	<td align='right'>电 话</td><td align='left' colspan="3"><%=MT.f(sod.getN_telphone()) %></td>
</tr>
<tr>
	<td align='right'>邮 编</td><td align='left' colspan="3"><%=MT.f(sod.getN_zip()) %></td>
</tr>
<tr>
	<td align='right'>地 址</td><td align='left' colspan="3"><%=MT.f(sod.getN_address()) %></td>
</tr>
<%
}
%>
<tr style="font-weight:bold;"><td colspan="1" nowrap align='right'>订单备注</td>
	<td colspan="3" align='left'><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></td>
</tr>

</table>

<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="orderId"/>
<input type="hidden" name="status"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td nowrap align='center' width="10%">商品编号</td>
  <td nowrap align='left'>商品名称</td>
  <td nowrap align='center'>价格</td>
  <td nowrap align='center'>商品数量</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Profile pf = Profile.find(so.getMember());
  
  //根据订单id查询订单详情信息
  Iterator it=ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE).iterator();
  for(int i=1;it.hasNext();i++)
  {
	  ShopOrderData t=(ShopOrderData)it.next();
	  
	  //判断product_id是否商品的id，如果不是则为套装id；最后产品或套装中的商品存入list中
      int product_id=t.getProductId();
      ShopProduct sp = ShopProduct.find(product_id);
      ShopPackage spage = new ShopPackage(0);
      List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
      String pname = "";
	  if(sp.isExist){
		  pname=sp.getAnchor(h.language);
	  }else{
		  spage = ShopPackage.find(product_id);
		  pname="[套装]"+MT.f(spage.getPackageName());
		  spagePList.add(0,ShopProduct.find(spage.getProduct_id()));
		  String [] sarr = spage.getProduct_link_id().split("\\|");
		  for(int m=1;m<sarr.length;m++){
			  spagePList.add(m,ShopProduct.find(Integer.parseInt(sarr[m])));
		  }
	  }
	  out.println("<tr><td style='text-align:center;'>");
	  if(sp.isExist)
		  out.println(sp.yucode);
	  out.println("</td>");
	  out.println("<td style='text-align:left;'>"+pname);
	  if(t.getCalibrationDate()!=null&&!t.getCalibrationDate().equals(""))
		  out.println("&nbsp;&nbsp;<span style='color:red;'>(粒子的校准时间："+MT.f(t.getCalibrationDate())+")</span>");
	  out.println("</td>");
	  out.println("<td style='text-align:center;'>"+t.getAmount()+"</td>");
	  out.println("<td style='text-align:center;'>"+t.getQuantity()+"</td>");
	  out.println("</tr>");
	  
	  if(!sp.isExist){
		  for(int n=0;n<spagePList.size();n++){
			    ShopProduct s1 = spagePList.get(n);
			    out.println("<tr class='tzP'><td style='text-align:center;'>"+s1.yucode+"</td>");
		    	out.println("<td style='text-align:left;'>"+s1.getAnchor(h.language)+"</td>");
		    	out.println("<td style='text-align:center;'>"+t.getAmount()+"</td>");
		    	out.println("<td style='text-align:center;'>"+t.getQuantity()+"</td>");
		    	out.println("</tr>");
  	  	  }
	  }
  }
}%>
<tr>
<td colspan="5" style="text-align:center;">商品总价：<%=MT.f(so.getAmount()) %></td>
</tr>
</table>

</form>
<div id="printP">
<button class="btn btn-default" type="button" onclick="printP()">打印</button>
</div>
<script>
function printP(){
	document.getElementById("printP").style.display="none";
	
	pagesetup_null();

	window.print();
	document.getElementById("printP").style.display="";
	return false;
}
function pagesetup_null(){
	try{
		var RegWsh = new ActiveXObject("WScript.Shell")
		hkey_key="header" 
		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
		hkey_key="footer"
		RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"")
	}catch(e){}
};
mt.fit();
</script>
</body>
</html>
