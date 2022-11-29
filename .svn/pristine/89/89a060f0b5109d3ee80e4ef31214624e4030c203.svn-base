<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}






%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
<!-- <script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery.js'></script> -->
</head>
<body >

<form id='form1' name="form1" action="/ShopOrders.do" method="post" target="_ajax" >
<input name='nexturl' type="hidden" value="/jsp/yl/shop/ShopHospitals.jsp" />
	<input name="act" value="exp_yiyuan" type="hidden"/>
<table id="tablecenter">
	<tr><td><select name="exp_type">
		<option value="3">全部</option>
		<option value="0">高科</option>
		<option value="1">欣科</option>
		<option value="2">君安</option>
	</select></td></tr>
	<tr><td colspan="2"><button class="btn btn-primary" type="submit" >提交</button></td></tr>
</table>

</form>

<script type="text/javascript">
</script>
</body>
</html>
