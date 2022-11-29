<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.*" %>
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


%><html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<script src="/tea/mt.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.picpath.focus();">
<h1><%=r.getString(teasession._nLanguage, "图片管理设置")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax">
<input type="hidden" name="community" value="[SYSTEM]">
<input type="hidden" name="name" value="/picpath/">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td><%=r.getString(teasession._nLanguage,"原图保存路径")%></td>
    <td><input name="picpath" size="50" value="<%=MT.f(obj.get("picpath"))%>"></td>
    <td></td>
  </tr>
</table>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>
