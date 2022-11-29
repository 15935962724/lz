<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("member");
int member=Integer.parseInt(MT.dec(key));
int tab=h.getInt("tab");
Profile p=Profile.find(member);
SimpleDateFormat SDF=new SimpleDateFormat("MM月dd日 E");
int type=0;

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#time{background-color:transparent}
</style>
<script>
mt.row=function()
{
  var arr=document.getElementsByName('time');
  if(arr.length)arr=arr[arr.length-1];
  arr.setAttribute('rowSpan',1+parseInt(arr.getAttribute('rowSpan')||1));
};
pmt=parent.mt;
</script>
</head>
<body>
<h1>查看学员报考</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="member" value="<%=key%>"/>
<input type="hidden" name="tab" value="<%=tab%>"/>
</form>

<%//=lp.name+"计划下考试科目表<font color='red'>（学员："+p.getName(h.language)+"（"+p.getMember()+"）　"+(type==0?"机考":"实践")+"报考科目）</font>"%>

<%
out.print("<div class='switch'>");
ArrayList al=LmsMemberCourse.find(" AND member="+member+" ORDER BY lmsplan DESC",0,200);
for(int i=0;i<al.size();i++)
{
  LmsMemberCourse lmc=(LmsMemberCourse)al.get(i);
  LmsPlan lp=LmsPlan.find(lmc.lmsplan);
  out.print("<a href='javascript:mt.tab("+i+")' class='"+(tab==i?"current":"")+"'>"+lp.name+"</a>");
}
out.print("</div>");
LmsMemberCourse lmc=(LmsMemberCourse)al.get(tab);
LmsPlan lp=LmsPlan.find(lmc.lmsplan);

%>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="58">日期</td>
  <td>时间</td>
  <td>代码</td>
  <td>实践</td>
  <td>机考</td>
  <td>备注</td>
</tr>
<%
String last=null;
al=LmsPlanCourse.find(" AND lmsplan="+lp.lmsplan+" ORDER BY starttime",0,200);
for(int i=0;i<al.size();i++)
{
  LmsPlanCourse lpc=(LmsPlanCourse)al.get(i);
  LmsCourse lc=LmsCourse.find(lpc.lmscourse);
  //LmsExam le=LmsExam.find(member,lp.lmsplan,lpc.lmscourse,type);
  LmsScore ls=LmsScore.find(member,lp.lmsplan,lpc.lmscourse);
  String time=SDF.format(lpc.starttime);
  out.print("<tr>");
  out.print(time.equals(last)?"<script>mt.row()</script>":"<td name='time' id='time'>"+time);
  last=time;
  out.print("<td>"+MT.f(lpc.starttime,1).substring(11)+"—"+MT.f(lpc.endtime,1).substring(11));
  out.print("<td>"+lc.code);
  out.print("<td>"+lc.name);
  if(lmc.lmscourse0.contains("|"+lpc.lmscourse+"|"))out.print("<font color='red'>（已报）</font>");
  if(ls.time!=null)out.print("<font title='考试得分'>"+ls.score+"</font>");
  out.print("<td>"+lc.name);
  if(lmc.lmscourse1.contains("|"+lpc.lmscourse+"|"))out.print("<font color='red'>（已报）</font>");
  out.print("<td>"+(lpc.lmscert<1?"专业核心课<font color='red'>（必考）</font>":LmsCert.find(lpc.lmscert).name));
}
%>
</table>

<br/>
<script>
document.write((mt.isIE?0:1)==history.length?"<input type='button' value='关闭' onclick=window.open('','_self');window.close() />":"<input type='button' value='返回' onclick='history.back()' />");
</script>

</body>
</html>
