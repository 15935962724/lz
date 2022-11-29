<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/request/Requests").add("/tea/ui/member/request/AccessRequests");
            if(!node.isCreator(teasession._rv))
            {
                response.sendError(403);
                return;
            }
            String s = request.getParameter("Pos");
            int i = s != null ? Integer.parseInt(s) : 0;
            int j = AccessRequest.count(teasession._nNode);

%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "AccessRequests")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
 <div id="PathDiv"><%=ts.hrefGlance(teasession._rv)%> ><A HREF="/servlet/Requests"><%=r.getString(teasession._nLanguage, "Requests")%></A> ><A HREF="/servlet/AccessRequestNodes"><%=r.getString(teasession._nLanguage, "AccessRequestNodes")%></A> ><%=r.getString(teasession._nLanguage, "AccessRequests")%></div>
<FORM name=foGrant METHOD=POST action="/servlet/GrantAccessRequests">
  <table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
    <tr>
      <td><%=j%> <%=r.getString(teasession._nLanguage, "AccessRequests")%></td>
    </tr>
    <%          Enumeration enumeration = AccessRequest.find(teasession._nNode, i, 25);
            if(j != 0)
            {%>
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <input type='hidden' name=Pos VALUE="<%=i%>">
    <tr>
      <%              for(; enumeration.hasMoreElements(); )
                {
                    RV rv = (RV)enumeration.nextElement();%>
      <!--input type='hidden' name="AccessRequests" VALUE="<%=rv.toString()%>"-->
      <td><input  id="CHECKBOX" type="CHECKBOX" name="AccessRequests"  value="<%=rv.toString()%>" CHECKED></td>
      <td><%=ts.getRvDetail(rv, teasession._nLanguage)%>
        <%              }
            }%>
  </table>
  <%      if(j != 0)
            {%>
  <%=new GrantDeny(teasession._nLanguage)%>
  <%}%>
</FORM>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>

