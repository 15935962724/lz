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
<header class="header"><!-- <a href="javascript:history.go(-1)"></a> -->开具发票</header>

<form name="form1" action="/ShopOrderDispatchs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="dispatch" value="<%=dispatch%>"/>
<input type="hidden" name="act" value="invoiceStatus"/>
<input type="hidden" name="invoiceStatus" value="2"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<div class='radiusBox newlist wSpan'>
  <ul class='seachr'>
    <li><span>发票号：</span><input placeholder="发票号" name="n_invoiceNo" value="<%=MT.f(t.getN_invoiceNo()) %>" alt="发票号"/></li>
  <%
  if(so.isLzCategory())
  {
  if(p.getMembertype() ==2){
  %>
  <li>
    <span>开票价：</span><%=MT.f((double)sod.getAgent_price(),2) %>
  </li>
  <li>
    <span>开票金额：</span><%=MT.f((double)sod.getAgent_amount(),2) %>
  </li>
  <%
	  }else{
  %>
    <li>
	    <span>开票价：</span>
	<%=MT.f((double)sod.getUnit(),2) %>
	</li>
	<li>
	    <span>开票金额：</span>
	<%=MT.f((double)sod.getAmount(),2) %>
	</li>
  <%
	  }
  }else{
  %>
  <li>
    <span>开票金额：</span>
   <%=MT.f((double)sod.getAmount(),2) %>
  </li>
  <%} %>
  <li>
    <span>快递单号：</span>
   <input name="n_expressNo" placeholder='快递单号' value="<%=MT.f(t.getN_expressNo()) %>" alt="快递单号"/>
  </li>
  <li>
    <span>开票日期</span>
    <input type="date" alt="开票日期" name="n_invoiceTime" value="<%=MT.f(t.getN_invoiceTime())%>" >
  </li>
  <li>
    <span>备注：</span>
   <%=MT.f(sn.getRemark()) %>
  </li>

<li class='btns'>
<button type="button" onclick="mt.act('invoiceStatus',2);">保存</button>
<button type="button" onclick="mt.act('invoiceStatus',3);">完成</button>
<!-- <button type="button" onclick="history.back();">返回</button>
 --></li>
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
