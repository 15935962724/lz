<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");

String referer=request.getHeader("referer");
if(referer==null||referer.indexOf(request.getServerName())==-1)
{
  response.sendError(404,request.getRequestURI());
  return;
}

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");

String trade=request.getParameter("trade");

Trade obj=Trade.find(trade);

Resource r=new Resource("/tea/ui/member/offer/Offers");

Community community=Community.find(teasession._strCommunity);

String s2 = r.getString(teasession._nLanguage, Common.CURRENCY[obj.getCurrency()]);//货币种类

Supplier supplier=Supplier.find(obj.getSupplier());
//supplier.getName(teasession._nLanguage)
%><html>
<head>
<link href="/tea/CssJs/<%=teasession._strCommunity%>.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body id="bodynone">




<h1><%=r.getString(teasession._nLanguage, "订单信息")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>列表</h2>
<table cellpadding="0" cellspacing="0"  id="tablecenter">
  <tr ID=tableonetr>
    <TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "TradeSubject")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Price")%></TD>
    <TD><%=r.getString(teasession._nLanguage, "Quantity")%></TD>
  </tr>
<%
java.math.BigDecimal total = new java.math.BigDecimal(0.0D);
Enumeration e=TradeItem.findByTrade(trade);
int count=0;
while(e.hasMoreElements())
{
  int tradeitem=((Integer)e.nextElement()).intValue();
  TradeItem obj_ti=TradeItem.find(tradeitem);
  int l = obj_ti.getNode();
  Node node = Node.find(l);

  BigDecimal price = obj_ti.getPrice();
  BigDecimal bigdecimal4=new BigDecimal(obj_ti.getQuantity());

  total=total.add(price.multiply(bigdecimal4));

  %>
  <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
    <td nowrap><%=obj_ti.getTime()%></td>
    <td nowrap><a href="/servlet/Node?node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
    <td>&yen;&nbsp;<%=price%></td>
    <td><%=obj_ti.getQuantity()%></td>
  </tr>
<%
count++;
}
%>
<!-- 总共的价格 -->
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td colspan="5">价格合计:&yen;&nbsp;<%=total%></td>
</tr>
<!-- 总共的个数 -->
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td colspan="5">购买的商品数:<%=count%></td>
</tr>
</table>


<!--收货地址 -->
 <h2>填写收货地址</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="tablejh">
<tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
  <td colspan="2">

       <%
     out.print(tea.entity.util.Card.find(Integer.parseInt(obj.getCity(teasession._nLanguage))).toString());
%>
  </td>
</tr>
<tr>
  <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
  <td colspan="2"><%=obj.getAddress(teasession._nLanguage).replaceAll("</","&lt;/")%></td>
</tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
 <td><%=obj.getEmail()%>
  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
    <td><%=obj.getFirstName(teasession._nLanguage)%></td>
  </tr>
      <tr>
        <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
  <td><%=obj.getOrganization(teasession._nLanguage)%></td>
      </tr>
      <tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
  <td><%=obj.getZip(teasession._nLanguage)%></td>
</tr>
<tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
 <td><%=obj.getTelephone(teasession._nLanguage)%></td>
</tr>
</table>

<br>
<input type=button value="返回" onClick="javascript:history.back()">





<div id="head6"><img height="6" src="about:blank"></div>



</body>
</html>

