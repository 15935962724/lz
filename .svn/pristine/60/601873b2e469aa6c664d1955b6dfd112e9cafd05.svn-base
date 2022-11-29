<%@page import="util.Config"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.member.Profile"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int ids = h.getInt("ids");

//根据订单id查询订单信息
TpsOrder tpsOrder = TpsOrder.find(ids);


%><!DOCTYPE html><html><head>


<!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
 --><script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/jquery-1.11.1.min.js"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
	.con-left .bd:nth-child(2){
		display:block;
	}
	.con-left .bd:nth-child(2) li:nth-child(1){
		font-weight: bold;
	}
	.right-tab td,.right-tab th{
		padding:0px 10px;
		text-align:left;
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
<table class="right-tab" border="1" cellspacing="0" style="margin:0px;">
<tr style="font-weight:bold;"><td colspan="4" align='left' style="font-size:15px;">订单信息</td></tr>
<tr>
	<td width="10%" align='right'>订单编号</td><td align='left'><%=MT.f(tpsOrder.getOrder_id()) %></td>
	<td align='right'>下单时间</td><td align='left'><%=MT.f(tpsOrder.getCreatetime(),1) %></td>
</tr>
<tr>
	<td width="10%" align='right'>当前状态</td><td align='left'><%=tpsOrder.getStatus()==1?"已下单":tpsOrder.getStatus()==2?"已推送":"已获取" %></td>
	<td width="10%" align='right'>支付方式</td><td align='left'>抵扣</td>
</tr>
    <tr>
        <td nowrap align='right'>医院名称</td><td align='left'><%=MT.f(ShopHospital.find(tpsOrder.getHospital_id()).getName())%></td>
        <td nowrap align='right'>收货人姓名</td><td align='left'><%=MT.f(Profile.find(tpsOrder.getConsignees_id()).member)%></td>
    </tr>
<tr>
	<td nowrap align='right'>邮箱号</td><td align='left'><%=MT.f(tpsOrder.getEmail())%></td>
    <td nowrap align='right'>类别</td><td align='left'><%=MT.f(tpsOrder.getXdms())%></td>
</tr>
    <tr>
        <td nowrap align='right'>规格</td><td align='left'><%=MT.f(tpsOrder.getHpcs())%></td>
        <td nowrap align='right'></td><td align='left'></td>
    </tr>
    <tr>
        <td nowrap align='right'>机器码</td><td align='left'><%=MT.f(tpsOrder.getJqm())%></td>
        <td nowrap align='right'>机器码提交时间</td><td align='left'><%=MT.f(tpsOrder.getJqmtime(),1)%></td>
    </tr>
    <tr>
        <td nowrap align='right'>激活码</td><td align='left'><%=MT.f(tpsOrder.getJhm())%></td>
        <td nowrap align='right'>激活码获取时间</td><td align='left'><%=MT.f(tpsOrder.getGetjhmtime(),1)%></td>
    </tr>
</table>
<style>
	.tab1 td,.tab1 th{
		text-align:center;
	}
</style>

	</div>
</div>
<script>
form2.nexturl.value=location.pathname+location.search;
mt.act=function(a,oid,did)
{
  if(a=='refund')
  {
	  location.href="/jsp/yl/shopweb/ShopExchangedAdd.jsp?oid="+oid+"&did="+did;
  }
};

function printView(orderId){
	 window.open("/html/folder/14110866-1.htm?orderId="+orderId);
};
mt.fit();
</script>
</body>
</html>
