<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.db.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  out.print("<script>top.location='/servlet/StartLogin?bg=1&node="+h.node+"'</script>");
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menu=h.getInt("menu");
par.append("?menu="+menu);

int atype=h.getInt("atype");

int weixin=h.getInt("site");
sql.append(" AND community="+DbAdapter.cite(h.community));

String name=h.get("name","");
if(name.length()>0)
{
  sql.append(" AND name LIKE "+DbAdapter.cite("%"+name+"%"));
  par.append("&name="+h.enc(name));
}

String keyword=h.get("keyword","");
if(keyword.length()>0)
{
  sql.append(" AND(1=1");
  for(int i=0;i<10;i++)sql.append(" OR keyword"+i+" LIKE "+DbAdapter.cite("%"+keyword+"%"));
  sql.append(")");
  par.append("&keyword="+h.enc(keyword));
}

int pos=h.getInt("pos");
par.append("&pos=");

int sum=WxRule.count(sql.toString());
String acts=h.get("acts","");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>关键字回复</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="menu" value="<%=menu%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>名称:<input name="name" value="<%=name%>"/></td>
  <td>关键字:<input name="keyword" value="<%=keyword%>"/></td>
  <td><input type="submit" value="查询"/></td>
</tr>
</table>
</form>

<h2>列表 <%=sum%></h2>
<form name="form2" action="/WxRules.do" method="post" target="_ajax">
<input type="hidden" name="rule"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="weixin" value="<%=weixin%>"/>
<input type="hidden" name="atype" value="<%=atype%>"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>名称</td>
  <td>关键字</td>
  <td>时间</td>
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
  Iterator it=WxRule.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
    WxRule t=(WxRule)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><%=i%></td>
    <td><%=MT.f(t.name)%></td>
    <td><%=t.getKeyword()%></td>
    <td><%=MT.f(t.time,1)%></td>
    <td><%
    out.println("<a href=javascript:mt.act('edit',"+t.wxrule+")>编辑</a>");
    out.println("<a href=javascript:mt.act('del',"+t.wxrule+")>删除</a>");
    %></td>
  </tr>
  <%
  }
  if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
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
  form2.rule.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else
  {
    if(a=='view')
      form2.action='/WxRuleView.jsp';
    else if(a=='edit')
      form2.action='/jsp/weixin/WxRuleEdit.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
