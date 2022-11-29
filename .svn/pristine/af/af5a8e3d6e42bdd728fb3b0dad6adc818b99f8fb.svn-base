<%@page import="com.alibaba.fastjson.JSON"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.AdminUsrRole"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String orderId = h.get("orderId");
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
//出厂信息
/* ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
//
ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());

StringBuffer sql=new StringBuffer();
sql.append(" AND order_id="+DbAdapter.cite(orderId));
//根据订单id查询订单详情信息
List<ShopOrderData> sodList = ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE);
ShopOrderData orderData = sodList.get(0);
//商品
ShopProduct sp = ShopProduct.find(orderData.getProductId());

String nexturl = h.get("nexturl");
//上海管理员  14122306
//AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);

//粒子签收 二维码
Map<String,String> map = new HashMap<String,String>();
map.put("act", "lzsign");
map.put("orderid",so.getOrderId());
String param = JSON.toJSON(map).toString();
String CODE_URL = "http://www.brachysolution.com/ScanQRCode?"+MT.enc(param); */

%><!DOCTYPE html>
<html>
<head>
	<link href="/jsp/yl/shop/print_css.css" rel="stylesheet" type="text/css" />
	
	<script src="/tea/mt.js" type="text/javascript"></script>
	<script src="/tea/jquery-1.4.2.min.js" type="text/javascript"></script>
	<script src="/tea/jquery.jqprint-0.3.js" type="text/javascript"></script>
</head>
<body>
	<div id="_printInfo" style="width: 751px;margin: 0 auto;">
		<div class="tits"><h2>中国同辐股份有限公司-医疗粒子</h2>
			<div class="h3">发货交接单</div>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>订单号:</td>
				<td>销售编号:</td>
				<td>产品批号:</td>
				<td>发货时间：</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class='tabline'>
			<tr>
				<th>商品名称</th>
				<th>医院</th>
				<th>活度</th>
				<th>商品数量</th>
				<th>校准日期</th>
				<th>有效期</th>
			</tr>
			<tr>
				<td></td>
				<td></td>
				<td align="right"></td>
				<td align="right"></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
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
		<div class='borderline' style="min-height:140px">
		<div  class='borderlineleft' style="float:left;width:40%">
			<div><span>发货方：</span>&nbsp;&nbsp;&nbsp;<span>中国同辐股份有限公司</span></div>
			<div ><span>代表：</span></div>
			<div ><span>日期：</span></div>
			</div>
		
		<div class='borderlineright' style="float:right;width:40%">
			<div><span>收货方：</span>&nbsp;&nbsp;&nbsp;<span></span></div>
			<div ><span>代表：</span></div>
			<div ><span>日期：</span></div>
		</div>
		</div>
		<table><tr>
			<td style="vertical-align:top;padding:15px 15px" width='70%' class='texts'>
				<p><strong>温馨提示：</strong></p>
				<p class='indent'>如发现商品破损或与商品订购信息描述不符等任何问题，请及时联系我们的售后服务热线 010-68533123。</p>
				<p><strong>签收方式：</strong></p>
				<p class='indent'>通过微信扫一扫，扫描右侧二维码，快速确认收货。</p>
			</td>
			<td width='30%' style='padding:20px 35px'><img id="order_code" src="" width='100%'/></td>
		</tr></table>
 	</div>
 	<div class='center mt15'>
	    <button class="btn btn-primary" type="button" onclick="printit()">打印</button>
	    <button class="btn btn-default" type="button" onclick="history.back();">返回</button>
    </div>

    <script type="text/javascript">
    
		<%-- window.onload=function(){ 
			//alert("初始化加载"); 
			mt.send("/WeiXins.do?act=lzcode&orderid=<%=so.getOrderId()%>",function(data){
				//alert(data);
				document.getElementById("order_code").src = data.trim();
			})
		}; --%> 
		
		function printit(){
			$("#_printInfo").jqprint();
		}
	
	</script>
	
	<script>
		mt.fit();
	</script>
</body>
</html>
