<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/jsp/Header.jsp"%>
<%
  r.add("/tea/ui/member/Glance");
  TeaServlet ts = new TeaServlet();
  String community = request.getParameter("community");
  if (community == null)
    community = node.getCommunity();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"   ></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Offers")%></h1>
<div id="head6">  <img height="6"></div>
<div id="PathDiv"><%=ts.hrefGlance(teasession._rv)%>  >
<%=r.getString(teasession._nLanguage, "Offers")%></div>
<table id="tablecenter">
  <tr>
    <td>
      <UL>
        <LI><A href="/servlet/ShoppingCarts"><%=Buy.countBuys(teasession._rv,community)%> <%=r.getString(teasession._nLanguage, "Buys")%></A> </LI>
        <LI><A href="/servlet/Bids"><%=Bid.countNodes(teasession._rv)%> <%=r.getString(teasession._nLanguage, "Bids")%></A> </LI>
        <LI><A href="/servlet/Bargains"><%=Bargain.countNodes(teasession._rv)%> <%=r.getString(teasession._nLanguage, "Bargains")%></A> </LI>
      </UL>
    </td>
  </tr>
</table>
<br>
<div id="head6">  <img height="6"></div>
<div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

