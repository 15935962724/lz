<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%!

public String options(Date time)
{
  String str=time==null?"":MT.f(time,1).substring(11);
  StringBuilder htm=new StringBuilder();
  String[] HOUR_TYPE={"00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30"};
  for(int i=0;i<HOUR_TYPE.length;i++)
  {
    htm.append("<option value="+HOUR_TYPE[i]);
    if(HOUR_TYPE[i].equals(str))htm.append(" selected");
    htm.append(">"+HOUR_TYPE[i]);
  }
  return htm.toString();
}
%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmsplan");
int lmsplan=key.length()<1?0:Integer.parseInt(MT.dec(key));
int lmsplancourse=h.getInt("lmsplancourse");
if(lmsplancourse>0)
{
  lmsplan=LmsPlanCourse.find(lmsplancourse).lmsplan;
}
ArrayList al=LmsPlanCourse.find(" AND lmsplan="+lmsplan+" ORDER BY starttime",0,Integer.MAX_VALUE);


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/lms/lms.js" type="text/javascript"></script>
<script src="/res/lms/cache/lmscourse.js" type="text/javascript"></script>
</head>
<body>
<h1><%=al.size()<1?"添加":"编辑"%>课程安排</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsPlanCourses.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>考试计划</td>
    <td colspan="3"><select name="lmsplan"><%=LmsPlan.options(" AND father=0 AND status IN(2,4)",lmsplan)%></select></td>
  </tr>
  <tr id="tableonetr">
    <td>时间</td>
    <td>证书方向</td>
    <td>考试科目</td>
    <td>操作</td>
  </tr>
<%
if(al.size()<1)al.add(new LmsPlanCourse(0));
al.add(0,new LmsPlanCourse(0));
for(int i=0;i<al.size();i++)
{
  LmsPlanCourse t=(LmsPlanCourse)al.get(i);
%>
  <tr id="tr_<%=i%>" style="<%=i==0?"display:none;":""%>">
    <td><input type="hidden" name="lmsplancourse" value="<%=t.lmsplancourse%>"/><input name="time" value="<%=MT.f(t.starttime)%>" alt="时间" onclick="mt.date(this)" class="date"/><select name="start"><%=options(t.starttime)%></select>至<select name="end"><%=options(t.endtime)%></select></td>
    <td><select name="lmscert" onchange="t=parentNode;t=(t.nextElementSibling||t.nextSibling).firstChild; lms.course(this,t)"><option value="0">证书基础课<optgroup label="证书方向课"><%=LmsCert.options(" AND rank=2",t.lmscert)%></optgroup></select></td>
    <td><select name="lmscourse" alt="考试科目"><%=LmsCourse.options(" AND status=1 AND lmscert="+t.lmscert,t.lmscourse)%></select></td>
    <td><%=i==1?"<a href='javascript:;' onclick='mt.add(this)'>添加</a>":"<a href='javascript:;' onclick='mt.del(this)'>删除</a>"%></td>
  </tr>
<%
}
%>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
//mt.focus();
mt.add=function(a)
{
  var tr=$('tr_0'),cn=tr.cloneNode(true);
  cn.style.display="";
  tr.parentNode.appendChild(cn);
};
mt.del=function(a)
{
  var tr=mt.ftr(a);
  tr.parentNode.removeChild(tr);
};
</script>
</body>
</html>
