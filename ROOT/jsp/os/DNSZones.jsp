<%@page contentType="text/html; charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.entity.os.*" %><%

Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuilder par=new StringBuilder();
int menuid=h.getInt("id");
par.append("?id="+menuid);

String zone=h.get("zone","");
par.append("&zone="+Http.enc(zone));

int pos=h.getInt("pos");
par.append("&pos=");


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=AdminFunction.find(menuid).getName(h.language)%></h1><!--域名管理-->
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称：</td>
  <td><input name="zone" value="<%=zone%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>域名</td>
  <td>操作</td>
</tr>
<%
int sum=DNSZone.count(zone);
if(sum<1)
out.print("<tr><td colspan='3' align='center'>暂无记录！");
else
{
  ArrayList al=DNSZone.find(zone,0,20);
  for(int i=0;i<al.size();i++)
  {
    DNSZone t=(DNSZone)al.get(i);
    out.print("<tr><td>"+(i+1));
    out.print("<td>"+t.name);
    out.print("<td><a href='/jsp/os/DNSRecords.jsp?zone="+Http.enc(t.name)+"'>编辑</a>");
  }
  if(sum>20)out.print("<tr><td colspan='20' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}
%>
</table>
</body>
</html>
