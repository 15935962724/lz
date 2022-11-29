<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

Trade t=Trade.find(h.getInt("trade"));


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看订单</h1>


订单号：<%=t.code%>    状态：<%=MT.f(Trade.STATE_TYPE,t.state)%>
下单时间：<%=MT.f(t.time,1)%>


<table id="tablecenter" cellspacing="0">
  <tr>
    <td>商品编号</td>
    <td>商品名称</td>
    <td>价格</td>
    <td>商品数量</td>
  </tr>
<%
Iterator it=Item.findByTrade(t.trade).iterator();
while(it.hasNext())
{
  Item d=(Item)it.next();
  Product p=Product.find(d.product);
%>
  <tr>
    <td><%=p.product%></td>
    <td><%=p.time==null?"已不存在":p.getAnchor(h.language)%></td>
    <td>￥<%=d.price%></td>
    <td><%=d.quantity%></td>
  </tr>
<%
}

%>
</table>

<table id="tablecenter" cellspacing="0">
  <tr><td><h2>收货人信息</h2></td>
  <tr>
    <td>收货人姓名：</td>
    <td><%=MT.f(t.aname)%></td>
  </tr>
  <tr>
    <td>省　　份：</td>
    <td colspan="2"><%=City.find(t.acity).toString()%></td>
  </tr>
  <tr>
    <td>地　　址：</td>
    <td colspan="2"><%=MT.f(t.aaddress)%></td>
  </tr>
  <tr>
    <td>手机号码：</td>
    <td><%=MT.f(t.amobile)%></td>
  <tr>
    <td>固定电话：</td>
    <td><%=MT.f(t.atel)%></td>
  </tr>
  <tr>
    <td>电子邮件：</td>
    <td><%=MT.f(t.aemail)%></td>
  </tr>
  <tr>
    <td>邮政编码：</td>
    <td><%=MT.f(t.azip)%></td>
  </tr>

<tr><td><h2>支付方式</h2></td></tr>
<tr><td>支付方式：</td><td><%=Trade.PPAYMENT_TYPE[t.ppayment]%></td></tr>
<tr><td>运　　费：</td><td>0.00元(免运费)</td></tr>
<tr><td>送货日期：</td><td><%=Trade.PTIME_TYPE[t.ptime]%></td></tr>

<tr><td><h2>发票类型</h2></td></tr>
  <tr>
    <td>发票类型：</td>
    <td><%=UInvoice.TYPE_NAME[t.itype]%></td>
  </tr>
  <tr>
    <td>发票抬头：</td>
    <td><%=t.itype==0?UInvoice.PAYABLE_TYPE[t.ipayable]:t.ititname%></td>
  </tr>
  <tr>
    <td>发票内容：</td>
    <td><%=UInvoice.CONTENT_TYPE[t.icontent]%></td>
  </tr>

<tr><td><h2>备注</h2></td></tr>
<tr><td colspan="2"><%=MT.f(t.remark,"暂无")%></td></tr>


<tr><td><h2>结算信息</h2></td>
<tr><td colspan="2">商品金额：<%=MT.f(t.total)%>元 + 运费：0.00元 - 优惠券：<%=MT.f(t.coupon)%>元 - 礼品卡：0.00元 - 返现：0.00元 </td>
<tr><th colspan="2" align="right">应付总额：<%=MT.f(t.actually)%>元</th>
</table>

<form name="form1" action="/Trades.do" method="post" enctype="multipart/form-data" target="_ajax">
<input type="hidden" name="act" value="state"/>
<input type="hidden" name="state" value="2"/>
<input type="hidden" name="trade" value="<%=t.trade%>"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="button" value="打印" onclick="window.print()"/>
<%
if(t.state==1)
{
  out.println("<input type='submit' value='确认订单' onclick='f_act(2)' />");
  out.println("<input type='submit' value='取消订单' onclick='f_act(5)' />");
}else if(t.state==2)
{
  out.println("<input type='submit' value='已发货' onclick='f_act(3)' />");
  out.println("<input type='submit' value='取消订单' onclick='f_act(5)' />");
}else if(t.state==3)
{
  out.println("<input type='submit' value='确认收货' onclick='f_act(4)' />");
  out.println("<input type='submit' value='拒收' onclick='f_act(6)' />");
}
%>
<input type="button" value="返回" onclick="history.back()"/>
</form>

<script>
function f_act(s)
{
  form1.state.value=s;
}
</script>
</body>
</html>
