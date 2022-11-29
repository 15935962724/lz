<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.entity.member.Message" %><%@ page import="tea.entity.member.MessageRead" %><%@ page import="tea.html.Anchor" %><%@ page import="tea.html.Text" %><%@ page import="tea.resource.Resource" %>
<%
TeaSession teasession = new TeaSession(request);
if (teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Resource r=new Resource();
r.add("/tea/ui/member/message/MessageFolders").add("/tea/ui/member/message/Messages").add("/tea/ui/member/message/MessageServlet").add("/tea/ui/member/message/MessageReaders");

String s = request.getParameter("Folder");
int i = Integer.parseInt(request.getParameter("Message"));

Message message = Message.find(i);

String s1 = request.getParameter("Pos");
int j = s1 == null ? 0 : Integer.parseInt(s1);

int k = MessageRead.count(i);

tea.ui.TeaServlet ts=new tea.ui.TeaServlet();

String community=request.getParameter("community");
if(community==null)
{
  tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
  community=node.getCommunity();
}
%>
<html>
<head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=k%> <%=r.getString(teasession._nLanguage, "MessageReaders")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>

<div id="PathDiv" ><%=ts.hrefGlance(teasession._rv) + ">" + new Anchor("MessageFolders", r.getString(teasession._nLanguage, "MessageFolders")) + ">" + new Anchor("Messages?Folder=" + s, new Text(r.getString(teasession._nLanguage, s))) + "><font>" + message.getSubject(teasession._nLanguage) + "</font>"%></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
if (k != 0)
{
  for (java.util.Enumeration enumeration = MessageRead.find(i, j, 25); enumeration.hasMoreElements();)
  {
    MessageRead messageread = (MessageRead) enumeration.nextElement();
    out.print("<tr><td>"+ts.getRvDetail(messageread.getReader(), teasession._nLanguage,)+"</td><td>"+(new java.text.SimpleDateFormat("yyyy.MM.dd hh:mm aaa")).format(messageread.getTime())+"</td></tr>");
  }
  out.print("<tr><td COLSPAN=9 >"+new tea.htmlx.FPNL(teasession._nLanguage, "MessageReaders?Folder=" + s + "&Message=" + i + "&Pos=", j, k)+"</td></tr>");
}
%>
</table>

 <div id="head6"><img height="6" src="about:blank"></div>
<%=new tea.htmlx.Languages(teasession._nLanguage, request)%>
</body>
</html>

