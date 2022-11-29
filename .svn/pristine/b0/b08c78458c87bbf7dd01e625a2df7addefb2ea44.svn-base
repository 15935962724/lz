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
<!--<iframe src="/jsp/profile/loginpassval.jsp" width="0" height="0">
</iframe>-->
<script language=javascript type="text/javascript">
function f_load()
{
  if(<%=request.getSession().getAttribute("nexturl")%> == null){window.location.href='/servlet/Node?node=2&language=<%=teasession._nLanguage%>&time='}else
  window.location.href='<%=request.getSession().getAttribute("nexturl")%>';
 // window.open('/servlet/Node?node=2&language=<%=teasession._nLanguage%>&time=','_self');//'_blank');
  location.reload;
}
// window.close();
</script>
</body>
</html>
