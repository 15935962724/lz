<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.html.*" %>
<%@page import="java.math.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?Node="+teasession._nNode);
  return;
}

Resource r=new Resource();
r.add("/tea/ui/member/offer/CheckoutCart3").add("/tea/ui/member/offer/Offers");

String trade=request.getParameter("trade");

BigDecimal total=TradeItem.sumByTrade(trade);

Community communitys=Community.find(teasession._strCommunity);

Trade obj=Trade.find(trade);



%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<script>
function f_tabledetail()
{
  var td=document.getElementById('tabledetail');
  if(td.style.display=="")
  {
    td.style.display="none";
  }else
  {
    td.style.display="";
  }
}
</script>
<body>





<span id="gopath4"></span>
<div id="zhifuhuokuan">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td colspan="3"><%=tea.http.RequestHelper.format(r.getString(teasession._nLanguage, "InfAfterTrade"), new tea.html.Anchor("/jsp/admin/phoneorder/ViewTrade.jsp?trade=" + trade, new tea.html.Text(trade)))%>
<br><span class="gojucu"><A HREF="javascript:f_tabledetail();" >查看订单详情</A></span></td>
</tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" id="tabledetail" style="display:none">
<tr><th>提交时间</th><td><%=obj.getTimeToString()%></td><td>　</td></tr>
<tr><th>购物清单</th><td><%
Enumeration e=TradeItem.findByTrade(trade);
while(e.hasMoreElements())
{
	int ti=((Integer)e.nextElement()).intValue();
	TradeItem ti_obj=TradeItem.find(ti);
	out.print(ti_obj.getSubject()+"　　"+ti_obj.getPrice()+"　　"+ti_obj.getQuantity()+"<br>");
}
%></td><td>　</td></tr>
<tr><th rowspan="7">收货信息</th><td id="cart1right">收货人</td><td><%=obj.getLastName(teasession._nLanguage)+obj.getFirstName(teasession._nLanguage)%>　</td></tr>
<tr><td id="cart1right">地址</td><td><%=obj.getAddress(teasession._nLanguage)%></td></tr>
<tr><td id="cart1right">邮编</td><td><%=obj.getZip(teasession._nLanguage)%></td></tr>
<tr><td id="cart1right">电话</td><td><%=obj.getTelephone(teasession._nLanguage)%></td></tr>
<tr><td id="cart1right">省(洲)</td><td><%=obj.getCityToString(teasession._nLanguage)%></td></tr>
<tr><td id="cart1right">单位</td><td><%=obj.getOrganization(teasession._nLanguage)%>&nbsp;</td></tr>
<tr><td id="cart1right">邮箱</td><td><a href="mailto:<%=obj.getEmail()%>"><%=obj.getEmail()%></a>　</td></tr>
<tr><th rowspan="5">订单金额</th><td id="cart1right">商品总计金额</td><td><%= TradeItem.sumByTrade(trade)%></td></tr>
<!-- <tr><td id="cart1right">配送方式</td><td><%=Trade.PS_TYPE[obj.getPs()]%>　</td></tr>-->
<tr><td id="cart1right">配送费用</td><td><%=obj.getFreight()%>　</td></tr>
<!--<tr><td id="cart1right">支付方式</td><td><%=Trade.DEFRAY_TYPE[obj.getDefray()]%>　</td></tr>-->
<tr><td id="cart1right">需付金额</td><td><%=obj.getTotal()%>　</td></tr>
</table></div>



</body>
</HTML>
