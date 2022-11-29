<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int crbookin=Integer.parseInt(request.getParameter("crbookin"));

Crbookin obj=Crbookin.find(crbookin);
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

<h1><%=obj.getSwname()%></h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >登记号</TD>
    <TD><%=obj.getScrbid()%></TD>
    <TD >分类号</TD>
    <TD><%=obj.getClassno()%></TD>
  </tr>
  <tr>
    <TD>软件名称</TD>
    <TD><%=obj.getSwname()%></TD>
    <TD>简称</TD>
    <TD><%=obj.getShortname()%></TD>
  </tr>
  <tr>
    <TD>著作权人姓名</TD>
    <TD><%=obj.getAuthor()%></TD>
    <TD>著作权人国籍</TD>
    <TD><%=obj.getNation()%></TD>
  </tr>
  <tr>
    <TD>软件首次发表日期</TD>
    <TD><%=obj.getPubdateToString()%></TD>
    <TD>软件首次发表地区</TD>
    <TD><%=obj.getPubarea()%></TD>
  </tr>
  <tr>
    <TD>软件零售价（￥）</TD>
    <TD><%=obj.getPrice()%></TD>
    <TD>软件零售价（$）</TD>
    <TD><%=obj.getPricedollar()%></TD>
  </tr>
  <tr>
    <TD>版本登记号</TD>
    <TD><%=obj.getVersion()%></TD>
    <TD>批准日期</TD>
    <TD><%=obj.getPassdateToString()%></TD>
  </tr>
  <tr>
    <TD colspan="4">备注1</TD>
  </tr>
  <tr>
    <TD colspan="4"><%=obj.getRemark1()%></TD>
  </tr>
  <tr>
    <TD colspan="4">备注2</TD>
  </tr>
  <tr>
    <TD colspan="4"><%=obj.getRemark2()%></TD>
  </tr>
</TABLE>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


