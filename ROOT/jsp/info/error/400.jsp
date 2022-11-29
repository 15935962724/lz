<%@page contentType="text/html;charset=UTF-8" %>
<%
//request.setCharacterEncoding("UTF-8");

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);


tea.resource.Resource r=new tea.resource.Resource();
%>
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
<h1>提示信息</h1><p> <u>您要查看的网页可能已被删除、名称已被更改，或者暂时不可用。</u></p>

</TD></TR></TABLE>
</body>
</html>

