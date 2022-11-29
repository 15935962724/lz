<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.db.*" %>
<%
TeaSession teasession = new TeaSession(request);
Community community =Community.find(teasession._strCommunity);
StringBuffer sql=new StringBuffer();

StringBuffer par=new StringBuffer("?");

int pos1=0,pos2=0,size=20;
String tmp=request.getParameter("pos1");
if(tmp!=null)
{
  pos1=Integer.parseInt(tmp);
}
tmp=request.getParameter("pos2");
if(tmp!=null)
{
  pos2=Integer.parseInt(tmp);
}
int count1=Hostel_application.count(sql.toString()+" AND audit=0");
int count2=Hostel_application.count(sql.toString()+" AND audit=1");
java.util.Enumeration e1=Hostel_application.find(sql.toString()+" AND audit=0",pos1,size);
java.util.Enumeration e2=Hostel_application.find(sql.toString()+" AND audit=1",pos2,size);
%>
<html>
<head>
<link  href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<title>audits</title>
</head>
<body>
<h1></h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<h2>酒店管理( <%%> )</h2>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td>酒店名称</td><td>待处理的订单数</td><td>操作</td>
</tr>
 <tr>
<td><a href=""><%%></a></td>
<td><a href=""><%%></a></td>
<td><a href=""> 订单管理 </a></td>
<td><a href=""> 酒店信息管理 </a></td>
<td><a href=""> 新闻管理 </a></td>
</tr>
<tr><td colspan="5" align="left">
  <%=new tea.htmlx.FPNL(teasession._nLanguage,par.toString()+"&pos1=",pos1,count1,size)%></td></tr>
</table>
</body>
</html>
