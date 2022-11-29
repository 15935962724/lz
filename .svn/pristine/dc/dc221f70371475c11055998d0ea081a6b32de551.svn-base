<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.http.RequestHelper"%>
<%@ page import = "tea.resource.Resource" %>
<%@ page import = "tea.entity.node.Sms" %>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
Resource r = new Resource("/tea/ui/node/type/sms/EditUser");

TeaSession teasession = new TeaSession(request);

Community communitys=Community.find(teasession._strCommunity);

%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body id="bodynone">

<div id="jspbefore" style="display:none">
<%=communitys.getJspBefore(teasession._nLanguage)%>
</div>
<div id="regoktop"></div>
<div id="regsuccess">
<h1><%=r.getString(teasession._nLanguage, "RegSuccess")%></h1>

<div id="head6"><img height="6" src="about:blank"></div>


<fieldset>
<%

CommunityOption co = CommunityOption.find(teasession._strCommunity);
int lv = co.getInt("loginvalid"); //"所有会员","审核会员","后台会员"
switch(lv)
{
  case 0:
  out.print(r.getString(teasession._nLanguage,"AlreadyRegSuccess")+"<br><input type='button' value='"+r.getString(teasession._nLanguage,"SoonEnter")+"' onClick=window.open('/servlet/StartLogin?node="+teasession._nNode+"&Language="+teasession._nLanguage+"','_self');>");
  break;
  default:
  out.print("会员注册已成功,需要管理员审核后,才能登陆!!<br><input type='button' value='回首页' onclick=window.open('/','_self');");
}
%>
</fieldset>
</div>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>

<div id="jspafter" style="display:none">
<%=communitys.getJspAfter(teasession._nLanguage)%>
</div>
<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}
</script>
</body>
</html>
