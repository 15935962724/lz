<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%
  r.add("/tea/resource/Ticket");
  if (!node.isCreator(teasession._rv)) {
    response.sendError(403);
    return;
  }
  Ticket ticket=Ticket.find(teasession._nNode,teasession._nLanguage);

int logolen=0;
if(ticket.getLogo()!=null)
logolen=(int)new java.io.File(application.getRealPath(ticket.getLogo())).length();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EditTicket")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%>  </div>
  <form name="form1" action="/servlet/EditTicket" method="post"  ENCtype=multipart/form-data  onsubmit="return(submitText(this.name, '<%=r.getString(teasession._nLanguage, "InvalidName")%>'))">
<INPUT type="hidden" name="Node" value="<%=teasession._nNode%>">
<INPUT type="hidden" name="ticket" value="ON">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Name")%>:</td>
      <td><input type="text" name="name" value="<%=node.getSubject(teasession._nLanguage)%>"></td>
    </tr>
    <tr>
      <td>Logo:</td>
      <td>  <INPUT TYPE=FILE NAME=logo  class="edit_input"><%if(logolen > 0) out.print(logolen + r.getString(teasession._nLanguage, "Bytes"));%><INPUT  id=CHECKBOX type="CHECKBOX" NAME=clearLogo onclick="form1.logo.disabled=this.checked;" VALUE=null><%=r.getString(teasession._nLanguage, "Clear")%>
</td>
    </tr>
    <tr>
      <td><%=r.getString(teasession._nLanguage, "Flight")%>:</td>
      <td><input type=button class="edit_button" onClick="window.open('/jsp/type/ticket/EditFlight.jsp?node=<%=teasession._nNode%>')" value="<%=r.getString(teasession._nLanguage, "New")%>"></td>
    </tr>
  </table>
  <INPUT TYPE=SUBMIT NAME="GoBack"  ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "GoBack")%>">
  <INPUT TYPE=SUBMIT name="GoFinish" ID="edit_GoFinish" class="edit_button" VALUE="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>
<div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

