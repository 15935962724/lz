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

//MemberOrder obj = MemberOrder.find(MemberOrder.getMemberOrder(teasession._strCommunity,MemberOrder.getMemberType(teasession._strCommunity,teasession._rv._strR),teasession._rv._strR));
MemberType mtobj = MemberType.find(MemberOrder.getMemberType(teasession._strCommunity,teasession._rv._strR));


%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body class="membercenter">
<table class="membertable" border="0" cellpadding="0" cellspacing="0">
 
<tr class="top"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>
 
<tr class="middle"><td class="memberleft"></td><td class="membercenter2">
<h1><span>等级服务</span></h1>
<div class="ServiceLevel">您是网站&nbsp;<font color="red"><%=mtobj.getMembername() %></font>&nbsp;,您享有的服务如下：</div>
<div class="ServiceLevelCon"><%=mtobj.getCaption() %></div>
<div class="ServiceLevelbottom"><a href="###" target="_blank">网站会员等级服务</a></div>
</td><td class="memberright"></td></tr>
<tr class="bottom"><td class="memberleft"></td><td class="membercenter2"></td><td class="memberright"></td></tr>
 
</table>
</body>
</html>



