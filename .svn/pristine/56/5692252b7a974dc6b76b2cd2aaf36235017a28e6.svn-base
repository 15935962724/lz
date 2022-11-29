<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.pm.Transactions" %>
<%@ page import="java.util.Date" %>
<%@ page import="tea.entity.Entity" %>

<%
	Http h=new Http(request); 
	if(h.member<1)
	{
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
	}
	
	
	String key=h.get("tid")==null?"":h.get("tid");
	int tid = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
	
	String varieties="",direction="",content="";
	Date ttime=new Date();
	int quantity=0;
	float tmoney=0f;
	if(tid>0){
		Transactions t=Transactions.find(tid);
		varieties=t.getVarieties();
		direction=t.getDirection();
		content=t.getContent();
		ttime=t.getTtime();
		quantity=t.getQuantity();
		tmoney=t.getTmoney();
	}
	


%>
<html>
<head>
<title>查看交易信息</title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/script/md5.js" type="text/javascript"></script>
<style>
#tablecenter td table td{border:0}

.date {
background-image: url(/tea/image/date.gif);
background-repeat: no-repeat;
background-position: right;
/* width: 100px; */
cursor: pointer;
}
</style>

</head>
<body>
<h1>查看交易信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
	<tr >
		<td class="th01">交易品种:</td>
		<td><%=varieties%></td>
	</tr>
	<tr >
		<td class="th01">交易方向:</td>
		<td><%=direction%></td>
	</tr>
	<tr >
		<td class="th01">成交数量:</td>
		<td><%=quantity%></td>
	</tr>
	<tr >
		<td class="th01">成交金额:</td>
		<td><%=tmoney%></td>
	</tr>
	<tr >
		<td class="th01">交易时间:</td>
		<td><%=Entity.sdf2.format(ttime) %></td>
	</tr>
	<tr >
		<td class="th01">阐述理由:</td>
		<td><%=content %></td>
	</tr>
</table>
<div align="center"><input type="button" onClick="window.history.back();" value="返回"/></div>
</body>
</html>