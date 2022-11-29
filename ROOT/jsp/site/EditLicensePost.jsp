<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
License license = License.getInstance();
String s = license.getWebName();

if(s != null && s.length() != 0)
{
  if(teasession._rv == null)
  {
    response.sendRedirect("/servlet/StartLogin");
    return;
  }
}
r.add("/tea/ui/site/EditLicense");
%>
<html>
  <head>
    <link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
      <script src="/tea/tea.js" type="text/javascript"></script>
  </head>
<body>
<h1><%=r.getString(teasession._nLanguage, "InsteadAuthor")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "InfWebOptionsSet")%><a href="/jsp/community/EditCommunity.jsp?community=Home"><%=r.getString(teasession._nLanguage, "Continue")%></a></td>
  </tr>
</table>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
