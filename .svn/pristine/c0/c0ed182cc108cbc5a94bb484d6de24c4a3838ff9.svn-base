<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"  %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.admin.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*"%><%
request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource("/tea/resource/Other");

CommunityOption obj=CommunityOption.find(h.community);



%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>微信设置</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/servlet/EditCommunityOption" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>">
<input type="hidden" name="name" value="/mmwelcome/mmnotfound/">

<table cellpadding="0" cellspacing="0" border="0" id="tablecenter">
  <tr>
    <td>欢迎语</td>
    <td><textarea name="mmwelcome" rows="5" cols="50"><%=MT.f(obj.get("mmwelcome"))%></textarea></td>
    <td></td>
  </tr>
  <tr>
    <td>未找到</td>
    <td><textarea name="mmnotfound" rows="5" cols="50"><%=MT.f(obj.get("mmnotfound"))%></textarea></td>
    <td></td>
  </tr>
</table>

<input type="submit" class="edit_input" value="<%=r.getString(teasession._nLanguage,"Submit")%>">
</form>

<!--<iframe src="/tea/editor.htm?instance=mmnotfound" width="550" height="150" frameborder="0"></iframe>-->

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
