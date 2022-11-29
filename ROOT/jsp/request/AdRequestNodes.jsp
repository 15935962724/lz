<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%

r.add("/tea/ui/member/request/Requests");


            String s =request.getParameter("Pos");
            int i = s != null ? Integer.parseInt(s) : 0;
            int j = Aded.countRequestNodes(teasession._rv);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<input type='hidden' name="rmember" VALUE="webmaster">
<input type='hidden' name=vmember VALUE="webmaster">
<h1><%=r.getString(teasession._nLanguage, "AdRequestNodes")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv"> <%=ts.hrefGlance(teasession._rv)%> <A HREF="/servlet/Call?Receiver=webmaster" TARGET="_blank"><IMG BORDER=0 SRC="/tea/image/Call.gif"></A> ><A HREF="/servlet/Requests"><%=r.getString(teasession._nLanguage, "Requests")%></A> ><%=r.getString(teasession._nLanguage, "AdRequestNodes")%>
  <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
    <tr>
      <td><%=j%> <%=r.getString(teasession._nLanguage, "AdRequestNodes")%></td>
    </tr>
    <%
 if(j != 0)
{

for(Enumeration enumeration = Aded.findRequestNodes(teasession._rv, i, 25); enumeration.hasMoreElements();)
{
                    int k = ((Integer)enumeration.nextElement()).intValue();
                    Node node = Node.find(k);
%>
    <tr>
      <td><%=node.getAncestor(teasession._nLanguage)%> <A HREF="/servlet/AdRequests?node=<%=k%>"><%=Integer.toString(Aded.countRequests(k))%>
        <%}
}%>
  </table>
  <%=new FPNL(teasession._nLanguage, "/servlet/AdRequestNodes?Pos=", i, j)%>
  <div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
<%----%>
</body>
</html>

