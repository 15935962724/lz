<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.member.Message"%>
<%@ page import="tea.entity.member.Profile"%>
<%@ page import="tea.entity.site.License"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.service.Robot"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource();
r.add("/tea/ui/util/RetrieveMemberId");
TeaSession teasession = new TeaSession(request);
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "RetrieveMemberId")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>
<%=r.getString(teasession._nLanguage, "InfRetrieveMemberId")%>

  <FORM name=foRetrieve METHOD=POST action="/servlet/RetrieveMemberId" onSubmit="return(submitEmail(this.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmail")%>'));">
    <%=r.getString(teasession._nLanguage, "EmailAddress")%>:
    <input type="TEXT" class="edit_input"  name=Email>
    <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
  </FORM>
  <SCRIPT>document.foRetrieve.Email.focus();</SCRIPT>
  <%=RequestHelper.format(r.getString(teasession._nLanguage, "InfFindMoreHelp"), License.getInstance().getWebSupport())%>
</td></tr></table>
 <div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

