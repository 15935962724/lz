<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.db.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Community community =Community.find(teasession._strCommunity);
StringBuffer sql=new StringBuffer();
sql.append(" AND nodeid IN (SELECT node FROM Node )");
StringBuffer par=new StringBuffer("?");
String memberid=request.getParameter("memberid");
if(memberid!=null&&memberid.length()>0)
{
  sql.append(" AND  memberid LIKE ").append(DbAdapter.cite(memberid));
  par.append("&memberid=").append(java.net.URLEncoder.encode(memberid,"UTF-8"));
}
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
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js" type=""></script>
<title>audits</title>
</head>
<body>
<h1>访问统计</h1>
<a href="">简要数据</a><a>热门话题</a><a href="">热门探索</a> <a>24小时统计</a><a>日统计</a><a>月统计</a><a>地区统计</a><a>来源统计</a><a>最后二十位访客</a>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<h2>网站统计简要信息</h2>
<!--此处师傅写的是提交给自己-->
<form name="form1" action="Editaudits.jsp">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td><label>网站名称：</label>
</td>
<td><% %></td>
<td><label>网站地址：</label></td>
<td><% %></td>
</tr>
<tr>
<td>
<label>网站信箱：</label>
</td>
<td><% %></td>
</tr>
<tr><td><label>总访问人数:</label></td>
<td><% %></td>
<td><label>开始统计日期：</label></td>
<td><% %></td>
</tr>
<tr>
<td><label>今日访问量：</label></td>
<td><% %></td>
<td><label>本月访问量：</label></td>
<td><% %></td>
</tr>
<tr>
<td><label>统计天数：</label></td>
<td><% %></td>
<td><label>平均日访问量：</label></td>
<td><% %></td>
</tr>
</table>
</form>
<h2>图表</h2>
<h3>最近24小时统计图表</h3>
<h3>访问量24小时分配图表</h3>
</body>
</html>
