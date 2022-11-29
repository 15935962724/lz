<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menu=h.getInt("id");
par.append("?menu="+menu);

int type=h.getInt("type");
sql.append(" AND type="+type);
par.append("&type="+type);

int product=h.getInt("product");
if(product>0)
{
  sql.append(" AND product LIKE "+Database.cite("%"+product+"%"));
  par.append("&product="+product);
}



int pos=h.getInt("pos");
int sum=Special.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1><%=Special.SPECIAL_TYPE[type]%></h1>

<%--
<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>类型:<input name="type" value="<%=type%>"/></td>
  <td> 特价商品:<input name="product" value="<%=product%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>
--%>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Specials.do" method="post" target="_ajax">
<input type="hidden" name="special"/>
<input type="hidden" name="product"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>商品</td>
  <td>移动</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Special.find(sql.toString(),pos,200).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Special t=(Special)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%><input type="checkbox" name="specials" value="<%=t.special%>" style="display:none"/></td>
    <td><%=Product.find(t.product).getAnchor(h.language)%></td>
    <td><img name="sequence" src="/tea/mt/move.gif" /></td>
    <td><input type="button" value="删除" onclick="f_act('del',<%=t.special%>)"/></td>
  </tr>
  <%}
  //if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('edit','0')"/>
</form>

<script>
mt.sequence(form2.specials);
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.special.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    mt.show("/jsp/yl/shop/ProductSel.jsp",2,"特价商品",500,400);
    //form2.action='/jsp/yl/shop/SpecialEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
mt.receive=function(v,n,h)
{
  form2.product.value=v;
  form2.submit();
}
</script>
</body>
</html>
