<%@page import="java.util.List"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.yl.shop.ShopQualification"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<%
Http h=new Http(request,response);
/* int qid = h.getInt("qid");
ShopQualification sq = ShopQualification.find(qid); */
String nexturl = h.get("nexturl");
%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src='/tea/mt.js'></script>
<script src='/tea/tea.js'></script>
<script src='/tea/city.js'></script>
<script src='/tea/jquery-1.3.1.min.js'></script>
<body>
<h1>资质审核</h1>
<form action="/ShopQualifications.do" name="form2" method="post" target="_ajax" onSubmit="return mt.check(this)" >
<div class='radiusBox'>
<table cellspacing="0" class='newTable' id='tdbor'>
<tr>
		<td class='topBorNone'>真实姓名：</td>
		<td class='topBorNone'><input name="name"  alt="真实姓名" /></td>
	</tr>
	<tr>
		<td>用户：</td>
		<td><input id="member1"  readonly="readonly" alt="用户" />&nbsp;<input id="member" type="hidden" name="member" />
		<input type="button" class="btn btn-primary btn-xs" value="查询" onclick="showmembersearch()" /></td>
	</tr>
	<tr id="type1">
    <td>有效期：</td>
    <td><input name="validity" readonly value="" onClick="mt.date(this)" alt="有效期" class="date"/></td>
  </tr>
  <tr>
		<td>所属医院：</td>
		<td>
		<input type="hidden" name="hospital" value=""/><input type="text" name="hospitals" readonly="readonly" value=""/>
		
		<%-- <%
	   List<ShopHospital> shlist = ShopHospital.find("", 0, 500);
		%>
		<SELECT name="hospital" id="hospital" alt="医院" >
		<option value="-1">--请选择--</option>
			<%
				for(int i=0;i<shlist.size();i++){
					ShopHospital sh = shlist.get(i);
					out.print("<option value='"+sh.getId()+"'>"+sh.getName()+"</option>");
				}
			%>
		</SELECT> --%>
		<input type="button" value="选择医院" class="btn btn-primary btn-xs" onclick="showhospitalsearch()" />
		
		</td>
	</tr>
	<tr>
		<td>
		科室：
		</td>
		<td>
			<select name="department">
				<option value="-1">--请选择--</option>
				<%
					for(int i=1;i<ShopQualification.DEPARTMENT_ARR.length;i++){
						out.print("<option value='"+i+"'>"+ShopQualification.DEPARTMENT_ARR[i]+"</option>");
					}
				%>
			</select>
		</td>
	</tr>

</table>
	<input name="act" type="hidden" value="addmember" />
	<input name="nexturl" type="hidden" value="<%= nexturl %>" />
 </div> <div class='mt15'>
  		<input type="submit" value="提交" class="btn btn-primary"/> <input type="button" value="返回" class="btn btn-default" onclick="history.back();"/>
  	</div>

</form>
</body>
<script type="text/javascript">
function showmembersearch(){
	mt.show("/jsp/yl/shop/MemberSearch.jsp?inpname=member",2,"查询用户",500,300);
}
function showhospitalsearch(){
	mt.show("/jsp/yl/shop/HospitalSearch.jsp?inpname=hospital",2,"查询医院",700,500);
}
mt.receive1=function(h,n){
	$("#"+n).val(h);
}
mt.receive=function(h,n){
	//$("#"+n).val(h);
	//fchange(h,n);
	form2.hospital.value=h;
	form2.hospitals.value=n;
}
function fchange(value,b)
{
  sendx("/jsp/admin/edn_ajax.jsp?act=selhosmember&hosid="+value,function(data){
	  $("#"+b).html(data.trim());
  });
}
</script>
</html>