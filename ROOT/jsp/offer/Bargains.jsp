<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>

<%r.add("/tea/ui/member/Glance");

   String s =request.getParameter("Pos");
            int i = s != null ? Integer.parseInt(s) : 0;
            int j = Bargain.countNodes(teasession._rv);
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "Bargains")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
  <div id="PathDiv"> <%=ts.hrefGlance(teasession._rv)%> <A href="/servlet/Call?Receiver=webmaster" TARGET="_blank"><IMG BORDER=0 SRC="/tea/image/Call.gif"></A> ><A href="/servlet/Offers"><%=r.getString(teasession._nLanguage, "Offers")%></A> ><%=r.getString(teasession._nLanguage, "Bargains")%></div>
  <h2><%=j%> <%=r.getString(teasession._nLanguage, "Bargains")%></h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
          <tr>
            <TD> <%
for(Enumeration enumeration = Bargain.findNodes(teasession._rv, i, 25); enumeration.hasMoreElements();)
{
	int k = ((Integer)enumeration.nextElement()).intValue();
	Node node = Node.find(k);%>
              <%=node.getAncestor(teasession._nLanguage)%>
              <%
}%></TD>
          </tr>
</table>
  <%=new FPNL(teasession._nLanguage, "/servlet/Bargains?Pos=", i, j)%>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

