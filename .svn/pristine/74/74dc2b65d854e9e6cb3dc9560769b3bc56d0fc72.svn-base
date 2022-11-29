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
String act = teasession.getParameter("act");
String membertype= teasession.getParameter("membertype");


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<%=community.getJspBefore(teasession._nLanguage)%>

<h1><%=r.getString(teasession._nLanguage, "ServerArticle")%></h1>
 <p><%=tea.entity.admin.mov.RegisterInstall.getNavigation(Integer.parseInt(membertype),teasession._nLanguage,"lzj_zccg",1) %></p>

  <div id="head6"><img height="6" src="about:blank"></div>

  <%=ss%>
  <FORM name=foSignUp method="POST" action="/jsp/mov/register.jsp">
    <input type="hidden" name="membertype" value="<%=membertype%>"/>
    <input type="hidden" name="act" value="<%=act%>"/>
        <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
    <input type=SUBMIT id="regyes" class="edit_button" VALUE="">
  <!--  <input type=SUBMIT id="regno"class="edit_button" name="DoNotAgree" VALUE="" onClick="javascript:location.href='/servlet/Node?node=<%=teasession._nNode%>';return(false);"> --> 
	<input type="button" value="不同意离开"  onClick="javascript:window.close();">
  </form>

<%=community.getJspAfter(teasession._nLanguage)%>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
