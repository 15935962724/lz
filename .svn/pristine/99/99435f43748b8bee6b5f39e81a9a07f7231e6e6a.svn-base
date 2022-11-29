<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String nexturl=request.getParameter("nexturl");

int crcourtclose=Integer.parseInt(request.getParameter("crcourtclose"));



String scrbid=null,court=null,author=null,name=null,close=null,year=null,open=null,cancel=null,path=null;

  Crcourtclose obj=Crcourtclose.find(crcourtclose);
  scrbid=obj.getScrbid();
  court=obj.getCourt();
  author=obj.getAuthor();
  name=obj.getName();
  close=obj.getClosetime();
  year=obj.getYear();
  open=obj.getOpentime();
  cancel=obj.getCanceltime();
  path=obj.getPath();


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body onload="form1.scrbid.focus();">

<h1>法院查封公告信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD>登记号</TD>
    <TD><%if(scrbid!=null)out.print(scrbid);%></TD>
  </tr>
  <TR>
    <TD>执行法院</TD>
    <TD><%if(court!=null)out.print(court);%>
    <TD>涉及公司或者个人</TD>
    <TD><%if(author!=null)out.print(author);%>
  </tr>
  <tr>
    <TD>软件名称</TD>
    <TD><%if(name!=null)out.print(name);%>
    <TD>查封日期</TD>
    <TD><%if(close!=null)out.print(close);%></TD>
  </tr>
  <tr>
    <TD>查封年限</TD>
    <TD><%if(year!=null)out.print(year);%>
    <TD>解封日期</TD>
    <TD><%if(open!=null)out.print(open);%></TD>
  </tr>
    <tr>
    <TD>撤销日期</TD>
    <TD><%if(cancel!=null)out.print(cancel);%></TD>
    <TD>原文路径</TD>
    <TD><%if(path!=null)out.print(path);%>
  </tr>
</TABLE>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

