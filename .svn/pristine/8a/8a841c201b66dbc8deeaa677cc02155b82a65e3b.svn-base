<%@page import="tea.entity.member.Profile"%>
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
par.append("&menu="+menu);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND spd.name1 LIKE "+Database.cite("%"+name+"%")+" ");
  par.append("&name="+h.enc(name));
}

int state=Integer.parseInt(h.get("state","-1"));

if(state!=-1)
{
  sql.append(" AND status = "+state);
  par.append("&state="+state);
}

int sum=ShopPackage.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>产品套餐</h1>

<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<div class='radiusBox mt15'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='5' class='bornone'>搜索</td></tr>
</thead>
<tr>
  <td class='bornone'>商品名称：<input name="name" value="<%=MT.f(name)%>"/>&nbsp;&nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn-primary">查询</button></td>
</tr>
</table>
</div>
</form>
<form name="form2" action="/ShopPackages.do" method="post" target="_ajax">
<input type="hidden" name="pid"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act" value="del"/>
<input type="hidden" name="act"/>
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='6'>列表 <%=sum%></td></tr>
</thead>
<tr>
  <th>序号</th>
  <th>商品名称</th>
  <th>套餐名称</th>
  <th>价格</th>
  <th>原价</th>
  <th>操作</th>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
}else
{
	sql.append(" order by product_id ");
  Iterator it=ShopPackage.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopPackage t=(ShopPackage)it.next();
	  ShopProduct sp = ShopProduct.find(t.getProduct_id());
  %>
  <tr>
    <td><%=i%></td>
    <td><%=sp.getAnchor(h.language)%></td>
    <td><%=MT.f(t.getPackageName())%></td>
    <td><%= MT.f(t.getSetPrice(),2)%></td>
    <td><%= MT.f(t.getPrice(),2)%></td>
    <td>
    <button type="button" class="btn btn-link" onclick="showqua('<%= t.getId() %>')">编辑</button>
    <button type="button" class="btn btn-link" onclick="delqua('<%= t.getId() %>')">删除</button>
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<div class="center mt15">
<button type="button" class="btn btn-primary" onclick="addqua()">添加套餐</button></div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function showqua(num){
	location = '/jsp/yl/shop/AddShopPackage.jsp?nexturl='+form2.nexturl.value+"&sid="+num;
};
function delqua(num){
	mt.show('你确定要删除吗？',2);
	mt.ok=function(){
		form2.pid.value = num;
		form2.submit();
	};
}
function addqua(){
	location = '/jsp/yl/shop/AddShopPackage.jsp?nexturl='+form2.nexturl.value;
};
</script>
</body>
</html>
