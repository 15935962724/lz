<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?community="+h.community+"&id="+menuid);


int city=h.getInt("city");
if(city>0)
{
  sql.append(" AND city="+city);
  par.append("&city="+city);
}

int limit=h.getInt("limit");
if(limit>0)
{
  sql.append(" AND limit LIKE "+DbAdapter.cite("%"+limit+"%"));
  par.append("&limit="+limit);
}

int total=h.getInt("total");
if(total>0)
{
  sql.append(" AND total LIKE "+DbAdapter.cite("%"+total+"%"));
  par.append("&total="+total);
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=WxRed.count(sql.toString());
String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/city.js" type="text/javascript"></script>
</head>
<body>
<h1>红包管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>城市:<script>mt.city('city',null,null,"<%=city%>")</script></td>
<!--
  <td>每天上限:<input name="limit" value="<%=limit%>"/></td>
  <td>共充值:<input name="total" value="<%=total%>"/></td>
-->
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/WxReds.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="wxred"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>城市</td>
  <td>已领取/每天上限</td>
  <td>已领取/共充值</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=WxRed.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    WxRed t=(WxRed)it.next();
  %>
  <tr>
    <td><%=i%></td>
    <td><%if(t.hidden)out.print("<s>");%><%=t.city<1?"全国":"<script>mt.city("+t.city+")</script>"%></s></td>
    <td><%=(int)WxRedGrab.sum(" AND wxred="+t.wxred+" AND time>"+DbAdapter.cite(new Date(),true))+"/"+MT.f(t.limit)%></td>
    <td><%=(int)WxRedGrab.sum(" AND wxred="+t.wxred)+"/"+MT.f(t.total)%></td>
    <td><%
    out.println("<a href=javascript:mt.act('edit',"+t.wxred+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+t.wxred+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
}%>
</table>
<br/>
<input type="button" value="添加" onclick="mt.act('edit','0')"/>
</form>

<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.wxred.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/WxRedView.jsp';
    else if(a=='edit')
      form2.action='/jsp/weixin/WxRedEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
