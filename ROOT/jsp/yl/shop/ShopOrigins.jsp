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
  sql.append(" AND(name0 LIKE "+Database.cite("%"+name+"%")+" OR name1 LIKE "+Database.cite("%"+name+"%")+")");
  par.append("&name="+h.enc(name));
}


int pos=h.getInt("pos");
int sum=ShopOrigin.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>产地管理</h1>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%=menu%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>标题:<input name="name" value="<%=MT.f(name)%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/ShopOrigins.do" method="post" target="_ajax">
<input type="hidden" name="origin"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>中文标题</td>
  <td>英文标题</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=ShopOrigin.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    ShopOrigin t=(ShopOrigin)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.name[1])%></td>
    <td><%=MT.f(t.name[0])%></td>
    <td><input type="button" value="编辑" onclick="f_act('edit',<%=t.origin%>)"/> <input type="button" value="删除" onclick="f_act('del',<%=t.origin%>)"/></td>
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
  form2.origin.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='edit')
  {
    form2.action='/jsp/yl/shop/ShopOriginEdit.jsp';form2.target='_self';form2.method='get';form2.submit();
  }
}
</script>
</body>
</html>
