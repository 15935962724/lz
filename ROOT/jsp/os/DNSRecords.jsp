<%@page contentType="text/html; charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.os.*" %><%

Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String zone=h.get("zone","");
String name=h.get("name","");
String nexturl=h.get("nexturl");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>域名管理==><%=zone%></h1><!--域名管理-->
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="zone" value="<%=zone%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称：</td>
  <td><input name="name" value="<%=name%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>类型</td>
  <td>数据</td>
  <td>操作</td>
</tr>
<%
ArrayList al=DNSRecord.find(zone,name,0,Integer.MAX_VALUE);
if(al.size()<1)
  out.print("<tr><td colspan='3' align='center'>暂无记录！");
else
{
  for(int i=0;i<al.size();i++)
  {
    DNSRecord t=(DNSRecord)al.get(i);
    out.print("<tr><td>"+i);
    out.print("<td>"+t.name);
    out.print("<td>"+t.type);
    out.print("<td>"+t.content);
    out.println("<td><a href=''>编辑</a>");
  }
}
%>
</table>
</body>
</html>
