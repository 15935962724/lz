<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="tea.ui.TeaSession"%>
<%
    TeaSession teasession = new TeaSession(request);
    tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
<%=community.getJspBefore(teasession._nLanguage)%>
        <h1>Thank you for your registration.
 Please log in our website.</h1>
        <%=community.getJspAfter(teasession._nLanguage)%>
    </body>
</html>
