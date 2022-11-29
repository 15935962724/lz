<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/ui/member/profile/ProfileServlet");
int pos=0;
String tmp = request.getParameter("pos");
if(tmp!=null)
{
  pos=Integer.parseInt(tmp);
}
String sql=" AND vmember="+DbAdapter.cite(teasession._rv._strV);

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
<h1><%=r.getString(teasession._nLanguage, "LoginHistory")%></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>

<div id="PathDiv">
<A href="/servlet/Glance?Member=<%=teasession._rv%>" TARGET="_blank"><%=teasession._rv%></A> >
<A href="/servlet/Profile"><%=r.getString(teasession._nLanguage, "Profile")%></A> >
<%=r.getString(teasession._nLanguage, "LoginHistory")%></div>

<table cellspacing="0" cellpadding="0" border="0" id="tablecenter">
<tr id="tableonetr">
<td width=1>&nbsp;</td>
<TD><%=r.getString(teasession._nLanguage, "MemberId")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Time")%></TD>
<TD><%=r.getString(teasession._nLanguage, "Type")%></TD>

</tr><%
Enumeration e = Logs.find(sql, pos, 25);
for(int i=1; e.hasMoreElements(); i++)
{
  Logs log = (Logs)e.nextElement();
  out.print("<tr onMouseOver=bgColor='#BCD1E9' onMouseOut=bgColor=''>");
  out.print("<td width=1>"+i);
  out.print("<td>"+log.getVMember());
  out.print("<td>"+log.getTimeToString());
  out.print("<td>"+r.getString(teasession._nLanguage, Logs.LOGIN_TYPE[log.getType()])+": "+log.getLog());
}
%>
</table>
<%=new tea.htmlx.FPNL(teasession._nLanguage,"?community="+teasession._strCommunity+"&pos=", pos, Logs.count(teasession._strCommunity,sql))%>

<div id="head6"><img height="6" src="about:blank"></div>
<%--<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>--%>
</body>
</html>
