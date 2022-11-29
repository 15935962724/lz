<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String order_id=h.get("order_id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&order_id="+order_id);
sql.append(" AND order_id="+DbAdapter.cite(order_id));

int pos=h.getInt("pos");
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1>订单详细</h1>

<h2></h2>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>商品名称</td>
  <td>数量</td>
  <td>价格</td>
</tr>
<%
int sum=ShopOrderData.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=ShopOrderData.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopOrderData t=(ShopOrderData)it.next();
	  ShopProduct sp = ShopProduct.find(t.getProductId());
      
  %>
  <tr>
    <td><%=i%></td>
    <td><%=sp.name[1]%></td>
    <td><%=t.getQuantity()%></td>
    <td><%=t.getAmount()%></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,oid,did)
{
  if(a=='refund')
  {
	  window.open("/jsp/yl/shopweb/ShopExchangedAdd.jsp?oid="+oid+"&did="+did);
  }
};
</script>
</body>
</html>
