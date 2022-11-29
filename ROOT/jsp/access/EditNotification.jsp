<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.site.Subscriber"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%!
private String getCheck(boolean bool)
{	return bool?"checked":"";
}
%>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();
TeaServlet ts=new TeaServlet();
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
response.sendRedirect("/servlet/StartLogin");
return;
}
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
 RV rv = teasession._rv;
            Notification notification = Notification.find(rv);
            int i = notification.getOptions();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBAddToReminder")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%> </div>
<FORM name=foEdit METHOD=POST action="/servlet/EditNotification">
  <TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><input id="CHECKBOX" type="CHECKBOX" name=CheckList1 value=null <%=getCheck((i & 2) != 0)%>></td>
      <td><A href="/servlet/Messages?Folder=Inbox" TARGET="_blank"><%=r.getString(teasession._nLanguage, "InboxNewMessages")%></A> </td>
    </tr>
    <tr>
      <td><input id="CHECKBOX" type="CHECKBOX" name=CheckList4 value=null  <%=getCheck((i & 0x10) != 0)%>></td>
      <td><A href="/servlet/JoinRequestCommunities" TARGET="_blank"><%=r.getString(teasession._nLanguage, "JoinRequestCommunities")%></A> </td>
      <td><A href="/servlet/AccessRequestNodes" TARGET="_blank"><%=r.getString(teasession._nLanguage, "AccessRequestNodes")%></A> </td>
      <td><A href="/servlet/AdRequestNodes" TARGET="_blank"><%=r.getString(teasession._nLanguage, "AdRequestNodes")%></A> </td>
      <td><A href="/servlet/NodeRequestNodes" TARGET="_blank"><%=r.getString(teasession._nLanguage, "NodeRequestNodes")%></A> </td>
      <%if(rv.isSupport()){%>
      <td><A href="/servlet/ProfileRequests" TARGET="_blank"><%=r.getString(teasession._nLanguage, "ProfileRequests")%></A> </td>
    </tr>
    <%}%>
    <tr>
      <td><input id="CHECKBOX" type="CHECKBOX" name=CheckList2 value=null <%=getCheck((i & 4) != 0)%>></td>
      <td><A href="/servlet/SaleOrders?Status=0" TARGET="_blank"><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[0])%> <%=r.getString(teasession._nLanguage, "SaleOrders")%></A> </td>
      <td><A href="/servlet/SaleOrders?Status=4" TARGET="_blank"><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[4])%> <%=r.getString(teasession._nLanguage, "SaleOrders")%></A> </td>
      <td><A href="/servlet/SaleOrders?Status=6" TARGET="_blank"><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[6])%> <%=r.getString(teasession._nLanguage, "SaleOrders")%></A> </td>
    </tr>
    <tr>
      <td><input id="CHECKBOX" type="CHECKBOX" name=CheckList3 value=null <%=getCheck((i & 8) != 0)%>></td>
      <td><A href="/servlet/PurchaseOrders?Status=3" TARGET="_blank"><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[3])%> <%=r.getString(teasession._nLanguage, "PurchaseOrders")%></A> </td>
      <td><A href="/servlet/PurchaseOrders?Status=7" TARGET="_blank"><%=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[7])%> <%=r.getString(teasession._nLanguage, "PurchaseOrders")%></A> </td>
      <td><A href="/servlet/PurchaseOrders?Status=10" TARGET="_blank">
        <%//=r.getString(teasession._nLanguage, Trade.TRADE_STATUS[10])%>
        <%=r.getString(teasession._nLanguage, "PurchaseOrders")%></A> </td>
    </tr>
    <tr>
      <td><input id="CHECKBOX" type="CHECKBOX" name=CheckList21 value=null <%=getCheck((i & 0x20) != 0)%>></td>
      <td><A href="/servlet/Reminders" TARGET="_blank"><%=r.getString(teasession._nLanguage, "Reminders")%></A> </td>
    </tr>
  </table>
  <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</form>
</body>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</html>



