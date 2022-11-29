<%@page import="util.Config"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.Http"%>
<%@ page import="tea.entity.yl.shop.*" %>
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
	int issign = ShopHospital.find(sod.getA_hospital_id()).getIssign();
	if(issign==1) {//20天未签收设置 否 （可以在出库状态下申请退货）
		if (so == null || so.getStatus() != 4 || so.getMember() != h.member) {
			out.print("非法操作！");
			return;
		}
	}
//高科服务快递单号为非必填项
    Profile profile = Profile.find(h.member);
	String p_num = profile.procurementUnit;
    boolean isgaoke = false;
    String gaoke = Config.getString("gaoke");
    if(p_num.indexOf(gaoke)!=-1){//服务商有高科的权限
        isgaoke = true;
    }
//String nexturl = "/html/folder/14111279-1.htm?orderId="+so.getOrderId();
String nexturl=h.get("nexturl");
%>
<!DOCTYPE html><html>
<head>

<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
.red{color:red}
.del{}
.imgs{
 float:left;
}
.bg-info {
    background-color: #d9edf7;
    padding: 10px;
	line-height:200%;
	font-size:14px;
}
.con-left-list .tit-on1{color:#044694;}

#personnum{width: 41px;text-align: center;}
	.right-tab img{float:left;}
</style>
</head>
<body class='returnbody'>

<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<p class="right-zhgl">
			<span>退货规则</span>
		</p>

<p class="bg-info">
<%
int mypuid = ShopOrderData.findPuid(so.getOrderId());
ProcurementUnit pu = ProcurementUnit.find(mypuid);
String mobstr = pu.mobile;

%>
<!-- 1.请务必致电<%= mobstr %>与厂家说明退货原因。<br/> -->
1.请务必联系厂家说明退货原因。<br/>
2.外包装及附件产品，退货时请一并退回<br/>
3.关于物流损：请您在收货时请务必仔细验货，如发现商品外包装或商品本身外观存在异常，需当场向配送人员指出，并拒收整个包裹；如您在收货后发现外观异常，请在收货24小时内提交退货申请。如超时未申请，将无法受理。<br/>
4.如果您在使用时对商品质量表示质疑，您可以提出相关书面鉴定，我们会按照国家法律规定予以处理
</p>
<div class='results'><table class="right-tab" border="1" cellspacing="0" style="margin-top:20px;">
<tr class="otr" id='tableonetr'>
<th>订单号</th>
<th>商品信息</th>
<th>商品单价</th>
<th>商品数量</th>
<th>已退货数量</th>
<th>收货人</th>
<th>下单时间</th>
</tr>
<tr>
<td><%=oid %></td>
<%
ShopProduct s=ShopProduct.find(sd.getProductId());
if(s.isExist)
	out.println("<td style='line-height:41px;vertical-align: middle;'>"+s.getAnchor('t')+s.name[1]+"</td>");
else{
	ShopPackage spage = ShopPackage.find(sd.getProductId());
	out.println("<td>[套装]"+MT.f(spage.getPackageName())+"</td>");
}
	ArrayList<ShopExchanged> shopExchangeds = ShopExchanged.find(" AND order_id=" + Database.cite(so.getOrderId()), 0, Integer.MAX_VALUE);

	int shiji = 0;
	for (int j = 0; j < shopExchangeds.size(); j++) {
		ShopExchanged shopExchanged = shopExchangeds.get(j);
		if(shopExchanged.status==1){
			shiji += shopExchanged.quantity;
		}else if(shopExchanged.status==2){//被拒修改实际数
			shiji += shopExchanged.exchangednum;
		}

	}
%>
<td><span style="font-size:13px;">&yen;</span><%=MT.f((double)sd.getUnit(),2) %></td>
<td><%=sd.getQuantity() %></td>
<td><%=shiji%></td>
<td><%=sod.getA_consignees() %></td>
<td><%=MT.f(so.getCreateDate(),1) %></td>
</tr>

</table>
</div>
<p class="right-zhgl" style="margin-top:10px">
	<span>服务单明细</span>
</p>
		<style>
			.tab1 td{text-align:left;padding:0px 8px;}
			.con-left .bd:nth-child(2){
				display:block;
			}
			.con-left .bd:nth-child(2) li:nth-child(1){
				font-weight: bold;
			}
			.right-tab td,.right-tab th{
				padding:0px 10px;
				text-align:left;
			}
			.form-control{width:auto;}
		</style>
<form name="form1" action="/ShopExchangeds.do" method="post" target="_ajax" enctype="multipart/form-data" onsubmit="return mt.check(this)">
<input type="hidden" name="oid" value="<%=oid%>">
<input type="hidden" name="pro_type" value="<%=so.isLzCategory()%>">
<input type="hidden" name="product_id" value="<%=sd.getProductId()%>">
<input type="hidden" name="nexturl" value="/jsp/yl/shopweb/ShopExchangedList.jsp">
<input type="hidden" name="act" value="add">
	<input type="hidden"  name="type" value="1">
<table class="right-tab tab1" border="1" cellspacing="0" style="margin-top:10px;height:483px;">
<tr>
<td nowrap width="80"><font class="red">*</font>服务类型：</td>
<td><%--<input type="radio" checked name="type" value="1">--%> 退货<%--&nbsp;&nbsp;&nbsp;<input name="type" type="radio" value="2"> 换货--%></td>
</tr>
<tr>
<td nowrap><font class="red">*</font>提交数量：</td>
<td>
<a class="num_oper num_min1" id="jian" onclick="reduct()">-</a>
<input  id="personnum" onblur="verifynum(this)"  onkeyup="this.value=this.value.replace(/\D/g,'')" class="input_txt" type="text" size="6" name="quantity" value="1" alt="提交数量"/>
<a class="num_oper num_plus" id="jia" onclick="add()">+</a>
</td>
</tr>
<tr>
<td style=''><font class="red">*</font>运单号：</td>
<td nowrap><input name="expressNo" <%=isgaoke?"":"alt='快递单号'"%>  class="form-control"/></td>
</tr>
<tr>
<td nowrap style=''><font class="red">*</font>问题描述：</td>
<td><textarea name="description" cols="80" rows="5" alt="问题描述" class="form-control"></textarea></td>
</tr>
<tr>
<td nowrap>图片信息：</td>
<td>
<input type="button" id="picture2" value="上传图片..">
<div id="pic"></div>
</td>
</tr>
<tr>
<td></td>
<td>
<p>为了我们更好的解决问题，请您上传图片</p>
<p>最多可上传5张图片，每张图片大小不超过5M，支持gif，jpg，png，jpeg格式的文件</p>
</td>
<tr><td colspan='2' class='btns text-c'><input type="submit" class="btn btn-primary btn-blue" value="提交"></td></tr>
</tr>
</table>
</form>
	</div>
</div>
</body>
<script>
var upcount=0;
var up=new Upload($$('picture2'),{buttonAction:-100,fileTypes:"*.jpg;*.jpeg;*.png;*.gif;"});
up.fileQueued=function(file)//浏览完成后
{
  if(upcount==5){mt.show("您最多上传5张图片");return;}
  parent.mt.show(null,0);//用于显示上传进度
  this.start();//开始上传 */
  
};

up.uploadProgress=function(f,b,t)
{
  f=this.getFile(f.id);
  parent.mt.progress(b,t,"文件：" +f.name+"<br/>总计：" + mt.f(t/1024,2)+' KB' + "　已传：" + mt.f(b/1024,2)+' KB');
};

up.uploadSuccess=function(file,data)//上传完成后
{  
	data=data.trim().split("|");
	parent.mt.close();
	$("#pic").append("<div class='imgs' id='"+data[0]+"'><a href='"+data[1]+"' target='_blank'><img onload='AutoResizeImage(50,50,this)' src='"+data[1]+"'></a><input type='hidden' name='picture' value='"+data[0]+"'>"+
	"<b class='del' onclick=\"delUploadImg('"+data[0]+"')\">×</b>"+
	"</div><script>mt.fit()<\/script>");
	upcount++;
};
function delUploadImg(id){
	$("#"+id).remove();
	upcount--;
}
var reduct = function() {
	var num = form1.quantity.value;
	if (Number(num) > 1) {
		var n = Number(num) - 1;
		form1.quantity.value = n;
		
	}
}
var add = function() {
	var num = form1.quantity.value;
	if(Number(num)<<%=sd.getQuantity()%>){
		var n = Number(num) + 1;
		form1.quantity.value = n;
	}
		
}
function verifynum(v){
	if(v.value><%=sd.getQuantity()-shiji%>){
		v.value=<%=sd.getQuantity()-shiji%>;
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