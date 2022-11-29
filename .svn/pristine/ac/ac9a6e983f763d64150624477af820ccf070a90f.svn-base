<%@page import="tea.entity.member.Member"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int menu=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
par.append("&menu="+menu);

String title=h.get("title","");
if(title.length()>0)
{
  sql.append(" AND title LIKE "+Database.cite("%"+title+"%"));
  par.append("&title="+h.enc(title));
}

int state=h.getInt("state",-1);
if(state!=-1)
{
  sql.append(" AND state="+state);
  par.append("&state="+state);
}

String username=h.get("username","");
if(username.length()>0)
{
  sql.append(" AND m.username LIKE "+Database.cite("%"+username+"%"));
  par.append("&username="+h.enc(username));
}



int pos=h.getInt("pos");
int sum=Review.count(sql.toString());
par.append("&pos=");


%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>评价管理</h1>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>用户:<input name="username" value="<%=MT.f(username)%>"/></td>
  <td>状态:<select name="state"><option value="-1">---不限---</option><%=h.options(Review.STATE_TYPE,state)%></select></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/Reviews.do" method="post" target="_ajax">
<input type="hidden" name="review"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>商品</td>
  <td>用户</td>
  <td>标题</td>
  <td>评分</td>
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
  Iterator it=Review.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Review t=(Review)it.next();
    int id=t.review;
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=Product.find(t.product).getAnchor(h.language)%></td>
    <td><%=MT.f(Member.find(t.member).username)%></td>
    <td><%=MT.f(t.title)%></td>
    <td><%=MT.f(t.score)%></td>
    <td><%=MT.f(Review.STATE_TYPE,t.state)%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><input type="button" value="状态" onclick="f_act('state',<%=id%>,<%=t.state%>)"/>
      <input type="button" value="详细" onclick="f_act('view',<%=id%>)"/>
      <input type="button" value="删除" onclick="f_act('del',<%=id%>)"/></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>

</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.review.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='state')
  {
    mt.show("状态：<%=h.radios(Review.STATE_TYPE,"_state",0)%>",2);
    a=$name('_state');
    a[b].checked=true;
    mt.ok=function(){form2.action+='?state='+mt.value(a);form2.submit();}
  }else if(a=='view')
  {
    form2.action='/jsp/yl/shop/ReviewView.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>
</body>
</html>
