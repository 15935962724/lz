<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "WeblogContentManageLef")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<%
tea.entity.node.Blog blog=tea.entity.node.Blog.find(node.getCommunity(),teasession._rv._strR);
//tea.entity.node.Node node=tea.entity.node.Node.find(blog.getHome());
java.util.Enumeration enumer =tea.entity.node.Node.findSons(blog.getHome());
while(enumer.hasMoreElements())
{
  int node_code=  ((Integer)enumer.nextElement()).intValue();
  tea.entity.node.Node node_obj=tea.entity.node.Node.find(node_code);
%>
<A href="/jsp/general/WeblogContentManageRight.jsp?node=<%=node_code%>" target="WeblogContentManageRight" ><%=node_obj.getSubject(teasession._nLanguage)%></A><br/>
<script type="">
window.open("/jsp/general/WeblogContentManageRight.jsp?node=<%=node_code%>","WeblogContentManageRight");
</script>
<%
}
%>
<div id="head6"><img height="6" src="about:blank"></div>

</body>
</html>

