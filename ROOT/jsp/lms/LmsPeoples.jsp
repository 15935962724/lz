<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.lms.*"%><%

Http h=new Http(request,response);

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int menuid=h.getInt("id");
par.append("&community="+h.community+"&id="+menuid);


int lmsorg=h.getInt("lmsorg");
if(lmsorg>0)
{
  sql.append(" AND lmsorg LIKE "+DbAdapter.cite("%"+lmsorg+"%"));
  par.append("&lmsorg="+lmsorg);
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String sex=h.get("sex","");
if(sex.length()>0)
{
  sql.append(" AND sex LIKE "+DbAdapter.cite("%"+sex+"%"));
  par.append("&sex="+h.enc(sex));
}

int age=h.getInt("age");
if(age>0)
{
  sql.append(" AND age LIKE "+DbAdapter.cite("%"+age+"%"));
  par.append("&age="+age);
}

String nation=h.get("nation","");
if(nation.length()>0)
{
  sql.append(" AND nation LIKE "+DbAdapter.cite("%"+nation+"%"));
  par.append("&nation="+h.enc(nation));
}

Date brithday0=h.getDate("brithday0");
if(brithday0!=null)
{
  sql.append(" AND brithday>"+DbAdapter.cite(brithday0));
  par.append("&brithday0="+MT.f(brithday0));
}
Date brithday1=h.getDate("brithday1");
if(brithday1!=null)
{
  sql.append(" AND brithday<"+DbAdapter.cite(brithday1));
  par.append("&brithday1="+MT.f(brithday1));
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=LmsPeople.count(sql.toString());
String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>信息管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>省助学发展机构:<input name="lmsorg" value="<%=lmsorg%>"/></td>
  <td>姓名:<input name="name" value="<%=name%>"/></td>
  <td>性别:<input name="sex" value="<%=sex%>"/></td>
  <td>年龄:<input name="age" value="<%=age%>"/></td>
  <td>民族:<input name="nation" value="<%=nation%>"/></td>
  <td>出生日期:<input name="brithday0" value="<%=MT.f(brithday0)%>" onclick="mt.date(this)" class="date"/> - <input name="brithday1" value="<%=MT.f(brithday1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/LmsPeoples.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmspeople"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>省助学发展机构</td>
  <td>姓名</td>
  <td>性别</td>
  <td>年龄</td>
  <td>民族</td>
  <td>出生日期</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=LmsPeople.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    LmsPeople t=(LmsPeople)it.next();
    int id=t.lmspeople;
  %>
  <tr>
    <td><%=i%></td>
    <td><%=MT.f(t.lmsorg)%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=MT.f(t.sex)%></td>
    <td><%=MT.f(t.age)%></td>
    <td><%=MT.f(t.nation)%></td>
    <td><%=MT.f(t.brithday)%></td>
    <td><%
    if(acts.contains("edit"))out.println("<a href=javascript:mt.act('edit',"+id+")>编辑</a>");
    if(acts.contains("del"))out.println("<a href=javascript:mt.act('del',"+id+")>删除</a>");
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
  form2.lmspeople.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/LmsPeopleView.jsp';
    else if(a=='edit')
      form2.action='/LmsPeopleEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
