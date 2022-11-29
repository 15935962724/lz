<%@page contentType="text/html;charset=UTF-8"  %><%@page import="java.util.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.db.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.resource.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%request.setCharacterEncoding("UTF-8"); %>
<%
TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");


StringBuffer sb=new StringBuffer();
String rs[]=request.getParameterValues("resumes");
for(int i=0;i<rs.length;i++)
{
  sb.append("&resumes=").append(rs[i]);
}


Resource r=new Resource("/tea/resource/Job");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1><%=r.getString(teasession._nLanguage, "1167458350890")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
  <td align="center">
    <a href="/servlet/ExportResume?act=down<%=sb.toString()%>" target="_blank" onclick="window.close();"><%=r.getString(teasession._nLanguage, "Download")%></a>
    <a href="/jsp/type/resume/SendEmailCandidate.jsp?act=export<%=sb.toString()%>" target="_blank" onclick="window.close();"><%=r.getString(teasession._nLanguage, "1167459387343")%></a>
  </td>
</tr>
<tr><td><%=r.getString(teasession._nLanguage, "1167459475187")%><!--点击下载可把文档下载到本机-->
<tr><td><%=r.getString(teasession._nLanguage, "1167459509296")%><!--点击发送可直接把导出的文档发送到任意邮箱-->
</table>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
