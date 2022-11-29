<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuilder sql=new StringBuilder(),par=new StringBuilder();

String key=h.get("member");
int member=Integer.parseInt(MT.dec(key));
sql.append(" AND member="+member);
par.append("?member="+key);

int pos=h.getInt("pos");
par.append("&pos=");

Profile p=Profile.find(member);

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body class="iframe">

<table id="tablecenter" cellspacing="0">
<tr>
  <th>姓名：</th>
  <td><%=p.getName(h.language)%></td>
  <th>学号：</th>
  <td><%=p.getMember()%></td>
</tr>
<tr>
  <th>证件号：</th>
  <td><%=p.getCard()%></td>
  <th>准考证号：</th>
  <td><%=MT.f(p.getCardnumber())%></td>
</tr>
</table>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>报考日期</td>
  <td>报考课程</td>
  <td>分数</td>
</tr>
<%
int sum=LmsScore.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  ArrayList al=LmsScore.find(sql.toString(),pos,8);
  for(int i=0;i<al.size();i++)
  {
    LmsScore t=(LmsScore)al.get(i);
  %>
  <tr>
    <td><%=LmsPlan.find(t.lmsplan).name%></td>
    <td><%=LmsCourse.find(t.lmscourse).name%></td>
    <td><%=t.score%></td>
  </tr>
  <%
  }
  out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,8));
}
%>
</table>
<input type="button" value="关闭" onclick="pmt.close()"/>

<script>
pmt=parent.mt;
mt.fit();
</script>
</body>
</html>
