<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.db.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.Entity" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);

if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}

Node n = Node.find(teasession._nNode);
Report r =Report.find(teasession._nNode);

//if(  teasession._rv._strR.equals(n.getCreator()._strR) || //NodeRole.isRole(teasession._strCommunity,teasession._rv._strR,n.getFather(),2))
{

tea.entity.site.Community community_jsp=tea.entity.site.Community.find(teasession._strCommunity);

Media media = Media.find(r.getMedia());


%>

<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community_jsp.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<div class="NewsCon">
<span id='ReportIDname'><%=n.getSubject(teasession._nLanguage) %></span>
<div class="NewsContop">
<%if(r.getSubhead(teasession._nLanguage)!=null && r.getSubhead(teasession._nLanguage).length()>0){ %>
<span id='ReportIDMediaName'>来源：<%=Entity.getNULL(r.getSubhead(teasession._nLanguage))%>　　</span>
<%} %>
<span id="ReportIDZ"><%=Entity.getNULL(media.getName(teasession._nLanguage) )%>　　</span>
<span id='ReportIDIssueTime'>日期：<%=r.getIssueTimeToString() %></span>
</div>
<!--导语被隐藏<span id='ReportIDLogograph'><%=r.getLogograph(teasession._nLanguage)%></span>-->
<span id='ReportIDtext'><%=n.getText(teasession._nLanguage) %></span>
<%if(r.getEditmember(teasession._nLanguage)!=null){ %>
<div id="zrbianji">[责任编辑：<span id='ReportIDeditmember'><%=r.getEditmember(teasession._nLanguage) %></span>]</div>
<%} %>
</div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community_jsp.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>

</html>
<%}
/*
else	{
	out.print("您不能预览这个页面"); 
	return; 
} 
*/

%>
