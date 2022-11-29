<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String nexturl=request.getParameter("nexturl");

int crnotice=Integer.parseInt(request.getParameter("crnotice"));

String title=null,author1=null,author2=null,pubpaper=null,repubpaper=null,pubdate=null,repubdate=null;
if(crnotice>0)
{
  Crnotice obj=Crnotice.find(crnotice);
  title=obj.getTitle();
  author1=obj.getAuthor1();
  author2=obj.getAuthor2();
  pubpaper=obj.getPubpaper();
  repubpaper=obj.getRepubpaper();
  pubdate=obj.getPubdateToString();
  repubdate=obj.getRepubdate();
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
<body onload="form1.author1.focus();">

<h1>稿酬查询</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form1" ACTION="/servlet/EditCopyRight" METHOD="post" onSubmit="return submitText(this.title,'无效-作品名称')&&submitText(this.author1,'无效-作者1')&&submitText(this.pubpaper,'无效-原发期刊')&&submitText(this.repubpaper,'无效-转载期刊');">
  <input type="hidden" name="act" value="editcrnotice"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="crnotice" value="<%=crnotice%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >作品名称</TD>
    <TD><input type="text" name="title" value="<%if(title!=null)out.print(title);%>"></TD>
  </tr>
  <TR>
    <TD >作者1</TD>
    <TD><input type="text" name="author1" value="<%if(author1!=null)out.print(author1);%>"></TD>
    <TD >作者2</TD>
    <TD><input type="text" name="author2" value="<%if(author2!=null)out.print(author2);%>"></TD>
  </tr>
  <tr>
    <TD>原发期刊</TD>
    <TD><input type="text" name="pubpaper" value="<%if(pubpaper!=null)out.print(pubpaper);%>"></TD>
    <TD>转载期刊</TD>
    <TD><input type="text" name="repubpaper" value="<%if(repubpaper!=null)out.print(repubpaper);%>"></TD>
  </tr>
  <tr>
    <TD>原发日期</TD>
    <TD><input type="text" name="pubdate" size=15 value="<%if(pubdate!=null)out.print(pubdate);%>"><input type=button value=... onClick="showCalendar('form1.pubdate');"></TD>
    <TD>转载日期</TD>
    <TD><input type="text" name="repubdate" size=15 value="<%if(repubdate!=null)out.print(repubdate);%>"><input type=button value=... onClick="showCalendar('form1.repubdate');"></TD>
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

