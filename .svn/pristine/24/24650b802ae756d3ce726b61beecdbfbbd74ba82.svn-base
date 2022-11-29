<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String nexturl=request.getParameter("nexturl");

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

<h1>计算机软件著作权登记撤销公告</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form1" ACTION="/servlet/EditCopyRight" METHOD="post" onSubmit="return submitText(this.scrbid,'无效-登记号')&&submitText(this.reason,'无效-撤消无效宣告理由');">
  <input type="hidden" name="act" value="editcrcancel"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="crcancel" value="<%=crcancel%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >登记号</TD>
    <TD><input type="text" name="scrbid" <%if(crcancel>0)out.print(" disabled ");%> value="<%if(scrbid!=null)out.print(scrbid);%>"></TD>
    <TD >编号</TD>
    <TD><input type="text" name="code" value="<%if(code!=null)out.print(code);%>"></TD>
  </tr>
  <TR>
    <TD >原登记者</TD>
    <TD><input type="text" name="author" value="<%if(author!=null)out.print(author);%>"></TD>
    <TD >软件名称</TD>
    <TD><input type="text" name="name" value="<%if(name!=null)out.print(name);%>"></TD>
  </tr>
  <TR>
    <TD >简称</TD>
    <TD><input type="text" name="shortname" value="<%if(shortname!=null)out.print(shortname);%>"></TD>
    <TD >版本号</TD>
    <TD><input type="text" name="ver" value="<%if(ver!=null)out.print(ver);%>"></TD>
  </tr>
  <tr>
    <TD>撤消无效宣告理由</TD>
    <TD><input type="text" name="reason" value="<%if(reason!=null)out.print(reason);%>"></TD>
    <TD>撤消无效宣告日期</TD>
    <TD><input type="text" name="canceldate" size=15 value="<%if(canceldate!=null)out.print(canceldate);%>"><input type=button value=... onClick="showCalendar('form1.canceldate');"></TD>
  </tr>
    <tr>
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

