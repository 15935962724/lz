<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

int crcancel=Integer.parseInt(request.getParameter("crcancel"));

String code=null;
String scrbid=null;
String author=null;
String name=null;
String shortname=null;
String ver=null;
String reason=null;
String canceldate=null;
String path=null;
if(crcancel>0)
{
  Crcancel obj=Crcancel.find(crcancel);
  code=obj.getCode();
  scrbid=obj.getScrbid();
  author=obj.getAuthor();
  name=obj.getName();
  shortname=obj.getShortname();
  ver=obj.getVer();
  reason=obj.getReason();
  canceldate=obj.getCanceldateToString();
  path=obj.getPath();
}

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

<h1>计算机软件著作权登记撤销公告</h1>
<br>
<div id="head6"><img height="6" src="about:blank"></div>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >编号</TD>
    <TD><%if(code!=null)out.print(code);%></TD>
    <TD >登记号</TD>
    <TD><%if(scrbid!=null)out.print(scrbid);%></TD>
  </tr>
  <TR>
    <TD >原登记者</TD>
    <TD><%if(author!=null)out.print(author);%></TD>
    <TD >软件名称</TD>
    <TD><%if(name!=null)out.print(name);%></TD>
  </tr>
  <TR>
    <TD >简称</TD>
    <TD><%if(shortname!=null)out.print(shortname);%></TD>
    <TD >版本号</TD>
    <TD><%if(ver!=null)out.print(ver);%></TD>
  </tr>
  <tr>
    <TD>撤消无效宣告理由</TD>
    <TD><%if(reason!=null)out.print(reason);%></TD>
    <TD>撤消无效宣告日期</TD>
    <TD><%if(canceldate!=null)out.print(canceldate);%></TD>
  </tr>
    <tr>
    <TD>原文路径</TD>
    <TD><%if(path!=null)out.print(path);%></TD>
  </tr>
</TABLE>


<br>
<div id="head6<img height="6</div>
</body>
</html>

