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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的积分</title>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<div class='query'>
<table id='tablecenter' width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align='left' nowrap>您的当前积分：<em><%=Profile.find(h.member).getIntegral() %></em>
</td>
<td align='left'><form name="form1" action="?" method="post">
<select name="type" onchange="form1.submit()">
<option value="1" <%=type==1?"selected":"" %>>全部</option>
<option value="-1" <%=type==-1?"selected":"" %>>最近一个月积分记录</option>
<option value="-3" <%=type==-3?"selected":"" %>>最近三个月积分记录</option>
</select>
</form></td>
  </tr>
</table>

</div>
<div class="results">
<table id='tablecenter'>
<tr id='tableonetr'>
<td>积分日期</td>
<td>积分</td>
<td>积分说明</td>
</tr>
<%
ArrayList list= ShopMyPoints.find(sql.toString(), pos, 20);
if(list.size()==0){
	out.print("<tr><td colspan='10'>暂无记录</td></tr>");
}else{
	for(int i=0;i<list.size();i++){
		ShopMyPoints smp=(ShopMyPoints)list.get(i);
	
%>
<tr>
<td><%=MT.f(smp.getCreateTime(),1) %></td>
<td style="color:#00A1E7;"><%=smp.getIntegral() %></td>
<td style="text-align:left;"><%=smp.content %></td>
</tr>
<%
}
if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}
%>
</table></div>
<script>
mt.fit();
</script>
</body>
</html>