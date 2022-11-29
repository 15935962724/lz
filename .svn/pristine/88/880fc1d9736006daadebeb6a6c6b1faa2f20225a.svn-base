<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.yl.shop.ShopQualification"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<%
Http h=new Http(request,response);
int qid = h.getInt("qid");
ShopQualification sq = ShopQualification.find(qid);
%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src='/tea/mt.js'></script>
<script src='/tea/city.js'></script>
<body>
<div class="radiusBox">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='8'>列表</td></tr>
</thead>
<tr>
		<td>姓名：</td>
		<td><%= MT.f(sq.realname) %></td>
	</tr>
	<tr>
		<td>所属医院：</td>
		<td>
			<%=
				MT.f(ShopHospital.find(sq.hospital_id).getName())
			%>
		</td>
	</tr>
	<tr>
		<td>
		科室：
		</td>
		<td>
			<%=
				MT.f(ShopQualification.DEPARTMENT_ARR[sq.department])
			%>
		</td>
	</tr>
	  <tr>
    <td>城市：</td>
    <td><script>mt.city(<%= sq.area%>)</script></td>
  </tr>
  <tr>
  	<td>详细地址：</td>
  	<td><%= MT.f(sq.address) %></td>
  </tr>
  <tr>
  	<td>手机：</td>
  	<td><%= MT.f(sq.mobile) %></td>
  </tr>
  <tr>
  	<td>固定电话：</td>
  	<td><%= MT.f(sq.telphone) %></td>
  </tr>
  <tr>
  	<td>资质证明：</td>
  	<td>
  	<%
  		if(sq.qualification>0){
  			%>
  			<a href='javascript:void(0);' onclick="downatt('<%= MT.enc(sq.qualification) %>');">下载</a>
  			<%
  		}else{
  			%>
  			无
  			<%
  		}
  	%>
  </td>
  </tr>
</table>
</div>
<div class='mt15'>
<form action="/Attchs.do" name="form2" method="post" target="_ajax">
	<input name="act" type="hidden" value="down" />
	<input name="attch" type="hidden" /></div>
</form>
</body>
<script type="text/javascript">
	function downatt(num){
		form2.attch.value = num;
		form2.submit();
	}
</script>
</html>