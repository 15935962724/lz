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

int menu=h.getInt("id");
par.append("?community="+h.community+"&id="+menu);

String username = MT.f(h.get("member"),"");
if(username.length()>0){
	sql.append(" AND sm.member = "+username);
	par.append("&username"+username);
}

int pos=h.getInt("pos");
par.append("&pos=");


int sum=ShopMyPoints.count(sql.toString());
%>
<!DOCTYPE html><html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 --><title>我的积分</title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
</head>
<body>
<h1>积分查询 </h1>
<form name="form1" action="?">
<input type="hidden" name="id" value="<%= menu %>" >
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='2' class='bornone'>查询</td></tr>
</thead>
<tr>
<td>
用户名：
<input id="member1" name="member1" value="<%= MT.f(h.get("member1")) %>"  readonly="readonly" />
<input id="member" type="hidden" name="member" value="<%= MT.f(h.get("member")) %>" />
<input type="button" class="btn btn-primary" value="选择用户"  onclick="showmembersearch()" />
</td>
  <td class='bornone'><input type="submit" class="btn btn-primary" value="查询"/></td>
</tr>
</table>
</div>
</form>
<div class="radiusBox mt15">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='8'>列表 <%=sum%></td></tr>
</thead>
<tr>
<th>序号</th>
<th>用户名</th>
<th>积分日期</th>
<th>积分</th>
<th>积分说明</th>
</tr>
<%
ArrayList list= ShopMyPoints.find(sql.toString()+" order by createtime desc  ", pos, 20);
if(sum<1){
	out.print("<tr><td colspan='10' class='noCont'>暂无记录</td></tr>");
}else{
	for(int i=0;i<list.size();i++){
		ShopMyPoints smp=(ShopMyPoints)list.get(i);
	
%>
<tr>
<td><%= (i+1)+pos %></td>
<td><%= MT.f(Profile.find(smp.getMember()).member) %></td>
<td><%=MT.f(smp.getCreateTime(),1) %></td>
<td><%=smp.getIntegral() %></td>
<td><%=smp.content %></td>
</tr>
<%
}
	if(sum>20)out.println("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table>
</div>
<script>
function showmembersearch(){
	mt.show("/jsp/yl/shop/MemberSearch1.jsp?inpname=member",2,"查询用户",500,300);
}
mt.receive1=function(h,n){
	$("#"+n).val(h);
}
mt.fit();
</script>
</body>
</html>