<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/message/MessageFolders");
int i = tea.entity.member.Message.count("Sent", teasession._rv);
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type="text/javascript">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "InboxMessages")%></h1>
  <div id="head6"><img height="6" src="about:blank" alt=""></div>

  <div id="PathDiv"><%=ts.hrefGlance(teasession._rv)%> > <%=r.getString(teasession._nLanguage, "MessageFolders")%></div>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><UL>
          <LI><A href="/jsp/message/InboxMessages.jsp"><%=tea.entity.member.Message.count("Inbox", teasession._rv)%> <%=r.getString(teasession._nLanguage, "InboxMessages")%></A> </LI>
          <%if(i != 0)
          {%>
          <LI><A href="/jsp/message/SendMessages.jsp"><%=i%> <%=r.getString(teasession._nLanguage, "SentMessages")%></A> </LI>
        </UL>
        <%}%>
        <input type="button" value="<%=r.getString(teasession._nLanguage, "CBNewMessage")%>" ID="CBNewMessage" CLASS="CB" onClick="window.open('/servlet/NewMessage', '_blank');">
      </td>
    </tr>
  </table>
    <div id="head6"><img height="6" src="about:blank" alt=""></div>
  <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

