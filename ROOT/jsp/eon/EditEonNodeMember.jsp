<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.netdisk.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.TeaSession"%><%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}


Resource r=new Resource();
String nexturl=request.getParameter("nexturl");
String act=request.getParameter("act");
String old=request.getParameter("old");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1><%=r.getString(teasession._nLanguage, "设置服务人")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>

<form name="form1" action="/servlet/EditEonNode" onSubmit="return submitText(this.name,'无效-用户')">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>">
<input type="hidden" name="node" value="<%=teasession._nNode%>">
<input type="hidden" name="nexturl" value="<%=nexturl%>">
<input type="hidden" name="old" value="<%=old%>">
<input type="hidden" name="act" value="<%=act%>">

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td>用户</td>
  <td><input type="text" name="name" value="<%=old%>"/></td>
</tr>
</table>

<input type=submit value="<%=r.getString(teasession._nLanguage,"CBSubmit")%>">
<input type=button value="<%=r.getString(teasession._nLanguage,"返回")%>" onClick="history.back()">
</form>

</body>
</html>
