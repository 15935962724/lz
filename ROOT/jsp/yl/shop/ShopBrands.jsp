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
par.append("&id="+menu);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND( name0 LIKE "+Database.cite("%"+name+"%")+" OR name1 LIKE "+Database.cite("%"+name+"%")+" )");
  par.append("&name="+h.enc(name));
}

int sum=ShopBrand.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>品牌管理</h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='1'>搜索</td></tr>
</thead>
<tr>
  <td>品牌名称:<input name="name" value="<%=MT.f(name)%>"/> &nbsp;&nbsp; <button class="btn btn-primary" type="submit">查询</button></td>
</tr>
</table>
</div>
</form>
<form name="form2" action="/ShopBrands.do" method="post" target="_ajax">
<input type="hidden" name="brand"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="lang"/>
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='4'>列表 <%=sum%></td></tr>
</thead>
<tr id="tableonetr">
  <th width="60">序号</th>
  <th>logo</th>
  <th>品牌名称</th>
  <th>操作</th>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
}else
{
  Iterator it=ShopBrand.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    ShopBrand t=(ShopBrand)it.next();
    int id=t.brand;
  %>
  <tr>
    <td align="cleft"><%=i%></td>
    <td><img src="<%=MT.f(t.logo,"/tea/mt/blank.gif")%>" height="28"/></td>
    <td><%=MT.f(t.name[1])%></td>
    <td>
    	<button type="button" class="btn btn-link" onclick="f_act('edit',<%=id%>,1)">编辑</button>
    	<button type="button" class="btn btn-link" onclick="f_act('del',<%=id%>,1)">删除</button>
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
</div>
<div class="center mt15">
<button class="btn btn-primary" type="button" onclick="f_act('edit','0',1)">添 加</button></div>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.brand.value=id;
  form2.lang.value=b;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/yl/shop/ShopBrandEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>
</body>
</html>
