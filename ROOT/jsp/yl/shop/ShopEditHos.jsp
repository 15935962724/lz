<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@ page import="util.Config" %>
<%

Http h=new Http(request,response);

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");

int profile = h.getInt("member");
Profile p = Profile.find(profile);

/* int product=h.getInt("product");
ShopProduct sp = ShopProduct.find(product);

sql.append(" AND product_id = "+product); */

int pos=h.getInt("pos");
int sum=ShopPriceSet.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html>
<html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
	<script src="/tea/mt.js" type="text/javascript"></script>
	<script src="/tea/tea.js" type="text/javascript"></script>
	<script src="/tea/yl/jquery-1.7.js"></script>
	<script src="/tea/yl/top.js"></script>
</head>
<body>
<h1>设置医院</h1>

<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" name="form3" method="post"  >
<input name="act" value="updatehos" type="hidden" />
<input name="profile" value="<%= profile %>" type="hidden" />
<input type="hidden" name="nexturl"/>
<!--<h2>设置医院</h2>
--><div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='4' class='bornone'>设置医院</td></tr>
</thead>
	<tr>
		<td>医院：</td>
		<td>
		<input type="hidden" name="hospital" value=""/><input type="text" alt="医院" name="hospitals" readonly value=""/>
		<button type="button" class="btn btn-primary btn-xs" onclick="showhospitalsearch()">选择医院</button>
		</td>
		<td>
			<button type="submit" class="btn btn-primary">添加</button>
		</td>
	</tr>
</table></div>
</form>
<form name="form2" id="form2" action="/Members.do" method="post" target="_ajax">
<input type="hidden" name="nexturl"/>
<input type="hidden" name="did"/>
<input type="hidden" name="act" value="productdelete"/>
<input type="hidden" name="delone" />
<input name="profile" value="<%= profile %>" type="hidden" />
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<tr>
<!--   <th><input type="checkbox" onclick="mt.select(form2.dids,checked)"/></th> -->
  <th width='60'>序号</th>
  <th>医院</th>
  <th>到期日</th>
  <th>粒子/发票签收人</th>
	<th>商品厂商</th>
	<th>开票单位</th>
  <th>操作</th>
</tr>
<%
String [] sarr = MT.f(p.hospitals,"|").split("\\|");
if(sarr.length<1)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
}else
{
	
	for(int i=1;i<sarr.length;i++){
		ShopHospital s1 = ShopHospital.find(Integer.parseInt(sarr[i]));
		List lzList = Profile.find1(" AND particles_sign=1 AND hospital like "+DbAdapter.cite("%"+s1.getId()+"%"), 0, Integer.MAX_VALUE);
		List fpList = Profile.find1(" AND invoice_sign=1 AND hospital like "+DbAdapter.cite("%"+s1.getId()+"%"), 0, Integer.MAX_VALUE);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
<%--     <td><input type="checkbox" name="dids" value="<%= s1.getId()%>"/></td> --%>
    <td><input name="shid" type="hidden" value="<%= s1.getId()%>" /><%=i%></td>
    <td><%= s1.getName() %></td>
    <td><%=MT.f(s1.getExpirationDate()) %></td>
    <td>
    	<% 
    	out.print("粒子：");
    	for(int j=0;j<lzList.size();j++){
    		Profile pObj = (Profile)lzList.get(j);
			out.print(pObj.getMember()+"&nbsp;&nbsp;");
    	}
    	out.print("|&nbsp;&nbsp;发票：");
    	for(int j=0;j<fpList.size();j++){
    		Profile pObj = (Profile)fpList.get(j);
			out.print(pObj.getMember()+"&nbsp;&nbsp;");
    	}
    	%>
    </td>
	<td>
		<select name="productPuid">
			<%
				List<ProcurementUnit> pulist = ProcurementUnit.find(" AND puid <>"+ Config.getInt("tongfu"),0,Integer.MAX_VALUE);
				for (int j = 0; j < pulist.size(); j++) {
					ProcurementUnit pu = pulist.get(j);
					out.print("<option value='"+pu.getPuid()+"' "+(s1.getProductPuid()==pu.getPuid()?"selected='selected'":"")+">"+pu.getName()+"</option>");
				}
			%>
		</select>
	</td>
	<td>
		<select name="invoicePuid">
			<%
				pulist = ProcurementUnit.find(" AND puid <>"+ Config.getInt("xinke"),0,Integer.MAX_VALUE);
				for (int j = 0; j < pulist.size(); j++) {
					ProcurementUnit pu = pulist.get(j);
					out.print("<option value='"+pu.getPuid()+"' "+(s1.getInvoicePuid()==pu.getPuid()?"selected='selected'":"")+" >"+pu.getName()+"</option>");
				}
			%>
		</select>
	</td>
    <td><a href='javascript:void(0);' onclick="delprice(<%= s1.getId()%>)">删除</a>&nbsp;|&nbsp;
    <a href='javascript:void(0);' onclick="updatetime(<%= s1.getId()%>)">设置日期</a></td>
  </tr>
  <%}
}%>
</table>
</div>
<div class='mt15'><input type="button" onclick="editprocurementunit()" value="保存" class="btn btn-primary"/>&nbsp;<input type="button" onClick="location='<%= h.get("nexturl") %>';" value="返回" class="btn btn-primary"/></div>
<!-- <br/>
<button class="btn btn-primary" type="button" name="multi" onclick="f_act('productdelete',0)">批量删除</button> -->
</form>

<script>
//mt.disabled(form2.dids);
form2.nexturl.value=location.pathname+location.search;
form3.nexturl.value=location.pathname+location.search;
function f_act(a,id)
{
  form2.act.value=a;
  form2.did.value=id;
  if(a=='productdelete')
  {
	 var flag = false;
	 var carr = document.getElementsByName("dids");
	 for(var i=0;i<carr.length;i++){
		 if(carr[i].checked){
			 flag = true;
		 }
	 }
	 if(!flag){
		 mt.show("请选择数据！");
		 return;
	 }
    mt.show('你确定要删除吗？',2,'form2.submit()');
  }
}
function delprice(num){
	mt.show('你确定要删除吗？',2);
	mt.ok=function(){
		form2.act.value = 'delhos';
		form2.did.value = num;
		form2.submit();
	};
}
function showhospitalsearch(){
	mt.show("/jsp/yl/shop/HospitalSearch1.jsp",2,"查询医院",900,500);
}
mt.receive=function(h,n){
	form3.hospital.value=h;
	form3.hospitals.value=n;
}

function updatetime(num){
	form2.did.value=num;
	form2.action=('/jsp/yl/shop/ShopHospitalSetExpiration.jsp');
	form2.target='_self';form2.method='get';form2.submit();
	//location = "/jsp/yl/shop/ShopHospitalSetExpiration.jsp?nexturl="+form2.nexturl.value+"&hid="+num;
}

function editprocurementunit(){
	fn.ajax("/Members.do?act=editprocurementunit",$("#form2").serialize(),function(data){
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

/* function fchange(value,b)
{
  sendx("/jsp/admin/edn_ajax.jsp?act=selhos&hosid="+value,function(data){
	  $("#"+b).html(data.trim());
  });
  selchange($("#"+b)[0]);
}
function tchange(value,b)
{
  sendx("/jsp/admin/edn_ajax.jsp?act=seltype&typeid="+value,function(data){
	  $("#"+b).html(data.trim());
  });
}
function selchange(obj){
	var index = obj.selectedIndex;
	if(index==1){
		tchange(1,"membertype");
	}else if(index>1){
		tchange(0,"membertype");
	}else{
		$("#membertype").html("<option value='-1'>请选择</option>");
	}
} */
</script>
</body>
</html>
