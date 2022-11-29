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
<div id="head6"><img height="6" src="about:blank"></div>


<form name="form1" method="post" action="/Members.do" target="_ajax" onSubmit="return checksubmit(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="<%= (member==0?"yladd":"upyl")%>"/>
<input type="hidden" name="member" value="<%= member %>" />
<input type="hidden" name="nexturl" value="<%=MT.f(h.get("nexturl"))%>">
<table cellSpacing="0" cellPadding="0" border="0" id="tablecenter">
  <tr>
	<td>用户名：</td>
	<td>
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
	<td>密码：</td>
	<td><input name="password" type="password" alt="密码" value="<%= MT.f(p.password) %>"  /></td>
  </tr>
  <tr>
	<td>手机 ：</td>
	<td><input name="mob" id="mob" value="<%= MT.f(p.mobile) %>" /></td>
  </tr>
  <tr>
	<td>电子邮箱：</td>	
	<td><input name="email" id="email" value="<%= MT.f(p.email) %>"  /></td>
  </tr>
  	<tr>
		<td>用户类型：</td>
		<td>
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
	ShopQualification sq = ShopQualification.findByMember(member);
	ShopHospital shp=ShopHospital.find(sq.hospital_id);
	%>
  <tr class="show" <%= (p.membertype==2?"style='display: none;'":"") %> >
		<td>所属医院：</td>
		<td>
		<input type="hidden" name="hospital" value="<%=sq.hospital_id%>"/><input type="text" name="hospitals" readonly="readonly" value="<%=MT.f(shp.getName())%>"/>
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
		<input type="button" class="btn btn-primary" value="选择医院" onclick="showhospitalsearch()" />
		</td>
	</tr>
  <tr class="show" <%= (p.membertype==2?"style='display: none;'":"") %> >
		<td>
		科室：
		</td>
		<td>
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
    <td>有效期：</td>
    <td><input name="validity" readonly  onClick="mt.date(this)" value="<%= MT.f(p.validity) %>"  class="date"/></td>
  </tr>
  <tr>
  	<td>不付费可发货：</td>
  	<td>
  		<input type="checkbox" <%= (Integer.parseInt(MT.f(p.isvip,0))==0?"":"checked='checked'") %> value="1" name="isvip" />
  	</td>
  </tr>
  </table>

<input type="submit" class="btn btn-primary" value="提交">
<input type="button" class="btn btn-default" value="返回" onClick="history.back()"/>
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
function fchange(value,b)
{
  sendx("/jsp/admin/edn_ajax.jsp?act=selhosmember&hosid="+value,function(data){
	  $("#"+b).html(data.trim());
  });
}
function hideshow(v){
	if(v==2){
		$(".show").css({"display":"none"});
	}else{
		$(".show").css({"display":""});
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
