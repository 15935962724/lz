<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
//h.member=teasession._rv.toString();

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

par.append("?community="+h.community+"&id="+menuid);
sql.append(" AND member="+Database.cite(h.member));

int sex=h.getInt("sex");
if(sex>0)
{
  sql.append(" AND sex LIKE "+DbAdapter.cite("%"+sex+"%"));
  par.append("&sex="+sex);
}

int age=h.getInt("age");
if(age>0)
{
  sql.append(" AND age LIKE "+DbAdapter.cite("%"+age+"%"));
  par.append("&age="+age);
}

String degree=h.get("degree","");
if(degree.length()>0)
{
  sql.append(" AND degree LIKE "+DbAdapter.cite("%"+degree+"%"));
  par.append("&degree="+h.enc(degree));
}

String expectcity=h.get("expectcity","");
if(expectcity.length()>0)
{
  sql.append(" AND expectcity LIKE "+DbAdapter.cite("%"+expectcity+"%"));
  par.append("&expectcity="+h.enc(expectcity));
}

int experience=h.getInt("experience");
if(experience>0)
{
  sql.append(" AND experience LIKE "+DbAdapter.cite("%"+experience+"%"));
  par.append("&experience="+experience);
}


int pos=h.getInt("pos");
int sum=RSearch.count(sql.toString());
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>搜索器管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<%--
<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>性别:<input name="sex" value="<%=sex%>"/></td>
  <td>年龄:<input name="age" value="<%=age%>"/></td>
  <td>学历:<input name="degree" value="<%=degree%>"/></td>
  <td>期望工作地区:<input name="expectcity" value="<%=expectcity%>"/></td>
  <td>工作经验:<input name="experience" value="<%=experience%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>
--%>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/jsp/type/resume/RSearchEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="rsearch"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>使用次数</td>
  <td>创建时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=RSearch.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    RSearch t=(RSearch)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=t.hits%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><input type="button" value="编辑" onclick="f_act('edit',<%=t.rsearch%>)"/> <input type="button" value="删除" onclick="f_act('del',<%=t.rsearch%>)"/></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('edit','0')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.rsearch.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>
</body>
</html>
