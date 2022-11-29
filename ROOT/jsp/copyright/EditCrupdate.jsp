<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String nexturl=request.getParameter("nexturl");

int crupdate=Integer.parseInt(request.getParameter("crupdate"));

String scrbid=null,proving=null,applicant=null,name=null,shortname=null,ver=null,type=null,item=null,beforeitem=null,afteritem=null,time=null,path=null;
if(crupdate>0)
{
	  Crupdate obj=Crupdate.find(crupdate);
	  scrbid=obj.getScrbid();
	  proving=obj.getProving();
	  applicant=obj.getApplicant();
	  name=obj.getName();
	  shortname=obj.getShortname();
	  ver=obj.getVer();
	  type=obj.getType();
	  item=obj.getItem();
	  beforeitem=obj.getBeforeitem();
	  afteritem=obj.getAfteritem();
	  time=obj.getTime();
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

<h1>变更补充公告信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form1" ACTION="/servlet/EditCopyRight" METHOD="post" onSubmit="return submitText(this.proving,'无效-证明编号')&&submitText(this.scrbid,'无效-登记号')&&submitText(this.applicant,'无效-申请者')&&submitText(this.name,'无效-软件名称');">
  <input type="hidden" name="act" value="editcrupdate"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="crupdate" value="<%=crupdate%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD>登记号</TD>
    <TD><input type="text" name="scrbid" <%if(crupdate>0)out.print(" disabled ");%> value="<%if(scrbid!=null)out.print(scrbid);%>"></TD>
    <TD>证明编号</TD>
    <TD><input type="text" name="proving" value="<%if(proving!=null)out.print(proving);%>"></TD>
  </tr>
  <TR>
    <TD>申请者</TD>
    <TD><input type="text" name="applicant" value="<%if(applicant!=null)out.print(applicant);%>"></TD>
    <TD>软件名称</TD>
    <TD><input type="text" name="name" value="<%if(name!=null)out.print(name);%>"></TD>
  </tr>
  <tr>
    <TD>简称</TD>
    <TD><input type="text" name="shortname" value="<%if(shortname!=null)out.print(shortname);%>"></TD>
    <TD>版本号</TD>
    <TD><input type="text" name="ver" value="<%if(ver!=null)out.print(ver);%>"></TD>
  </tr>
  <tr>
    <TD>变更类别</TD>
    <TD><input type="text" name="type" value="<%if(type!=null)out.print(type);%>"></TD>
    <TD>变更项目</TD>
    <TD><input type="text" name="item" value="<%if(item!=null)out.print(item);%>"></TD>
  </tr>
    <tr>
    <TD>变前内容</TD>
    <TD><input type="text" name="beforeitem" value="<%if(beforeitem!=null)out.print(beforeitem);%>"></TD>
    <TD>变后内容</TD>
    <TD><input type="text" name="afteritem" value="<%if(afteritem!=null)out.print(afteritem);%>"></TD>
  </tr>
      <tr>
    <TD>出证日期</TD>
    <TD><input type="text" name="time" size=15 value="<%if(time!=null)out.print(time);%>"><input type=button value=... onClick="showCalendar('form1.time');"></TD>
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

