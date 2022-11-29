<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int crtransfer=Integer.parseInt(request.getParameter("crtransfer"));

Crtransfer obj=Crtransfer.find(crtransfer);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body>

<h1>计算机软件著作权转移备案公告</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >登记号</TD>
    <TD><%=obj.getScrbid()%></TD>
    <TD >权利转移权限</TD>
    <TD><%=obj.getDroit()%></TD>
  </tr>
  <tr>
    <TD>转移开始日期</TD>
    <TD><%=obj.getStartdateToString()%></TD>
    <TD>转移结束日期</TD>
    <TD><%=obj.getEnddateToString()%></TD>
  </tr>
  <tr>
    <TD>权利继受人姓名</TD>
    <TD><%=obj.getHeir()%></TD>
    <TD>权利继受人国籍</TD>
    <TD><%=obj.getHeirnation()%></TD>
  </tr>
  <tr>
    <TD>转移备案批准日期</TD>
    <TD><%=obj.getPassdateToString()%></TD>
  </tr>
</TABLE>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


