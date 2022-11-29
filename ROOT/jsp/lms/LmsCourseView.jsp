<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


String key=h.get("lmscourse");
LmsCourse t=LmsCourse.find(Integer.parseInt(MT.dec(key)));


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看课程信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsCourses.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0" class='alignLeft'>
  <tr>
    <th nowrap>课程代码：</th>
    <td><%=MT.f(t.code)%></td>
  </tr>
  <tr>
    <th>类型：</th>
    <td><%=LmsCourse.COURSE_TYPE[t.type]%></td>
  </tr>
  <tr>
    <th>名称：</th>
    <td><%=MT.f(t.name)%></td>
  </tr>
  <tr>
    <th>主编：</th>
    <td><%=MT.f(t.operator)%></td>
  </tr>
  <tr>
    <th>课件地址：</th>
    <td><%=MT.f(t.address)%></td>
  </tr>
  <tr>
    <th>习题：</th>
    <td><%=Attch.f(t.problem)%></td>
  </tr>
  <tr>
    <th>课时：</th>
    <td align='right'><%=MT.f(t.period)%></td>
  </tr>
  <tr>
    <th>学分：</th>
    <td><%=MT.f(t.credit)%></td>
  </tr>
  <tr>
    <th>状态：</th>
    <td><%=LmsCourse.STATUS_TYPE[t.status]%></td>
  </tr>
  <tr>
    <th>描述：</th>
    <td><%=MT.f(t.content).replaceAll("\r\n","<br/>")%></td>
  </tr>
</table>

<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script></script>
</body>
</html>
