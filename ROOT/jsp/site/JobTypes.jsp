<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.site.*"%><%

Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
//h.member=teasession._rv.toString();

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community+"&id="+menuid);

sql.append(" AND community="+DbAdapter.cite(h.community));
sql.append(" AND state=0");

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

//int state=h.getInt("state");
//if(state>0)
//{
//  sql.append(" AND state LIKE "+DbAdapter.cite("%"+state+"%"));
//  par.append("&state="+state);
//}

Date t0=h.getDate("t0");
if(t0!=null)
{
  sql.append(" AND time>"+Database.cite(t0));
  par.append("&t0="+MT.f(t0));
}
Date t1=h.getDate("t1");
if(t1!=null)
{
  sql.append(" AND time<"+Database.cite(t1));
  par.append("&t1="+MT.f(t1));
}


int pos=h.getInt("pos");
int sum=JobType.count(sql.toString());
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>职位类别</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称:<input name="name" value="<%=name%>"/></td>
  <td>时间:<input name="t0" value="<%=MT.f(t0)%>" class="date" readonly="readonly" onClick="mt.date(this)"/>至<input name="t1" value="<%=MT.f(t1)%>" class="date" readonly="readonly" onClick="mt.date(this)"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/JobTypes.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="jobtype"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="name"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>时间</td>
  <td>顺序</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=JobType.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    JobType t=(JobType)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%><input type="checkbox" name="jobtypes" value="<%=t.jobtype%>" style="display:none"/></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><img name="sequence" src="/tea/image/public/move2.gif" />
    <td><input type="button" value="编辑" onclick="f_act('edit',<%=t.jobtype%>,'<%=MT.f(t.name)%>')"/> <input type="button" value="删除" onclick="f_act('del',<%=t.jobtype%>)"/></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('edit','0','')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.sequence(form2.jobtypes);
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.jobtype.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    mt.show("类别名称：<input id='_name' value='"+b+"' >",2);
    mt.ok=function()
    {
      var t=$('_name').value;
      if(!t)
      {
        alert('“名称”不能为空！');
        return false;
      }
      form2.name.value=t;
      form2.submit();
    };
    //form2.action='/jsp/site/JobTypeEdit.jsp';form2.target=form2.method='';form2.submit();
  }
}
</script>
</body>
</html>
