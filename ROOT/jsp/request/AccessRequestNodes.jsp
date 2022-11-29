<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/request/Requests");

            String s =  request.getParameter("Pos");
            int i = s != null ? Integer.parseInt(s) : 0;
            int j = AccessRequest.countNodes(teasession._rv);





%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "AccessRequestNodes")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv">
<%=ts.hrefGlance(teasession._rv)%> <A HREF="/servlet/Call?Receiver=webmaster" TARGET="_blank"><IMG BORDER=0 SRC="/tea/image/Call.gif"></A> > <A HREF="/servlet/Requests"><%=r.getString(teasession._nLanguage, "Requests")%></A> ><%=r.getString(teasession._nLanguage, "AccessRequestNodes")%>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=j%> <%=r.getString(teasession._nLanguage, "AccessRequestNodes")%></td>
  </tr>
  <%
if(j != 0)
{
for(Enumeration enumeration = AccessRequest.findNodes(teasession._rv, i, 25); enumeration.hasMoreElements();)
{
                    int k = ((Integer)enumeration.nextElement()).intValue();
                    Node node = Node.find(k);
%>
  <tr>
    <td><%=node.getAncestor(teasession._nLanguage)%> <A HREF="/servlet/AccessRequests?node=<%=k%>"><%=Integer.toString(AccessRequest.count(k))%>
      <%
}
}
%>
</table>
<%=new FPNL(teasession._nLanguage, "AccessRequestNodes?Pos=", i, j)%>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
<%----%>
</body>
</html>

