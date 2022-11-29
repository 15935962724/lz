<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.yl.shop.ShopQualification"%>
<%@page import="tea.entity.yl.shop.ShopNvoice"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="tea.entity.yl.shop.ShopOrderDispatch"%>
<!DOCTYPE html>
<html><head>

<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">

<title>索要发票</title>

</head>
<%
Http h=new Http(request,response);
String orderId = MT.dec(h.get("orderId"));
Profile p = Profile.find(h.member);
ShopNvoice sn = ShopNvoice.getObjByMember(h.member);

String nexturl = h.get("nexturl");
%>
<script src="/tea/mt.js" type="text/javascript"></script>
<body>
	<form action="/ShopOrderForms.do" target="_ajax"  onSubmit="return mt.check(this)" name="form1" method="post" >
	<input type="hidden" name="member" value="<%= h.member%>"/>
	<input type="hidden" name="act" value="nvoice" />
	<input type="hidden" name="nexturl" value="<%=nexturl %>" />
	<input type="hidden" name="orderid" value="<%= orderId%>"/>
	<header class="header"><a href="javascript:history.go(-1)"></a>索要发票</header>
<div class='radiusBox newlist wSpan'>
<ul class="seachr">
			<li>
				<span>开票单位：</span>
						
				<%
					int hospitalId = 0;
					if(p.membertype == 0){
						out.print("<input name='company'  />");
					}else if(p.membertype == 1){
						ShopQualification sq =  ShopQualification.findByMember(h.member);
						hospitalId = sq.hospital_id;
						String hosname = ShopHospital.find(sq.hospital_id).getName();							
						out.print("<input name='company' value='"+MT.f(hosname)+"' />");
					}else if(p.membertype == 2){
						ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderId);
						hospitalId = sod.getA_hospital_id();
						out.print("<input type='hidden' name='company' value='"+MT.f(sod.getA_hospital())+"' />");
						out.print( MT.f(sod.getA_hospital()) );
					}
				%>
			</li>
			<li>
				<span>发票接收人：</span>
				<input type="hidden" name="consignees" placeholder="请输入发票接收人" value="<%= MT.f(sn.getConsignees()) %>" />
				<select id="_consignees" alt="发票接收人" onchange="selectPro(this.options[this.options.selectedIndex])">
				</select>
			</li>
			<li>
				<span>联系电话：</span><input id="_mobile" readonly="readonly" name="telphone" placeholder="请输入联系电话" alt="联系电话" value="<%= MT.f(sn.getTelphone()) %>" />
			</li>	
			<li>
				<span>地址：</span><input id="_address" readonly="readonly" name="address" placeholder="请输入地址" alt="地址" value="<%= MT.f(sn.getAddress()) %>" />
			</li>
			<li class="bold">备注：</li>
				<li><textarea name="remark" placeholder="请输入备注说明" rows="6" cols="" id='textar'></textarea>
			</li>
			<li><button type="submit" value="保存">保存</button></li>
			</ul>
		</div>
	</form>
<script type="text/javascript">
//查找收货人
mt.send("/Members.do?act=getsign&type=1&hospital=<%=hospitalId%>",function(d)
{
   var sel = document.getElementById("_consignees");
   sel.innerHTML = d;
});

//选择签收人
function selectPro(obj){
	//alert(obj.value + "-" + obj.text);
	form1.consignees.value = obj.text;
	//查找收货人
	mt.send("/Members.do?act=selsign&profile="+obj.value,function(d)
	{
		var obj = eval(d);
		document.getElementById("_mobile").value=obj[0].mobile;
		document.getElementById("_address").value=obj[0].address;
	});
}
</script>
</body>
</html>