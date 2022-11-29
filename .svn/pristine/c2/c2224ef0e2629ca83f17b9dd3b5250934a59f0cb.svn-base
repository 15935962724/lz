<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.yl.shop.ShopQualification"%>
<%@page import="tea.entity.yl.shop.ShopNvoice"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="tea.entity.yl.shop.ShopOrderDispatch"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
</head>
<%
Http h=new Http(request,response);
String orderId = MT.dec(h.get("orderId"));
Profile p = Profile.find(h.member);
ShopNvoice sn = ShopNvoice.getObjByMember(h.member);
%>
<script src="/tea/mt.js" type="text/javascript"></script>
<body>
	<form action="/ShopOrderForms.do" target="_ajax"  onSubmit="return mt.check(this)" name="form1" method="post" >
	<input type="hidden" name="member" value="<%= h.member%>"/>
	<input type="hidden" name="act" value="nvoice" />
		<!-- /html/folder/19082246-1.htm /html/folder/19092169-1.htm-->
	<input type="hidden" name="nexturl" value="/html/folder/19092169-1.htm" />
	<input type="hidden" name="orderid" value="<%= orderId%>"/>
		<table class="PassWordtable" cellspacing="0">
			<tr>
				<td align='right'>开票单位：</td>
					<td align="left">
						
						<%
							int hospitalId = 0;
							if(p.membertype == 0){
								out.print("<input name='company' alt='开票单位' />");
							}else if(p.membertype == 1){
								ShopQualification sq =  ShopQualification.findByMember(h.member);
								String hosname = ShopHospital.find(sq.hospital_id).getName();
								hospitalId = sq.hospital_id;
								out.print("<input name='company' alt='开票单位' value='"+MT.f(hosname)+"' />");
							}else if(p.membertype == 2){
								/*
									String [] sarr = p.hospitals.split("\\|");
								out.print("<select name='company' alt='开票单位'>");
									out.print("<option value=''>--请选择--</option>");
									for(int i=1;i<sarr.length;i++){
										ShopHospital s1 = ShopHospital.find(Integer.parseInt(sarr[i]));
										out.print("<option value='"+s1.getName()+"'>"+s1.getName()+"</option>");
									}
								out.print("</select>");
								*/
								ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(orderId);
								hospitalId = sod.getA_hospital_id();
								out.print("<input type='hidden' name='company' value='"+MT.f(sod.getA_hospital())+"' />");
								out.print("<span>"+ MT.f(sod.getA_hospital()) +"</span>");
							}
						%>
					</td>
			</tr>
			<tr>
				<td align='right'>发票接收人：</td>
				<td align="left">
					<input type="hidden" name="consignees" value="<%= MT.f(sn.getConsignees()) %>" />
					<select id="_consignees" alt="发票接收人" onchange="selectPro(this.options[this.options.selectedIndex])">
						
					</select>
				</td>
			</tr>
			<tr>
				<td align='right'>联系电话：</td>
				<td align="left"><input id="_mobile" readonly="readonly" name="telphone" alt="联系电话" value="" /></td>
			</tr>	
			<tr>
				<td align='right'>地址：</td>
				<td align="left"><input id="_address" readonly="readonly"  name="address" alt="地址" value="" /></td>
			</tr>
			<tr>
				<td align='right'>备注：</td>
				<td align="left"><textarea name="remark" rows="" cols=""></textarea></td>
			</tr>
			
			<tr><td>&nbsp;</td>
				<td colspan="" align="left">
					<input type="submit" value="保存" class="btn btn-primary"/>
					<input type="button" onClick="history.back();" value="返回" class="btn btn-primary"/>
					<!-- <input type="button" onClick="parent.location='/html/folder/14110184-1.htm';" value="返回" class="btn btn-primary"/> -->
				</td>
			</tr>
		</table>
	</form>
    
<script>
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

mt.fit();
</script>
</body>
</html>