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
int pos=h.getInt("pos");
par.append("&pos=");
int sum=ShopMyPoints.count(sql.toString());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的积分</title>

<script src="/tea/mt.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
    .con-left-list .tit-on4{color:#044694;}

</style>
</head>
<body style='min-height:800px'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">
		<div class="con-right-box" style="height:60px;">
			<div class="right-line1">
				<p style="float:left;margin-right:20px;">
					<span>您的当前积分：<em><%=Profile.find(h.member).getIntegral() %></em></span>
				</p>
				<form name="form1" action="?" method="post" style="float:left;">
					<select name="type" onchange="form1.submit()" class="right-box-yy">
						<option value="1" <%=type==1?"selected":"" %>>全部</option>
						<option value="-1" <%=type==-1?"selected":"" %>>最近一个月积分记录</option>
						<option value="-3" <%=type==-3?"selected":"" %>>最近三个月积分记录</option>
					</select>
				</form>
			</div>
		</div>


<div class="results">
<table class="right-tab3" border="1" cellspacing="0">
<tr id='tableonetr'>
<th>积分日期</th>
<th>积分</th>
<th>积分说明</th>
</tr>
<%
sql.append(" order by createTime desc");
ArrayList list= ShopMyPoints.find(sql.toString(), pos, 20);
if(list.size()==0){
	out.print("<tr><td colspan='10'>暂无记录</td></tr>");
}else{
	for(int i=0;i<list.size();i++){
		ShopMyPoints smp=(ShopMyPoints)list.get(i);
	
%>
<tr>
<td><%=MT.f(smp.getCreateTime(),1) %></td>
<td><%=smp.getIntegral() %></td>
<td><%=smp.content %></td>
</tr>
<%
}
if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table></div>
	</div>
</div>
<script>
mt.fit();
</script>
</body>
</html>