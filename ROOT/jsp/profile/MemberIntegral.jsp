<%@page contentType="text/html;charset=UTF-8" %><%@ page  import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.db.*" %>
<%@page import="java.util.Date" %>
<%@page import="tea.entity.Entity" %>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.admin.mov.*"%>
<%@page import="java.net.URLEncoder"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
Resource r=new Resource("/tea/resource/fun");
Profile p = Profile.find(teasession._rv.toString());

%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body class="membercenter">
<table class="membertable" border="0" cellpadding="0" cellspacing="0">
 
<tr class="top"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>
 
<tr class="middle"><td class="memberleft"></td><td class="membercenter2">
<h1><span>积分查看</span></h1>

<div class="MyIntegral">您目前可用的积分是：<b><%=p.getIntegral() %></b>分,其中（论坛<b><%=p.getPoint() %></b>分/投稿<b><%=p.getContributeintegral() %></b>分）&nbsp;积分汇总是：<b><%=p.getIntegral() %></b><br/>可用积分＝（投稿积分 + 论坛发帖积分 + 加分项目- 减分项目）<br/>
<a href="/html/node/<%=teasession._nNode %>-<%=teasession._nLanguage%>.htm">如何获取更多积分?</a></div>


</td><td class="memberright"></td></tr>
<tr class="bottom"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>
 
</table>

</body>
</html>



