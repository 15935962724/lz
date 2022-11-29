<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.service.version.Version" %>
<%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
/*
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
*/

Version v=new Version();
String path=request.getSession().getServletContext().getRealPath("/");
v.getversion(path+"\\version\\version.properties");
Resource r=new Resource("/tea/resource/Lucene");

String rp=application.getRealPath("/");
int i=rp.lastIndexOf('\\',rp.length()-2);
if(i!=-1)
{
  rp=rp.substring(rp.lastIndexOf('\\',i-1)+1,i);
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<title>
系统信息
</title>
</head>
<body>

<div class="Sinfo">系统信息</div>
<ul class="ver_ul">
<% if(v.getClient()!=null){%>

<li class="ver_li" style="text-align:center;">客户号:<%=v.getClient()%></li>
<li class="ver_li" style="text-align:center;">当前版本是：<%=v.getCurversion()%></li>
<li class="ver_li" style="text-align:center;">最后更新时间是：<%=v.getUpdatetime()%></li>
<li class="ver_li" style="text-align:center;">路径：<%=rp%></li>
<%
}else
out.print("<li class=\"ver_li\" style=\"text-align:center;\">您尚未设置系统信息，请与系统管理员联系</li>");
%>
</ul>
</body>
</html>
