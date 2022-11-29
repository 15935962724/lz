<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);
sql.append(" AND father="+h.node);

sql.append(" AND node IN(SELECT node FROM materia WHERE 1=1");

int type=h.getInt("type");
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String  harvesting=h.get("harvesting","");
if(harvesting.length()>0)
{
  sql.append(" AND harvesting LIKE "+DbAdapter.cite("%"+harvesting+"%"));
  par.append("&harvesting="+h.enc(harvesting));
}

String quarry=h.get("quarry","");
if(quarry.length()>0)
{
  sql.append(" AND quarry LIKE "+DbAdapter.cite("%"+quarry+"%"));
  par.append("&quarry="+h.enc(quarry));
}

String source=h.get("source","");
if(source.length()>0)
{
  sql.append(" AND source LIKE "+DbAdapter.cite("%"+source+"%"));
  par.append("&source="+h.enc(source));
}
sql.append(")");

int pos=h.getInt("pos");
par.append("&pos=");
int sum=Node.count(sql.toString());

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>中华本草管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td class="th">本名：</td><td><input name="name" value="<%=name%>"/></td>
  <td class="th">出处：</td><td><input name="source" value="<%=source%>"/></td>
  <td class="th">采收加工：</td><td><input name="harvesting" value="<%=harvesting%>"/></td>
</tr>
<tr>
  <td class="th">分类：</td><td><select name="type"><%=h.options(Materia.MATERIA_TYPE,type)%></select></td>
  <td class="th">来源：</td><td><input name="quarry" value="<%=quarry%>"/></td>
  <td><td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Materias.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="node"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>本名</td>
  <td>出处</td>
  <td>采收加工</td>
  <td>分类</td>
  <td>来源</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY node");
  Enumeration e=Node.find(sql.toString(),pos,20);
  for(int i=1+pos;e.hasMoreElements();i++)
  {
    int node=((Integer)e.nextElement()).intValue();
    Node n=Node.find(node);
    Materia t=Materia.find(node);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=n.getAnchor(h.language)%></td>
    <td><%=MT.f(t.source)%></td>
    <td><%=MT.f(t.harvesting,50)%></td>
    <td><%=Materia.MATERIA_TYPE[t.type]%></td>
    <td><%=MT.f(t.quarry,50)%></td>
    <td>
    <%
    out.println("<a href=javascript:mt.act('hidden',"+node+")>"+(n.isHidden()?"发布":"取消发布")+"</a>");
    out.println("<a href=javascript:mt.act('edit',"+node+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+node+")>删除</a>");
    %></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','<%=h.node%>')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.node.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='hidden')
    {
    }else if(a=='edit')
    {
      form2.action='/jsp/type/materia/EditMateria.jsp';
      form2.target=form2.method='';
    }
    form2.submit();
  }
};
</script>
</body>
</html>
