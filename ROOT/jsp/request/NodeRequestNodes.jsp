<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.Table"%>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/request/Requests");
            String s = request.getParameter("Pos");
            int i = s != null ? Integer.parseInt(s) : 0;
            Table table = new Table();
            int j = Node.countRequestNodes(teasession._rv);
            %>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "NodeRequestNodes")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv"> <%=ts.hrefGlance(teasession._rv) + ">" + new Anchor("Requests", r.getString(teasession._nLanguage, "Requests")) + ">" + r.getString(teasession._nLanguage, "NodeRequestNodes")
    %> </div>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr id="TableCaption">
    <td><%=j%> <%=r.getString(teasession._nLanguage, "NodeRequestNodes")%></td>
  </tr>
  <%
if(j != 0)
{
for(Enumeration enumeration = tea.entity.node.Node.findRequestNodes(teasession._rv, i, 25); enumeration.hasMoreElements();)
{
   int k = ((Integer)enumeration.nextElement()).intValue();
   Node node = Node.find(k);
%>
  <tr>
    <td> <%=node.getAncestor(teasession._nLanguage)%> <A href="/servlet/NodeRequests?node=<%=k%>"><%=Integer.toString(Node.countRequests(k))%>
      <%
}

}
%>
</table>
<%=new FPNL(teasession._nLanguage, "NodeRequestNodes?Pos=", i, j)%>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>

