<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
TeaSession teasesson=new TeaSession(request);
if(teasesson._rv==null)
{
  response.sendRedirect("/servlet/StartLogin");
  return;
}
int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

sql.append(" AND community="+DbAdapter.cite(h.community));
par.append("&community="+h.community+"&id="+menuid);
String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

int pos=h.getInt("pos");
int sum=STemplate.count(sql.toString());
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>主题模板管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>模板名称:<input name="name" value="<%=name%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/STemplateEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>模板名称</td>
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
  Iterator it=STemplate.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    STemplate t=(STemplate)it.next();
    int id=t.node;
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><a href="/html/node/<%=t.node%>-<%=h.language%>.htm" target="_blank"><%=MT.f(t.name)%></a></td>
    <td><%=t.hits%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><input type="button" value="删除" onclick="f_act('del',<%=id%>)"/></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('add','0')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.node.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='add')
  {
    mt.show("/jsp/node/STemplateTree.jsp?act=add&tid=<%=Community.find(h.community).getNode()%>&name=<%=Http.enc("模版名称")%>",2,"选择模板",500,400);
  }
}
</script>
</body>
</html>
