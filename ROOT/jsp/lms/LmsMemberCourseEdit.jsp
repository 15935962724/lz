<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.text.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String mkey=h.get("member");
int member=mkey.length()<1?0:Integer.parseInt(MT.dec(mkey));

int type=h.getInt("type");
LmsMemberCourse lmc=LmsMemberCourse.find(member,h.getInt("lmsplan"));
LmsPlan lp=LmsPlan.find(lmc.lmsplan);
Profile p=Profile.find(lmc.member);
SimpleDateFormat SDF=new SimpleDateFormat("MM月dd日 E");

String str=type==0?lmc.lmscourse0:lmc.lmscourse1;

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
pmt=parent.mt;
</script>
</head>
<body class="iframe">

<form name="form2" action="/LmsMemberCourses.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
<input type="hidden" name="lmsmembercourse" value="<%=MT.enc(lmc.lmsmembercourse)%>"/>
<input type="hidden" name="member" value="<%=mkey%>"/>
<input type="hidden" name="lmsplan" value="<%=lmc.lmsplan%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<br/>
<%=lp.name+"计划下考试科目表<font color='red'>（学员："+p.getName(h.language)+"（"+p.getMember()+"）　"+(type==0?"实践":"机考")+"报考科目）</font>"%>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="58">日期</td>
  <td>时间</td>
  <td>代码</td>
  <td>课程名称</td>
  <td>备注</td>
</tr>
<%
String last=null;
ArrayList al=LmsPlanCourse.find(" AND lmsplan="+lp.lmsplan+" ORDER BY starttime",0,200);
for(int i=0;i<al.size();i++)
{
  LmsPlanCourse lpc=(LmsPlanCourse)al.get(i);
  LmsCourse lc=LmsCourse.find(lpc.lmscourse);
  LmsScore ls=LmsScore.findLast(lmc.member,lp.lmsplan,lpc.lmscourse);
  String time=SDF.format(lpc.starttime),start=MT.f(lpc.starttime,1);
  out.print("<tr>");
  out.print(time.equals(last)?"<script>mt.row()</script>":"<td name='time' id='time'>"+time);
  last=time;
  out.print("<td>"+start.substring(11)+"—"+MT.f(lpc.endtime,1).substring(11));
  out.print("<td>"+lc.code);
  out.print("<td>");
  out.print("<input type='checkbox' name='lmscourse' value='"+lpc.lmscourse+"' id='_lc"+lpc.lmscourse+"' data='"+start+"'");
  //if(ls.score>=60)out.print(" disabled");
  if(str.contains("|"+lpc.lmscourse+"|"))out.print(" checked");
  out.print(" /><label for='_lc"+lpc.lmscourse+"'>"+lc.name+"</label>");
  if(ls.lmsscore>0)out.print("<font color='red' title='考试得分' id='_"+ls.lmsscore+"'>（"+ls.score+"）</font>");
  out.print("<td>"+(lpc.lmscert<1?"专业核心课<font color='red'>（必考）</font>":LmsCert.find(lpc.lmscert).name));
}
%>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="关闭" onclick="pmt.close();"/>
</form>

<script>
mt.fit();
var arr=form2.elements;
for(var i=0;i<arr.length;i++)
{
  if(arr[i].type=='checkbox')
  arr[i].onclick=function()
  {
    if(!this.checked)return;
    var start=this.getAttribute('data');
    for(var i=0;i<arr.length;i++)
    {
      if(this==arr[i])continue;
      if(start==arr[i].getAttribute('data'))arr[i].checked=false;
    }
  };
}
</script>
</body>
</html>
