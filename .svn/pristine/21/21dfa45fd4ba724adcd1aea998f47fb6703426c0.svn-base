<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource("/tea/resource/Other");

CommunityOption obj=CommunityOption.find("[SYSTEM]");
String proxyhost=obj.get("proxyhost");
if(proxyhost==null)proxyhost="";

int proxyport=obj.getInt("proxyport");
if(proxyport==0)proxyport=8080;


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "设置代理")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax">
<input type="hidden" name="community" value="[SYSTEM]">
<input type="hidden" name="name" value="/proxyport/proxyhost/">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"主机")%></td>
    <td><input name="proxyhost" value="<%=proxyhost%>"></td>
    <td></td>
  </tr>
  <tr>
    <td><%=r.getString(teasession._nLanguage,"端口")%></td>
    <td><input name="proxyport" value="<%=proxyport%>" mask="int" ></td>
    <td></td>
  </tr>
</table>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>


<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
