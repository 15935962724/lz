<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.subscribe.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.subscribe.*" %>

<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache"); 
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
String mobile = teasession.getParameter("mobile");
String mobilecode = teasession.getParameter("mobilecode");
String nexturl = teasession.getParameter("nexturl");
int poid = 0;

String moorder = MobileOrder.getMobileOrder(mobile,mobilecode,teasession._nNode,teasession._strCommunity);
//Cookie 
MobileOrder  mobj = MobileOrder.find(moorder);

if(!mobj.isExists())
{
	out.print("<script>alert('您输入的有错误，不能查看这个页面！');</script>");
	return;
}

//添加支付中转表 
	if(tea.entity.admin.PayOrder.isPoid(teasession._strCommunity,moorder,4)>0)
	{
		poid = tea.entity.admin.PayOrder.isPoid(teasession._strCommunity,moorder,4);
	}else
	{ 
		poid = tea.entity.admin.PayOrder.create(moorder,mobj.getAmount(),null,teasession._strCommunity,0,4);
	}

	/*
MobileOrder  mobj = MobileOrder.find(MobileOrder.getMobileOrder(mobile,mobilecode,teasession._nNode,teasession._strCommunity));
//激活 付款
mobj.setType(1);
mobj.setPaytime(new Date());


Cookie cookie=new Cookie(String.valueOf(mobj.getNode()),"/"+mobile+"/"+mobilecode+"/"+teasession._nNode+"/"+teasession._strCommunity+"/");
cookie.setMaxAge(60*60*24);//60*60*24一天
cookie.setPath("/");
response.addCookie(cookie);
*/

%>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<html>
<head>
<title>手机支付</title>
</head>

<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<h1>手机支付</h1>
<div class="PromptPay">短信确认码验证成功，您的手机号码是：<%=mobile %>&nbsp;&nbsp;&nbsp;&nbsp;您输入的短信确认码是：<%=mobilecode %></div>
<div class="Payment" id="Payment">
您需要支付费用后，才能使用该阅读密码进行一天的阅读，请选择下面的方式支付5元费用：
</div>
<div class="Paybutton" id="Paybutton">
<% 

out.print(tea.entity.admin.Payinstall.getPaybutton(teasession._strCommunity,4,poid)); 

%>
</div>
<span id="paybutton2_id" style="display:none">
通过支付通道，你是否支付成功了：
<div class="PaySuc"><a href="/html/folder/<%=teasession._nNode %>-<%=teasession._nLanguage %>.htm"><img src="/jsp/img/SuccessfulPay.png"></a>　<img src="/jsp/img/FailurePay.png"></div>
</span>


<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

</body>
</html>
