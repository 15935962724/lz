<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>


<%

r.add("/tea/ui/member/community/Communities");

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Communities")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
  <div id="PathDiv"><%=ts.hrefGlance(teasession._rv)%> ><%=r.getString(teasession._nLanguage, "Communities")%></div>
  <table  border="0" cellspacing="0" cellpadding="0" id="tablecenter">
    <tr>
      <td><UL>
          <LI> <A href="/servlet/JoiningCommunities"><%=JoinRequest.countJoining(teasession._rv)%> <%=r.getString(teasession._nLanguage, "JoiningCommunities")%></A> </LI>
          <LI> <A href="/servlet/JoinedCommunities"><%=Subscriber.countJoined(teasession._rv)%> <%=r.getString(teasession._nLanguage, "JoinedCommunities")%></A> </LI>
          <LI><A href="/servlet/OrganizingCommunities"><%=Organizer.countOrganizing(teasession._rv)%> <%=r.getString(teasession._nLanguage, "OrganizingCommunities")%></A> </LI>
        </UL></td>
    </tr>
  </table>
  <div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

</body>
</html>


