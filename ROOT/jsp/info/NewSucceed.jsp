<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.site.*" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

Resource r=new Resource();

String info=request.getParameter("info");
if(info==null)
{
  info=r.getString(teasession._nLanguage,"UpdateSuccessful");
}
info=info.replaceAll("\"","&quot;");
String nexturl=request.getParameter("nexturl");

Community community=Community.find(teasession._strCommunity);
%>



<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<TR><TD><%=info%>　　　
<a href="/" >返回首页</a></td></TR>
</table>
</body>
</html>

