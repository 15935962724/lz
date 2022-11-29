<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@ page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@ page import="tea.entity.cio.*" %><%@ page import="tea.ui.TeaSession" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");

int ccid=CioCompany.findByMember(teasession._rv.toString());

CioCompany cc = CioCompany.find(ccid);
if(!cc.isReceipt())
{
  response.sendRedirect("/jsp/cio/InfoCioCompany.jsp?alert="+java.net.URLEncoder.encode("您的信息还没有被审核,暂时不能查看座位安排.","UTF-8"));
  return;
}

String nexturl=request.getParameter("nexturl");

String q=request.getParameter("q");

StringBuilder sql=new StringBuilder();


Resource r=new Resource();


%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body style="text-align:left;">
<img src="/res/cavendishgroup/u/0810/081059219.jpg" border="0"/>
</body>
</html>
