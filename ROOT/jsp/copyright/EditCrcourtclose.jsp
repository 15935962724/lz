<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String nexturl=request.getParameter("nexturl");

int crcourtclose=Integer.parseInt(request.getParameter("crcourtclose"));

String scrbid=null,court=null,author=null,name=null,close=null,year=null,open=null,cancel=null,path=null;
if(crcourtclose>0)
{
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
}

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

<FORM NAME="form1" ACTION="/servlet/EditCopyRight" METHOD="post" onSubmit="return submitText(this.scrbid,'无效-登记号')&&submitText(this.court,'无效-执行法院')&&submitText(this.author,'无效-涉及公司或者个人')&&submitText(this.name,'无效-软件名称');">
  <input type="hidden" name="act" value="editcrcourtclose"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="crcourtclose" value="<%=crcourtclose%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD>登记号</TD>
    <TD><input type="text" name="scrbid" <%if(crcourtclose>0)out.print(" disabled ");%> value="<%if(scrbid!=null)out.print(scrbid);%>"></TD>
  </tr>
  <TR>
    <TD>执行法院</TD>
    <TD><input type="text" name="court" value="<%if(court!=null)out.print(court);%>"></TD>
    <TD>涉及公司或者个人</TD>
    <TD><input type="text" name="author" value="<%if(author!=null)out.print(author);%>"></TD>
  </tr>
  <tr>
    <TD>软件名称</TD>
    <TD><input type="text" name="name" value="<%if(name!=null)out.print(name);%>"></TD>
    <TD>查封日期</TD>
    <TD><input type="text" name="close" value="<%if(close!=null)out.print(close);%>"><input type=button value=... onClick="showCalendar('form1.close');"></TD>
  </tr>
  <tr>
    <TD>查封年限</TD>
    <TD><input type="text" name="year" size=15 value="<%if(year!=null)out.print(year);%>"></TD>
    <TD>解封日期</TD>
    <TD><input type="text" name="open" size=15 value="<%if(open!=null)out.print(open);%>"><input type=button value=... onClick="showCalendar('form1.open');"></TD>
  </tr>
    <tr>
    <TD>撤销日期</TD>
    <TD><input type="text" name="cancel" size=15 value="<%if(cancel!=null)out.print(cancel);%>"><input type=button value=... onClick="showCalendar('form1.cancel');"></TD>
    <TD>原文路径</TD>
    <TD><input type="text" name="path" value="<%if(path!=null)out.print(path);%>"></TD>
  </tr>
</TABLE>
  <input type="submit" value="提交">
  <input type="reset" value="重置">
  <input type="button" value="返回" onClick="window.history.back();">

</FORM>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

