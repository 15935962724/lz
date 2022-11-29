<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/request/Requests");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body> 
<h1><%=r.getString(teasession._nLanguage, "Requests")%></h1> 
<div id="head6"><img height="6" src="about:blank"></div> 
<input type='hidden' name="rmember" VALUE="webmaster"> 
<input type='hidden' name=vmember VALUE="webmaster"> 
<DIV ID="edit_BodyDiv"> 
  <div id="PathDiv"> <%=ts.hrefGlance(teasession._rv)%> <A href="/servlet/Call?Receiver=webmaster" TARGET="_blank"><IMG BORDER=0 SRC="/tea/image/Call.gif"></A> ><%=r.getString(teasession._nLanguage, "Requests")%></div> 
  <table cellspacing="0" cellpadding="0" border="0" id="tablecenter"> 
    <tr> 
      <td> <UL> 
          <%
if(teasession._rv.isSupport())
{%> 
          <LI><A href="/servlet/ProfileRequests"><%=ProfileRequest.countRequests(teasession._rv._strR)%> <%=r.getString(teasession._nLanguage, "ProfileRequests")%></A> </LI> 
          <%}%> 
          <LI><A href="/servlet/JoinRequestCommunities"><%=JoinRequest.countRequestCommunities(teasession._rv)%> <%=r.getString(teasession._nLanguage, "JoinRequestCommunities")%></A> </LI> 
          <LI><A href="/servlet/AdRequestNodes"><%=Aded.countRequestNodes(teasession._rv)%> <%=r.getString(teasession._nLanguage, "AdRequestNodes")%></A> </LI> 
          <LI><A href="/servlet/AccessRequestNodes"><%=AccessRequest.countNodes(teasession._rv)%> <%=r.getString(teasession._nLanguage, "AccessRequestNodes")%></A> </LI> 
          <LI><A href="/servlet/NodeRequestNodes"><%=Node.countRequestNodes(teasession._rv)%> <%=r.getString(teasession._nLanguage, "NodeRequestNodes")%></A> </LI> 
        </UL></td> 
    </tr> 
  </table> 
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div> 
<%----%> 
</body>
</html>

