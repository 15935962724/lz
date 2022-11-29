<%@page contentType="text/html;charset=UTF-8" %>
<%@ page language="java"   import="java.util.*"%>
<%@page  import="tea.entity.node.Report" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.ui.*" %>
<%@ page import="tea.entity.node.*" %>
<%@page import="tea.entity.subscribe.Pageinform"%>
<%
TeaSession teasession=new TeaSession(request);

int versionid1 = Report.getVersion(teasession._nNode,teasession._nNode);
int versionid2 = Report.getVersion(teasession._nNode,versionid1);
Node nobj = Node.find(versionid2);


%>
<style type="text/css">
<!--
body {
margin-left: 0px;
margin-top: 0px;
margin-right: 0px;
margin-bottom: 0px;
}
-->
</style>
<a href="http://cmt.redcome.com/html/folder/2200246-1.htm" target="_blank" title="请点击查看电子报">
<img width="214" height="298"  src="<%=nobj.getPicture(teasession._nLanguage) %>"   style="cursor:pointer" border="0" > 
</a>
