<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.Http" %>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.resource.Resource" %>
<%@page import="util.Config" %>
<%@page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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

	int parentid = h.getInt("parentpro");
%>
<html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
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
<input type="hidden" name="nexturl" value="">
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='2' class='bornone'>基础信息&nbsp;&nbsp;<input type="submit" class="btn btn-primary" value="保存">
<input type="button" class="btn btn-default" value="返回" onClick="location='/jsp/yl/user/DeptSeqs.jsp';"/></td></tr>
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
			  <select name="membertype" id='membertype' onchange="hideshow(this.value)"> 
  	<%
  	int memebertype = p.membertype;
  		for(int i=0;i<Profile.MEMBER_TYPE.length;i++){
  		    if(i==Profile.MEMBER_TYPE.length-1){
  		        continue;
			}
  			out.print("<option "+(i==memebertype?"selected='selected'":"")+" value='"+i+"'>"+Profile.MEMBER_TYPE[i]+"</option>");
  		}
  	%>
  </select>
		</td>
	</tr>
	<tr class='procurementUnitdiv'>
		<td align='right'>采购厂商：</td>
		<td class='bornone'>
  	<%
  		List<ProcurementUnit> prlist = ProcurementUnit.find(" AND deleted = 0  AND puid <> 0 ", 0, Integer.MAX_VALUE);
  		for(int i=0;i<prlist.size();i++){
  			ProcurementUnit pu = prlist.get(i);
  			out.print("<label><input name='procurementUnit' type='checkbox' "+(MT.f(p.procurementUnit,"").indexOf(""+pu.getPuid())>0?"checked='checked'":"")+" value='"+pu.getPuid()+"' />"+pu.getName()+"</label>");
  		}
  		//out.print(h.checks(Profile.procurementUnitARR, "procurementUnit", MT.f(p.procurementUnit,"")));
  	%>
		</td>
	</tr>
	<%
		int parentpro = p.parentpro;//父parent
		System.out.println(parentpro);
		ArrayList arrayList = Profile.find1(" AND profile=" + parentpro, 0, Integer.MAX_VALUE);
		String pro_name = "";
		if(arrayList.size()>0){
		    Profile profile1 = (Profile) arrayList.get(0);
		    pro_name = profile1.member;
		    %>
	<tr class="parentProfileDiv"  <%= (p.membertype==3?"":"style='display: none;'") %> >
		<td align='right'>所属服务商</td>
		<td class='bornone'>
			<input type="hidden" name="parentpro" value="<%=p.parentpro%>"/><input type="text" name="parentpros" readonly value="<%=pro_name%>"/>
			<button type="button" class="btn btn-primary btn-xs" onclick="showfuwushangsearch()">选择服务商</button>
		</td>
	</tr>
		<%}else {
	%>
	<tr class="parentProfileDiv"  <%= (p.membertype==3?"":"style='display: none;'") %> >
		<td align='right'>所属服务商</td>
		<td class='bornone'>
			<input type="hidden" name="parentpro" value="<%=p.parentpro%>"/><input type="text" name="parentpros" readonly value=""/>
			<button type="button" class="btn btn-primary btn-xs" onclick="showfuwushangsearch()">选择服务商</button>
		</td>
	</tr>
	<%}
	if(p.membertype==3){
	%>

	<tr >
		<td align='right'>服务商公司选择</td>
		<%
			List<ProcurementUnitJoin> pujlist1 =ProcurementUnitJoin.find(" AND profile = "+p.parentpro, 0, Integer.MAX_VALUE);
			int company_parent=0;
			if(p.procurementUnit!=null&&p.procurementUnit.length()>2){
			    company_parent = Integer.parseInt(p.procurementUnit.replaceAll("[|]",""));
			}
		%>
		<td><select name="company_parent">
			<%
				for (int i = 0; i <pujlist1.size() ; i++) {
					ProcurementUnitJoin puj = pujlist1.get(i);
					if(i==0){%>
			<option value="0">--请选择--</option>
					<%}
			%>
			<option value="<%=puj.jid%>" <%=company_parent==puj.jid?"selected":""%>><%=puj.getCompany()%></option>
			<%}%>
		</select></td>
	</tr>
	<%
		}

	ShopQualification sq = ShopQualification.findByMember(p.profile);
	
	ShopHospital shp=ShopHospital.find(sq.hospital_id);
	%>
  <tr class="show" <%= (p.membertype==1?"":"style='display: none;'") %> >
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
  <tr class="show" <%= (p.membertype==1?"":"style='display: none;'") %> >
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
		<tr id="type1" class="show" <%= (p.membertype==1?"":"style='display: none;'") %> >
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
  
  <tr>
  	<td>openid:</td>
  	<td><input name="openid" value="<%=MT.f(p.openid) %>" /></td>
  </tr>
    <tr>
        <td>当前登录昵称:</td>
        <%
            String nicheng = "";
            if(p.openid!=null&&!"".equals(p.openid)){
                List<SecurityCode> securityCodes = SecurityCode.find(" and pid=" + p.profile, 0, 1);
                if(securityCodes.size()!=0) {
                    String nicheng1 = securityCodes.get(0).getNicheng();
                    nicheng = nicheng1;
                }
            }%>
        <td><input disabled="disabled" name="nicheng" value="<%=MT.f(nicheng) %>" /></td>
    </tr>
  <tr>
  	<td>收货地址:</td>
  	<td><input name="address" value="<%=MT.f(p.address) %>" size="72px" />
  	<%= MT.red("注：该地址为，签收人所在医院的收货地址","注：该地址为，签收人所在医院的收货地址") %></td>
  </tr>
  <tr>
  	<td>服务商公司名称:</td>
  	<td><input name="company" value="<%=MT.f(p.company) %>" size="72px" /></td>
  </tr>
	<%if(p.hospital!=null&&!"".equals(p.hospital)){%>
	<tr>
		<td>签收人所属医院:</td>
		<%
			String hospital_id  = p.hospital;
            String[] split = hospital_id.split("[|]");
            for (int i = 0; i < split.length; i++) {
                if(split[i].equals("0")){
                    continue;
                }else {
                    hospital_id = split[i];
                }
            }
            ShopHospital shopHospital = ShopHospital.find(Integer.valueOf(hospital_id));
			if(shopHospital!=null){%>
		<td><input name="company" value="<%=MT.f(shopHospital.getName()) %>" size="72px" /></td>
		<%}%>
	</tr>
	<%}%>
  <%-- <tr>
  	<td>进项税返还政策：</td>
  	<td>
  		<select name="tax">
  			<option value="0">请选择</option>
  			<option value="1" 
  			<%
  				if(p.tax==1){
  					out.print("selected");
  				}
  				
  			%>
  			>返还增值税专用发票（6%）</option>
  			<option value="2"
  			<%
  				if(p.tax==2){
  					out.print("selected");
  				}
  			%>
  			>返还增值税专用发票（6%）抵扣部分的50%</option>
  			<option value="3"
  			<%
  				if(p.tax==3){
  					out.print("selected");
  				}
  			%>
  			>返还增值税专用发票（3%）</option>
  			<option value="4"
  			<%
  				if(p.tax==4){
  					out.print("selected");
  				}
  			%>
  			>返还增值税专用发票（3%）抵扣部分的50%</option>
  		</select>
  	</td>
  </tr> --%>
  <tr>
  	<td>进项税返还政策：</td>
  	<td>
  		<select name="tax">
  		<%
  			String[] taxarr=Profile.TAX;
  			for(int i=0;i<taxarr.length;i++){
  				String tax=taxarr[i];
  				if(tax==""){
  					tax="请选择";
  				}
  				String selected="";
  				if(p.tax==i){
  					selected="selected";
  				}
  			%>
  			<option <%=selected %> value="<%=i %>"><%=tax %></option>
  			<%
  			}
  		%>	
  		</select>
  	</td>
  </tr>
  <tr>
  	<td>服务费公式：</td>
  	<td>
  		<select name="formula">
  		<%
  			String[] formulaarr=Profile.FORMULA;
  			for(int i=0;i<formulaarr.length;i++){
  				String formula=formulaarr[i];
  				if(formula==""){
  					formula="请选择";
  				}
  				String selected="";
  				if(p.formula==i){
  					selected="selected";
  				}
				%>
				<option <%=selected %> value="<%=i %>"><%=formula %></option>
				<%
  			}
  		%>
  		</select>
  	</td>
  </tr>
  <tr>
  	<td>是否自营业务员（君安购买库存涉及功能）：</td>
  	<td>
  		<select name="issalesman">
  			<option value='0' <%= (p.issalesman==0?"selected='selected'":"") %>>否</option>
  			<option value='1' <%= (p.issalesman==1?"selected='selected'":"") %>>是</option>
  		</select>
  	</td>
  </tr>
  </table>
</div>

</form>

<form id='form2' name='form2'>
<div class='radiusBox' <%= (p.membertype!=2?"style='display: none;'":"") %>>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='10' class='bornone'>厂商关联信息&nbsp;&nbsp;<input  type="button" class="btn btn-primary" onclick="editprocurementunitjoin()" value="保存">&nbsp;&nbsp;<select class="puidsel" name="puidsel"><option value="<%= Config.getInt("junan")%>">君安</option><option value="<%= Config.getInt("xinke")%>">欣科</option><option value="<%= Config.getInt("gaoke")%>">高科</option></select><input class="btn btn-primary" onclick="addCompany()" type="button" value="新增公司"></td></tr>
</thead>
<tr>
	<th>序号</th>
	<th>厂商名称</th>
	<th>服务商公司名称</th>
	<th>CRM服务商档案id</th>
	<th>进项税返还政策</th>
	<th>服务费公式（<span style='color: red'>2019年4月1日之前计算方式，不确定可不选</span>）<br/>4月1号以后默认为（单价-底价）*0.9844*（开票金额/单价）/1.13</th>
	<th>产品</th>
	<th>底价设置</th>
	<th>所属医院</th>
	<th>操作</th><%--<th>开票单位</th>--%>
</tr>
<%
	int junanf = 0;
	int gaokef = 0;
	int xinkef = 0;
	List<ProcurementUnitJoin> pujlist = ProcurementUnitJoin.find(" AND profile = "+p.profile, 0, Integer.MAX_VALUE);
	for(int i=0;i<pujlist.size();i++){
		ProcurementUnitJoin puj = pujlist.get(i);
		ProcurementUnit pu = ProcurementUnit.find(puj.puid);
		String hosname = "";
        String [] ids = MT.f(puj.hoid,",").split(",");
        if(ids.length>1) {
            for (int j = 1; j < ids.length; j++) {
                ShopHospital sh1 = ShopHospital.find(Integer.parseInt(ids[j]));
                if(j>1){
                    hosname += "，";
                }
                hosname += sh1.getName();
            }
        }
//		List<String> models = ProcurementUnitJoin.model(puj.puid)
        String models = ProcurementUnitJoin.options(puj.puid,puj.model);
		out.print("<tr><td>"+(i+1)+"<input name='jid' type='hidden' value='"+puj.jid+"' /></td><td>"+MT.f(pu.getName())+"</td><td><input name='company' value='"+MT.f(puj.company)+"' /></td><td><input style='width:80px;' name='companyid' value='"+MT.f(puj.crmid)+"' /></td><td><select name='tax'>"+h.options(ProcurementUnitJoin.TAXxinke, puj.tax)+"</select></td><td><select name='formula'>"+h.options(ProcurementUnitJoin.FORMULAxinke, puj.formula)+"</select></td><td><select style='width:145px' name='model'>"+models+"</select></td><td><input name='agentPriceNew' value='"+MT.f(puj.agentPriceNew)+"' /><input name='invoicePuid' type='hidden' value='0' /></td><td><input name='' readonly='readonly'  onclick=findhos('"+member+"','"+puj.jid+"') value='"+hosname+"' /></td>");
		if(puj.puid==Config.getInt("junan")){
			if(junanf==0){
				out.print("<td></td>");
				junanf++;
			}else{
				out.print("<td><input value='删除' type='button' onclick='delCompany("+puj.jid+")' /></td>");
			}

		}
		if(puj.puid==Config.getInt("gaoke")){
			if(gaokef==0){
				gaokef++;
				out.print("<td></td>");
			}else{
				out.print("<td><input value='删除' type='button' onclick='delCompany("+puj.jid+")' /></td>");
			}

		}
		if(puj.puid==Config.getInt("xinke")){
			if(xinkef==0){
				xinkef++;
				out.print("<td></td>");
			}else{
				out.print("<td><input value='删除' type='button' onclick='delCompany("+puj.jid+")' /></td>");
			}

		}
		//out.print("<td><select name='invoicePuid'><option "+(puj.invoicePuid==pu.getPuid()?"selected='selected'":"")+" value='"+pu.getPuid()+"'>"+pu.getName()+"</option><option "+(puj.invoicePuid==0?"selected='selected'":"")+" value='0'>同辐</option></select></td>");
		out.print("</tr>");
	}
%>
</table>
</div>
</form>

<script type="text/javascript">
form1.nexturl.value=location.pathname+location.search;
function showhospitalsearch(){
	mt.show("/jsp/yl/shop/HospitalSearch.jsp?inpname=hospital",2,"查询医院",700,500);
}
function showfuwushangsearch() {
    mt.show("/jsp/yl/shop/FuWuShangSearch.jsp?editparent=1",2,"查询服务商",700,500);
}
mt.receive=function(h,n){
	//$("#"+n).val(h);
	//fchange(h,n);
	form1.hospital.value=h;
	form1.hospitals.value=n;
};
mt.receive1=function(h,n){
    alert(h);
    alert(n);
    form1.parentpro.value=h;
    form1.parentpros.value=n;
    form1.action="?";
    form1.submit();
};

function editprocurementunitjoin(){
	fn.ajax("/Members.do?act=editprocurementunitjoin",$("#form2").serialize(),function(data){
		//console.log(data);
		if(data.type>0){
			if(data.type==1){
				//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
				return;
			}
			mtDiag.close();
			mtDiag.show(data.mes);
			return;
		}else{
			layer.alert("操作成功！", {
				  closeBtn: 0
				}, function(){
					location.reload();
				});
		}
	});
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
	if(v==1){
		$(".show").css({"display":""});
		$(".procurementUnitdiv").hide();
        $(".parentProfileDiv").hide();
		//$(".show1").css({"display":""});
	}else if(v==2){
		$(".show").css({"display":"none"});
		$(".procurementUnitdiv").show();
        $(".parentProfileDiv").hide();
	}else if(v==0){
		$(".show").css({"display":"none"});
		$(".procurementUnitdiv").hide();
        $(".parentProfileDiv").hide();
		//$(".show1").css({"display":"none"});
	}else {
        $(".show").css({"display":"none"});
        $(".procurementUnitdiv").hide();
        $(".parentProfileDiv").show();
	}
}
//var reg=/^(((13[0-9]{1})|(18[0-9]{1})|147|150|151|152|153|154|155|156|157|158|159|170|176|177|178|175)+\d{8})$/;
var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
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
	form1.action="/Members.do";
}
$(function(){
	$("#membertype").change();
});


function addCompany(){
	fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=addCompany","member="+form1.member.value+"&puid="+$(".puidsel").val(),function(data) {
		mtDiag.show("添加成功！","alert",null,function(index){
			location.reload()
		});
	});
}

function delCompany(pid){
	mtDiag.show("您确定要删除吗？","confirm",function(){
		fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=delCompany","pid="+pid,function(data) {
			mtDiag.show("删除成功！","alert",null,function(index){
				location.reload()
			});
		});
	},function(){
	});


}


function findhos(member,pid){
	layer.open({
		type: 2,
		title: '所属医院',
		shadeClose: true,
		area: ['90%', '90%'],
		content: '/jsp/yl/shop/ShopEditHosShow.jsp?member='+member+'&pid='+pid //iframe的url /jsp/yl/shop/ExpExcel.jsp
		,end:function(){
			location.reload();
		}
	});
}


</script>
</body>
</html>
