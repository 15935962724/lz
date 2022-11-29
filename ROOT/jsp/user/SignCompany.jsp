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
<div id="bigborder">
<div id="log_top">
	<table>
		<tr><td id="log_top_img"><img src="/res/lib/u/0805/080565362.gif">　</td><td><font>相关条款</font></td><td id="log_top_img"><img src="/res/lib/u/0805/080565363.gif">　</td><td>基本信息</td><td id="log_top_img"><img src="/res/lib/u/0805/080565364.gif">　</td><td>注册成功</td></tr>
	</table>
</div>
<div id="log_top_title"><%=r.getString(teasession._nLanguage, "ServerArticle")%><font>>></font></div>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="log_top_con">
  <%=ss%>
  </div>
  <FORM name=foSignUp action="/jsp/user/EditCompany.jsp">
    <input type="hidden" name="node" VALUE="1" />
    <input type='hidden' name=Language VALUE="<%=teasession._nLanguage%>">
    <input type="hidden" name="community" VALUE="<%=teasession._strCommunity%>" />
    <input type="hidden" name="father" VALUE="2196661"/>
    <input type="hidden" name="act" VALUE="user"/>

    <input type=SUBMIT id="regyes" class="edit_button" VALUE="">
    <input type=SUBMIT id="regno"class="edit_button" name="DoNotAgree" VALUE="" onClick="javascript:location.href='/servlet/Node?node=<%=teasession._nNode%>';return(false);">
  </form>
</div>
<%=community.getJspAfter(teasession._nLanguage)%>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</body>
</html>
