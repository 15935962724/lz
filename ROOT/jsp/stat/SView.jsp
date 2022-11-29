<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.util.regex.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.stat.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

int menu=h.getInt("id");
String[] TAB={"日统计","月统计"};

StringBuilder sql=new StringBuilder();
sql.append(" AND community="+DbAdapter.cite(h.community));

int filter=h.getInt("filter");
String name=h.get("name");
String tab=h.get("tab");
if(tab.startsWith("sday,pv0")){tab="sday";name=null;};//旧菜单
if("spage".equals(tab))
{
  tab="spage,pv"+filter+",uv"+filter+",ip"+filter+",rate"+filter+",stay"+filter+",entrance"+filter+",outward"+filter+",exit"+filter+"";
  name="历史趋势,PV,UV,IP,退出率,平均停留时长,入口页次数,贡献下游浏览量,退出页次数";
}else if(name==null)
{
  tab+=",pv"+filter+",uv"+filter+",ip"+filter+",rate"+filter+",stay"+filter+"";
  name="趋势分析,PV,UV,IP,跳出率,平均访问时长";
}

Date st=h.getDate("st"),et=h.getDate("et");
if(st==null)
{
  Calendar c=Calendar.getInstance();
  c.add(Calendar.DAY_OF_YEAR,1);
  if(et==null)et=c.getTime();
  c.add(Calendar.DAY_OF_YEAR,-31);
  st=c.getTime();
}
if(st!=null)
{
  sql.append(" AND time>="+DbAdapter.cite(st,true));
}
if(et!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(et,true));
}

int type=h.getInt("type");
if(type>0)sql.append(" AND type="+type);

String data=h.get("data","");
if(data.length()>0)sql.append(" AND data="+DbAdapter.cite(data));

int node=h.getInt("nodeid");
if(node>0)
{
  sql.append(" AND node="+node);
  data=Node.find(node).getAnchor(h.language).toString();
}

int group=h.getInt("group");

%><!DOCTYPE html>
<html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js"></script>
<script src="/tea/script/echarts.min.js"></script>
<script>data=<%=SPage.chart(tab,name,sql.toString(),group)%>;</script>
<script src="/tea/script/stat.js"></script>
</head>
<body>
<h1><%=data.length()<1?(tab.startsWith("sday,pv1")?"来源分析":"趋势分析"):"走势图（"+data+"）"%></h1>
<div id="head6"><img height="6" src="about:blank"></div>


<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=h.getInt("id")%>"/>
<input type="hidden" name="tab" value="<%=h.get("tab")%>" />
<input type="hidden" name="nodeid" value="<%=node%>" />
<table id="tablecenter" cellspacing="0">
<tr>
  <td>时间：<td><script>var time=<%=System.currentTimeMillis()%>;document.write(mt.sel1());</script> <input name="st" value="<%=MT.f(st)%>" class="date" onClick="mt.date(this)"/>—<input name="et" value="<%=MT.f(et)%>" class="date" onClick="mt.date(this)"/></td>
  <td>类型：<td><select name="filter"><%=h.options(TJBaidu.f(type),filter)%></select></td>
  <td>显示：<td><select name="group"><%=h.options(TAB,group)%></select> <input type="submit" value="查询" /></td>
</tr>
</table>
</form>



<h2>列表</h2>
<table id="tablecenter">
<tr><td><div id="chart"></div></td>
</table>

<table id="tablecenter"><script>document.write(stat.table())</script></table>
<input type="button" value="导出" onClick="stat.save(stat.csv(document.getElementsByTagName('TABLE')[2]),'table.csv')"/>

<script>
t=$$('fast');t.value=form1.st.value+"—"+form1.et.value;
t.options[0]=null;
//form1.group.options[0]=null;
//
data.series.length=3;
chart.style.height=(navigator.userAgent.indexOf(' Mobile')>0?150:300)+"px";
echarts.init(chart).setOption(data);
</script>
</body>
</html>
