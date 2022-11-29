<%@page contentType="text/html;charset=UTF-8" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/fun");

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>
<table width="100%"  border="0" cellspacing="0" cellpadding="0" height="50%">
  <tr>
    <td valign="middle"><p align="center">
      <p align="center"><font size="3" face="Arial, Helvetica, sans-serif"><strong><%=r.getString(teasession._nLanguage,"ManagementPlatform")%></strong></font>
      <p align="center">
      <p align="center"><%=r.getString(teasession._nLanguage,"Start")%>
<br>
<p align="center"><p align="center">
<p align="center"></td>
  </tr>
</table>
</body>
</html>



