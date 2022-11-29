<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/ui/member/email/EmailBoxs");
r.add("/tea/ui/member/message/Messages");
%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "CBNewEmailBox")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>

<div id="PathDiv"> <%=TeaServlet.hrefGlance(teasession._rv)%> ><%=r.getString(teasession._nLanguage, "EmailBoxs")%></div>

<TABLE border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<%
Enumeration e=EmailBox.find(teasession._strCommunity,teasession._rv._strR);
for(int i=0;e.hasMoreElements();i++)
{
  int emailbox = ((Integer)e.nextElement()).intValue();
  EmailBox eb=EmailBox.find(emailbox);

  byte byte0 = -1;
%>
<tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''" >
<td><A href="/jsp/message/Emails.jsp?community=<%=teasession._strCommunity%>&emailbox=<%=emailbox%>"> <%=(byte0 != -1 ? Integer.toString(byte0) : "")+" "+eb.getEmail()%></A>
<td><input type="button" value="<%=r.getString(teasession._nLanguage, "CBEdit")%>" ID="CBEdit" CLASS="CB" onClick="window.open('/servlet/EditEmailBox?community=<%=teasession._strCommunity%>&emailbox=<%=emailbox%>', '_self');">
<input type="button" value="<%=r.getString(teasession._nLanguage, "CBDelete")%>" ID="CBDelete" CLASS="CB" onClick="if(confirm('<%=r.getString(teasession._nLanguage, "ConfirmDelete")%>')){window.open('/servlet/DeleteEmailBox?community=<%=teasession._strCommunity%>&emailbox=<%=emailbox%>', '_self'); this.disabled=true;}">
<%}%>
</tr>
</table>

<input type="button" value="<%=r.getString(teasession._nLanguage, "CBNewEmailBox")%>" ID="CBNewEmailBox" CLASS="CB" onClick="window.open('/jsp/message/EditEmailBox.jsp?emailbox=0', '_self');">

<div id="head6"><img height="6" src="about:blank" alt=""></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
