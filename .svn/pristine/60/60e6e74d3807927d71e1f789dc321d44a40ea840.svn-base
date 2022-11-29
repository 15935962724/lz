<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.stat.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
int menuid=h.getInt("id");

par.append("?id="+menuid);
sql.append(" AND community="+DbAdapter.cite(h.community));

Date st=h.getDate("st"),et=h.getDate("et");
String sst=MT.f(st),set=MT.f(et);
if(st==null)
{
  Calendar c=Calendar.getInstance();
  c.add(Calendar.HOUR_OF_DAY, -24);
  c.set(Calendar.MINUTE,0);
  c.set(Calendar.SECOND,0);
  st=c.getTime();
}
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

int order=h.getInt("order",1);
par.append("&order="+order);

boolean desc=!"false".equals(h.get("desc"));
par.append("&desc="+desc);

int pos=h.getInt("pos");
par.append("&pos=");

Calendar c=Calendar.getInstance();

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
#O<%=order%>{background:url(/tea/mt/order<%=desc?0:1%>.gif) no-repeat right;padding-right:8px}
</style>
</head>
<body>
<h1>地区分布</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<h2>查询</h2>
<form name="form1" action="?">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="id" value="<%=menuid%>"/>
<input type="hidden" name="order" value="<%=order%>"/>
<input type="hidden" name="desc" value="<%=desc%>"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>时间：<select onChange="mt.fast(value);">
<%
String[] arr={"今天","昨天","前天"};
out.print("<option value='—'>最近24小时");
c.add(Calendar.DAY_OF_YEAR,1);
String last=MT.f(c.getTime());
for(int i=0;i<arr.length;i++)
{
  c.add(Calendar.DAY_OF_YEAR,-1);
  String tmp=MT.f(c.getTime()),str=tmp+"—"+last;
  last=tmp;
  out.print("<option value="+str);
  if(str.equals(sst+"—"+set))out.print(" selected");
  out.print(">"+arr[i]);
}
%>
</select>
  <input name="st" value="<%=sst%>" class="date" onClick="mt.date(this)"/>—<input name="et" value="<%=set%>" class="date" onClick="mt.date(this)"/></td>
  <td><input type="submit" value="查询" /></td>
</tr>
</table>
</form>

<h2>列表</h2>
<form name="form2" action="/SPages.do" method="post" target="_ajax">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="city"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td>序号</td>
  <td>网页</td>
  <td><a href="javascript:mt.order('O1')" id="O1">浏览次数(PV)</a></td>
  <td><a href="javascript:mt.order('O2')" id="O2">独立访客(UV)</a></td>
  <td><a href="javascript:mt.order('O3')" id="O3">IP</a></td>
  <td>操作</td>
</tr>
<%
DbAdapter db = new DbAdapter();
try
{
  db.executeQuery("SELECT COUNT(*) FROM (SELECT city FROM scity WHERE 1=1"+sql.toString()+" GROUP BY city)AS tab");
  int sum=db.next()?db.getInt(1):0;
  if(sum<1)
  {
    out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
  }else
  {
    String[] ORDER_TYPE={"","pv","uv","ip"};
    java.sql.ResultSet rs = db.executeQuery("SELECT city,SUM(pv),SUM(uv),SUM(ip) FROM scity WHERE 1=1"+sql.toString()+" GROUP BY city ORDER BY SUM("+ORDER_TYPE[order]+")"+(desc?" DESC":" ASC"),pos,20);
    for(int i = 1;rs.next();i++)
    {
      String city=rs.getString(1);
    %>
    <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
      <td><%=i%></td>
      <td><%=city%></td>
      <td><%=MT.f(rs.getInt(2))%></td>
      <td><%=MT.f(rs.getInt(3))%></td>
      <td><%=MT.f(rs.getInt(4))%></td>
      <td><a href=javascript:mt.act('chart','<%=city%>')>走势图</a></td>
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
mt.fast=function(v)
{
  arr=v.split('—');
  form1.st.value=arr[0];
  form1.et.value=arr[1];
  form1.submit();
};
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,id,b)
{
  form2.act.value=a;
  form2.city.value=id;
  if(a=='del')
  {
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }else if(a=='chart')
  {
    form2.action='/jsp/stat/SCityChart.jsp';
    form2.target=form2.method='';
    form2.submit();
  }
};
</script>
</body>
</html>
