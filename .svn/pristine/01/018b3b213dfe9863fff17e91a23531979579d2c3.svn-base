<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND( sname LIKE "+Database.cite("%"+name+"%")+")");
  par.append("&name="+h.enc(name));
}


int pos=h.getInt("pos");
int sum=YuShop.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>商家管理</h1>

<h2>查询</h2>
<form name="form1" action="/jsp/yl/shop/YuShops.jsp">
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称:<input name="name" value="<%=name%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/jsp/yl/shop/YuShopEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="sid"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>图片</td>
  <td>编号</td>
  <td>中文名称</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=YuShop.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  YuShop t=(YuShop)it.next();
    int id=t.sid;
  %>
  <tr>
    <td><%=i%></td>
    <td><img id="view" width="100" src="<%=t.slogo%>" /></td>
    <td><%=MT.f(t.scode)%></td>
    <td><%=MT.f(t.sname)%></td>
    <td><input type="button" value="编辑" onclick="f_act('edit',<%=id%>,1)"/><input type="button" value="删除" onclick="f_act('del',<%=id%>)"/><input type="button" value="添加商品" onclick="addpro(<%= t.sid %>);" /></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new Page(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('edit','0',1)"/>
</form>
<form name="form3" action="/jsp/yl/shop/ProductSetCategory.jsp" target="_self" method="get" >
	<input type="hidden" name="product"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act" value="add"/>
<input type="hidden" name="shopid"/>
</form>
<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.sid.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/yl/shop/YuShopEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
function addpro(sid){
	form3.shopid.value = sid;
	form3.submit();
};
</script>
</body>
</html>
