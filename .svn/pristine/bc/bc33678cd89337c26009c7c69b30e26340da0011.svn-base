<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/request/Requests");
r.add("/tea/resource/Hostel");
%>



<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Destine")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div><div id="PathDiv">
<%=ts.hrefGlance(teasession._rv)%> ><%=r.getString(teasession._nLanguage, "DestineOrders")%></div>
<table border="0" cellpadding="0" cellspacing="0" class="tablecenter">
<tr><td>

<UL>
<LI>
<A href="/jsp/type/hostel/DestineOrders.jsp?node=<%=teasession._nNode%>"><%=Destine.countByMember(teasession._strCommunity,teasession._rv.toString())%>  <%=r.getString(teasession._nLanguage, "DestineOrders")%></A>
</LI>
</UL>






</td></tr></table>
<div id="head6"><img height="6" src="about:blank"></div><div id="language"><%=new Languages(teasession._nLanguage,request)%></div></DIV>
</body>
</html>

