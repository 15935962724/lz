<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter"  %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.util.*"%><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Other");

CommunityOption obj=CommunityOption.find("[SYSTEM]");
String inter=obj.get("westracinter");
if(inter==null)inter="5";

%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1>会员同步——第一工程机械</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax" onsubmit="">
<input type="hidden" name="community" value="[SYSTEM]"/>
<input type="hidden" name="name" value="/westracurl/westracinter/">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td>接口地址</td>
    <td><input name="westracurl" value="<%=MT.f(obj.get("westracurl"))%>" size="40"></td>
  </tr>
  <tr>
    <td>间隔</td>
    <td><input name="westracinter" value="<%=inter%>" size="10" mask="int">秒</td>
  </tr>
</table>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
