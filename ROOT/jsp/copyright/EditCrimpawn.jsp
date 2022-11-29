<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
	response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
	return;
}

String nexturl=request.getParameter("nexturl");

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

<FORM NAME="form1" ACTION="/servlet/EditCopyRight" METHOD="post" onSubmit="return submitText(this.code,'无效-证明编号')&&submitText(this.scrbid,'无效-登记号')&&submitText(this.name,'无效-软件名称')&&submitText(this.mortgagor,'无效-出质人')&&submitText(this.pawnee,'无效-质权人');">
  <input type="hidden" name="act" value="editcrimpawn"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="crimpawn" value="<%=crimpawn%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD>登记号</TD>
    <TD><input type="text" size="40" name="scrbid" <%if(crimpawn>0)out.print(" disabled ");%> value="<%if(scrbid!=null)out.print(scrbid);%>"></TD>
    <TD>证明编号</TD>
    <TD><input type="text" size="40" name="code" value="<%if(code!=null)out.print(code);%>"></TD>
  </tr>
  <TR>
    <TD>软件名称</TD>
    <TD><input type="text" size="40" name="name" value="<%if(name!=null)out.print(name);%>"></TD>
    <TD>简称</TD>
    <TD><input type="text" size="40" name="shortname" value="<%if(shortname!=null)out.print(shortname);%>"></TD>
  </tr>
  <tr>
    <TD>出质人</TD>
    <TD><input type="text" size="40" name="mortgagor" value="<%if(mortgagor!=null)out.print(mortgagor);%>"></TD>
    <TD>质权人</TD>
    <TD><input type="text" size="40" name="pawnee" value="<%if(pawnee!=null)out.print(pawnee);%>"></TD>
  </tr>
  <tr>
    <TD>版本号</TD>
    <TD><input type="text" size="40" name="ver" value="<%if(ver!=null)out.print(ver);%>"></TD>
  </tr>
   <tr>
    <TD>出证日期</TD>
    <TD><input type="text" name="time" size=15 value="<%if(time!=null)out.print(time);%>"><input type=button value=... onClick="showCalendar('form1.time');"></TD>
    <TD>注销撤消日期</TD>
    <TD><input type="text" name="cancel" size=15 value="<%if(cancel!=null)out.print(cancel);%>"><input type=button value=... onClick="showCalendar('form1.cancel');"></TD>
  </tr>
  <tr>
    <TD>状态</TD>
    <TD><input type="text" size="40" name="states" value="<%if(states!=null)out.print(states);%>"></TD>
	<TD>原文路径</TD>
    <TD><input type="text" size="40" name="path" value="<%if(path!=null)out.print(path);%>"></TD>
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

