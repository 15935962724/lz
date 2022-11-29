<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

r.add("/tea/ui/member/request/Requests");








            String s =request.getParameter("Pos");
            int i = s != null ? Integer.parseInt(s) : 0;

            int j = JoinRequest.countRequestCommunities(teasession._rv);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "JoinRequestCommunities")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
<div id="PathDiv"> <%=ts.hrefGlance(teasession._rv)%> <A href="/servlet/Call?Receiver=webmaster" TARGET="_blank"><IMG BORDER=0 SRC="/tea/image/Call.gif"></A> > <A href="/servlet/Requests"><%=r.getString(teasession._nLanguage, "Requests")%></A> ><%=r.getString(teasession._nLanguage, "JoinRequestCommunities")%></div>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr>
    <td><%=j%> <%=r.getString(teasession._nLanguage, "JoinRequestCommunities")%></td>
  </tr>
  <%
for(Enumeration enumeration = JoinRequest.findRequestCommunities(teasession._rv); enumeration.hasMoreElements(); )
{
                String s1 = (String)enumeration.nextElement();
%>
  <tr>
    <td> <A href="/servlet/Node?Community=<%=s1%>"><%=s1%></a>
    <td><A href="/servlet/JoinRequests?Community=<%=s1%>"><%=Integer.toString(JoinRequest.countRequests(s1))%></a>
      <%}
%>
</table>
<%=new FPNL(teasession._nLanguage, "JoinRequestCommunities?Pos=", i, j)%>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
<%----%>
</body>
</html>

