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

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body id="bodynone">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<div id="tablebgnone">
<h1><%=r.getString(teasession._nLanguage, "修改订单信息")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>列表-<%=supplier.getName(teasession._nLanguage)%></h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
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
    <td nowrap><%=obj_ti.getTimeToString()%></td>
    <td nowrap><a href="/servlet/Node?node=<%=l%>&Language=<%=teasession._nLanguage%>"><%=node.getSubject(teasession._nLanguage)%></a></td>
    <td><%=s2+price%></td>
    <td><%=obj_ti.getQuantity()%></td>
  </tr>
<%
count++;
}
%>
<!-- 总共的价格 -->
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td colspan="5">价格合计:<%=s2+total%></td>
</tr>
<!-- 总共的个数 -->
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
  <td colspan="5">购买的商品数:<%=count%></td>
</tr>
</table>

<%--
<!-- 积分管理在这个表格里 -->
<h2>双重积分</h2>
<table cellpadding="0" cellspacing="0" bordercolor="0" id="tablecenter">
  <tr>
    <td height="32">
      您本次购买将获得本站积分<%=total_point%>分，如果您拥<%=supplier.getName(teasession._nLanguage)%>的积分卡则可同时获得商场积分
      <a href="/jsp/admin/9000_3.jsp" target="_blank">（双积分）</a>；
    </td>
  </tr>

  <tr>
    <td>
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td><%=supplier.getName(teasession._nLanguage)%></td>
          <td><input type="text" name="point"></td>
            <td>请在此处填写您<%=supplier.getName(teasession._nLanguage)%>的积分卡号，如果没有可以为空；</td>
        </tr>
      </table>
</td>
  </tr>
</table>
--%>

<!--收货地址 -->
 <h2>填写收货地址</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" class="tablejh">
<tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "State")%>:</Td>
  <td>
      <%//=r.getString(teasession._nLanguage,"Province."+Common.PROVINCE[p.getState(teasession._nLanguage)])%>
      <%=r.getString(teasession._nLanguage, "City")%>:<%=obj.getCity(teasession._nLanguage)%>
  </td>
</tr>
<tr>
  <td id="left"><%=r.getString(teasession._nLanguage, "收货地址")%></Td>
  <td><%=obj.getAddress(teasession._nLanguage).replaceAll("</","&lt;/")%></td>  <td>*我们将根据此地址发送您选的商品并计算发货费用；</td>
</tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "EmailAddress")%>:</Td>
    <td><%=obj.getEmail()%></td><td>*我们会通过邮件形式通知您发货情况；</td>
  </tr>
  <tr>
    <Td id="left"><%=r.getString(teasession._nLanguage, "LastName")%><%=r.getString(teasession._nLanguage, "FirstName")%>:</Td>
    <td><%=obj.getFirstName(teasession._nLanguage)%></td>
      <td>*接收时需要接受人签字；</td>        </tr>
      <tr>
        <Td id="left"><%=r.getString(teasession._nLanguage, "Organization")%>:</Td>
        <td><%=obj.getOrganization(teasession._nLanguage)%></td>  <td>*指明接收单位，以免地址有误时错送；</td>
      </tr>
      <tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "Zip")%>:</Td>
  <td><%=obj.getZip(teasession._nLanguage)%></td><td>*正确填写，以方便发货方更快的找到您；</td>
</tr>
<tr>
  <Td id="left"><%=r.getString(teasession._nLanguage, "Telephone")%>:</td>
  <td><%=obj.getTelephone(teasession._nLanguage)%></td><td>*紧急联系方式，请正确填写。</td>
</tr>
</table>

<h2>配送方式</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
switch(obj.getPs())
{
  case 0:
  out.print("<tr><td nowrap>平邮</td><td>如果您不急于使用此商品可以考虑选择平邮，此种方式邮购费用最低但邮递时间很长；</td></tr>");
  break;
  case 1:
  out.print("<tr><td nowrap>快递</td><td>此方式邮递时间很短，但需要携带个人相关证件到快地公司去取，费用也相应贵些；</td></tr>");
  break;
  case 2:
  out.print("<tr><td nowrap>EMS</td><td>邮政特快专递服务，是中国邮政的一个服务产品，主要是采取空运方式，加快递送速度，一般来说根据地区远近，1－4天到达。</td></tr>");
  break;
}
%>
</table>

<h2>支付方式</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
switch(obj.getDefray())
{
  case 0:
  out.print("<tr><td nowrap>支付宝</td><td></td></tr>");
  break;
  case 1:
  out.print("<tr><td nowrap>网上支付</td><td>通过您的网上银行进行支付，安全便捷；</td></tr>");
  break;
  case 2:
  out.print("<tr><td nowrap>邮局汇款</td><td>通过邮局将钱汇到指定帐号，安全可靠，只是速度慢！</td></tr>");
  break;
  case 3:
  out.print("<tr><td nowrap>银行电汇</td><td></td></tr>");
}
%>
</table>

<h2>发票</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
if(obj.getFp()==0)
{
  out.print("<tr><td nowrap>要发票</td><td></td></tr>");
}else
{
    out.print("<tr><td nowrap>不要发票</td><td></td></tr>");
}
%>
</table>

<h2>备注</h2> 
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>会员留言:</td>
    <td><%=obj.getRemark(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <td>供货商留言:</td>
    <td><%=obj.getRemark2(teasession._nLanguage)%></td>
  </tr>
</table>

<div id="head6"><img height="6" src="about:blank"></div>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

</body> 
</html>

