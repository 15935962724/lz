<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%
TeaSession teasession=new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String emailbox=request.getParameter("emailbox");
int emailno=Integer.parseInt(request.getParameter("emailno"));

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "EmailBoxs")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="pathdiv">
  <%=TeaServlet.hrefGlance(teasession._rv)%>
  ><A HREF="/jsp/message/EmailBoxs.jsp"><%=r.getString(teasession._nLanguage, "EmailBoxs")%></A>
  ><A HREF="/jsp/message/Emails.jsp?emailbox=<%=emailbox%>"><%=r.getString(teasession._nLanguage, emailbox)%></A>
</div>

<iframe src="/servlet/Email?community=<%=teasession._strCommunity%>&emailbox=<%=emailbox%>&emailno=<%=emailno%>" width="100%" height="80%" frameborder="0">

</iframe>
<%
//out.print(new Button("New", r.getString(teasession._nLanguage, "New"), "window.open('NewMessage');"));
//out.print(new Button("Reply", r.getString(teasession._nLanguage, "Reply"), "window.open('NewMessage?Receiver=" + stringbuffer + "');"));
//out.print(new Button("Delete",r.getString(teasession._nLanguage, "Delete"),"if(confirm('" + r.getString(teasession._nLanguage, "ConfirmDelete") + "'))window.open('DeleteEmail?EmailBox=" + s + "&EmailNo=" + i+");"));

%>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
