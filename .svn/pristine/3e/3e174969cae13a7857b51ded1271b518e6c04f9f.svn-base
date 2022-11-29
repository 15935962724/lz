<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
int category=h.getInt("category");
sql.append(" AND category="+category);
par.append("&category="+category);


int type=h.getInt("type",-1);
if(type!=-1)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}


String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND(name0 LIKE "+Database.cite("%"+name+"%")+" OR name0 LIKE "+Database.cite("%"+name+"%")+")");
  par.append("&name="+h.enc(name));
}

int pos=h.getInt("pos");
int sum=ShopAttrib.count(sql.toString());
par.append("&pos=");

ShopCategory c=ShopCategory.find(category);


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=c.name[h.language]%></h1>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="category" value="<%=category%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>类型:<select name="type"><option value="-1">---不限---</option><%=h.options(ShopAttrib.TYPE_NAME,type)%></select></td>
  <td>名称:<input name="name" value="<%=MT.f(name)%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/ShopAttribs.do" method="post" target="_ajax">
<input type="hidden" name="category" value="<%=category%>"/>
<input type="hidden" name="attrib"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="15"><input type="checkbox" onclick="mt.select(form2.attribs,checked)"/></td>
  <td>分类</td>
  <td>英文名称</td>
  <td>中文名称</td>
  <td>移动</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=ShopAttrib.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    ShopAttrib t=(ShopAttrib)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="attribs" value="<%=t.attrib%>"/></td>
    <td><%=MT.f(ShopAttrib.TYPE_NAME,t.type)%></td>
    <td><%=MT.f(t.name[0])%></td>
    <td><%=MT.f(t.name[1])%></td>
    <td><img name="sequence" src="/tea/mt/move.gif" />
    <td><input type="button" value="编辑" onclick="f_act('edit',<%=t.attrib%>)"/> <input type="button" value="删除" onclick="f_act('del',<%=t.attrib%>)"/></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="批量删除" name="multi" onclick="f_act('del',0)"/>
<input type="button" value="添加" onclick="f_act('edit','0')"/>
</form>

<script>
mt.sequence(form2.attribs);
mt.disabled(form2.attribs);
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.attrib.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/yl/shop/ShopAttribEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>
</body>
</html>
