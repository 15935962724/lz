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
if(type>0)
{
  sql.append(" AND type="+type);
  par.append("&type="+type);
}

Date t0=h.getDate("t0"),t1=h.getDate("t1");
if(t0!=null)
{
  sql.append(" AND time>"+Database.cite(t0));
  par.append("&t0="+MT.f(t0));
}
if(t1!=null)
{
  sql.append(" AND time<"+Database.cite(t1));
  par.append("&t1="+MT.f(t1));
}



int pos=h.getInt("pos");
int sum=Discount.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>商品折扣</h1>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
<!--  <td>类型:<input name="type" value="<%=type%>"/></td>-->
  <td>时间:<input name="t0" value="<%=MT.f(t0)%>" onclick="mt.date(this)" class="date"/> - <input name="t1" value="<%=MT.f(t1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/DiscountEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="discount"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>类型</td>
  <td>范围</td>
  <td>折扣</td>
  <td>状态</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Discount.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Discount t=(Discount)it.next();
    int id=t.discount;
    //t.category<1?"--":Category.find(t.category).name[1]
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=Discount.TYPE_NAME[t.type]%></td>
    <td><%=t.cust?"自定义":"全部"%></td>
    <td><%=MT.f(t.value)%></td>
    <td><%=Discount.STATE_TYPE[t.state]%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><input type="button" value="编辑" onclick="f_act('edit',<%=id%>)"/> <input type="button" value="删除" onclick="f_act('del',<%=id%>)"/></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('edit','0')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.discount.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/yl/shop/DiscountEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>
</body>
</html>
