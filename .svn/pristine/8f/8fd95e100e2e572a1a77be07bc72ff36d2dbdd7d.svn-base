<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.ui.*" %>
<%
String url=request.getParameter("url");
TeaSession teasession=new TeaSession(request);

tea.resource.Resource r=new tea.resource.Resource();
r.add("/tea/resource/fun");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
if (top.location == self.location)
{
  top.location="/jsp/admin/earth/index.jsp?community=<%=teasession._strCommunity%>&node=<%=teasession._nNode%>";
}
</script>
</head>
<body bgcolor="ffffff" text="000000" link="#CB9966" leftmargin="0" topmargin="0" id="touright">
<table width="100%" height="67" border="0" cellpadding="0" cellspacing="0" >
  <tr >
  <td height="57" class="tou" valign="bottom"><div align="right"><A href="<%=url%>" id="ToDesktop" target="earth_main" ><%=r.getString(teasession._nLanguage,"ToDesktop")%></A> <A id="ToProspects" href="/servlet/Node?node=<%=tea.entity.site.Community.find(teasession._strCommunity).getNode()%>" target="_blank" ><%=r.getString(teasession._nLanguage,"ToProspects")%></A></div></td>
  </tr>
  <tr>
    <td class="tou2">
      <a href="/servlet/Category?node=5&Language=1" target="MenuFrame">服务器</a> |
      <a href="/jsp/admin/earth/Leftup.jsp?node=1" target="MenuFrame">系统</a> |
      <a href="/servlet/Category?node=29&Language=1" target="MenuFrame"> 功能</a> |
     <!-- <a href="#">会员</a> |
      <a href="#">工作人员</a> |
      <a href="#">信息</a> | -->
      <a href="/jsp/admin/earth/EarthIps.jsp" target="earth_main">管理服务器</a> |
      <a href="/jsp/admin/earth/EarthHosts.jsp" target="earth_main">管理系统</a>  </td>
  </tr>
</table>
<%--
if (teasession._nCount == 1 && tea.ui.member.notification.NotificationServlet.isNotifying(teasession._rv))
{
  out.print("<SCRIPT language=JavaScript FOR=window EVENT=onload>");
  out.print("window.screenX = screen.width; window.screenY = screen.height;");
  out.print("window.open(\"/servlet/Notification\",\"Notification\", \"height=250,width=250,left=600,top=400,scrollbars=yes,toolbar=no,status=no,menubar=no,location=no,resizable=yes\");");
  out.print("</SCRIPT>");
}
<APPLET CODEBASE="/tea/applet/" CODE="tea.applet.meeting.CheckIn.class" WIDTH="0" HEIGHT="0" style="display:none"></APPLET>
--%>
</body>
</html>



