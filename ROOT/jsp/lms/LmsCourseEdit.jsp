<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmscourse");
int lmscourse=key.length()<1?0:Integer.parseInt(MT.dec(key));

LmsCourse t=LmsCourse.find(lmscourse);
if(t.lmscourse<1)
{
  t.type=t.status=1;
}

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=t.lmscourse<1?"添加":"编辑"%>课程信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsCourses.do?repository=course" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmscourse" value="<%=key%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0" class='alignLeft'>
  <tr>
    <th><em>*</em>课程代码：</th>
    <td><input name="code" value="<%=MT.f(t.code)%>" alt="课程代码"/></td>
  </tr>
  <tr>
    <th><em>*</em>类型：</th>
    <!--<td><%=h.radios(LmsCourse.COURSE_TYPE,"type",t.type)%></td>-->
    <td><select name="lmscert"><option value="0">证书基础课</option><optgroup label="证书方向课"><%=LmsCert.options(" AND rank=2",t.lmscert)%></optgroup></select></td>
  </tr>
  <tr>
    <th><em>*</em>名称：</th>
    <td><input name="name" value="<%=MT.f(t.name)%>" alt="名称" size="40"/></td>
  </tr>
  <tr>
    <th><em>*</em>主编：</th>
    <td><input name="operator" value="<%=MT.f(t.operator)%>" alt="主编" size="30"/></td>
  </tr>
  <tr>
    <th>课件地址：</th>
    <td><input name="address" value="<%=MT.f(t.address)%>" size="30"/></td>
  </tr>
  <tr>
    <th>习题：</th>
    <td>
      <input type="file" name="problem" <%=t.problem>0?"_alt":"del_alt"%>="习题"/>
      <%
      if(t.problem>0)
      {
        out.print(Attch.find(t.problem).getAnchor("查看"));
      }
      %>
    </td>
  </tr>
  <tr>
    <th><em>*</em>课时：</th>
    <td><input name="period" value="<%=MT.f(t.period)%>" alt="课时" mask="float"/></td>
  </tr>
  <tr>
    <th><em>*</em>学分：</th>
    <td><input name="credit" value="<%=MT.f(t.credit)%>" alt="学分" mask="float"/></td>
  </tr>
  <tr>
    <th><em>*</em>状态：</th>
    <td><%=h.radios(LmsCourse.STATUS_TYPE,"status",t.status)%></td>
  </tr>
  <tr>
    <th>描述：</th>
    <td><textarea name="content" cols="60" rows="6"><%=MT.f(t.content)%></textarea></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
