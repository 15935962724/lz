<%@page import="tea.entity.MT"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.trust.TrustProduct"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Http h = new Http(request);
	int pos = h.getInt("pos", 0);
	int size = 10;
	StringBuffer sql = new StringBuffer();
	StringBuffer par = new StringBuffer();
    par.append("?pos=");
	sql.append(" AND n.hidden=0 AND n.finished=1 AND n.type=110 and tp.deleted=0 and companyNode="
			+ h.node);
	int count =TrustProduct.count(sql.toString());
%>
<table class="tab1">
	<tr>
		<th class="th1">产品名称</th>
		<th>发行时间</th>
		<th>投资门槛(万元)</th>
		<th>预期年化收益</th>
		<th>状态</th>
	</tr>
<%
if(count==0){
	out.print("<tr><td colspan='5'>暂无记录！</td></tr>");
}else{
		ArrayList list = TrustProduct.find(sql.toString(), pos, size);
		for (int i = 0; i < list.size(); i++) {
			TrustProduct t = (TrustProduct) list.get(i);
%>

	<tr>
		<td class="td1"><a href="/html/<%=h.community%>/trustproduct/<%=t.node%>-1.htm"><%=MT.f(t.name) %></a></td>
		<td><%=MT.f(t.releaseTime) %></td>
		<td><%=MT.f(t.threshold) %></td>
		<td class="td2"><%=t.income1+"%至"+t.income2+"%" %></td>
		<td><%=MT.f(TrustProduct.STATE[t.state]) %></td>
	</tr>

<%
	}
		if(count>size)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),pos,count,size));
}
%>
</table>