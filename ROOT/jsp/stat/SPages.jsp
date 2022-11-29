<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.sql.ResultSet"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.stat.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

int filter=h.getInt("filter");
sql.append("SELECT node,SUM(pv"+filter+")pv,SUM(uv"+filter+")uv,SUM(ip"+filter+")ip,SUM(entrance"+filter+")entrance,SUM(outward"+filter+")outward,SUM(exit"+filter+")ex FROM spage WHERE community="+DbAdapter.cite(h.community));

Date st=h.getDate("st"),et=h.getDate("et");
if(st==null)
{
  Calendar c=Calendar.getInstance();
  if(et==null)et=c.getTime();
  c.add(Calendar.DAY_OF_YEAR,-1);
  for(int i=11;i<15;i++)c.set(i,0);
  st=c.getTime();
}
String sst=MT.f(st),set=MT.f(et);
if(st!=null)
{
  sql.append(" AND time>="+DbAdapter.cite(st));
  par.append("&st="+sst);
}
if(et!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(et));
  par.append("&et="+set);
}

sql.append(" AND pv"+filter+">0");
par.append("&filter="+filter);

String order=h.get("order","pv");
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);

int pos=h.getInt("pos");
par.append("&pos=");

sql.append(" AND node=-1 GROUP BY node");

%><!DOCTYPE html>
<html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js"></script>
<script src="/tea/mt.js"></script>
<script src="/tea/script/stat.js"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
</style>
</head>
<body>
<h1>受访页面</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>时间：<td><script>var time=<%=System.currentTimeMillis()%>;document.write(mt.sel1());</script> <input name="st" value="<%=sst%>" class="date" onClick="mt.date(this)"/>—<input name="et" value="<%=set%>" class="date" onClick="mt.date(this)"/></td>
  <td>类型：<td><select name="filter"><%=h.options(TJBaidu.FILTER_TYPE,filter)%></select></td>
  <td><input type="submit" value="查询" /></td>
</tr>
</table>
</form>


<h2>列表</h2>
<table id="tablecenter" cellspacing="0">
<tr><td>浏览次数(PV)</td><td>独立访客(UV)</td><td>IP</td><td>入口页次数</td><td>贡献下游流量</td><td>退出页次数</td>
<%
int sum=0;
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery(sql.toString());
  if(db.next())
  {
    out.print("<tr><td>"+MT.f(db.getInt(2))+"<td>"+db.getInt(3)+"<td>"+db.getInt(4)+"<td>"+db.getInt(5)+"<td>"+db.getInt(6)+"<td>"+db.getInt(7));

    //
    sql.insert(sql.length()-17,'!');
    db.executeQuery("SELECT COUNT(*) FROM("+sql.toString()+")TAB");
    if(db.next())sum=Math.min(db.getInt(1),100);
  }
}finally
{
  db.close();
}
%>
</table>

<form name="form2" action="/SPages.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nodeid"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="tab" value="spage"/>
<input type="hidden" name="filter" value="<%=filter%>"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>网页</td>
  <td><a href="javascript:" onclick="mt.order(id)" id="Opv">浏览次数(PV)</a></td>
  <td><a href="javascript:" onclick="mt.order(id)" id="Ouv">独立访客(UV)</a></td>
  <td><a href="javascript:" onclick="mt.order(id)" id="Oip">IP</a></td>
  <td><a href="javascript:" onclick="mt.order(id)" id="Oentrance">入口页次数</a></td>
  <td><a href="javascript:" onclick="mt.order(id)" id="Ooutward">贡献下游流量</a></td>
  <td><a href="javascript:" onclick="mt.order(id)" id="Oex">退出页次数</a></td>
  <td>操作</td>
</tr>
<%
db=new DbAdapter();
try
{
  if(sum<1)
  {
    out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
  }else
  {
    ResultSet rs=db.executeQuery(sql.toString()+" ORDER BY "+order+" "+(desc?" DESC":" ASC"),pos,20);
    for(int i=pos+1;rs.next();i++)
    {
      int node=rs.getInt(1);
    %>
    <tr>
      <td><%=i%></td>
      <td><%=node<1?"其它":Node.find(node).getAnchor(h.language).toString()%></td>
      <td><%=MT.f(rs.getInt(2))%></td>
      <td><%=MT.f(rs.getInt(3))%></td>
      <td><%=MT.f(rs.getInt(4))%></td>
      <td><%=MT.f(rs.getInt(5))%></td>
      <td><%=MT.f(rs.getInt(6))%></td>
      <td><%=MT.f(rs.getInt(7))%></td>
      <td><a href=javascript:mt.act('chart','<%=node%>')>走势图</a></td>
    </tr>
    <%
    }
    rs.close();
    if(sum>20)out.print("<tr><td colspan='10' align='right'>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
  }
}finally
{
  db.close();
}%>
</table>
<br/>
<!--
<input type="button" value="导出"/>
-->
</form>

<script>
t=$$('fast');t.value=form1.st.value+"—"+form1.et.value;
t.options[0]=null;
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.nodeid.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='chart')
  {
    form2.action='/jsp/stat/SView.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
