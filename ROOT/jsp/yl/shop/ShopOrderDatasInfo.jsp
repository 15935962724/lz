<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.AdminUsrRole"%><%
/**
 查看订单详情-扫码签收单-粒子
*/
Http h=new Http(request,response);

String community = h.get("community","");
if(community.equals("")){
community = h.getCook("community", "Home");
}
h.setCook("community", community, Integer.MAX_VALUE);


    String openid=h.getCook("openid",null);
	if(openid==null){
		response.sendRedirect("/PhoneProjectReport.do?act=openid&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()+"&r="+Math.random()));
		return;
	}
/* Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
} */

String orderId = h.get("orderId");
//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(orderId);
//出厂信息
ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
//
ShopOrderDispatch sod = ShopOrderDispatch.findByOrderId(so.getOrderId());

StringBuffer sql=new StringBuffer();
sql.append(" AND order_id="+DbAdapter.cite(orderId));
//根据订单id查询订单详情信息
List<ShopOrderData> sodList = ShopOrderData.find(sql.toString(),0,Integer.MAX_VALUE);
ShopOrderData orderData = sodList.get(0);
//商品
ShopProduct sp = ShopProduct.find(orderData.getProductId());

%><!DOCTYPE html><html><head>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
	<div id="_printInfo" style="width: 751px;margin: 0 auto;">
		<link href="/jsp/yl/shop/print_css.css" rel="stylesheet" type="text/css" />
		<div class="tits"><h2>中国同辐股份有限公司-医疗粒子</h2>
			<div class="h3">发货交接单</div>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>订单号:<%=MT.f(so.getOrderId()) %></td>
				<td>销售编号:<%=MT.f(soe.NO1) %></td>
				<td>产品批号:<%=MT.f(soe.NO2) %></td>
				<td>发货时间：<%=MT.f(soe.time) %></td>
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
				<td><%=MT.f(sp.name[1]) %></td>
				<td><%=MT.f(sod.getA_hospital()) %></td>
				<td align="right"><%=orderData.getActivity() %></td>
				<td align="right"><%=orderData.getQuantity() %></td>
				<td><%=MT.f(orderData.getCalibrationDate()) %></td>
				<td><%=MT.f(soe.vtime) %></td>
			</tr>
		</table>
 	</div>

<script>
mt.fit();
</script>
</body>
</html>
