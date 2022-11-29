 <%@page import="util.Config"%>
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

<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
 <link rel="stylesheet" href="/tea/new/css/style.css">
 <script src="/tea/new/js/jquery.min.js"></script>
 <script src="/tea/new/js/superslide.2.1.js"></script>
 <script src="/tea/yl/mtDiag.js"></script>
 <style>
	 .con-left .bd:nth-child(2){
		 display:block;
	 }
	 .con-left .bd:nth-child(2) li:nth-child(4){
		 font-weight: bold;
	 }
	 .tab1 td,.tab1 th{
		 text-align:left;
		 padding:0px 10px;
	 }
	.con-left-list .tit-on1{color:#044694;}

 </style>
</head>
<body>

<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
	<div class="con-left">
		<%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
	</div>
	<div class="con-right">

	<table class="right-tab tab1" border="1" cellspacing="0" style="margin:0px;">
		<tr>
			<td class="tdleft" width="80">回款编号</td>
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
			<td class="tdright"><%=rm.getReplyPrice() %></td>
		</tr>
		<%
	int bid = HangWith.findbid(replyid);
	float deductprice = HangWith.findDeductPriceBid(bid);
	if(Config.getInt("gaoke")==rm.getPuid()&&rm.getType()==1){//高科 挂款 
		if(deductprice>0){
			%>
			<tr>
					<td class="tdleft" nowrap="">调整挂款金额</td>
					<td class="tdright"><%= deductprice %></td>
				</tr>	
				<%
		}
	}
	%>
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
		<div class='center text-c pd20'>
			<button class="btn btn-default" type="button" onclick="history.go(-1)">返回</button>
		</div>
	</div>
</div>
<script>

mt.fit();
</script>
</body>
</html>
