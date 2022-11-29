<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

h.member=62589;
int menuid=h.getInt("id");

LmsPlan lp=LmsPlan.getInstance();

LmsMemberCourse lmc=LmsMemberCourse.find(h.member,lp.lmsplan);
SimpleDateFormat SDF=new SimpleDateFormat("MM月dd日 E");


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#time{background-color:transparent;width:65px;text-align:center}
</style>
<script>
mt.row=function()
{
  var arr=document.getElementsByName('time');
  if(arr.length)arr=arr[arr.length-1];
  arr.setAttribute('rowSpan',1+parseInt(arr.getAttribute('rowSpan')||1));
};
</script>
</head>
<body>
<h1><%=menuid<1?"我的课程":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmscourse">
<input type="hidden" name="nexturl">

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="58">考试日期</td>
  <td>时间</td>
  <td>课程名称</td>
  <td>主编</td>
  <td>进入课程</td>
  <td>习题</td>
</tr>
<%
String last=null;
ArrayList al=LmsPlanCourse.find(" AND lmsplan="+lp.lmsplan+" AND "+DbAdapter.cite(lmc.lmscourse0+lmc.lmscourse1)+" LIKE "+DbAdapter.concat("'%|'","lmscourse","'|%'")+" ORDER BY starttime",0,200);
for(int i=0;i<al.size();i++)
{
  LmsPlanCourse lpc=(LmsPlanCourse)al.get(i);
  LmsCourse lc=LmsCourse.find(lpc.lmscourse);
  LmsScore ls=LmsScore.findLast(lmc.member,lp.lmsplan,lpc.lmscourse);
  String time=SDF.format(lpc.starttime);
  out.print("<tr id='"+MT.enc(lpc.lmscourse)+"'>");
  out.print(time.equals(last)?"<script>mt.row()</script>":"<td name='time' id='time'>"+time);
  last=time;
  out.print("<td>"+MT.f(lpc.starttime,1).substring(11)+"—"+MT.f(lpc.endtime,1).substring(11));
  out.print("<td>"+lc.name);
  out.print("<td>"+lc.operator);
  out.print("<td><a href='###' onclick=mt.act(this,'view')>-> 进入</a>");
  out.print("<td>"+(Attch.find(lc.problem).getAnchor("下载")));
}
%>
</table>

</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a)
{
  form2.lmscourse.value=mt.ftr(t).id;
  if(a=='view')
  {
    form2.action="/jsp/lms/MyLmsChapters.jsp";
  }
  form2.submit();
};
</script>
</body>
</html>
