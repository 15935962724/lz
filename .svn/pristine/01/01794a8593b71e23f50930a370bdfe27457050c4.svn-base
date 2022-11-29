<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="java.util.*" %>
<%
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

TeaSession teasession =new TeaSession(request);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

if(teasession._rv==null)
{
  response.sendRedirect("/jsp/user/StartLogin.jsp?nexturl="+request.getRequestURI());
}
String email = request.getParameter("email");
if(email == null)
{
  email = teasession._rv._strR;
}
int bpid = Bperson.findId(email);
Bperson bp = Bperson.find(bpid);
%>
<html>
<!-- Stock photography -->
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>图库Email</title>

</head>
<style>
#table001{background:#F6F6F6;border-bottom:10px solid #eee;border-top:10px solid #eee;padding:6px;width:95%;margin-top:10px;}
#table001 td{padding:6px 15px;}
#chkCopy{border:0;}
#DdSendLB,#txtTo,#txtFrom,#txtSubject,#taMessage{border:1px solid #7F9DB9;background:#fff;}
</style>
<body style="margin:0;padding:0;">
<div id="wai">
<div id="li_biao"><a href="http://bp.redcome.com">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;图库Email</div>
<h1>图库Email</h1>
<form name="send" id="frmSendLB"  method="get" action="" onSubmit="return check();">
<table border="0" align="center" cellpadding="2" cellspacing="0" id="table001">
	<tr class="bg8">

		<td width="90%" class="padleft">请选择多个图库发送Email</td>
		<td width="10%"><img src="s.gif" width="1" height="1"></td>
	</tr>

	<tr>
		<td width="90%" align=right valign=top>在PC机使用Ctrl键，以选取多个图库</td>
		<td width="10%" class="padright">
<select multiple size=6 id="DdSendLB" name="DdSendLB" style="WIDTH:360;" >
  <%
                Enumeration e = BLightbox.findLightBox(bp.getEmail());
                while(e.hasMoreElements()){
                  String element = e.nextElement().toString();
                  out.print("<option value=\""+element+"\">"+element+"</option>");
                }
                %>

</select>

		</td>
	</tr>
	<tr>
		<td align="right">至 (输入Email地址):</td>
		<td  class="padright"><INPUT type="text" id="txtTo" name="txtTo" size=31 style="WIDTH: 360" maxlength="130"></td>
	</tr>
	<tr>
		<td align="right">来自:</td>
		<td class="padright"><INPUT type="text" id="txtFrom" name="txtFrom" value="zhangyichj@yahoo.com.cn" size=31 style="WIDTH: 360"  maxlength="130"></td>
	</tr>
	<tr>
		<td align="right">主题</td>
		<td class="padright"><INPUT type="text" id="txtSubject" name="txtSubject" size=31 style="WIDTH: 360px"  maxlength=100></td>
	</tr>
	<tr valign="top">
		<td align="right">消息</td>
		<td class="padright"><textarea class="textfield" id="taMessage" name="taMessage" cols="31" rows="5" wrap="soft" style="width:360;"></textarea></td>
	</tr>
	<tr valign="top">
		<td>&nbsp;</td>
		<td class="padright"><input type="checkbox" id=chkCopy name=chkCopy>请给我寄这封电子邮件</td>
	</tr>
	<tr><td colspan="4" align="right"><input type="submit" value="发送" id="SubmitLB" name="SubmitLB" width="140" class="button" >
		</td></tr>
</table>
</form>
</div>
</body>

<!-- Stock photography -->
</html>
