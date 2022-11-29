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
//ShopNvoice sn = ShopNvoice.getObjByMember(so.getMember());
ArrayList<ShopOrderData> sodlist = ShopOrderData.find(" AND order_id="+DbAdapter.cite(t.getOrder_id()),0,1);
ShopOrderData sod = sodlist.size() < 1 ? new ShopOrderData(0):sodlist.get(0);
Profile p = Profile.find(so.getMember());

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看发票</h1>

<form name="form1" action="/ShopOrderDispatchs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="dispatch" value="<%=dispatch%>"/>
<input type="hidden" name="act" value="invoice"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td width="10%">发票号</td>
    <td><%=MT.f(t.getN_invoiceNo()) %></td>
  </tr>
  <%
  if(so.isLzCategory())
  {
	  if(p.getMembertype() ==2){
  %>
  <tr>
    <td>开票价</td>
    <td><%=MT.f((double)sod.getAgent_price(),2) %></td>
  </tr>
  <tr>
    <td>开票金额</td>
    <td><%=MT.f((double)sod.getAgent_amount(),2) %></td>
  </tr>
  <%
	  }else{
  %>
    <tr>
	    <td>开票价</td>
	    <td><%=MT.f((double)sod.getUnit(),2) %></td>
	</tr>
	<tr>
	    <td>开票金额</td>
	    <td><%=MT.f((double)sod.getAmount(),2) %></td>
	</tr>
  <%
	  }
  }else{
  %>
  <tr>
    <td>开票金额</td>
    <td><%=MT.f((double)sod.getAmount(),2) %></td>
  </tr>
  <%} %>
  <tr>
    <td>快递单号</td>
    <td><%=MT.f(t.getN_expressNo()) %></td>
  </tr>
  <tr>
    <td>开票日期</td>
    <td><%=MT.f(t.getN_invoiceTime()) %></td>
  </tr>
  <tr>
    <td>备注</td>
    <td><%=MT.f(t.getN_remark()) %></td>
  </tr>
</table>

<div class="center mt15">
<button class="btn btn-default" type="button" onclick="history.back();">返回</button></div>
</form>

</body>
</html>
