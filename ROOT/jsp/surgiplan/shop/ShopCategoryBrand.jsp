<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}


int category=h.getInt("category");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&category="+category);
sql.append(" AND category="+category);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND( name0 LIKE "+Database.cite("%"+name+"%")+" OR name1 LIKE "+Database.cite("%"+name+"%")+" )");
  par.append("&name="+h.enc(name));
}

ShopCategory t=ShopCategory.find(category);
String[] arr=t.brand.split("[|]");

int pos=h.getInt("pos");
int sum=arr.length;
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>分类对应的品牌 <%=t.getAncestor(h.language)%></h1>

<form name="form2" action="/ShopCategorys.do" method="post" target="_ajax">
<input type="hidden" name="category" value="<%=category%>"/>
<input type="hidden" name="brand"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="15"><input type="checkbox" onclick="mt.select(form2.brands,checked)"/></td>
  <td>logo</td>
  <td>品牌名称</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  for(int i=1+pos;i<arr.length;i++)
  {
    ShopBrand b=ShopBrand.find(Integer.parseInt(arr[i]));
    if(b.time==null)continue;
  %>
  <tr>
    <td><input type="checkbox" name="brands" value="<%=b.brand%>"/></td>
    <td><img src="<%=MT.f(b.logo,"/tea/mt/blank.gif")%>" height="30"/></td>
    <td><%=MT.f(b.name[1])%></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<button class="btn btn-primary" type="button" name="multi" onclick="f_act('del')">批量删除</button>&nbsp;&nbsp;&nbsp;&nbsp;
<button class="btn btn-primary" type="button" onclick="f_act('add')">添加</button>&nbsp;&nbsp;&nbsp;&nbsp;
<button class="btn btn-default" type="button" onclick="history.back();">返回</button>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.disabled(form2.brands);
function f_act(a)
{
  form2.act.value='brand'+a;
  if(a=='del')
  {
    mt.show('你确定要移除吗？',2,'form2.submit()');
  }else if(a=='add')
  {
    mt.show("/jsp/yl/shop/ShopBrandSel.jsp",2,"选择品牌",500,400);
  }
}
mt.receive=function(v,n,h)
{
  form2.brand.value=v;
  form2.submit();
}
</script>
</body>
</html>
