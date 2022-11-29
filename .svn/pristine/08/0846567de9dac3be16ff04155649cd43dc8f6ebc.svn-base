<%@page import="tea.entity.yl.shop.ShopPackage"%>
<%@page import="tea.entity.yl.shop.ShopOrderDispatch"%>
<%@page import="tea.entity.yl.shop.ShopOrderData"%>
<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.yl.shop.ShopOrder"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
String oid=MT.dec(h.get("oid"));
int did=Integer.parseInt(MT.dec(h.get("did")));
ShopOrderData sd=ShopOrderData.find(did);

ShopOrder so=ShopOrder.findByOrderId(oid);
ShopOrderDispatch sod=ShopOrderDispatch.findByOrderId(oid);
if(so==null||so.getStatus()!=4||so.getMember()!=h.member){
	out.print("非法操作！");
	return;
}

String nexturl = "/xhtml/folder/14111279-1.htm?orderId="+so.getOrderId();

%>
<!DOCTYPE html><html>
<head>
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
<h1>退换货规则</h1>
<p style="line-height:180%;margin-top:10px;">
　　1.外包装及附件产品，退换货时请一并退回<br />
　　2.关于物流损：请您在收货时请务必仔细验货，如发现商品外包装或商品本身外观存在异常，需当场向配送人员指出，并拒收整个包裹；如您在收货后发现外观异常，请在收货24小时内提交退换货申请。如超时未申请，将无法受理。<br />
　　3.如果您在使用时对商品质量表示质疑，您可以提出相关书面鉴定，我们会按照国家法律规定予以处理
</p>
<div class='results'>
<h1 style="padding-top:10px;width:100%;float:left;">订单信息</h1>
<table class="otable" id='tablecenter'>
<%--<tr class="otr" id='tableonetr'>
<td></td>
<td></td>
<td></td>
<td>订单金额</td>
<td>下单时间</td>
</tr>
--%><tr>
<td nowrap width="20%" align="right">订单号：</td><td><%=oid %></td>
<%
ShopProduct s=ShopProduct.find(sd.getProductId());
if(s.isExist)
	out.println("</tr><tr><td nowrap align='right'>商品信息：</td><td>"+s.getAnchorX('t')+s.getAnchorX(h.language)+"</td>");
else{
	ShopPackage spage = ShopPackage.find(sd.getProductId());
	out.println("</tr><tr><td nowrap align='right'>商品信息：</td><td>[套装]"+MT.f(spage.getPackageName())+"</td>");
}
%>
</tr>
<tr><td align="right">商品单价：</td><td><%=MT.f((double)sd.getUnit(),2) %></td></tr>
<tr><td align="right">商品数量：</td><td><%=sd.getQuantity() %></td></tr>
<tr><td align="right">收货人：</td><td><%=sod.getA_consignees() %></td></tr>
<tr><td align="right">下单时间：</td><td><%=MT.f(so.getCreateDate(),1) %></td></tr>

</table>
</div>
<h1 style="padding-top:10px;width:100%;float:left;">服务单明细：</h1>
<form name="form1" action="/ShopExchangeds.do" method="post" target="_ajax" enctype="multipart/form-data" onsubmit="return mt.check(this)">
<input type="hidden" name="oid" value="<%=oid%>">
<input type="hidden" name="product_id" value="<%=sd.getProductId()%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="act" value="madd">
<input type="hidden" name="pro_type" value="<%=so.isLzCategory()%>">
<table class="table2">
<tr>
<td nowrap><font class="red">*</font>服务类型：</td><td><input type="radio" checked name="type" value="1"> 退货&nbsp;&nbsp;&nbsp;<input name="type" type="radio" value="2"> 换货</td>
</tr>
<tr>
<td nowrap><font class="red">*</font>提交数量：</td>
<td>
<a class="num_oper num_min1" id="jian" onclick="reduct()">-</a>
<input  id="personnum" onblur="verifynum(this)"  onkeyup="this.value=this.value.replace(/\D/g,'')" class="input_txt" type="text" size="2" name="quantity" value="1" alt="提交数量"/>
<a class="num_oper num_plus" id="jia" onclick="add()">+</a>
</td>
</tr>
<tr>
<td style='vertical-align:top;'><font class="red">*</font>运单号：</td>
<td nowrap><input name="expressNo" alt="快递单号" class="text_dh"/></td>
</tr>
<tr>
<td nowrap style='vertical-align:top;'><font class="red">*</font>问题描述：</td>
<td><textarea name="description" cols="80" rows="5" alt="问题描述" class="text_area"></textarea></td>
</tr>
<tr>
<td nowrap>图片信息：</td>
<td>
<!-- <input type="button" id="picture2" value="上传图片.."> -->
<input type="file" name="picture" value="上传图片..">
<input type="file" name="picture" value="上传图片..">
<input type="file" name="picture" value="上传图片..">
<input type="file" name="picture" value="上传图片..">
<input type="file" name="picture" value="上传图片..">
<div id="pic"></div>
</td>
</tr>
<tr>
<td></td>
<td>
<p>为了我们更好的解决问题，请您上传图片</p>
<p>最多可上传5张图片，每张图片大小不超过5M，支持gif，jpg，png，jpeg格式的文件</p>
</td>
<tr><td colspan='2' class='btns'><input type="submit" value="提交"></td></tr>
</tr>
</table>
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