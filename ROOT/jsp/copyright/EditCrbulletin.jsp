<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@page  import="tea.entity.copyright.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String nexturl=request.getParameter("nexturl");

int crbulletin=Integer.parseInt(request.getParameter("crbulletin"));
String scrbid=null,ainame=null,writingname=null,writingtype=null,createdate=null,pubdate=null;
if(crbulletin>0)
{
  Crbulletin obj=Crbulletin.find(crbulletin);
  scrbid=obj.getScrbid();
  ainame=obj.getAiname();
  writingname=obj.getWritingname();
  writingtype=obj.getWritingtype();
  createdate=obj.getCreatedateToString();
  pubdate=obj.getPubdateToString();
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

<body onload="form1.scrbid.focus();">
<h1>各类作品著作权登记公告</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form1" ACTION="/servlet/EditCopyRight" METHOD="post" onSubmit="return submitText(this.scrbid,'无效-登记号')&&submitText(this.ainame,'无效-著作者名字')&&submitText(this.writingname,'无效-作品名称');">
  <input type="hidden" name="act" value="editcrbulletin"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="crbulletin" value="<%=crbulletin%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <TR>
      <TD >登记号</TD>
      <TD><input type="text" name="scrbid" <%if(crbulletin>0)out.print(" disabled ");%> value="<%if(scrbid!=null)out.print(scrbid);%>">
      </TD>
      <TD >著作者名字</TD>
      <TD><input type="text" name="ainame" value="<%if(ainame!=null)out.print(ainame);%>">
      </TD>
    </tr>
    <tr>
      <TD>作品名称</TD>
      <TD><input type="text" name="writingname" value="<%if(writingname!=null)out.print(writingname);%>">
      </TD>
      <TD>作品类别</TD>
      <TD><input type="text" name="writingtype" value="<%if(writingtype!=null)out.print(writingtype);%>">
      </TD>
    </tr>
    <tr>
      <TD>完成日期</TD>
      <TD><input type="text" name="createdate" size=15 value="<%if(createdate!=null)out.print(createdate);%>"><input type=button value=... onclick="showCalendar('form1.createdate');">
      </TD>
      <TD>发表日期</TD>
      <TD><input type="text" name="pubdate" size=15 value="<%if(pubdate!=null)out.print(pubdate);%>"><input type=button value=... onclick="showCalendar('form1.pubdate');">
      </TD>
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

