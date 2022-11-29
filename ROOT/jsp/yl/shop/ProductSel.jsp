<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
String product=h.get("product","|");

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
sql.append(" AND state=0");
par.append("&product="+product);

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND( name0 LIKE "+Database.cite("%"+name+"%")+" OR name1 LIKE "+Database.cite("%"+name+"%")+" )");
  par.append("&name="+h.enc(name));
}

int pos=h.getInt("pos");
int sum=Product.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script>var pmt=parent.mt;</script>
</head>
<body class="iframe">

<form name="form1" action="?">
<table id="tablecenter" cellspacing="0">
<input type="hidden" name="product" value="<%=product%>"/>
<tr>
  <td>名称:<input name="name" value="<%=MT.f(name)%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<form name="form2" action="/Brands.do" method="post" target="_ajax">

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="15"><input type="checkbox" onclick="mt.select(form2.products,checked)"/></td>
  <td>名称</td>
  <td>销售价</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Product.find(sql.toString(),pos,8).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Product t=(Product)it.next();
  %>
  <tr>
    <td><input type="checkbox" name="products" <%=product.indexOf("|"+t.product+"|")!=-1?" checked='' ":""%> value="<%=t.product%>" alt="<%=MT.f(t.name[1])%>"/></td>
    <td><%=MT.f(t.name[1],30)%></td>
    <td><%=MT.f(t.price)%></td>
  </tr>
  <%
  }
  if(sum>8)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new Page(h.language,par.toString(),pos,sum,8));
}%>
</table>
<br/>
<input type="button" value=" 确 定 " onclick="f_ok()"/>
<input type="button" value=" 取 消 " onclick="pmt.close()"/>
</form>
<script>
function f_ok()
{
  var arr=form2.products,v='|',n='',d=form1.product.value,h='';
  if(!arr.length)arr=new Array(arr);
  for(var i=0;i<arr.length;i++)
  {
    if(!arr[i].checked||d.indexOf('|'+arr[i].value+'|')!=-1)continue;
    v+=arr[i].value+'|';
    n+=arr[i].alt+'；';
    h+="<span id='"+arr[i].value+"'><input type='hidden' name='products' value='"+arr[i].value+"'/>"+arr[i].alt+"<img src='/tea/image/d.gif' onclick='var p=parentNode;p.parentNode.removeChild(p);' />　</span>";
  }
  pmt.receive(v,n,h);
  pmt.close()
}
</script>

</body>
</html>
