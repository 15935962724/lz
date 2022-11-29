<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page  import="tea.entity.admin.sales.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
tea.resource.Resource r = new Resource() ;

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body bgcolor="#ffffff">
<form method="post" action="ItemList.jsp">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td><a href="/jsp/admin/workreport/NonceItem.jsp" target="Itemlist" id="qt"><%=r.getString(teasession._nLanguage,"潜在客户")%></a></td>
<td><a href="/jsp/admin/workreport/NonceItem.jsp" target="Itemlist" id="dq"><%=r.getString(teasession._nLanguage,"当前客户")%></a></td>
<td><a href="/jsp/admin/workreport/NonceItem.jsp" target="Itemlist" id="fw"><%=r.getString(teasession._nLanguage,"服务客户")%></a></td>
<td><a href="/jsp/admin/workreport/NonceItem.jsp" target="Itemlist" id="cx"><%=r.getString(teasession._nLanguage,"撤消客户")%></a></td>
<td><a href="/jsp/admin/workreport/NonceItem.jsp" target="Itemlist" id="zf"><%=r.getString(teasession._nLanguage,"作废客户")%></a></td>
</tr>
</table>
</form>
</body>
</html>



