<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body id="tes_body">
<h1>提示信息</h1>
<div id="tes_body02">
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<div id="content_all04">
<div id="content_01">
请在会议设置→设置会场座位中进行设置！
</div>
</body>
</html>
