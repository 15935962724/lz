<%@page import="java.util.List"%>
<%@page import="tea.entity.yl.shop.ShopPackage"%>
<%@page import="tea.entity.yl.shop.ShopOrderDispatch"%>
<%@page import="tea.entity.yl.shop.ShopOrderData"%>
<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.yl.shop.ShopOrder"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.Filex"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
String oid=h.get("oid");
//int did=Integer.parseInt(MT.dec(h.get("did")));
//ShopOrderData sd=ShopOrderData.find(did);

ShopOrder so=ShopOrder.findByOrderId(oid);
Filex.logs("ytth.txt", so.getId()+","+so.getStatus()+","+so.getMember()+","+h.member);
ShopOrderDispatch sod=ShopOrderDispatch.findByOrderId(oid);
if(so==null||so.getStatus()!=4||so.getMember()!=h.member){
	out.print("非法操作！");
	return;
}
//根据订单id查询订单详情信息
List<ShopOrderData> sodList = ShopOrderData.find(" AND order_id="+DbAdapter.cite(oid),0,Integer.MAX_VALUE);
ShopOrderData sd = sodList.get(0);

String nexturl = "/xhtml/folder/14111279-1.htm?orderId="+MT.enc(so.getOrderId());

%>
<!DOCTYPE html>
<html>

<head>
 <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
<style>
.red{color:red}
.del{}
.imgs{
 float:left;
}
.table2{
 height: 440px;
}
</style>
</head>
<body class='returnbody'>


<header class="header">申请退换货</header>

<div class='radiusBox newlist wSpan'>
<ul>
	<li class="bold">退换货规则</li>

<li class="texts">
　　1.外包装及附件产品，退换货时请一并退回<br />
　　2.关于物流损：请您在收货时请务必仔细验货，如发现商品外包装或商品本身外观存在异常，需当场向配送人员指出，并拒收整个包裹；如您在收货后发现外观异常，请在收货24小时内提交退换货申请。如超时未申请，将无法受理。<br />
　　3.如果您在使用时对商品质量表示质疑，您可以提出相关书面鉴定，我们会按照国家法律规定予以处理
</li></ul>
</div>
<div class='radiusBox newlist wSpan'>
<ul>
	<li class="bold">订单信息</li>

<li>
<span>订单号：</span><%=oid %></li>
<%
ShopProduct s=ShopProduct.find(sd.getProductId());
if(s.isExist)
	out.println("<li><span>商品信息：</span>"+s.getAnchorX(h.language)+"</li>");
else{
	ShopPackage spage = ShopPackage.find(sd.getProductId());
	out.println("<li><span>商品信息：</span>[套装]"+MT.f(spage.getPackageName())+"</li>");
}
%>
<li><span>粒子活度：</span><%= sd.getActivity()+" X "+ sd.getQuantity()%></li>
<li><span>收货人：</span><%=sod.getA_consignees() %></li>
<li><span>校准时间：</span><%=MT.f(sd.getCalibrationDate()) %></li>

</ul>
</div>
<div class='radiusBox newlist wSpan'>
<ul>
	<li class="bold">服务单明细</li>

<form name="form1" action="/ShopExchangeds.do" method="post" target="_ajax" enctype="multipart/form-data" onsubmit="return mt.check(this)">
<input type="hidden" name="oid" value="<%=oid%>">
<input type="hidden" name="product_id" value="<%=sd.getProductId()%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="madd">
<input type="hidden" name="pro_type" value="<%=so.isLzCategory()%>">

<li><span><font class="red">*</font>服务类型：</span><input type="radio" checked name="type" value="1"> 退货&nbsp;&nbsp;&nbsp;<input name="type" type="radio" value="2"> 换货
</li>
<li>
<span><font class="red">*</font>提交数量：</span>
<a class="num_oper num_min1" id="jian" onclick="reduct()">-</a>
<input  id="personnum" onblur="verifynum(this)"  onkeyup="this.value=this.value.replace(/\D/g,'')" class="input_txt" type="text" size="2" name="quantity" value="1" alt="提交数量"/>
<a class="num_oper num_plus" id="jia" onclick="add()">+</a>

</li>
<li>
<span><font class="red">*</font>运单号：</span><input name="expressNo" alt="快递单号" class="text_dh"/>
</li>
<li>
<span><font class="red">请填写真实有效的信息，避免退货失败！</font></span>
</li>
<li>
<span><font class="red">*</font>问题描述：</span><br>
<textarea name="description"  rows="5" alt="问题描述" class="text_area"></textarea>
</li>
<li class="files">
<span>图片信息：</span>

<!-- <input type="button" id="picture2" value="上传图片.."> -->
<a href="javascript:;">上传图片..<input type="file" name="picture" value="上传图片.."></a>
<a href="javascript:;">上传图片..<input type="file" name="picture" value="上传图片.."></a>
<a href="javascript:;">上传图片..<input type="file" name="picture" value="上传图片.."></a>
<a href="javascript:;">上传图片..<input type="file" name="picture" value="上传图片.."></a>
<div id="pic"></div>
</li>
<li>


<p>为了我们更好的解决问题，请您上传图片</p>
<p>最多可上传5张图片，每张图片大小不超过5M，支持gif，jpg，png，jpeg格式的文件</p>
</li>
<li class='btns'><button type="submit" value="">提交</button></li>

</ul>
</div>

</form>
</body>
<script>
var reduct = function() {
	var num = form1.quantity.value;
	if (Number(num) > 1) {
		var n = Number(num) - 1;
		form1.quantity.value = n;
		
	}
};
var add = function() {
	var num = form1.quantity.value;
	if(Number(num)<<%=sd.getQuantity()%>){
		var n = Number(num) + 1;
		form1.quantity.value = n;
	}
		
};
function verifynum(v){
	if(v.value><%=sd.getQuantity()%>){
		v.value=<%=sd.getQuantity()%>;
	}
	if(v.value<1){
		v.value = 1;
	}
};
</script>
<script>
mt.fit();
</script>
</html>