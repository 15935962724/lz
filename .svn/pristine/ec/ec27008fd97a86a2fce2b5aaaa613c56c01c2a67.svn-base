<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);



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

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD>证明编号</TD>
    <TD><%if(proving!=null)out.print(proving);%>
    <TD>登记号</TD>
    <TD><%if(scrbid!=null)out.print(scrbid);%>
  </tr>
  <TR>
    <TD>申请者</TD>
    <TD><%if(applicant!=null)out.print(applicant);%>
    <TD>软件名称</TD>
    <TD><%if(name!=null)out.print(name);%>
  </tr>
  <tr>
    <TD>简称</TD>
    <TD><%if(shortname!=null)out.print(shortname);%>
    <TD>版本号</TD>
    <TD><%if(ver!=null)out.print(ver);%>
  </tr>
  <tr>
    <TD>变更类别</TD>
    <TD><%if(type!=null)out.print(type);%>
    <TD>变更项目</TD>
    <TD><%if(item!=null)out.print(item);%>
  </tr>
    <tr>
    <TD>变前内容</TD>
    <TD><%if(beforeitem!=null)out.print(beforeitem);%>
    <TD>变后内容</TD>
    <TD><%if(afteritem!=null)out.print(afteritem);%>
  </tr>
      <tr>
    <TD>出证日期</TD>
    <TD><%if(time!=null)out.print(time);%></TD>
    <TD>原文路径</TD>
    <TD><%if(path!=null)out.print(path);%>
  </tr>
</TABLE>


<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

