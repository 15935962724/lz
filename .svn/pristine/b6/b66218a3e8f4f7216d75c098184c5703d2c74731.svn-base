<%@page contentType="text/html;charset=UTF-8" pageEncoding="GB2312"%>
<%@page import="tea.htmlx.*"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.resource.*"%>
<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession = new TeaSession(request);
%>
<html>
<head>
<title>
Loading...
</title>
</head>
<body bgcolor="#ffffff" onload="f_load()">
<h1 align="center">
<img src="/tea/image/loading.gif" />
</h1>

<!--<iframe src="/jsp/profile/logoutpassval.jsp" width="0" height="0">
</iframe>-->
<script language=javascript type="text/javascript">
function f_load()
{
  window.open('/servlet/Node?node=<%=teasession._nNode%>&language=<%=teasession._nLanguage%>&time=','_self');//'_blank');
}
 // window.close();
  </script>
  </body>
</html>
