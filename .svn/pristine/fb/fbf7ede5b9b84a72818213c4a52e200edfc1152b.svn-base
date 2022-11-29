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
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
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
</style>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=0">
<title>回款信息</title>
</head>
<body>

<div class="body">
	<div class="detail-list">

		<p class="detail-tit ft16">回款信息</p>
		<ul class="ft14">
			<li>
				<span class="list-spanr3 fl-left">回款编号：</span>
				<span class="list-spanr fl-left"><%=MT.f(rm.getCode()) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">回款编号：</span>
				<span class="list-spanr fl-left"><%=MT.f(rm.getCode()) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">回款编号：</span>
				<span class="list-spanr fl-left"><%=MT.f(rm.getCode()) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">类型：</span>
				<span class="list-spanr fl-left"><%=ReplyMoney.typeARR[rm.getType()] %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">回款单位：</span>
				<%
					ShopHospital hospital=ShopHospital.find(rm.getHid());
				%>
				<span class="list-spanr fl-left"><%=MT.f(hospital.getName()) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">回款金额：</span>
				<span class="list-spanr fl-left"><%=rm.getReplyPrice() %></span>
			</li>
			<%
				int bid = HangWith.findbid(replyid);
				float deductprice = HangWith.findDeductPriceBid(bid);
				if(Config.getInt("gaoke")==rm.getPuid()&&rm.getType()==1){//高科 挂款
					if(deductprice>0){
			%>
			<li>
				<span class="list-spanr3 fl-left">调整挂款金额：</span>
				<span class="list-spanr fl-left"><%= deductprice %></span>
			</li>
			<%
					}
				}
			%>
			<li>
				<span class="list-spanr3 fl-left">回款时间：</span>
				<span class="list-spanr fl-left"><%=MT.f(rm.getReplyTime()) %></span>
			</li>
			<li>
				<span class="list-spanr3 fl-left">状态：</span>
				<span class="list-spanr fl-left"><%=ReplyMoney.statusmemberARR[rm.getStatusmember()] %></span>
			</li>

		</ul>

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
