<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%
r.add("/tea/ui/member/node/Nodes");
String s = request.getParameter("Member");
if(s == null)
if(teasession._rv != null)
{
  s = teasession._rv._strR;
} else
{
  response.sendRedirect("/servlet/StartLogin");
  return;
}

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Nodes")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
  <div id="PathDiv"><%=ts.hrefGlance(teasession._rv)%> ><%=r.getString(teasession._nLanguage, "Nodes")%></div>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td><UL>
<%
if(teasession._rv != null && teasession._rv._strR.equals(s))
{
%>
          <LI><A href="/jsp/node/TalkbackedNodes.jsp"><%=Node.count(" AND n.rcreator="+DbAdapter.cite(teasession._rv._strR)+" AND n.node IN(SELECT node FROM Talkback)")%> <%=r.getString(teasession._nLanguage, "TalkbackedNodes")%></A> </LI>
          <LI><A href="/jsp/node/TalkbackingNodes.jsp"><%=Node.count(" AND n.node IN(SELECT node FROM Talkback WHERE rmember="+DbAdapter.cite(teasession._rv._strR)+")")%> <%=r.getString(teasession._nLanguage, "TalkbackingNodes")%></A> </LI>
          <LI><A href="/jsp/node/AdedNodes.jsp"><%=Node.count(" AND node IN(SELECT node FROM Aded WHERE rmember=" + DbAdapter.cite(teasession._rv._strR) + " AND vmember=" + DbAdapter.cite(teasession._rv._strV)+")")%> <%=r.getString(teasession._nLanguage, "AdedNodes")%></A> </LI>
          <LI><A href="/jsp/node/AdingNodes.jsp"><%=Node.count(" AND n.rcreator="+DbAdapter.cite(teasession._rv._strR)+" AND n.node IN(SELECT node FROM Ading)")%> <%=r.getString(teasession._nLanguage, "AdingNodes")%></A> </LI>
          <LI><A href="/jsp/node/ListedNodes.jsp"><%=Node.count(" AND n.rcreator="+DbAdapter.cite(teasession._rv._strR)+" AND node IN(SELECT node FROM Listed)")%> <%=r.getString(teasession._nLanguage, "ListedNodes")%></A> </LI>
          <LI><A href="/jsp/node/ListingNodes.jsp"><%=Node.count(" AND n.rcreator=" + DbAdapter.cite(teasession._rv._strR)+" AND node IN(SELECT node FROM Listing)")%> <%=r.getString(teasession._nLanguage, "ListingNodes")%></A> </LI>
          <LI><A href="/jsp/node/FavoriteNodes.jsp"><%=Favorite.countNodes(teasession._strCommunity,teasession._rv,0)%> <%=r.getString(teasession._nLanguage, "FavoriteNodes")%></A> </LI>
          <%}%>
        </UL></td>
      <td><UL>
          <%
int i = 4;
do
{
int j = Node.countMyNodes(s, i);
if(j != 0)
{%>
          <LI><A href="/servlet/Search?type=<%=i%>&Area=<%=1%>&CreatorStyle=<%=1%>&Creator=<%=s%>"><%=j%> <%=r.getString(teasession._nLanguage, Node.NODE_TYPE[i])%></A> </LI>
          <%}
} while(++i <= 6);
%>
        </UL></td>
    </tr>
</table><br>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
