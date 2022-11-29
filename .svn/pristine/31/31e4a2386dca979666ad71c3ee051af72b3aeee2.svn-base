<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int crbulletin=Integer.parseInt(request.getParameter("crbulletin"));

Crbulletin obj=Crbulletin.find(crbulletin);
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

<h1>各类作品著作权登记公告</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >登记号</TD>
    <TD><%=obj.getScrbid()%></TD>
    <TD >著作者名字</TD>
    <TD><%=obj.getAiname()%></TD>
  </tr>
  <tr>
    <TD>作品名称</TD>
    <TD><%=obj.getWritingname()%></TD>
    <TD>作品类别</TD>
    <TD><%=obj.getWritingtype()%></TD>
  </tr>
  <tr>
    <TD>完成日期</TD>
    <TD><%=obj.getCreatedateToString()%></TD>
    <TD>发表日期</TD>
    <TD><%=obj.getPubdateToString()%></TD>
  </tr>
</TABLE>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


