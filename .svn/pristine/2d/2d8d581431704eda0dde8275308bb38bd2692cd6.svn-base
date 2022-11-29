<%@page import="tea.entity.yl.shop.ShopPackage"%>
<%@page import="tea.entity.Attch"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.yl.shop.ShopExchanged"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
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
%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#tablecenter img{
padding-right:10px;
}
</style>
</head>
<body>
<table id="tablecenter">
<tr>
<td width="23%">类型：</td>
<td><%=se.type==1?"退货":"换货" %></td>
</tr>
<tr>
<td width="23%">商品名称：</td>
<td><%=pname%></td>
</tr>
<tr>
<td width="23%">快递单号：</td>
<td><%=MT.f(se.expressNo) %></td>
</tr>
<tr>
<td width="23%">申请退货数量：</td>
<td><%=se.quantity %></td>
</tr>
<tr>

<td width="23%">实际退货数量：</td>
<td>
	<%
		if(se.status==0){
			out.print("");
		}else if(se.status==1){
			out.print(se.quantity);
		}else if(se.status==2){
			out.print(se.exchangednum);
		}
	%>
</td>
</tr>
<tr>
<td width="23%">退货描述：</td>
<td><%=MT.f(se.description) %></td>
</tr>
<tr>
<td width="23%">退货图片：</td>
<td><%
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
</body>
</html>
