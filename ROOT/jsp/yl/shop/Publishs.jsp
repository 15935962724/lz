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
  sql.append(" AND type LIKE "+Database.cite("%"+type+"%"));
  par.append("&type="+type);
}

int quantity=h.getInt("quantity");
if(quantity>0)
{
  sql.append(" AND quantity LIKE "+Database.cite("%"+quantity+"%"));
  par.append("&quantity="+quantity);
}

int scode=h.getInt("scode");
if(scode>0)
{
  sql.append(" AND scode LIKE "+Database.cite("%"+scode+"%"));
  par.append("&scode="+scode);
}

int ecode=h.getInt("ecode");
if(ecode>0)
{
  sql.append(" AND ecode LIKE "+Database.cite("%"+ecode+"%"));
  par.append("&ecode="+ecode);
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
int sum=Publish.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>发行优惠券</h1>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>时间:<input name="t0" value="<%=MT.f(t0)%>" onclick="mt.date(this)" class="date"/> - <input name="t1" value="<%=MT.f(t1)%>" onclick="mt.date(this)" class="date"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Publishs.do" method="post" target="_ajax">
<input type="hidden" name="publish"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="type" value="1"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>发行者</td>
  <td>数量</td>
  <td>开始编号</td>
  <td>结束编号</td>
  <td>有效期</td>
  <td>已发放</td>
  <td>已使用</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=Publish.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Publish t=(Publish)it.next();
    int id=t.publish;
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.member)%></td>
    <td><%=MT.f(t.quantity)%></td>
    <td><%=Publish.DF8.format(t.scode)%></td>
    <td><%=Publish.DF8.format(t.ecode)%></td>
    <td><%=MT.f(t.vtime)%></td>
    <td><%=Coupon.count(" AND publish="+t.publish+" AND member IS NOT NULL")%></td>
    <td><%=Coupon.count(" AND publish="+t.publish+" AND trade>0")%></td>
    <td></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="f_act('edit','0')"/>
<input type="button" value="发放" onclick="f_act('member',0)"/>
<input type="button" value="导出" onclick="f_act('exp',0)"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.publish.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/yl/shop/PublishEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }else if(a=='member')
  {
    mt.show('/jsp/yl/shop/PublishSetMember.jsp?type=1',2,"发放给代理商",400,250);
  }else
  form2.submit();
}
</script>
</body>
</html>
