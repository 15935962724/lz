<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);



int crimpawn=Integer.parseInt(request.getParameter("crimpawn"));

String code=null;
String scrbid=null;
String name=null;
String shortname=null;
String mortgagor=null;//出质人
String pawnee=null;//质权人
String ver=null;
String time=null;
String cancel=null;
String states=null;
String path=null;
if(crimpawn>0)
{
	  Crimpawn obj=Crimpawn.find(crimpawn);
	  code=obj.getCode();
	  scrbid=obj.getScrbid();
	  name=obj.getName();
	  shortname=obj.getShortname();
	  mortgagor=obj.getMortgagor();
	  pawnee=obj.getPawnee();
	  ver=obj.getVer();
	  time=obj.getTime();
	  cancel=obj.getCancel();
	  states=obj.getStates();
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

<h1>许可合同公告信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD>证明编号</TD>
    <TD><%if(code!=null)out.print(code);%></TD>
    <TD>登记号</TD>
    <TD><%if(scrbid!=null)out.print(scrbid);%></TD>
  </tr>
  <TR>
    <TD>软件名称</TD>
    <TD><%if(name!=null)out.print(name);%></TD>
    <TD>简称</TD>
    <TD><%if(shortname!=null)out.print(shortname);%></TD>
  </tr>
  <tr>
    <TD>出质人</TD>
    <TD><%if(mortgagor!=null)out.print(mortgagor);%></TD>
    <TD>质权人</TD>
    <TD><%if(pawnee!=null)out.print(pawnee);%></TD>
  </tr>
  <tr>
    <TD>版本号</TD>
    <TD><%if(ver!=null)out.print(ver);%></TD>
  </tr>
   <tr>
    <TD>出证日期</TD>
    <TD><%if(time!=null)out.print(time);%></TD>
    <TD>注销撤消日期</TD>
    <TD><%if(cancel!=null)out.print(cancel);%></TD>
  </tr>
  <tr>
    <TD>状态</TD>
    <TD><%if(states!=null)out.print(states);%></TD>
	<TD>原文路径</TD>
    <TD><%if(path!=null)out.print(path);%></TD>
  </tr>
</TABLE>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

