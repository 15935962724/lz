<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
int category=h.getInt("category");
if(category>0)
{
  sql.append(" AND category LIKE "+Database.cite("%"+category+"%"));
  par.append("&category="+category);
}

int quantity=h.getInt("quantity");
if(quantity>0)
{
  sql.append(" AND quantity LIKE "+Database.cite("%"+quantity+"%"));
  par.append("&quantity="+quantity);
}

int hits=h.getInt("hits");
if(hits>0)
{
  sql.append(" AND hits LIKE "+Database.cite("%"+hits+"%"));
  par.append("&hits="+hits);
}


int pos=h.getInt("pos");
int sum=Keywords.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>热门关键字</h1>

<!--
<h2>查询</h2>
<form name="form1" action="?">
<table id="tablecenter" cellspacing="0">
<tr>
  <td>分类:<input name="category" value="<%=category%>"/></td>
  <td>结果数量:<input name="quantity" value="<%=quantity%>"/></td>
  <td>搜索次数:<input name="hits" value="<%=hits%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>
-->

<h2>列表 <%=sum%></h2>
<form name="form2" action="/KeywordsEdit.jsp" method="post" target="_ajax">
<input type="hidden" name="keywords"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>关键字</td>
  <!-- <td>结果数量</td> -->
  <td>搜索次数</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  sql.append(" ORDER BY hits DESC");
  Iterator it=Keywords.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    Keywords t=(Keywords)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.keywords)%></td>
    <%-- <td><%=MT.f(t.quantity)%></td> --%>
    <td><%=MT.f(t.hits)%></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<br/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
function f_act(a,id,b)
{
  form2.act.value=a;
  form2.keywords.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/KeywordsEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>
</body>
</html>
