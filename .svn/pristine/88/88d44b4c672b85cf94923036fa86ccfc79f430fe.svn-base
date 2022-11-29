<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int crbargain=Integer.parseInt(request.getParameter("crbargain"));

Crbargain obj=Crbargain.find(crbargain);

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

<h1>录音制品著作权合同登记公告</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >登记号</TD>
    <TD><%=obj.getScrbid()%></TD>
  </tr>
  <tr>
    <TD>节目名称</TD>
    <TD><%=obj.getName()%></TD>
  </tr>
  <tr>
    <TD>出品地</TD>
    <TD><%=obj.getPubarea()%></TD>
  </tr>
  <tr>
    <TD>出版单位</TD>
    <TD><%=obj.getCrto()%></TD>
  </tr>
</TABLE>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

