<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int crnotice=Integer.parseInt(request.getParameter("crnotice"));

Crnotice obj=Crnotice.find(crnotice);
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

<h1>稿酬查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >作者1</TD>
    <TD><%=obj.getAuthor1()%></TD>
  </tr>
  <tr>
    <TD >作者2</TD>
    <TD><%=obj.getAuthor2()%></TD>
  </tr>
  <tr>
    <TD >作品名称</TD>
    <TD><%=obj.getTitle()%></TD>
  </tr>
  <%--
  <tr>
    <TD>原发期刊</TD>
    <TD><%=obj.getPubpaper()%></TD>
    <TD>转载期刊</TD>
    <TD><%=obj.getRepubpaper()%></TD>
  </tr>
  <tr>
    <TD>原发日期</TD>
    <TD><%=obj.getPubdateToString()%></TD>
    <TD>转载日期</TD>
    <TD><%=obj.getRepubdate()%></TD>
  </tr>
  --%>
</TABLE>

<input type="button" value="关闭" onclick="window.opener=null;window.close();"/>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


