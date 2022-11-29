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

String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,");
  return;
}

String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND code LIKE "+DbAdapter.cite("%"+code+"%"));
  par.append("&code="+h.enc(code));
}

int lmscert=h.getInt("lmscert",-1);
if(lmscert!=-1)
{
  sql.append(" AND lmscert="+lmscert);
  par.append("&lmscert="+lmscert);
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

int status=h.getInt("status");
if(status>0)
{
  sql.append(" AND status="+status);
  par.append("&status="+status);
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsCourse.count(sql.toString());
String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
<%=acts.contains("oper,")?".null":".oper"%>{display:none}
</style>
</head>
<body>
<h1><%=menuid<1?"课程信息":AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0" class='alignLeft'>
<tr>
  <th>代码:</th><td><input name="code" value="<%=code%>"/></td>
  <th>名称:</th><td><input name="name" value="<%=name%>"/></td>
  <th>类型:</th><td><select name="lmscert"><option value="">--</option><option value="0" <%=lmscert==0?" selected":""%>>证书基础课<optgroup label="证书方向课"><%=LmsCert.options(" AND rank=2",lmscert)%></optgroup></select></td>
  <th>状态:</th><td><select name="status"><%=h.options(LmsCourse.STATUS_TYPE,status)%></select></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h3>
<%
if(acts.contains("oper,"))
{
  out.println("<input type='button' value='添加' onclick=mt.act(null,'edit') />");
  out.println("<input type='button' value='状态' name='multi' onclick=mt.act(null,'status') />");
}
%>
<input type="button" value="导出" onclick="mt.show(null,0);form3.submit();"/>
</h3>

<h2>列表</h2>
<form name="form2" action="/LmsCourses.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmscourse"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="status"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="8" class="oper"><input type="checkbox" onclick="mt.select(form2.lmscourses,checked)"/></td>
  <td>代码</td>
  <td>名称</td>
  <td>类型</td>
  <td>状态</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=LmsCourse.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsCourse t=(LmsCourse)it.next();
    String key=MT.enc(t.lmscourse);
  %>
  <tr id="<%=key%>">
    <td class="oper"><input type="checkbox" name="lmscourses" value="<%=key%>"/></td>
    <td><%=MT.f(t.code)%></td>
    <td align='left'><%=t.getName()%></td>
    <td><%=t.lmscert<1?"证书基础课":LmsCert.f(t.lmscert)%></td>
    <td><%=LmsCourse.STATUS_TYPE[t.status]%></td>
    <td><%
    out.println("<a href=### onclick=mt.act(this,'view')>查看</a>");
    if(acts.contains("oper,"))
    {
      out.println("<a href=### onclick=mt.act(this,'edit')>编辑</a>");
      out.println("<a href=### onclick=mt.act(this,'chap')>章节"+MT.f(LmsChapter.count(" AND lmscourse="+t.lmscourse),'(')+"</a>");
      out.println("<a href=### onclick=mt.act(this,'del')>删除</a>");
    }
    %></td>
  </tr>
  <%
  }
  out.print("<tr><td colspan='6' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table>
</form>

<form name="form3" action="/LmsExports.do?name=课程信息.xlsx" method="post" target="_ajax">
<input type="hidden" name="act" value="sql"/>
<input type="hidden" name="key" value="<%=MT.enc("SELECT code 代码,name 名称,"+Lms.when(LmsCourse.COURSE_TYPE,"type")+" 类型,"+Lms.when(LmsCourse.STATUS_TYPE,"status")+" 状态 FROM LmsCourse WHERE 1=1"+sql.toString())%>"/>
</form>
<script>
mt.disabled(form2.lmscourses);
form2.nexturl.value=location.pathname+location.search;
mt.act=function(t,a,b)
{
  form2.act.value=a;
  form2.lmscourse.value=t?mt.ftr(t).id:"";
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='status')
  {
    mt.show("状态：<input name='status' type='radio' id='_status1' checked value='1' /><label for='_status1'>可用</label>　<input name='status' type='radio' id='_status2' value='2' /><label for='_status2'>不可用</label>",2,"form2.status.value=$$('_status1').checked?1:2;form2.submit()");
  }else
  {
    if(a=='view')
      form2.action='/jsp/lms/LmsCourseView.jsp';
    else if(a=='edit')
      form2.action='/jsp/lms/LmsCourseEdit.jsp';
    else if(a=='chap')
      form2.action='/jsp/lms/LmsChapters.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
