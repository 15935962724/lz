<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.io.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.htmlx.*"%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


TeaSession teasession = new TeaSession(request);
String member = teasession.getParameter("member");
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
int type = 0;//如果是 0 当天超过规定登录次数，本网会出现提示： 1 会员获取新密码后，当天持新密码登录出现以下提示：
if(teasession.getParameter("type")!=null && teasession.getParameter("type").length()>0)
{
	type = Integer.parseInt(teasession.getParameter("type"));
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body >
<%=community.getJspBefore(teasession._nLanguage)%>
 

<table border="0" align="center" cellpadding="0" cellspacing="0" id="tablecenter" height="10">
<tr>
	<td> 
	<%if(type == 0){ %>
	<font color=red><%=member %></font>，您好！<br>　　
	您的账户出现频繁登录的异常状况，已超过每日规定登录次数（5次），您的密码可能被盗。为了确保您的账户安全，我们已锁定您的账户，重置您的密码。请登录您的注册邮箱，获取新的登录密码并确保密码安全。<br/>
	<font color=red><b>重要提示：点击“退出登录”、“退出会员中心”按钮，或直接关闭网页浏览器，本次登录即告结束。</b></font><br>
　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　网站管理员
<%}else if(type == 1){ %> 
<font color=red><%=member %></font>，您好！<br/>
	您的账户今日已被锁定，请您持新密码于<b>明日0点</b>以后登录。<BR/> 
	<font color=red><B>重要提示：如果账户被锁定超过3次，本网有权进行调查并重新评估您对本账户的使用。</B></font><br>
　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　网站管理员

<%} %>
　</td>
</tr>
</table>
<%=community.getJspAfter(teasession._nLanguage)%>
</body>

</html>
