<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.admin.*"%><%
response.setHeader("Cache-Control", "no-cache");
Http h=new Http(request);

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

int sequence=h.getInt("sequence");
if(sequence>0)
{
  sql.append(" AND sequence LIKE "+DbAdapter.cite("%"+sequence+"%"));
  par.append("&sequence="+sequence);
}


int pos=h.getInt("pos");
int sum=AdminUnitType.count(sql.toString());
par.append("&pos=");

%><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_edit(id)
{
  form2.adminunittype.value=id;
  form2.submit();
}
function f_del(id)
{
  if(!confirm("你确定要删除吗?"))return;
  form2.method="post";
  f_edit(id);
}
</script>
</head>
<body>
<h1>部门分类</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter">
<tr>
  <td>名称:<input name="name" value="<%=name%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/jsp/admin/popedom/EditAdminUnitType.jsp?del">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="adminunittype"/>
<table id="tablecenter">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>顺序</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=AdminUnitType.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    AdminUnitType t=(AdminUnitType)it.next();
    int id=t.adminunittype;
  %>
  <tr onMouseOver="bgColor='#BCD1E9'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=MT.f(t.sequence)%></td>
    <td><input type="button" value="编辑" onclick="f_edit(<%=id%>)"/> <input type="button" value="删除" onclick="f_del(<%=id%>)"/></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_edit('0')"/>
</form>

</body>
</html>
