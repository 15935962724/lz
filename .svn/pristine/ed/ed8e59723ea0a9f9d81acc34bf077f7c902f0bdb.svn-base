<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%
r.add("/tea/ui/member/order/SaleOrders");
String s2 =  request.getParameter("Pos");
int l1 = s2 == null ? 0 : Integer.parseInt(s2);

if(!teasession._rv.isAccountant())
{
  response.sendError(403);
  return;
}
String s = request.getParameter("Type");
if(s==null)
s = request.getParameter("type");
String s1 = request.getParameter("Status");
boolean flag = s == null;
boolean flag1 = s != null && s1 == null;
boolean flag2 = s != null && s1 != null;
boolean flag3 = teasession._rv.isReal() || teasession._rv.isAccountant();
int j = Integer.parseInt(s==null?"0":s);
int k = Integer.parseInt(s1==null?"0":s1);
int i2 = Trade.count(false, teasession._rv, j, k,node.getCommunity());
int i = Integer.parseInt(s==null?"0":s);
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NewOrder")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=ts.hrefGlance(teasession._rv)%> ><A href="/servlet/SaleOrders"><%=r.getString(teasession._nLanguage, "SaleOrders")%></a> ><%=r.getString(teasession._nLanguage, Trade.TRADE_TYPE[i])%></div>
  <ul>
    <%
    for(int j1 = 0; j1 < tea.entity.member.Trade.TRADE_STATUS.length; j1++)
    {
      int k1 =tea.entity.node.SOrder.count(teasession._rv._strR,j1);
      if(k1 != 0)
      {%>
    <LI><A href="SaleSOrder2.jsp?Type=<%=i%>&Status=<%=j1%>"><%=k1%> <%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[j1])%> <%=r.getString(teasession._nLanguage, "SaleOrders")%></A> </LI>
    <%}
  }%>
  </UL>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

