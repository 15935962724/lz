<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="tea.entity.yl.shop.*" %>
<%@ page import="tea.entity.Database" %>
<%@ page import="util.Config" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<!-- <link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css"> -->
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">

<title></title>
<!--script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script-->
<title>提交发票申请</title>
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
<body>
<!-- <header class="header">提交发票申请</header> -->
	<form action="/Invoices.do" target="_ajax"  onSubmit="return mt.check(this)&&mt.show(null,0)" name="form1" id="form1" method="post" >
	<input type="hidden" name="member" value="<%= h.member%>"/>
	<input type="hidden" name="act" value="nvoice" />
	<input type="hidden" name="nexturl" value="/mobjsp/yl/shopwebnew/ListInvoice_wx.jsp" />
	<input type="hidden" name="ids" value="<%=ids %>" />
	
	<input type="hidden" name="nums" value="<%=nums %>" />
	<input type="hidden" name="amounts" value="<%=amounts %>" />
	<input type="hidden" name="hospitalid" value="<%=hospitalid %>" />
	
	<input type="hidden" name="totalamount" value="<%=totalamount %>" />
	<input type="hidden" name="totalnum" value="<%=totalnum %>" />
	
		<!-- <table id="tableweb" class="getfp" cellspacing="0">
			<tr>
				<td align='left'>开票单位：</td>
					<td align="left">
						
						<%=shophospital.getName() %>
					</td>
			</tr>
			<tr>
				<td align='left'>发票接收人：</td>
				<td align="left">
					<input type="hidden" name="consignees" value="" />
					<select id="_consignees" alt="发票接收人" onchange="selectPro(this.options[this.options.selectedIndex])">
						
					</select>
				</td>
			</tr>
			<tr>
				<td align='left'>联系电话：</td>
				<td align="left"><input id="_mobile" readonly="readonly" name="telphone" alt="联系电话" value="" /></td>
			</tr>	
			<tr>
				<td align='left'>地址：</td>
				<td align="left"><input id="_address" readonly="readonly"  name="address" alt="地址" value="" /></td>
			</tr>
			<tr>
				<td align='left'>备注：</td>
				<td align="left"><textarea name="remark" rows="" cols=""></textarea></td>
			</tr>
			
			<tr><td>&nbsp;</td>
				<td colspan="" align="left">
					<input type="button" value="保存" class="btn btn-primary" onclick="tijiao()"/>
					<input type="button" onClick="history.back();" value="返回" class="btn btn-primary"/>
					<input type="button" onClick="parent.location='/html/folder/14110184-1.htm';" value="返回" class="btn btn-primary"/>
				</td>
			</tr>
		</table> -->
		<div class="order-sea get-div">
			<p>
				<span class="ft14 order-l-span">开票单位：</span>
				<span class="ft14 get-span" style="border:none;"><%=shophospital.getName() %></span>
			</p>
			<p>
				<span class="ft14 order-l-span">发票接收人：</span>
				<input type="hidden" name="consignees" value="" />
				<select  class="get-span" id="_consignees" alt="发票接收人" onchange="selectPro(this.options[this.options.selectedIndex])">
				</select>
			</p>
			<p>
				<span class="ft14 order-l-span">联系电话：</span>
				<input  class="get-span" id="_mobile" readonly="readonly" name="telphone" alt="联系电话" value="" />
			</p>
			<p>
				<span class="ft14 order-l-span">地址：</span>
				<input  class="get-span" id="_address" readonly="readonly"  name="address" alt="地址" value="" />
			</p>
			<%
				int mypuid = 0;
				String activitystr = "";
				String [] idsarr = ids.split(",");
				for(int i=0;i<idsarr.length;i++){
					ShopOrder so = ShopOrder.find(Integer.parseInt(idsarr[i]));
					if(i>0){
						activitystr += "、";
					}
					ShopOrderData sod = ShopOrderData.find(" and order_id="+ Database.cite(so.getOrderId()),0,1).get(0);
					mypuid = ShopOrderData.findPuid(so.getOrderId());
					activitystr += sod.getActivity();
					//System.out.println("=="+idsarr[i]);
				}
				if(mypuid==((int) Config.getInt("gaoke"))){
					%>
			<p>
				<span class="ft14 order-l-span">订单活度：</span>
				<%= activitystr%>
			</p>
			<p>
				<span class="ft14 order-l-span">开票活度：</span>
				<input  class="get-span"   name="activity" alt="开票活度" value="" />
			</p>
			<%
				}
			%>
			<p>
				<span class="ft14 order-l-span">备注：</span>
				<textarea name="remark" rows=""  class="get-span" cols=""></textarea>
			</p>
			<p>
				<em style="flex: 1"></em>
				<input class="get-inp" type="button" value="保存" class="btn btn-primary" onclick="tijiao()"/>
				<input style="margin-left:15px" class="get-inp" type="button" onClick="history.back();" value="返回" class="btn btn-primary"/>
				<em style="flex: 1"></em>

			</p>
		</div>
	</form>
    
<script>
function tijiao(){
	mt.show(null,0);
	if(mt.check($("#form1")[0])){
		$.post("/Invoices.do",$("#form1").serialize(),function(data){

			if(data==1){
				mt.close();

				//mt.show('操作执行成功！',1,'/mobjsp/yl/shopwebnew/ListInvoice_wx.jsp');
				mt.show('操作执行成功！',1,'/mobjsp/yl/shopweb/ListInvoice.jsp');

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