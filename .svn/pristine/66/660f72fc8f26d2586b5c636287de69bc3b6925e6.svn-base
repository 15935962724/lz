<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.sql.ResultSet"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.stat.*"%><%
String ref=request.getHeader("Referer");

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer();

int menuid=h.getInt("id");
par.append("?id="+menuid);

int type=h.getInt("type");
par.append("&type="+type);

int filter=h.getInt("filter");
sql.append("SELECT data,SUM(pv"+filter+")pv,SUM(uv"+filter+")uv,SUM(ip"+filter+")ip,AVG(rate"+filter+")rate,AVG(stay"+filter+")stay FROM sdata WHERE type="+type+" AND community="+DbAdapter.cite(h.community)+" AND pv"+filter+" IS NOT NULL");

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

String prefix=h.get("data","");
if(prefix.length()>0)
{
  sql.append(" AND data LIKE "+DbAdapter.cite(prefix+"%"));
  par.append("&data="+Http.enc(prefix));
}

String order=h.get("order","pv");
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);

int pos=h.getInt("pos");
par.append("&pos=");

sql.append(" AND data='总计' GROUP BY data");


%><!DOCTYPE html>
<html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js"></script>
<script src="/tea/mt.js"></script>
<script src="/tea/script/stat.js"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
<%
if(type==6)out.println(".ip,.rate,.stay{display:none}");
%>
</style>
</head>
<body>
<h1><%=TJBaidu.DATA_TYPE[type]%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<input type="hidden" name="data" value="<%=prefix%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>时间：<td><script>var time=<%=System.currentTimeMillis()%>;document.write(mt.sel1());</script>
    <input name="st" value="<%=sst%>" class="date" onClick="mt.date(this)"/>—<input name="et" value="<%=set%>" class="date" onClick="mt.date(this)"/></td>
  <td>类型：<td><select name="filter"><%=h.options(TJBaidu.f(type),filter)%></select></td>
  <td><input type="submit" value="查询" /></td>
</tr>
</table>
</form>


<h2>列表</h2>
<%
int sum=0;
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery(sql.toString());
  if(db.next())
  {
	out.print("<table id=tablecenter cellspacing=0><tr><td>浏览次数(PV)</td><td>独立访客(UV)</td><td>IP</td><td>跳出率</td><td>平均访问时长</td>");
    out.print("<tr><td>"+MT.f(db.getInt(2))+"<td>"+db.getInt(3)+"<td>"+db.getInt(4)+"<td>"+MT.f(db.getInt(5)/100F)+"%<td>"+MT.ss(db.getInt(6)));
	out.print("</table>");
  }
  sql.insert(sql.length()-19,'!');
  db.executeQuery("SELECT COUNT(*) FROM("+sql.toString()+")TAB");
  if(db.next())sum=Math.min(db.getInt(1),100);
}finally
{
  db.close();
}
%>

<form name="form2" action="/SPages.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="type" value="<%=type%>"/>
<input type="hidden" name="data"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<input type="hidden" name="tab" value="sdata"/>
<input type="hidden" name="filter" value="<%=filter%>"/>

<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td><%=type==1?"搜索词":TJBaidu.DATA_TYPE[type]%></td>
  <td><a href="javascript:" onclick="mt.order(id)" id="Opv">浏览次数(PV)</a></td>
  <td><a href="javascript:" onclick="mt.order(id)" id="Ouv">独立访客(UV)</a></td>
  <td class="ip"><a href="javascript:" onclick="mt.order(id)" id="Oip">IP</a></td>
  <td class="rate"><a href="javascript:" onclick="mt.order(id)" id="Orate">跳出率</a></td>
  <td class="stay"><a href="javascript:" onclick="mt.order(id)" id="Ostay">平均访问时长</a></td>
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
    String[] SO={"http://www.baidu.com/s?wd=","http://www.baidu.com/s?wd=","http://www.google.com/search?q=","http://www.so.com/s?q="};
    ResultSet rs=db.executeQuery(sql.append(" ORDER BY "+order+" ").append(desc?" DESC":" ASC").toString(),pos,20);
    for(int i=pos+1;rs.next();i++)
    {
      String data=rs.getString(1),url=data;
      if("未知".equals(data));
      else if(type==1)url="<a href="+SO[filter>3?0:filter]+Http.enc(data)+" target=_blank>"+MT.f(data,50)+"</a>";
      else if(type==2)url="<a href="+data+" target=_blank>"+data+"</a>";
	  else if(type==6)url=url.substring(prefix.length());
    %>
    <tr>
      <td><%=i%></td>
      <td><%=url%></td>
      <td><%=MT.f(rs.getInt(2))%></td>
      <td><%=MT.f(rs.getInt(3))%></td>
      <td class="ip"><%=MT.f(rs.getInt(4))%></td>
      <td class="rate"><%=rs.getInt(5)/100F%>%</td>
      <td class="stay"><%=MT.ss(rs.getInt(6))%></td>
      <td><a href="javascript:mt.act('chart','<%=data%>')">走势图</a></td>
    </tr>
    <%
    }
    rs.close();
    if(sum>20)out.print("<tr><td colspan=10 align=right>共"+sum+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,sum,20));
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
  form2.data.value=id;
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
