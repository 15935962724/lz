<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String info=request.getParameter("info");
if(info==null)
info="&#26080;&#26435;&#35775;&#38382;.";//无权访问.";
tea.resource.Resource r=new tea.resource.Resource();

%><html>
<head>
<title>&#25552;&#31034;&#20449;&#24687;</title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</HEAD>
<body>
<h1>&#25552;&#31034;&#20449;&#24687;</h1>

<table border="0" cellpadding="0" cellspacing="0" style="width:550px;height:118px;background-image:url(/jsp/info/error/bg.jpg);background-repeat: no-repeat;background-position: left top;">
<TR><TD align="center" valign="middle"><%=info%></TD></TR></TABLE>

</body>
</html>

