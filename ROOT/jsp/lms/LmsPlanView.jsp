<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%!
String f(ArrayList al,int i,int j)
{
  return "";
//  LmsPlan lp=(LmsPlan)al.get(0);
//  LmsPlan t=(LmsPlan)al.get(i);
//  float val=t.price[j]-lp.price[j];
//  return MT.f(t.price[j])+"　<font color="+(val>0?"#FE0002>+":"#009900>")+""+MT.f(val)+"</font>";
}
%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmsplan");
int lmsplan=Integer.parseInt(MT.dec(key));


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

<form name="form1" >

<%
ArrayList al=LmsPlan.find(" AND "+lmsplan+" IN(lmsplan,father) ORDER BY city",0,200);
for(int i=0;i<al.size();i++)
{
  LmsPlan t=(LmsPlan)al.get(i);
%>
<h2><%=t.city<1?"默认":"<script>mt.city('"+t.city+"')</script>"%></h2>
<table id="tablecenter" cellspacing="0">
<%
if(i<1)
{
%>
  <tr>
    <th>考试计划：</th>
    <td colspan="3"><%=t.name%></td>
  </tr>
<%
}%>
  <tr>
    <th>机考报考开始时间</th>
    <td><%=MT.f(t.starttime,1)%></td>
    <th>机考报考结束时间</th>
    <td><%=MT.f(t.endtime,1)%></td>
  </tr>
  <tr>
    <th>实践环节报考开始时间</th>
    <td><%=MT.f(t.pstarttime,1)%></td>
    <th>实践环节报考结束时间</th>
    <td><%=MT.f(t.pendtime,1)%></td>
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
