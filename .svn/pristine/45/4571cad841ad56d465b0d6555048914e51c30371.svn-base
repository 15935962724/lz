<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1){
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int dispatch=h.getInt("dispatch");
ShopOrderDispatch t=ShopOrderDispatch.find(dispatch);
ShopOrder so = ShopOrder.findByOrderId(t.getOrder_id());
ArrayList<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id="+DbAdapter.cite(t.getOrder_id()),0,1);
ShopOrderData sod = sodlist.size() < 1 ? new ShopOrderData(0):sodlist.get(0);
//商品
ShopProduct sp = ShopProduct.find(sod.getProductId());
Profile p = Profile.find(so.getMember());

ShopOrderDispatch sodis = ShopOrderDispatch.findByOrderId(so.getOrderId());
double amount = 0.0;
if(so.isLzCategory()){
	if(p.getMembertype() ==2){
		//开票价
		//MT.f((double)sod.getAgent_price(),2);
	  	//开票金额
	  	amount = sod.getAgent_amount();
  	}else{
		//开票价;
		//MT.f((double)sod.getUnit(),2);
		//开票金额
		amount = sod.getAmount();
	}
}else{
	//开票金额
	amount = sod.getAmount();
}

//发票签收 二维码
Map<String,String> map = new HashMap<String,String>();
map.put("act", "invoice");
map.put("orderid",so.getOrderId());
String param = JSON.toJSON(map).toString();
String CODE_URL = "http://www.brachysolution.com/ScanQRCode?"+MT.enc(param);

%><!DOCTYPE html><html><head>
	<link href="/jsp/yl/shop/print_css.css" rel="stylesheet" type="text/css" />
	
	<script src="/tea/mt.js" type="text/javascript"></script>
	<script src="/tea/jquery-1.4.2.min.js" type="text/javascript"></script>
	<script src="/tea/jquery.jqprint-0.3.js" type="text/javascript"></script>
</head>
<body>
<div id="_printInfo" style="width: 751px;margin: 0 auto;">
	<div class="tits"><h2>中国同辐股份有限公司</h2>
		<div class="h3">发票交接单</div>
	</div>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin: 20px 0px 5px 5px">
		<tr>
			<td><span style="font-weight: bold;">订购信息</span></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class='tabline'>
		<tr>
			<th>订单号</th>
			<th>商品名称</th>
			<th>医院</th>
			<th>活度</th>
			<th>商品数量</th>
			<th>校准日期</th>
		</tr>
		<tr>
			<td><%=MT.f(so.getOrderId()) %></td>
			<td><%=MT.f(sp.name[1]) %></td>
			<td><%=MT.f(sodis.getA_hospital()) %></td>
			<td align="right"><%=sod.getActivity() %></td>
			<td align="right"><%=sod.getQuantity() %></td>
			<td><%=MT.f(sod.getCalibrationDate()) %></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin: 20px 0px 5px 5px">
		<tr>
			<td><span style="font-weight: bold;">开票信息</span></td>
		</tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class='tabline'>
		<tr>
			<th>发票号码</th>
			<th>开票单位</th>
			<th>开票金额</th>
			<th>快递单号</th>
			<th>发票接收人</th>
			<th>联系电话</th>
			<th>开票日期</th>
		</tr>
		<tr>
			<td><%=MT.f(sodis.getN_invoiceNo())%></td>
			<td><%=MT.f(sodis.getN_company())%></td>
			<td align="right"><%=MT.f(amount,2) %></td>
			<td><%=MT.f(sodis.getN_expressNo()) %></td>
			<td><%=MT.f(sodis.getN_consignees()) %></td>
			<td><%=MT.f(sodis.getN_telphone())%></td>
			<td><%=MT.f(sodis.getN_invoiceTime())%></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	<div class='borderline'>
		<div><span>发货方：</span>&nbsp;&nbsp;&nbsp;<span>中国同辐股份有限公司</span></div>
		<div style="margin-bottom:0"><span>&nbsp;&nbsp;代表：</span></div>
	</div>
	<table><tr>
		<td style="vertical-align:top;padding:15px 15px" width='70%' class='texts'>
			<p><strong>温馨提示：</strong></p>
			<p class='indent'>如发现开票信息或与商品订购信息描述不符等任何问题，请及时联系我们的售后服务热线 010-68533123。</p>
			<p><strong>签收方式：</strong></p>
			<p class='indent'>通过微信扫一扫，扫描右侧二维码，快速确认收货。</p>
		</td>
		<td width='30%' style='padding:20px 35px'><img id="order_code" src="/CodeServlet?text=<%=CODE_URL%>" width='100%'/></td>
	</tr></table>
</div>
<div class='center mt15'>
    <button class="btn btn-primary" type="button" onclick="printit()">打印</button>
    <button class="btn btn-default" type="button" onclick="history.back();">返回</button>
</div>
    
<script type="text/javascript">
	<%-- window.onload=function(){ 
		//alert("初始化加载"); 
		mt.send("/WeiXins.do?act=invoice&orderid=<%=so.getOrderId()%>",function(data){
			//alert(data);
			document.getElementById("order_code").src = data.trim();
		})
		
		
	}; --%> 
	
	function printit(){
		$("#_printInfo").jqprint();
	}

</script>
</body>
</html>
