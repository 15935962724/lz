<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.member.*"%>
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

sql.append(" AND lp.ctime IS NOT NULL");

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND lp.name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND cp.member LIKE "+DbAdapter.cite("%"+username+"%"));
  par.append("&username="+h.enc(username));
}

Date time0=h.getDate("time0");
if(time0!=null)
{
  sql.append(" AND lp.ctime>"+DbAdapter.cite(time0));
  par.append("&time0="+MT.f(time0));
}
Date time1=h.getDate("time1");
if(time1!=null)
{
  sql.append(" AND lp.ctime<"+DbAdapter.cite(time1));
  par.append("&time1="+MT.f(time1));
}

int order=h.getInt("order",3);
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);


int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsPlan.count(sql.toString());
String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
</style>
</head>
<body>
<h1><%=menuid<1?"课程安排":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0" class="alignLeft">
<tr>
  <th>标题名称:</th><td><input name="name" value="<%=name%>"/></td>
  <th>创建人:</th><td><input name="username" value="<%=username%>"/></td>
  <th>创建时间:</th><td colspan="4"><input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> - <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
<input type="button" value="导出" onclick="mt.show(null,0);form3.submit();"/>
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsPlanCourses.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmsplan"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="status"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td><a href="javascript:mt.order('O1')" id="O1">标题名称</a></td>
  <td><a href="javascript:mt.order('O2')" id="O2">创建人</a></td>
  <td><a href="javascript:mt.order('O3')" id="O3">创建时间</a></td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  String[] ORDER_TYPE={"lp.lmsplan","lp.name","cp.member","lp.ctime"};
  sql.append(" ORDER BY "+ORDER_TYPE[order]+(desc?" DESC":" ASC")+",lp.lmsplan");
  Iterator it=LmsPlan.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsPlan t=(LmsPlan)it.next();
  %>
  <tr>
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=t.cmember<1?"":Profile.find(t.cmember).getMember()%></td>
    <td><%=MT.f(t.ctime,1)%></td>
    <td><%
    out.println("<a href=javascript:mt.act('edit',"+t.lmsplan+")>课程"+MT.f(LmsPlanCourse.count(" AND lmsplan="+t.lmsplan),'(')+"</a>");
    out.println("<a href=javascript:mt.act('pdel',"+t.lmsplan+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</form>

<form name="form3" action="/LmsExports.do?name=考试计划.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="sql"/>
<input type="hidden" name="key" value="<%=MT.enc("SELECT lp.name 名称,c.address 省份,lp.starttime 机考报考开始时间,lp.endtime 机考报考结束时间,lp.pstarttime 实践环节报考开始时间,lp.pendtime 实践环节报考结束时间,lp.time 创建时间,lp.etime 审核时间,"+Lms.when(LmsPlan.STATUS_TYPE,"lp.status")+" 状态 FROM LmsPlan lp LEFT JOIN Card c ON lp.city=c.card WHERE 1=1"+sql.toString())%>"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.lmsplan.value=id;
  if(a=='pdel')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/LmsPlanView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsPlanCourseEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
