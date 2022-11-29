<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.admin.mov.*"%>
<%
request.setCharacterEncoding("UTF-8");

response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);

String nexturl = request.getRequestURI()+"?community="+teasession._strCommunity+request.getContextPath();
tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body bgcolor="#ffffff">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<h1>选择注册会员类型</h1>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<%
    java.util.Enumeration e = MemberType.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
    while(e.hasMoreElements())
    {
        int mtid = ((Integer)e.nextElement()).intValue();
        MemberType mtobj = MemberType.find(mtid);
%>
  <tr>
    <td><a href="/jsp/mov/Transfer.jsp?community=<%=teasession._strCommunity%>&membertype=<%=mtid%>&nexturl=<%=java.net.URLEncoder.encode(nexturl,"UTF-8")%>"><%=mtobj.getMembername() %></a></td>
  </tr>
<% } %>
</table>


<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

</body>
</html>
