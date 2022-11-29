<%@page contentType="text/html;charset=UTF-8" %>
<%
request.setCharacterEncoding("UTF-8");

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
//tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
Throwable exception = (Throwable) request.getAttribute("javax.servlet.jsp.jspException");
String info=null;
if(exception!=null)
info=(exception.getMessage());
if(info==null)
info="您要访问的网页存在问题，因此无法显示。";
tea.resource.Resource r=new tea.resource.Resource();
%>
<%//@include file="Notice.jsp" %>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提示信息</title>
</HEAD>
<body>

<table border="0" cellpadding="0" cellspacing="0" style="width:550px;height:118px;background-image:url(/jsp/info/error/bg.jpg);background-repeat: no-repeat;background-position: left top;">
<TR><TD align="center" valign="middle">
<h1>提示信息</h1><p> <u><%=info%></u></p>
</TD></TR></TABLE>
</body>
</html>

