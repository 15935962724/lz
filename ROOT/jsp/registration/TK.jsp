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
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="bodynone">
<input type="button" onclick="location='/jsp/registration/putongTK.jsp'" value="普通会员" /><input type="button" onclick="location='/jsp/registration/guanliyuanTK.jsp'" value="酒店管理员" />
<%=community.getJspBefore(teasession._nLanguage)%>
<h1><%=r.getString(teasession._nLanguage, "ServerArticle")%></h1>
  <div id="head6"><img height="6" src="about:blank"></div>
  <%=ss%>
  <FORM name=foSignUp action="/jsp/registration/register.jsp">
    <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
    <input type='hidden' name=Language VALUE="<%=teasession._nLanguage%>">
    <input type='hidden' name=nexturl VALUE="/servlet/Node?node=<%=teasession._nNode%>">
    <input type="SUBMIT" id="regyes" class="edit_button" VALUE="">
    <input type="SUBMIT" id="regno"class="edit_button" name="DoNotAgree" VALUE="" onClick="javascript:location.href='/servlet/Node?node=<%=teasession._nNode%>';return(false);">
  </form>
<%=community.getJspAfter(teasession._nLanguage)%>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
