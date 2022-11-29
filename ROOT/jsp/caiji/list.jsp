<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*"%>
<%@page import="tea.db.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.util.Caiji"%><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();
sql.append(" AND community="+DbAdapter.cite(h.community));

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+Http.enc(name));
}

int menu=h.getInt("id");
int pos=h.getInt("pos");
par.append("&pos=");

%><!DOCTYPE html>
<html>
<script src="/tea/layer.js" type="text/javascript" ></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<body>
<h1>信息采集</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <th>名称：</th><td><input name="name" value="<%=name%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表</h2>
<input type="button" value="创建" onclick="mt.act('edit',0)"/>

<form name="form2" action="/Caijis.do" target="_ajax" method="post">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="caiji"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table border=0 cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
    <td>序号</td>
    <td>名称</td>
    <td>采集时间</td>
    <td>共采集数量</td>
    <td>操作</td>
  </tr>
<%
int sum=Caiji.count(sql.toString());
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录！</td></tr>");
}else
{
  sql.append(" ORDER BY time");
  ArrayList al=Caiji.find(sql.toString(),pos,20);
  for(int i=0;i<al.size();i++)
  {
    Caiji c=(Caiji)al.get(i);
    %>
    <tr>
      <td><%=i+1%></td>
      <td><%=c.name%></td>
      <td><%=MT.f(c.lasttime,1)%></td>
      <td><%=MT.f(c.total)%></td>
      <td>
        <a href="javascript:mt.act('edit',<%=c.caiji%>)">编辑</a>
        <a href="javascript:mt.act('clone',<%=c.caiji%>)">复制</a>
        <a href="javascript:mt.act('del',<%=c.caiji%>)">删除</a>
        <a href="javascript:mt.act('run',<%=c.caiji%>)">采集</a>
      </td>
    </tr>
    <%
  }
  out.print("<tr><td colspan='5' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}
%>
</table>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,v)
{
  form2.act.value=a;
  form2.caiji.value=v;
  if(a=='del')
  {
    mt.show("确认删除？",2,"form2.submit()");
  }else if(a=='run')
  {
    mt.show(null,0);
    form2.submit();
  }else
  {
    form2.action='/jsp/caiji/CaijiEdit.jsp';
    form2.target=form2.method="";
    if(a=='clone')
    {
      form2.caiji.name=a;
    }
    form2.submit();
  }
};
</script>
</body>
</html>
