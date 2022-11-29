<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.admin.*"%><%response.setHeader("Cache-Control", "no-cache");

Http h=new Http(request);


int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&community="+h.community+"&id="+menuid);
String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}


int pos=h.getInt("pos");
int sum=AdminUnitOrg.count(sql.toString());
par.append("&pos=");

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function f_edit(id)
{
  form2.adminunitorg.value=id;
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
<h1>所属机构管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter">
<tr>
  <td>公司名称:<input name="name" value="<%=name%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/jsp/admin/popedom/EditAdminUnitOrg.jsp?del">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="adminunitorg"/>
<table id="tablecenter">
<tr id="tableonetr">
  <td>序号</td>
  <td>类型名称</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=AdminUnitOrg.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    AdminUnitOrg t=(AdminUnitOrg)it.next();
    int id=t.adminunitorg;
  %>
  <tr onMouseOver="bgColor='#BCD1E9'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
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
