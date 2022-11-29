<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
int count=tea.entity.node.Node.countSons(teasession._nNode,teasession._rv);
String s =  request.getParameter("Pos");
int i = s == null ? 0 : Integer.parseInt(s);
%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "WeblogContentManageRight")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<h2 hu="hu"><%=node.getSubject(teasession._nLanguage)%>:<%=count%> </h2>
<table cellspacing="0" cellpadding="0" id="tablecenter">
          <tr id="TableHeader">
    <td><%=r.getString(teasession._nLanguage,"Subject")%></td>
    <td><%=r.getString(teasession._nLanguage,"IssueTime")%></td>
    <td><%=r.getString(teasession._nLanguage,"Click")%></td>
    <td><%=r.getString(teasession._nLanguage,"operation")%></td>
</tr>
<%

java.util.Enumeration enumer=tea.entity.node.Node.findSons(teasession._nNode,teasession._rv,i,5);
while(enumer.hasMoreElements())
{
tea.entity.node.Node node_obj=tea.entity.node.Node.find  (((Integer)enumer.nextElement()).intValue());

%>
<tr>
    <td><A href="/servlet/Node?node=<%=node_obj._nNode%>"><%=node_obj.getSubject(teasession._nLanguage)%></A></td>
    <td><%=node_obj.getTimeToString()%></td>
    <td><%=node_obj.getClick()%></td>
    <td><input type="button" value="<%=r.getString(teasession._nLanguage,"Edit")%>"  onclick="window.location='/jsp/type/weblog/EditWeblog.jsp?node=<%=node_obj._nNode%>';"/>
      <input type="button" value="<%=r.getString(teasession._nLanguage,"Delete")%>"  onClick="if(confirm('<%=r.getString(teasession._nLanguage,"ConfirmDelete")%>')){window.open('/servlet/DeleteNode?node=<%=node_obj._nNode%>', '_self');}"/></td>
</tr>
<%
}

%>
</table>

<%=new tea.htmlx.FPNL(teasession._nLanguage, request.getRequestURI() +"?node=" + teasession._nNode + "&Pos=", i, count,5)%>
<%

  tea.entity.node.Category cat=tea.entity.node.Category.find(teasession._nNode);
  switch(cat.getCategory())
  {
    case 82:
    %><input type="button" onclick="window.location='/jsp/type/weblog/EditWeblog.jsp?Type=<%=cat.getCategory()%>&NewNode=ON&node=<%=teasession._nNode%>';" value="发布文章"/>
    <%
    break;
    case 34:
    %><input type="button" onclick="window.location='/jsp/type/goods/WeblogEditGoods.jsp?Type=<%=cat.getCategory()%>&NewNode=ON&node=<%=teasession._nNode%>';" value="发布商品"/>
    <%
    break;
  }

%>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>

</body>
</html>

