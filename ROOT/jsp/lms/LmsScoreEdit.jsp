<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmsscore");
int lmsscore=Integer.parseInt(MT.dec(key));
LmsScore t=LmsScore.find(lmsscore);


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=t.lmsscore<1?"添加":"编辑"%>考试成绩</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsScores.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsscore" value="<%=key%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <th>学员姓名：</th>
    <td><%=t.member<1?"--":Profile.find(t.member).getName(h.language)%></td>
  </tr>
  <tr>
    <th>学习服务中心：</th>
    <td><%=t.lmsorg<1?"--":LmsOrg.find(t.lmsorg).orgname%></td>
  </tr>
  <tr>
    <th>考试计划：</th>
    <td><select name="lmsplan"><option value="">--<%=LmsPlan.options(" AND father=0 AND status IN(2,4)",t.lmsplan)%></select></td>
  </tr>
  <tr>
    <th>考试科目：</th>
    <td><input name="lmscourse" value="<%=t.lmscourse<1?"--":LmsCourse.find(t.lmscourse).name%>" size="30"/></td>
  </tr>
  <tr>
    <th>证件号：</th>
    <td><input name="card" value="<%=MT.f(t.card)%>" size="30"/></td>
  </tr>
  <tr>
    <th>准考证号：</th>
    <td><input name="ticket" value="<%=MT.f(t.ticket)%>"/></td>
  </tr>
  <tr>
    <th>总成绩：</th>
    <td><input name="score" value="<%=MT.f(t.score)%>" mask="float"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
