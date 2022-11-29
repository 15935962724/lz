<%@page import="java.util.Date"%>
<%@page import="tea.entity.member.Profile"%>
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
Profile p = Profile.find(sq.member);
int type = h.getInt("type");
String nexturl = h.get("nexturl");
%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src='/tea/mt.js'></script>
<script src='/tea/city.js'></script>
<script src='/tea/jquery-1.3.1.min.js'></script>
<body>
<div <%= (type==1?"style='display: none;'":"") %>>
	<form action="/ShopQualifications.do" name="form2" method="post" target="_ajax" onSubmit="return mt.check(this)" >
	<table id="tablecenter" cellspacing="0" style="background:none;">
	<tr>
		<td>审核状态：</td>
		<td><input name="type" checked="checked" value="1" type="radio" onclick="showtype(1)">通过
		<input name="type" value="0" type="radio" onclick="showtype(0)">不通过</td>
	</tr>
	<tr id="type0" style="display: none;">
		<td>不通过原因：</td>
		<td>
			<textarea name="returnv" alt="不通过原因" rows="" cols=""></textarea>
		</td>
	</tr>
	<tr id="type1">
    <td>有效期：</td>
    <td><input name="validity" readonly alt="有效期" value="" onClick="mt.date(this,false,'<%=new Date() %>')" class="date"/></td>
  </tr>
  <tr>
  	<td colspan="2">
  		<input type="submit" value="提交" class="btn btn-primary"/>
  	</td>
  </tr>
</table>
	<input name="qid" type="hidden" value="<%= qid %>" />
	<input name="act" type="hidden" value="updatetype" />
	<input name="nexturl" type="hidden" value="<%= nexturl %>" />
</form>
</div>
<div <%= (type==0?"style='display: none;'":"") %>>
	<form action="/ShopQualifications.do" name="form2" method="post" target="_ajax" onSubmit="return mt.check(this)" >
	<div class="radiusBox mt15">
<table cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='8'>列表</td></tr>
</thead>
<tr>
		    <td>有效期：</td>
		    <td><input alt="有效期" name="validity" readonly value="<%=MT.f(p.validity)%>" onClick="mt.date(this,false,'<%=new Date() %>')" class="date"/></td>
  		</tr>
  		<tr>
  			<td colspan="2">
  			<input value="提交" class="btn btn-primary" type="submit" />
  			<input value="返回" class="btn btn-primary" type="button" onclick="history.back()" />
  			</td>
  		</tr>
  	</table>
	</div>
<div class='mt15'>
  	<input name="qid" type="hidden" value="<%= qid %>" />
	<input name="act" type="hidden" value="updatetime" />
	<input name="nexturl" type="hidden" value="<%= nexturl %>" /></div>
	</form>
</div>
</body>
<script type="text/javascript">
/* 	function downatt(num){
		form2.attch.value = num;
		form2.submit();
	} */
	function showtype(num){
		if(num==1){
			$("#type0").hide();
			$("#type1").show();
		}else{
			$("#type0").show();
			$("#type1").hide();
		}
	}
</script>
</html>