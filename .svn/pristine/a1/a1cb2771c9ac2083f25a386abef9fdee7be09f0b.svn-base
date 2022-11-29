<%@page import="tea.db.DbAdapter"%>
<%@page import="java.util.Date"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.MT"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.yl.shop.ShopMyPoints"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Http h=new Http(request);
StringBuffer par=new StringBuffer(),sql=new StringBuffer();
sql.append(" and member ="+h.member);
int type=h.getInt("type",1);
if(type!=1){
	sql.append(" and createTime> DATEADD(month, "+type+", "+DbAdapter.cite(new Date())+")");
}
par.append("?type="+type);
int pos=h.getInt("pos",0);
par.append("&pos="+pos);
int sum=ShopMyPoints.count(sql.toString());
%>
<!DOCTYPE html>
<html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<title>我的积分</title>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<header class="header"><!-- <a href="javascript:history.go(-1)"></a> -->我的积分</header>

<div class='radiusBox newlist wSpan'>
<ul class='webkitbox'>
  <li><div>您的当前积分：<dfn><%=Profile.find(h.member).getIntegral() %></dfn></div>
<div>
<form name="form1" action="?" method="post">
<select name="type" onchange="form1.submit()">
<option value="1" <%=type==1?"selected":"" %>>全部</option>
<option value="-1" <%=type==-1?"selected":"" %>>最近一个月积分记录</option>
<option value="-3" <%=type==-3?"selected":"" %>>最近三个月积分记录</option>
</select>
</form>
</div>
</li>
</ul>

</div>
<div class='radiusBox newlist wSpan'>

<%
ArrayList list= ShopMyPoints.find(sql.toString(), pos, 20);
if(list.size()==0){
	out.print("<ul><li class='noncont'>暂无记录</li></ul>");
}else{
	for(int i=0;i<list.size();i++){
		ShopMyPoints smp=(ShopMyPoints)list.get(i);
	
%><ul>
<li><span>积分日期：</span><%=MT.f(smp.getCreateTime(),1) %></li>
<li><span>积分：</span><dfn><%=smp.getIntegral() %></dfn></li>
<li><span>积分说明：</span><%=smp.content %></li>
</ul><%
}
if(sum>20)out.print("<li class='pages'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>

</div>
</body>
</html>