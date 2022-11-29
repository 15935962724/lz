<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.stat.*"%><%@page import="tea.entity.admin.*"%><%!

String htm(String sql)throws Exception
{
  StringBuilder sb=new StringBuilder();
  DbAdapter db=new DbAdapter();
  try
  {
    db.executeQuery(sql,0,5);
    for(int i=1;db.next();i++)
    {
      String tmp=db.getString(1);
      if(tmp.indexOf("://")==-1)
      {
        int node=Integer.parseInt(tmp);
        tmp=node<1?"其它":Node.find(node).getAnchor(1).toString();
      }
      sb.append("<tr><td>"+i);
      sb.append("<td>"+tmp);
      sb.append("<td>"+db.getInt(2));
    }
  }finally
  {
    db.close();
  }
  return sb.toString();
}
%><%

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
  sql.append(" AND time>="+DbAdapter.cite(st));
}
if(et!=null)
{
  sql.append(" AND time<"+DbAdapter.cite(et));
}

int group=h.getInt("group");
String tab="sday";


%><!DOCTYPE html>
<html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js"></script>
<script src="/tea/script/echarts.min.js"></script>
<script src="/tea/script/stat.js"></script>
</head>
<body>
<h1>新老访客</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=h.getInt("id")%>"/>
<input type="hidden" name="node" value="<%=h.node%>" />

<table id="tablecenter" cellspacing="0">
<tr>
  <td>时间：<td><script>var time=<%=System.currentTimeMillis()%>;document.write(mt.sel1());</script> <input name="st" value="<%=MT.f(st)%>" class="date" onClick="mt.date(this)"/>—<input name="et" value="<%=MT.f(et)%>" class="date" onClick="mt.date(this)"/></td>
  <td><input type="submit" value="查询" /></td>
</tr>
</table>
</form>

<style>
.vleft{float:left;width:49%}
.vright{float:right;width:49%}
.vclear{overflow: hidden;clear: both;width:95.5%;margin:0 auto;}
.vtitle{color: #006D46; font-weight: bold;margin-bottom: 10px;}
.vclear td{padding: 5px;font-size:14px;}
.vclear td.trt{text-align:right;color:#999;width:45%;}
.vclear td.tlt{text-align:left;color:#006D46;}
.vclear td.vm{font-size:26px;vertical-align:middle;text-align:left;color:#006D46}
.vtop{text-align:left;font-weight:bold;margin-bottom:15px;;margin:25px auto 5px;color:#006D46;}
.tl{text-align:left !important;}
#tablecenter .date{border:1px #ddd solid ;height:23px;}

.vtable{width:100%;}
.vtable th{background-color:#e1effa;padding:6px;}
.thbg th{background-color:#DDD;}
.vtable td{padding:5px;border-bottom:1px solid #ddd;text-align:left;font-size:12px;}
.vtable td a{text-decoration:none;color:#006D46;}

</style>
 <h2>列表</h2>
<%
StringBuilder en4=new StringBuilder(),en5=new StringBuilder(),ex4=new StringBuilder(),ex5=new StringBuilder();
DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT SUM(uv0),SUM(pv4),SUM(uv4),AVG(rate4),AVG(stay4),SUM(pv5),SUM(uv5),AVG(rate5),AVG(stay5) FROM sday WHERE 1=1" + sql);
  if(db.next())
  {
    int j=1;
    int uv=db.getInt(j++),pv4=db.getInt(j++),uv4=db.getInt(j++);
    out.print("<div class=vclear><div class=vleft><table width=100% cellspacing=0 cellpadding=0><tr><td class=trt><div class=vtitle>新访客：</div><img src='data:image/gif;base64,R0lGODlhSABdAMQAAP///+/6/t/1/c/w/L/r+6/m+p/h+Y/b+H/W93DS9mDM9VDH9EDC8zC98iC48RCz8ACu7wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEHAAAALAAAAABIAF0AAAX/ICCOZGmeYmAoDeRCD5MQaG3fOEoob+87iEBuSLwFeL5k71EoOp+Dh3LaWwifWJuByn01rtnwaNstf8XiaHm9QIdb6/XB/UTE4w8wHReQ3tcKe0MHf3h6gihwhWUGiDYCi3FtjigFkWsPlCh2l2WHmgAJnWU0oCQMo12lpiKoqVSrrKKvU7GmnLRJrCSWuT+7IwG+PoHAIorDjcYAZMOZywB9wxAI0CKEvnnWx75N2wACfqnF3wBqow3lJOeRDJ/fA8h3CeonAbhrDrb1JAIJ4lMaKON3owACBooYLDgggKDDhxAjSpxIsSKaAAQyHkDAsaPHjyA5Fsg4ABiBg9N+oCxsKGiAAoAplQh8V2SAq5iYgmAJMAvnH31O4vm8RG8Iu6GLFNBcBxNpIQY3jjqNRM5EAHlTI8050TPrqJIlCHilBbXEzbGjBgIQi/aVg1NtaSkbEJesiK51OzV0kPfVAbp9UzHAFnjUgsKpmiJezLix48eQI0ueTLmy5cuYM2vezLmz58+gQ4sevVhx5rOcUW9WrRmJZ3ycYW+WrbmX5xAAOw=='></td><td class=vm>"+MT.f(uv4*100F/uv)+"%"+"</td></tr>");
    out.print("<tr><td class=trt>浏览量：</td><td class=tlt>"+pv4+"</td></tr>");
    out.print("<tr><td class=trt>访客数：</td><td class=tlt>"+uv4+"</td></tr>");
    out.print("<tr><td class=trt>跳出率：</td><td class=tlt>"+db.getInt(j++)/100F+"%</td></tr>");
    out.print("<tr><td class=trt>平均访问时长：</td><td class=tlt>"+MT.ss(db.getInt(j++))+"</td></tr>");
    out.print("<tr><td class=trt>平均访问页数：</td><td class=tlt>"+MT.f(pv4/(float)uv4)+"</td></tr></table></div>");

    int pv5=db.getInt(j++),uv5=db.getInt(j++);
    out.print("<div class=vright><table width=100% cellspacing=0 cellpadding=0><tr><td class=trt><div class=vtitle>老访客：</div><img src='data:image/gif;base64,R0lGODlhSABdAMQAAP////n5+fLy8uzs7OXl5d/f39nZ2dLS0szMzMbGxr+/v7m5ubOzs6ysrKampp+fn5mZmQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEHAAAALAAAAABIAF0AAAX/ICCOZGmeYmAoDeRCD5MQaG3fOEoob+87iEBuSLwFeL5k71EoOp+Dh3LaWwifWJuByn01rtnwaNstf8XiaHm9QIdb6/XB/UTE4w8wHReQ3tcKe0MHf3h6gihwhWUGiDYCi3FtjigFkWsPlCh2l2WHmgAJnWU0oCQMo12lpiKoqVSrrKKvU7GmnLRJrCSWuT+7IwG+PoHAIorDjcYAZMOZywB9wxAI0CKEvnnWx75N2wACfqnF3wBqow3lJOeRDJ/fA8h3CeonAbhrDrb1JAIJ4lMaKON3owACBooYLDgggKDDhxAjSpxIsSKaAAQyHkDAsaPHjyA5Fsg4ABiBg9N+oCxsKGiAAoAplQh8V2SAq5iYgmAJMAvnH31O4vm8RG8Iu6GLFNBcBxNpIQY3jjqNRM5EAHlTI8050TPrqJIlCHilBbXEzbGjBgIQi/aVg1NtaSkbEJesiK51OzV0kPfVAbp9UzHAFnjUgsKpmiJezLix48eQI0ueTLmy5cuYM2vezLmz58+gQ4sevVhx5rOcUW9WrRmJZ3ycYW+WrbmX5xAAOw=='></td><td class=vm>"+MT.f(uv5*100F/uv)+"%");
    out.print("<tr><td class=trt>浏览量：</td><td class=tlt>"+pv5+"</td></tr>");
    out.print("<tr><td class=trt>访客数：</td><td class=tlt>"+uv5+"</td></tr>");
    out.print("<tr><td class=trt>跳出率：</td><td class=tlt>"+db.getInt(j++)/100F+"%</td></tr>");
    out.print("<tr><td class=trt>平均访问时长：</td><td class=tlt>"+MT.ss(db.getInt(j++))+"</td></tr>");
    out.print("<tr><td class=trt>平均访问页数：</td><td class=tlt>"+MT.f(pv5/(float)uv5)+"</td></tr></table></div></div>");
  }
}finally
{
  db.close();
}
%>
<div class=vclear>
	<div class=vleft>
		<div class="vtop">来源网站 TOP 5</div>
		<table class="vtable">
		<tr id="tableonetr"><th class='tl'>排名</th><th class='tl'>页链接</th><th class='tl'>浏览量(PV)</th></tr>
		<%=htm("SELECT data,SUM(pv4) FROM sdata WHERE type=2"+sql+" AND data!='总计' AND pv4>0 GROUP BY data ORDER BY SUM(pv4) DESC")%>
		</table>
	</div>
	<div class="vright thbg">
		<div class="vtop">来源网站 TOP 5</div>
		<table class="vtable">
		<tr id="tableonetr"><th class='tl'>排名</th><th class='tl'>页链接</th><th class='tl'>浏览量(PV)</th></tr>
		<%=htm("SELECT data,SUM(pv5) FROM sdata WHERE type=2"+sql+" AND data!='总计' AND pv5>0 GROUP BY data ORDER BY SUM(pv5) DESC")%>
		</table>
	</div>
</div>

<div class=vclear>
	<div class=vleft>
		<div class="vtop">入口网页 TOP 5</div>
		<table class="vtable">
		<tr id="tableonetr"><th class='tl'>排名</th><th class='tl'>页链接</th><th class='tl'>次数</th></tr>
		<%=htm("SELECT node,SUM(entrance4) FROM spage WHERE node>0"+sql+" AND entrance4>0 GROUP BY node ORDER BY SUM(entrance4) DESC")%>
		</table>
	</div>
	<div class="vright thbg">
		<div class="vtop">入口网页 TOP 5</div>
		<table class="vtable">
		<tr id="tableonetr"><th class='tl'>排名</th><th class='tl'>页链接</th><th class='tl'>次数</th></tr>
		<%=htm("SELECT node,SUM(entrance5) FROM spage WHERE node>0" + sql+" AND entrance5>0 GROUP BY node ORDER BY SUM(entrance5) DESC")%>
		</table>
	</div>
</div>


<script>
t=$$('fast');t.value=form1.st.value+"—"+form1.et.value;
t.options[0]=null;
//
chart.style.height=(navigator.userAgent.indexOf(' Mobile')>0?150:300)+"px";
echarts.init(chart).setOption(data);
</script>
</body>
</html>
