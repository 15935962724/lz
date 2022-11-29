 <%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shopnew.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int replyid = h.getInt("replyid");
ReplyMoney rm=ReplyMoney.find(replyid);
String nexturl=h.get("nexturl");
%><!DOCTYPE html><html><head>
  
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

 <link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<link href="webcss.css" rel="stylesheet" type="text/css">


<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<title>回款详情</title>

</head>
<body>
<header class="header">回款详情</header>
	<table id="tableweb" cellspacing="0">
		<tr>
			<td class="tdleft">回款编号</td>
			<td class="tdright"><%=MT.f(rm.getCode()) %></td>
		</tr>
		<tr>
			<td class="tdleft">类型</td>
			<td class="tdright"><%=ReplyMoney.typeARR[rm.getType()] %></td>
		</tr>
		<tr>
			<td class="tdleft">回款单位</td>
			<%
				ShopHospital hospital=ShopHospital.find(rm.getHid());
			%>
			<td class="tdright"><%=MT.f(hospital.getName()) %></td>
		</tr>
		<tr>
			<td class="tdleft">回款金额</td>
			<td class="tdright"><%=ShopHospital.getDecimal((double)rm.getReplyPrice()) %></td>
		</tr>
		<tr>
			<td class="tdleft">回款时间</td>
			<td class="tdright"><%=MT.f(rm.getReplyTime()) %></td>
		</tr>
		<tr>
			<td class="tdleft">状态</td>
			<td class="tdright"><%=ReplyMoney.statusmemberARR[rm.getStatusmember()] %></td>
		</tr>
		
	</table>
	
<br>
<div class="btnbottom">
<button class="btn btn-default" type="button" onclick="history.back(-1)">返回</button>
</div>
<script>

mt.fit();
</script>
</body>
</html>
