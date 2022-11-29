<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int dispatch=h.getInt("dispatch");
ShopOrderDispatch t=ShopOrderDispatch.find(dispatch);
ShopOrder so = ShopOrder.findByOrderId(t.getOrder_id());
ShopNvoice sn = ShopNvoice.getObjByMember(so.getMember());
ArrayList<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id="+DbAdapter.cite(t.getOrder_id()),0,1);
ShopOrderData sod = sodlist.size() < 1 ? new ShopOrderData(0):sodlist.get(0);
Profile p = Profile.find(so.getMember());

%><!DOCTYPE html><html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">

<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<header class="header"><!-- <a href="javascript:history.go(-1)"></a> -->查看发票</header>


<form name="form1" action="/ShopOrderDispatchs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="dispatch" value="<%=dispatch%>"/>
<input type="hidden" name="act" value="invoice"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<div class='radiusBox bg'>
<ul class="seachr">
	<li><span>发票号：</span><%=MT.f(t.getN_invoiceNo()) %></li>


  <%
  if(so.isLzCategory())
  {
	  if(p.getMembertype() ==2){
  %>
  <li><span>开票价：</span><%=MT.f((double)sod.getAgent_price(),2) %></li>
	<li><span>开票金额：</span><%=MT.f((double)sod.getAgent_amount(),2) %></li>

  <%
	  }else{
  %>
  <li><span>开票价：</span><%=MT.f((double)sod.getUnit(),2) %></li>
<li><span>开票金额：</span><%=MT.f((double)sod.getAmount(),2) %></li>
  <%
	  }
  }else{
  %>
  <li><span>开票金额：</span><%=MT.f((double)sod.getAmount(),2) %></li>

  <%} %>
  <li><span>快递单号：</span><%=MT.f(t.getN_expressNo()) %></li>
  <li><span>开票日期：</span><%=MT.f(t.getN_invoiceTime()) %></li>
  <li><button  type="button" onclick="history.back();">返回</button></li>
</ul>
</form>

</body>
</html>
