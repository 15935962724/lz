<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="tea.entity.yl.shop.*" %>
<%@ page import="util.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

</head>
<%
Http h=new Http(request,response);
int hospitalid=h.getInt("hospital");//医院id
ShopHospital shophospital=ShopHospital.find(hospitalid);
String ids=h.get("ids");//订单id，逗号分隔
String nums=h.get("nums");//开票数量，逗号分隔
String amounts=h.get("amounts");//开票金额，逗号分隔
float totalamount = h.getFloat("totalamount");//申请总金额
int totalnum=h.getInt("totalnum");//申请总数量
String nexturl=h.get("nexturl");
%>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(3){
		font-weight: bold;
	}
	.right-tab th,.right-tab td{padding:0px 5px;}
	.form-control{
		box-sizing:border-box;
	}
	.con-left-list .tit-on1{color:#044694;}

</style>
<body>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<form action="/Invoices.do" target="_ajax"  onSubmit="return mt.check(this)&&mt.show(null,0)" name="form1" id="form1" method="post" >
			<input type="hidden" name="member" value="<%= h.member%>"/>
			<input type="hidden" name="act" value="nvoice" />
			<!-- /html/folder/19082246-1.htm /html/folder/19092169-1.htm-->
			<input type="hidden" name="nexturl" value="/html/folder/19082246-1.htm?nexturl=/jsp/yl/shopwebnew/ListInvoice.jsp" />
			<input type="hidden" name="ids" value="<%=ids %>" />

			<input type="hidden" name="nums" value="<%=nums %>" />
			<input type="hidden" name="amounts" value="<%=amounts %>" />
			<input type="hidden" name="hospitalid" value="<%=hospitalid %>" />

			<input type="hidden" name="totalamount" value="<%=totalamount %>" />
			<input type="hidden" name="totalnum" value="<%=totalnum %>" />

			<table class="right-tab" border="1" cellspacing="0" style="margin-top:0px;">
				<tr>
					<td align='right' width="100">开票单位：</td>
					<td align="left">
						<input name="hospital_name" value="<%=shophospital.getName() %>" type="text">
						<span style="color: gainsboro">原发票单位：<%=shophospital.getName() %></span>
					</td>
				</tr>
				<tr>
					<td align='right'>发票接收人：</td>
					<td align="left">
						<input type="hidden" name="consignees" value="" />
						<select id="_consignees" alt="发票接收人" onchange="selectPro(this.options[this.options.selectedIndex])" class="form-control">

						</select>
					</td>
				</tr>
				<tr>
					<td align='right'>联系电话：</td>
					<td align="left"><input id="_mobile" readonly="readonly" name="telphone" alt="联系电话" value="" class="form-control" /></td>
				</tr>
				<tr>
					<td align='right'>地址：</td>
					<td align="left"><input id="_address" readonly="readonly"  name="address" alt="地址" value="" class="form-control"/></td>
				</tr>
				<%
					int mypuid = 0;
					String activitystr = "";
					String [] idsarr = ids.split(",");
					for(int i=0;i<idsarr.length;i++){
						ShopOrder so = ShopOrder.find(Integer.parseInt(idsarr[i]));
						if(i>0){
							activitystr += "、";
						}
						ShopOrderData sod = ShopOrderData.find(" and order_id="+Database.cite(so.getOrderId()),0,1).get(0);
						mypuid = ShopOrderData.findPuid(so.getOrderId());
						activitystr += sod.getActivity();
						//System.out.println("=="+idsarr[i]);
					}
					if(mypuid==((int)Config.getInt("gaoke"))){
						%>
				<tr>
					<td align='right'>订单活度：</td>
					<td align="left"><%= activitystr%></td>
				</tr>
				<tr>
					<td align='right'>开票活度：</td>
					<td align="left"><input  name="activity" alt="开票活度" value="" class="form-control" /></td>
				</tr>
				<%
					}
				%>
				<tr>
					<td align='right'>备注：</td>
					<td align="left" style="padding:8px 5px"><textarea name="remark" rows="" cols="" class="form-control"></textarea></td>
				</tr>

				<tr>
					<td>&nbsp;</td>
					<td colspan="" align="left">
						<input type="button" value="保存" onclick="tijiao()" class="btn btn-primary btn-blue"/>　
						<input type="button" onClick="history.back();" value="返回" class="btn btn-default"/>
						<!-- <input type="button" onClick="parent.location='/html/folder/14110184-1.htm';" value="返回" class="btn btn-primary"/> -->
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>


    
<script>
function tijiao(){
	mt.show(null,0);
	if(mt.check($("#form1")[0])){
		$.post("/Invoices.do",$("#form1").serialize(),function(data){

			if(data=="1"){

				parent.mt.close();
				//本地：/html/folder/19060276-1.htm
				//测试：/html/folder/19070112-1.htm
				///html/folder/19082246-1.htm
				//正式19092169 测试19082246
				mt.show('操作执行成功！',1,'/jsp/yl/shopwebnew/ListInvoice.jsp');

			}else {
			    mt.show('不可提交开票申请！',1,'/jsp/yl/shopwebnew/ListInvoice.jsp');
			}
		});
	}
}
//查找收货人
mt.send("/Members.do?act=getsign&type=1&hospital=<%=hospitalid%>",function(d)
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