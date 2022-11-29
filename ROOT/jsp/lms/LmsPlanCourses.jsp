<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);


int lmsplan=h.getInt("lmsplan");
if(lmsplan>0)
{
  sql.append(" AND lmsplan="+lmsplan);
  par.append("&lmsplan="+lmsplan);
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND starttime>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND starttime<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

int lmscert=h.getInt("lmscert");
if(lmscert>0)
{
  sql.append(" AND lmscert="+lmscert);
  par.append("&lmscert="+lmscert);
}

int lmscourse=h.getInt("lmscourse");
if(lmscourse>0)
{
  sql.append(" AND lmscourse="+lmscourse);
  par.append("&lmscourse="+lmscourse);
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsPlanCourse.count(sql.toString());
String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <th>考试计划:</th><td><select name="lmsplan"><option value="0">--<%=LmsPlan.options(" AND father=0 AND status IN(2,4)",lmsplan)%></select></td>
  <th>开始时间:</th><td><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <th>证书方向:</th><td><select name="lmscert"><option value="0">--<%=LmsCert.options(" AND rank=2",lmscert)%></select></td>
  <th>考试科目:</th><td><select name="lmscourse"><option value="0">--<%=LmsCourse.options(" AND status=1",lmscourse)%></select></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/LmsPlanCourses.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsplancourse"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>考试计划</td>
  <td>考试时间</td>
  <td>证书方向</td>
  <td>考试科目</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=LmsPlanCourse.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsPlanCourse t=(LmsPlanCourse)it.next();
  %>
  <tr>
    <td><%=i%></td>
    <td><%=MT.f(LmsPlan.find(t.lmsplan).name)%></td>
    <td><%=MT.f(t.starttime,1)%>—<%=MT.f(t.endtime,1)%></td>
    <td><%=MT.f(LmsCert.find(t.lmscert).name)%></td>
    <td><%=MT.f(LmsCourse.find(t.lmscourse).name)%></td>
    <td><%
    out.println("<a href=javascript:mt.act('edit',"+t.lmsplancourse+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+t.lmsplancourse+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.lmsplancourse.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/LmsPlanCourseView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsPlanCourseEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
