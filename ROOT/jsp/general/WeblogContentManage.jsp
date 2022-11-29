<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
tea.entity.node.Blog blog=tea.entity.node.Blog.find(node.getCommunity(),teasession._rv._strV);
int count=tea.entity.node.Node.countSons(blog.getHome(),teasession._rv);
if(count>0)
{
    %>
<frameset cols="150,*" frameborder="NO" border="0" framespacing="0">
  <frame src="/jsp/general/WeblogContentManageLeft.jsp?node=<%=blog.getHome()%>" name="leftFrame" scrolling="NO" noresize>
  <frame src="" name="WeblogContentManageRight">
<!--/jsp/general/WeblogContentManageRight.jsp-->
</frameset>


  <%
}else
{
%>

<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>
<fieldset>
<legend>Info</legend>
  还没有创建栏目呢，请先<a target="m" href="/jsp/general/WeblogEditNode.jsp?node=<%=teasession._nNode%>">创建栏目</a>
</fieldset>
</body>
<%}%>
</html>

