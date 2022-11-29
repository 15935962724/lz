<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if(node.isCreator(teasession._rv))
{
  response.sendRedirect("/servlet/Node?node=" + teasession._nNode);
  return;
}
r.add("/tea/ui/node/access/RequestAccess");
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script></head>
<body>
<DIV ID="edit_Bodydiv">
<table cellspacing="0" class="section">
<tr><td>
<div align="center">
<%
tea.entity.node.AccessRequest.create(teasession._nNode, teasession._rv);
%>
<%=r.getString(teasession._nLanguage, "InfRequested")%>
</div></td>
</tr></table>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div></DIV>
</body>
</html>



