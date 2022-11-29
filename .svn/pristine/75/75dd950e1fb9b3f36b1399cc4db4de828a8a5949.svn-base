<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource"  %><%@page  import="tea.entity.copyright.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String nexturl=request.getParameter("nexturl");

int crtransfer=Integer.parseInt(request.getParameter("crtransfer"));
String scrbid=null,droit=null,startdate=null,enddate=null,heir=null,heirnation=null,passdate=null;
if(crtransfer>0)
{
  Crtransfer obj=Crtransfer.find(crtransfer);
  scrbid=obj.getScrbid();
  droit=obj.getDroit();
  startdate=obj.getStartdateToString();
  enddate=obj.getEnddateToString();
  heir=obj.getHeir();
  heirnation=obj.getHeirnation();
  passdate=obj.getPassdateToString();
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

<h1>计算机软件著作权转移备案公告</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<FORM NAME="form1" ACTION="/servlet/EditCopyRight" METHOD="post" onSubmit="return submitText(this.scrbid,'无效-登记号')&&submitText(this.droit,'无效-权利转移权限')&&submitText(this.passdate,'无效-转移备案批准日期');">
  <input type="hidden" name="act" value="editcrtransfer"/>
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>">
  <input type="hidden" name="crtransfer" value="<%=crtransfer%>">
  <input type="hidden" name="nexturl" value="<%=nexturl%>">
  
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <TR>
    <TD >登记号</TD>
    <TD><input type="text" name="scrbid" <%if(crtransfer>0)out.print(" disabled ");%> value="<%if(scrbid!=null)out.print(scrbid);%>"></TD>
    <TD >权利转移权限</TD>
    <TD><input type="text" name="droit" value="<%if(droit!=null)out.print(droit);%>"></TD>
  </tr>
  <tr>
    <TD>转移开始日期</TD>
    <TD><input type="text" name="startdate" size="15" value="<%if(startdate!=null)out.print(startdate);%>"><input type=button value=... onClick="showCalendar('form1.startdate');"></TD>
    <TD>转移结束日期</TD>
    <TD><input type="text" name="enddate" size="15" value="<%if(enddate!=null)out.print(enddate);%>"><input type=button value=... onClick="showCalendar('form1.enddate');"></TD>
  </tr>
  <tr>
    <TD>权利继受人姓名</TD>
    <TD><input type="text" name="heir" value="<%if(heir!=null)out.print(heir);%>"></TD>
    <TD>权利继受人国籍</TD>
    <TD><input type="text" name="heirnation" value="<%if(heirnation!=null)out.print(heirnation);%>"></TD>
  </tr>
  <tr>
    <TD>转移备案批准日期</TD>
    <TD><input type="text" name="passdate" size="15" value="<%if(passdate!=null)out.print(passdate);%>"><input type=button value=... onClick="showCalendar('form1.passdate');"></TD>
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

