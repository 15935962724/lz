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

ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());

Profile p = Profile.find(so.getMember());
%><!DOCTYPE html><html>
<head>
<meta http-equiv="X-UA-Compatible"content="IE=9; IE=8; IE=7; IE=EDGE">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<style type="text/css">
	.tdt{border-bottom-color:#d7d7d7;border-bottom-width:1px;border-top-style:none;border-bottom-style:solid;background-color:rgb(242, 242, 242);}
</style>
</head>
<body>
<h1>开具发票</h1>
<!-- 订单信息 -->

<div class="radiusBox">
<table id="tdbor" cellspacing="0" class="newTable">
<thead>
<tr><td colspan="7" class="bornone">订单基本信息</td></tr>
</thead>
<tbody>
	<tr id="tableonetr">
	  <th width="260">开票单位</th>
	  <th width="30">数量</th>
	  <th width="30">活度</th>
	  <th width="50">订单编号</th>
	  <th width="50">销售编号</th>
	  <th width="50">生产编号</th>
	  <th width="50">收件人</th>
	</tr>
	
	<tr>
	    <td><%=MT.f(t.getN_company())%></td>
	    <td><%=sod.getQuantity() %></td>
	    <td><%=sod.getActivity() %></td> 
	    <td><%=MT.f(so.getOrderId()) %></td>
	    <td><%=MT.f(soe.NO1)%></td>
	    <td><%=MT.f(soe.NO2)%></td>
	  	<td><%=MT.f(t.getN_consignees())%></td>
  	</tr>

</tbody></table>
</div>

<%-- 
<table id="tablecenter" cellspacing="0" style="margin-top:10px">
<tr style="font-weight:bold;"><td class="tdt" colspan="4" align='left'>订单信息</td></tr>
<tr>
	<td width="10%" align='right'>订单编号</td><td align='left' colspan="3"><%=MT.f(so.getOrderId()) %></td>
</tr>

<tr style="font-weight:bold;"><td class="tdt"  colspan="4" align='left'>收货人信息</td></tr>
<tr>
	<td align='right'>收货人姓名</td><td align='left'><%=MT.f(t.getA_consignees())%></td>
	<td align='right'>医院</td><td align='left'><%=MT.f(t.getA_hospital())%></td>
</tr>
<tr>
	<td align='right'>地址</td><td align='left'><%=MT.f(t.getA_address())%></td>
	<td align='right'>邮编</td><td align='left'><%=MT.f(t.getA_zipcode())%></td>
</tr>
<tr>
	<td align='right'>手机号</td><td align='left'><%=MT.f(t.getA_mobile())%></td>
	<td align='right'>固定电话</td><td align='left'><%=MT.f(t.getA_telphone())%></td>
</tr>

<%
	ShopOrderExpress soe = ShopOrderExpress.findByOrderId(so.getOrderId());
%>
<tr style="font-weight:bold;"><td class="tdt"  colspan="4" align='left'>发货信息</td></tr>
<tr>
	<td nowrap align='right'>销售编号</td><td align='left'><%=MT.f(soe.NO1)%></td>
	<td nowrap align='right'>生产批号</td><td align='left'><%=MT.f(soe.NO2)%></td>
</tr>
<tr>
	<td nowrap align='right'>有效期</td><td align='left'><%=MT.f(soe.vtime)%></td>
	<td nowrap align='right'>发货日期</td><td align='left'><%=MT.f(soe.time)%></td>
</tr>

<tr style="font-weight:bold;"><td class="tdt"  colspan="4" align='left'>发票信息</td></tr>
<tr>
	<td nowrap align='right'>开票单位</td><td align='left'><%=MT.f(t.getN_company())%></td>
	<td nowrap align='right'>发票接收人</td><td align='left'><%=MT.f(t.getN_consignees())%></td>
</tr>
<tr>
	<td nowrap align='right'>联系电话</td><td align='left'><%=MT.f(t.getN_telphone())%></td>
	<td nowrap align='right'>地址</td><td align='left'><%=MT.f(t.getN_address())%></td>
</tr>
<tr style="font-weight:bold;"><td class="tdt"  colspan="4" align='left' style='border:none;'>订单备注</td></tr>
<tr><td colspan="4" align='left' style='color:red'><%out.print(so.getUserRemarks()==null||so.getUserRemarks().length()<1?"无":MT.f(so.getUserRemarks())); %></td></tr>
</table> --%>

<br>

<form name="form1" action="/ShopOrderDispatchs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="dispatch" value="<%=dispatch%>"/>
<input type="hidden" name="act" value="invoiceStatus"/>
<input type="hidden" name="invoiceStatus" value="2"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td width="10%">发票号</td>
    <td><input name="n_invoiceNo" value="<%=MT.f(t.getN_invoiceNo()) %>" size="40" alt="发票号"/></td>
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
    <td><input name="n_expressNo" value="<%=MT.f(t.getN_expressNo()) %>" size="40" alt="快递单号"/></td>
  </tr>
   <tr>
    <td>开票日期</td>
    <td><input type="text" alt="开票日期" name="n_invoiceTime" alt="开票日期" value="<%=MT.f(t.getN_invoiceTime())%>" readonly="readonly" onclick="mt.date(this)"></td>
  </tr>
  <tr>
    <td>备注</td>
    <td><%=MT.f(t.getN_remark()) %></td>
  </tr>
</table>

<div class="center mt15">
<button class="btn btn-primary" type="button" onclick="mt.act('invoiceStatus',2);">保存</button>&nbsp;&nbsp;&nbsp;&nbsp;
<button class="btn btn-primary" type="button" onclick="mt.act('invoiceStatus',3);">完成</button>&nbsp;&nbsp;&nbsp;&nbsp;
<button class="btn btn-default" type="button" onclick="history.back();">返回</button></div>
</form>

<script>form1.n_invoiceNo.focus();</script>
<script language="JavaScript" type="text/javascript">

mt.act=function(a,status)
{
  if(mt.check(document.getElementsByName("form1")[0])){
	  form1.act.value=a;
	  form1.invoiceStatus.value=status;
	  if(a=='invoiceStatus')
	  {
	    form1.submit();
	  }
  }else{
	  return false;
  }
};

function clearNoNum(obj)
{
  //先把非数字的都替换掉，除了数字和.
  obj.value = obj.value.replace(/[^\d.]/g,"");
  //必须保证第一个为数字而不是.
  obj.value = obj.value.replace(/^\./g,"");
  //保证只有出现一个.而没有多个.
  obj.value = obj.value.replace(/\.{2,}/g,".");
  //保证.只出现一次，而不能出现两次以上
  obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}
 </script>

</body>
</html>
