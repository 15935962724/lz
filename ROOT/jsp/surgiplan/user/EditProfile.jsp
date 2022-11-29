<%@page import="tea.entity.yl.shop.ShopQualification"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %><%@page import="tea.entity.*"%>
<%@page import="tea.entity.node.*"%>
<% request.setCharacterEncoding("UTF-8");

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
if(h.isIllegal())
{
  response.sendError(404,request.getRequestURI());
  return;
}

Resource res=new Resource().add("/tea/resource/deptuser");

int member = h.getInt("member",0);

Profile p=Profile.find(member);


%>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/jquery.js" type="text/javascript"></script>
<style>
#tablecenter td table td{border:0}
</style>
</head>
<body>
<h1>添加/编辑——用户管理</h1>


<form name="form1" method="post" action="/Members.do" target="_ajax" onSubmit="return checksubmit(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="<%= (member==0?"yladd":"upyl")%>"/>
<input type="hidden" name="member" value="<%= member %>" />
<input type="hidden" name="nexturl" value="<%=MT.f(h.get("nexturl"))%>">
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='2' class='bornone'>&nbsp;</td></tr>
</thead>
<tr>
	<td width=105 align='right'>用户名：</td>
	<td class='bornone'>
		<%
			if(member>0){
				%>
				<%= p.member %>
				<%
			}else{
				%>
				<input name="username" alt="用户名"  />
				<%
			}
		%>
	</td>
  </tr>
  <tr>
	<td align='right'>密码：</td>
	<td class='bornone'><input name="password" type="password" alt="密码" value="<%= MT.f(p.password) %>"  /></td>
  </tr>
  <tr>
	<td align='right'>手机 ：</td>
	<td class='bornone'><input name="mob" id="mob" value="<%= MT.f(p.mobile) %>" /></td>
  </tr>
  <tr>
	<td align='right'>电子邮箱：</td>	
	<td class='bornone'><input name="email" id="email" value="<%= MT.f(p.email) %>"  /></td>
  </tr>
  	<tr>
		<td align='right'>用户类型：</td>
		<td class='bornone'>
			  <select name="membertype" onchange="hideshow(this.value)"> 
  	<%
  	int memebertype = p.membertype;
  		for(int i=0;i<Profile.MEMBER_TYPE.length;i++){
  			out.print("<option "+(i==memebertype?"selected='selected'":"")+" value='"+i+"'>"+Profile.MEMBER_TYPE[i]+"</option>");
  		}
  	%>
  </select>
		</td>
	</tr>
	<%
	ShopQualification sq = ShopQualification.findByMember(p.profile);
	
	ShopHospital shp=ShopHospital.find(sq.hospital_id);
	%>
  <tr class="show" <%= (p.membertype==2?"style='display: none;'":"") %> >
		<td align='right'>所属医院：</td>
		<td class='bornone'>
		<input type="hidden" name="hospital" value="<%=sq.hospital_id%>"/><input type="text" name="hospitals" readonly value="<%=MT.f(shp.getName())%>"/>
		<%-- <%
	List<ShopHospital> shlist = ShopHospital.find("", 0, Integer.MAX_VALUE);
		int shid = sq.hospital_id;
		int dpid = sq.department;
		%>
		<SELECT name="hospital" id="hospital" alt="医院" >
		<option value="-1">--请选择--</option>
			<%
				for(int i=0;i<shlist.size();i++){
					ShopHospital sh = shlist.get(i);
					out.print("<option "+(sh.getId()==shid?"selected='selected'":"")+" value='"+sh.getId()+"'>"+sh.getName()+"</option>");
				}
			%>
		</SELECT> --%>
		<button type="button" class="btn btn-primary btn-xs" onclick="showhospitalsearch()">选择医院</button>
		</td>
	</tr>
  <tr class="show" <%= (p.membertype==2?"style='display: none;'":"") %> >
		<td align='right'>
		科室：
		</td>
		<td class='bornone'>
			<select name="department">
				<option value="-1">--请选择--</option>
				<%
					for(int i=1;i<ShopQualification.DEPARTMENT_ARR.length;i++){
						out.print("<option "+(i==sq.department?"selected='selected'":"")+" value='"+i+"'>"+ShopQualification.DEPARTMENT_ARR[i]+"</option>");
					}
				%>
			</select>
		</td>
	</tr>
		<tr id="type1" class="show" <%= (p.membertype==2?"style='display: none;'":"") %> >
    <td align='right'>有效期：</td>
    <td class='bornone'><input name="validity" readonly  onClick="mt.date(this)" value="<%= MT.f(p.validity) %>"  class="date"/></td>
  </tr>
  <tr>
  	<td align='right'>不付费可发货：</td>
  	<td class='bornone'>
  		<input type="checkbox" <%= (Integer.parseInt(MT.f(p.isvip,0))==0?"":"checked='checked'") %> value="1" name="isvip" />
  		<%= MT.red("注：此选项为用户购买商品不支付，订单管理中对其下的订单进行发货处理。", "注：此选项为用户购买商品不支付，订单管理中对其下的订单进行发货处理。") %>
  	</td>
  </tr>
<%--   <tr class="show1" <%= (p.membertype!=2?"style='display: none;'":"") %> >
  	<td colspan="2">
  		代理医院 <input value="添加" class="btn btn-primary" type="button" onclick="showhospitalsearch1()" />
  		<table id="mytab"  cellspacing="0" style="background:none;">
  			<tr id="tableonetr" >
  				<td>名称</td>
  				<td>操作</td>
  			</tr>
  			<%
				String [] sarr = p.hospitals.split("\\|");
				if(sarr.length>1){
					for(int i=1;i<sarr.length;i++){
						ShopHospital s1 = ShopHospital.find(Integer.parseInt(sarr[i]));
						out.print("<tr name='mtr' ><td><input type='hidden' name='myproduct' value='"+s1.getId()+"' />"+s1.getName()+"</td><td><a href='javascript:void(0);' onclick='mt.deltr(this)'>删除</a></td></tr>");
					}
				}else{
					out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
				}
				%>
  		</table>
  	</td>
  </tr> --%>
  </table>
</div>
<div class="center mt15">
<input type="submit" class="btn btn-primary" value="提交">
<input type="button" class="btn btn-default" value="返回" onClick="location='<%= h.get("nexturl") %>';"/>
</div>
</form>
<script type="text/javascript">
function showhospitalsearch(){
	mt.show("/jsp/yl/shop/HospitalSearch.jsp?inpname=hospital",2,"查询医院",700,500);
}
mt.receive=function(h,n){
	//$("#"+n).val(h);
	//fchange(h,n);
	form1.hospital.value=h;
	form1.hospitals.value=n;
}



function showhospitalsearch1(){
	var str = "(0";
	if($("#mytab tr[name='mtr']").length>0){
		$("#mytab input[name='myproduct']").each(function(){
			str += ","+ this.value ;
		});
	}
	str+=")";
	mt.show("/jsp/yl/shop/HospitalSearch1.jsp?hos="+str,2,"查询医院",700,500);
}

mt.addtr = function(h,n){
	$("#mytab tr").each(function(){
		//alert(this.innerHTML);
	});
	if($("#mytab tr[name='mtr']").length==0){
		$("#mytab tr:eq(1)").remove();
	}
	var mtr = "<tr name='mtr'><td><input type='hidden' name='myproduct' value='"+h+"' />"+n+"</td><td><a href='javascript:void(0);' onclick='mt.deltr(this)'>删除</a></td></tr>";
	$("#mytab").append(mtr);
};

mt.deltr = function(obj){
	$(obj).parent().parent().remove();
	mt.addmes();
};

mt.addmes = function(){
	if($("#mytab tr[name='mtr']").length==0){
		$("#mytab").append("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
	}
};

function fchange(value,b)
{
  sendx("/jsp/admin/edn_ajax.jsp?act=selhosmember&hosid="+value,function(data){
	  $("#"+b).html(data.trim());
  });
}



function hideshow(v){
	if(v==2){
		$(".show").css({"display":"none"});
		//$(".show1").css({"display":""});
	}else{
		$(".show").css({"display":""});
		//$(".show1").css({"display":"none"});
	}
}
var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
var reg2=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
function checksubmit(obj){
	if(mt.check(obj)){
		var mob = form1.mob.value;
		if(mob.length>0&&!reg.test(mob)){
			mt.show("手机格式不正确");
			form1.mob.focus();
			return false;
		}
		var email = form1.email.value;
		if(email.length>0&&!reg2.test(email)){
			mt.show("邮箱格式不正确");
			form1.email.focus();
			return false;
		}
		if(mob.length==0&&email.length==0){
			mt.show("手机或者邮箱必须填一个");
			form1.mob.focus();
			return false;
		}
	}else{
		return false;
	}
}
</script>
</body>
</html>
