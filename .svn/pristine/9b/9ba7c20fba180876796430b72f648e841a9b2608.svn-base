<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%!
String f(ArrayList al,int i,int j)
{
  LmsPrice lp=(LmsPrice)al.get(0);
  LmsPrice t=(LmsPrice)al.get(i);
  float val=t.price[j]-lp.price[j];
  return MT.f(t.price[j])+"　<font color="+(val>0?"#FE0002>+":"#009900>")+""+MT.f(val)+"</font>";
}
%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmsprice");
int lmsprice=Integer.parseInt(MT.dec(key));


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<style>
th{width:200px}
</style>
</head>
<body>
<h1>查看收费标准</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1">

<%
ArrayList al=LmsPrice.find(" AND "+lmsprice+" IN(lmsprice,father) ORDER BY city",0,200);
for(int i=0;i<al.size();i++)
{
  LmsPrice t=(LmsPrice)al.get(i);
%>
<h2><%=t.city<1?"默认":"<script>mt.city('"+t.city+"')</script>"%></h2>
<table id="tablecenter" cellspacing="0">
<%
if(i<1)
{
%>
  <tr>
    <th>考试计划：</th>
    <td colspan="3"><%=LmsPlan.find(t.lmsplan).name%></td>
  </tr>
<%
}%>
  <tr>
    <th>实践考费：</th>
    <td><%=f(al,i,1)%></td>
    <th>机考费：</th>
    <td><%=f(al,i,2)%></td>
  </tr>
  <tr>
<!--
    <th>实践环节重考费</th>
    <td><%=f(al,i,3)%></td>
-->
    <th>培训费：</th>
    <td><%=f(al,i,4)%></td>
    <th>考试费：</th>
    <td><%=f(al,i,5)%></td>
  </tr>
  <tr>
    <th>项目管理费：</th>
    <td><%=f(al,i,6)%></td>
    <th>省级管理费：</th>
    <td><%=f(al,i,7)%></td>
  </tr>
</table>
<%
}%>
<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
</script>
</body>
</html>
