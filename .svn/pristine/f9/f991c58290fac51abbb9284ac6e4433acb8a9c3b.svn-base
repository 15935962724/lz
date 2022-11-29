<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/request/Requests");

 if(!teasession._rv.isSupport())
            {
                 response.sendError(403);
                return;
            }

            String s =  request.getParameter("Pos");
            int i = s != null ? Integer.parseInt(s) : 0;

            int j = ProfileRequest.countRequests(teasession._rv._strR);


%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ProfileRequests")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="PathDiv"> <%=ts.hrefGlance(teasession._rv)%> <A href="/servlet/Call?Receiver=webmaster" TARGET="_blank"><IMG BORDER=0 SRC="/tea/image/Call.gif"></A> ><A href="/servlet/Requests"><%=r.getString(teasession._nLanguage, "Requests")%></A> ><%=r.getString(teasession._nLanguage, "ProfileRequests")%></div>
<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
  <tr>
    <td> <FORM name=foGrant METHOD=POST action="/servlet/GrantProfileRequests">
        <%=j%> <%=r.getString(teasession._nLanguage, "ProfileRequests")%>
      </FORM>
      <%
 if(j != 0)
{%>
      <input type='hidden' name=Pos VALUE="<%=Integer.toString(i)%>">
      <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
        <%
for(Enumeration enumeration = ProfileRequest.findRequests(teasession._rv._strR, i, 25); enumeration.hasMoreElements();)
{
                    RV rv = (RV)enumeration.nextElement();
%>
        <input type='hidden' name=ProfileRequests VALUE="<%=rv.toString()%>">
        <input  id="CHECKBOX" type="CHECKBOX" name=<%=rv.toString()%> checked>
        <%=ts.getRvDetail(rv, teasession._nLanguage)%>
        <%}%>
      </table>
      <%=new GrantDeny(teasession._nLanguage)%>
      <%}
%>
      <%=new FPNL(teasession._nLanguage, "/servlet/ProfileRequests?Pos=", i, j)%> </td>
  </tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
<%----%>
</body>
</html>

