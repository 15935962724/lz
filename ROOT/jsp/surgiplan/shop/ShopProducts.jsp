<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("menu="+menu);

String selstate = h.get("selstate");//查询类型 0 已通过 1 未审核  
par.append("&selstate="+selstate);


sql.append(" AND state in "+"("+selstate+")");

String yucode=h.get("yucode","");
if(yucode.length()>0)
{
  sql.append(" AND yucode LIKE "+Database.cite("%"+yucode+"%"));
  par.append("&yucode="+h.enc(yucode));
}

String brand=h.get("brand","");
if(brand.length()>0)
{
  sql.append(" AND brand IN(SELECT brand FROM brand WHERE name1 LIKE "+Database.cite("%"+brand+"%")+")");
  par.append("&brand="+Http.enc(brand));
}

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name1 LIKE "+Database.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

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
int sum=ShopProduct.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>商品管理</h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='5' class='bornone'>搜索</td></tr>
</thead>
<tr>
  <td>商品编号:<input name="yucode" value="<%=MT.f(yucode)%>"/></td>
  <td>品牌:<input name="brand" value="<%=MT.f(brand)%>"/></td>
  <td>名称:<input name="name" value="<%=MT.f(name)%>"/></td>
  <td>创建时间:<input name="t0" value="<%=MT.f(t0)%>" onclick="mt.date(this)" class="date"/> - <input name="t1" value="<%=MT.f(t1)%>" onclick="mt.date(this)" class="date"/></td>
  <td class='bornone'><button class="btn btn-primary" type="submit">查询</button></td>
</tr>
</table>
</div>
</form>

<form name="form2" action="/ShopProducts.do" method="post" target="_ajax">
<input type="hidden" name="product"/>
<input type="hidden" name="mystate"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='8'>列表 <%=sum%></td></tr>
</thead>
<tr>
  <th>序号</th>
  <th>商品编号</th>
  <th>品牌</th>
  <th>商品分类</th>
  <th>名称</th>
  <th>销售价</th>
  <th>显示状态</th>
  <th>操作</th>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='8' class='noCont'>暂无记录!</td></tr>");
}else
{
  Iterator it=ShopProduct.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    ShopProduct t=(ShopProduct)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.yucode)%></td>
    <td><%=MT.f(ShopBrand.find(t.brand).name[1])%></td>
    <td><%=MT.f(ShopCategory.find(t.category).name[1])%></td>
    <td><%=t.getAnchor(h.language)%></td>
    <td><%=MT.f(t.price)%></td>
    <td><%= (t.state==1?"不显示":"显示") %></td>
    <td>
    <input type="button"  class="btn btn-link" value="编辑" onclick="f_act('edit',<%=t.product%>)"/>
	<input type="button"  class="btn btn-link" value="删除" onclick="f_act('del',<%=t.product%>)"/>
     <input type="button"  class="btn btn-link" value="产品详情" onclick="f_act('detail',<%=t.product%>)"/>
     <%-- <input type="button"  class="btn btn-link" value="设置价格" onclick="f_act('editprice',<%=t.product%>)"/> --%>
     <%
     	if(!selstate.equals("0")){
     		%>
     	<input type="button"  class="btn btn-link" value="<%= (t.state==1?"打开显示":"关闭显示") %>" onclick="f_act('uptype','<%=t.product%>',<%= (t.state==1?0:1) %>)"/>		
     		<%
     	}
     %>
     </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<div class="center mt15">
	<button class="btn btn-primary" onclick="f_act('add','0')">添加</button></div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.product.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
    return;
  }else if(a=='edit'||a=='add')
  {
    form2.action='/jsp/yl/shop/ShopProduct'+(a=='add'?'SetCategory':'Edit')+'.jsp';
  }else if(a=='detail'){
	  form2.action='/jsp/yl/shop/ShopProduct_Dlist.jsp';
  }else if(a=='editprice'){
	  form2.action='/jsp/yl/shop/ProductEditPrice.jsp';
  }else if(a=='uptype'){
	  form2.mystate.value = b;
	  form2.submit();
	  return;
  }
  form2.target='_self';form2.method='get';form2.submit();
}
function showreturn(num){
	mt.show("/jsp/yl/shop/ShopProductReturn.jsp?nexturl="+form2.nexturl.value+"&qid="+num,2,"审核",500,200);
}

</script>
</body>
</html>
