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

int seid=h.getInt("seid");
ShopExchanged se=ShopExchanged.find(seid);
String pname = "";
ShopProduct sp = ShopProduct.find(se.product_id);
if(sp.isExist){
	pname=sp.getAnchor(h.language);
}else{
	ShopPackage spage = ShopPackage.find(se.product_id);
	pname="[套装]"+MT.f(spage.getPackageName());
}

//根据订单id查询订单信息
ShopOrder so = ShopOrder.findByOrderId(se.orderId);

String nexturl = h.get("nexturl");
//上海管理员  14122306
AdminUsrRole aur=AdminUsrRole.find(h.community,h.member);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1>订单详细</h1>


<table id="tablecenter" cellspacing="0" style="margin-top:10px">


<%

	ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
	if(soe.time!=null)
	{
%>
<tr style="font-weight:bold;"><td colspan="4" align='left'>发货信息</td></tr>
<tr>
	<td nowrap align='right'>运单号</td><td colspan="3" align='left'><%=MT.f(soe.express_code)%></td>
</tr>
<tr>
	<td nowrap align='right'>销售编号</td><td align='left'><%=MT.f(soe.NO1)%></td>
	<td nowrap align='right'>生产批号</td><td align='left'><%=MT.f(soe.NO2)%></td>
</tr>
<tr>
	<td nowrap align='right'>有效期</td><td align='left'><%=MT.f(soe.vtime)%></td>
	<td nowrap align='right'>发货日期</td><td align='left'><%=MT.f(soe.time)%></td>
</tr>
<tr>
	<td nowrap align='right'>发件人</td><td align='left'><%=MT.f(soe.person)%></td>
	<td nowrap align='right'>联系电话</td><td align='left'><%=MT.f(soe.mobile)%></td>
</tr>
<%
	}
%>

<tr style="font-weight:bold;"><td colspan="4" align='left'>退货单信息</td></tr>
<tr>
	<td nowrap align='right'>类型</td><td colspan="3" align='left'><%=se.type==1?"退货":"换货" %></td>
</tr>
<tr>
	<td nowrap align='right'>商品名称</td><td align='left'><%=pname%></td>
	<td nowrap align='right'>运单号</td><td align='left'><%=MT.f(se.expressNo) %></td>
</tr>
<tr>
	<td nowrap align='right'>退货数量</td><td align='left'><%=se.quantity %></td>
	<td nowrap align='right'>退货描述</td><td align='left'><%=MT.f(se.description) %></td>
</tr>
<%
	if(se.exchangednum>=0){
		List<SetExchangedRecord> lstex=SetExchangedRecord.find(" and exchangeid = "+se.id, 0, Integer.MAX_VALUE);
		String exnum="";
		if(lstex.size()>0){
			exnum=String.valueOf(se.exchangednum);
		}
%>
<tr>
	<td nowrap align='right'>修改后数量</td><td align='left'><%=exnum %></td>
	
</tr>
<%
	}
%>
<tr>
	<td nowrap align='right'>退换货图片</td><td align='left' colspan="3"><%
String pics=se.picture;
if(pics.length()>0){
	for(int i=1;i<pics.split("[|]").length;i++){
		int pic=Integer.parseInt(pics.split("[|]")[i]);
		out.print("<a href='"+Attch.find(pic).path+"' target='_blank'><img width='50px' src='"+Attch.find(pic).path+"'>");
	}
}else{
	out.print("无");
}

%></td>
</tr>
</table>

<div class="center mt15"><button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button></div>
</body>
</html>
