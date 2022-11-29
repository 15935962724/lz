<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import = "tea.entity.site.Community" %>
<%@ page import = "tea.entity.node.Node" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import="tea.ui.TeaServlet"%>
<%
TeaSession teasession = new TeaSession(request);


Resource r = new Resource("/tea/ui/util/SignUp");

Community community = Community.find(teasession._strCommunity);

String ss = community.getTerm(teasession._nLanguage);


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<%=community.getJspBefore(teasession._nLanguage)%>

<h1><%=r.getString(teasession._nLanguage, "注册用户选择")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
  <input type="radio" value="1" name="huiyuan" checked="checked" />普通用户注册
  <input type="radio" value="2" name="huiyuan">酒店管理员注册

  <div id="p">
<include src="/jsp/registration/register.jsp"/>
</div>
<br />
<%=community.getJspAfter(teasession._nLanguage)%>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
