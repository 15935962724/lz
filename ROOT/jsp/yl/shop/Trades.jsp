<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
StringBuilder sql=new StringBuilder(),par=new StringBuilder();

int menu=h.getInt("id");
par.append("?menu="+menu);

sql.append(" AND state>0");

int state=h.getInt("state");

int s=h.getInt("s",state);
if(s>0)
{
  sql.append(" AND state="+s);
  par.append("&s="+s);
}



String code=h.get("code","");
if(code.length()>0)
{
  sql.append(" AND code LIKE "+Database.cite("%"+code+"%"));
  par.append("&code="+h.enc(code));
}

String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND m.username LIKE "+Database.cite("%"+username+"%"));
  par.append("&username="+h.enc(username));
}

String product=h.get("product",""),name=h.get("name","");
if(product.length()>0||name.length()>0)
{
  sql.append(" AND trade IN(SELECT trade FROM item i INNER JOIN product p ON i.product=p.product WHERE 1=0");
  if(product.length()>0)
  {
    sql.append(" OR i.product LIKE "+Database.cite("%"+product+"%"));
    par.append("&product="+h.enc(product));
  }
  if(name.length()>0)
  {
    sql.append(" OR p.name"+h.language+" LIKE "+Database.cite("%"+name+"%"));
    par.append("&name="+h.enc(name));
  }
  sql.append(")");
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
par.append("&pos=");


int sum=Trade.count(sql.toString());


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>订单管理 - <%=state>0?Trade.STATE_TYPE[state]:""%></h1>



<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>订单编号:<input name="code" value="<%=MT.f(code)%>"/></td>
  <td>商品编号:<input name="product" value="<%=MT.f(product)%>"/></td>
  <td>商品名称:<input name="name" value="<%=MT.f(name)%>"/></td>
  <td>客户:<input name="username" value="<%=MT.f(username)%>"/></td>
<%
if(state<1)
{
  out.print("<td>状态:<select name='s'>"+h.options(Trade.STATE_TYPE,s)+"</select><script>form1.s.options[0].text='---不限---';</script>");
}
%>
  <td>时间:<input name="t0" value="<%=MT.f(t0)%>" onclick="mt.date(this)" class="date"/> - <input name="t1" value="<%=MT.f(t1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>


<h2>列表</h2>
<form name="form2" action="/TradeEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="trade"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>订单编号</td>
  <td>订单商品</td>
  <td>收货人</td>
  <td>订单金额</td>
  <td>下单时间</td>
  <td>订单状态</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Trade.find(sql.toString(),pos,20).iterator();
  for(int j=1+pos;it.hasNext();j++)
  {
    Trade t=(Trade)it.next();
    StringBuilder sb=new StringBuilder();
    Iterator ii=Item.findByTrade(t.trade).iterator();
    while(ii.hasNext())
    {
      Item i=(Item)ii.next();
      sb.append(Product.find(i.product).getAnchor('t')+" ");
    }
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=j%></td>
    <td><%=MT.f(t.code)%></td>
    <td><%=sb.toString()%></td>
    <td><%=MT.f(t.aname)%></td>
    <td>￥<%=MT.f(t.actually)+"<br/>"+Trade.PPAYMENT_TYPE[t.ppayment]%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><%=MT.f(Trade.STATE_TYPE,t.state)%></td>
    <td>
      <a href="javascript:f_act('view',<%=t.trade%>)">查看</a>
    </td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
等待付款订单数：0　未完成的订单数：０　已完成的订单数：０　已取消的订单数：3　订单总数：12
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.trade.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='view')
  {
    form2.action='/jsp/yl/shop/TradeView.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>

</body>
</html>
