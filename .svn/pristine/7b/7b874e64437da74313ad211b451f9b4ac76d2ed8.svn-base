<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int crzzba=Integer.parseInt(request.getParameter("crzzba"));

Crzzba obj=Crzzba.find(crzzba);
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

<h1>作者信息备案 ( <%=obj.getZzxm()%> )</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >作者名称</TD>
    <TD><%=obj.getZzxm()%> ( <%=obj.getZzpy()%> )</TD>
    <TD >作者笔名</TD>
    <TD><%=obj.getZzbm()%></TD>
  </tr>
  <tr>
    <TD>作者简介</TD>
    <TD><%=obj.getZzjj()%></TD>
    <TD>身份证号</TD>
    <TD><%=obj.getZzsfzh()%></TD>
  </tr>
  <tr>
    <TD>地    址</TD>
    <TD><%=obj.getZzdz()%></TD>
    <TD>邮编</TD>
    <TD><%=obj.getZzyb()%></TD>
  </tr>
  <tr>
    <TD>电话</TD>
    <TD><%=obj.getZzdh()%></TD>
    <TD>移动电话</TD>
    <TD><%=obj.getZzsj()%></TD>
  </tr>
  <tr>
    <TD>电子邮件</TD>
    <TD><%=obj.getZzdzyj()%></TD>
    <TD>创作范围</TD>
    <TD><%=obj.getZzczfw()%></TD>
  </tr>
  <tr>
    <TD>寄送合同</TD>
    <TD><%=obj.isZzht()?"是":"否"%></TD>
    <TD>附言</TD>
    <TD><%=obj.getZzfy()%></TD>
  </tr>
</TABLE>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>


