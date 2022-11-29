<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/request/JoinRequests");
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin");
  return;
}
r.add("/tea/ui/member/request/Requests");
String s = request.getParameter("Community");
if(!teasession._rv.isWebMaster() && !teasession._rv.isOrganizer(s))
{
  response.sendError(403);
  return;
}
String s1 = request.getParameter("Pos");
int i = s1 != null ? Integer.parseInt(s1) : 0;

%>
<html>
<head>
<link href="/res/<%=s%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "JoinRequests")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div ID=PathDiv> <%=ts.hrefGlance(teasession._rv)%> ><A href="/servlet/Requests"><%=r.getString(teasession._nLanguage, "Requests")%></A> ><A href="/servlet/JoinRequestCommunities"><%=r.getString(teasession._nLanguage, "JoinRequestCommunities")%></A> ><%=r.getString(teasession._nLanguage, "JoinRequests")%> </div>
<FORM name=foGrant METHOD=POST action="/servlet/GrantJoinRequests">
  <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
    <tr>
      <td> <%int j = JoinRequest.countRequests(s);
out.print(j);
%>
        <%=r.getString(teasession._nLanguage, "JoinRequests")%> </td>
    </tr>
    <%          if(j != 0)
            {%>
    <input type='hidden' name=Community VALUE="<%=s%>">
    <input type='hidden' name=Pos VALUE="<%=i%>">
    <%              for(Enumeration enumeration =Subscriber.find(s, "",i, 25); enumeration.hasMoreElements();)
                {
                    RV rv = (RV)enumeration.nextElement();
                    %>
    <tr>
      <td>
        <input  id="CHECKBOX" type="CHECKBOX" name="Members" VALUE="<%=rv.toString()%>" checked>
        <%
                   out.print(ts.getRvDetail(rv,teasession._nLanguage));
               %> </td>
    </tr>
    <% }%>
  </table>
  <%

                out.println(new GrantDeny(teasession._nLanguage));
            }
%>
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

