<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int menuid=h.getInt("id");
StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
int product=h.getInt("product");
ShopProduct sp = ShopProduct.find(product);

sql.append(" AND product_id = "+product);
par.append("&product="+product);
/* if(category>0)
{
  sql.append(" AND category LIKE "+Database.cite("%"+category+"%"));
  par.append("&category="+category);
} */

/* int quantity=h.getInt("quantity");
if(quantity>0)
{
  sql.append(" AND quantity LIKE "+Database.cite("%"+quantity+"%"));
  par.append("&quantity="+quantity);
}

int hits=h.getInt("hits");
if(hits>0)
{
  sql.append(" AND hits LIKE "+Database.cite("%"+hits+"%"));
  par.append("&hits="+hits);
} */

String hosname = MT.f(h.get("hosname"));
if(hosname.length()>0){
	sql.append(" AND sh.name LIKE "+Database.cite("%"+hosname+"%"));
	par.append("&hosname="+hosname);
}

int dls = h.getInt("dls");
if(dls>0){
	sql.append(" AND sp.hospital_id = 1 ");
	par.append("&dls="+dls);
}else{
	sql.append(" AND sh.id <> 0 ");
	par.append("&dls="+dls);
}


int pos=h.getInt("pos");
int sum=ShopPriceSet.count(sql.toString());
par.append("&pos=");

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script>
</head>
<body>
<h1><%= sp.name[1] %>--价格设置</h1>

<form name="form1" action="?">
<input type="hidden" name="menuid"  value="<%= menuid %>" />
<input type="hidden" name="product"  value="<%= product %>" />
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='5' class='bornone'>搜索</td></tr>
</thead>
<tr>
  <td>类型选择：
  <select name="dls" onchange="dlschange(this)">
  	<option value="0">医院</option>
  	<option value="1" <%= (dls==1?"selected='selected'":"") %> >服务商</option>
  </select>&nbsp;&nbsp;&nbsp;&nbsp;
  医院名称:<input name="hosname" id="hosname" value="<%= (dls==0?MT.f(hosname):"") %>" <%= (dls==1?"disabled='disabled'":"") %>  />
<input class="btn btn-primary btn-sm" type="submit" value="查询"/>
  </td>
</tr>
</table>
</div>
</form>
<form action="/ShopPrices.do" target="_ajax"  onSubmit="return mt.check(this)" name="form3" method="post"  >
<input name="act" value="productedit" type="hidden" />
<input name="product" value="<%= product %>" type="hidden" />
<input type="hidden" name="nexturl"/>

<h2>设置价格</h2>
<table id="tablecenter">
	<tr>
		<td>医院/服务商：</td>
		<td>
		<input type="hidden" name="hospital" value=""/><input type="text" name="hospitals" readonly value=""/>
		<%-- <select name="hospital" id="hospital" alt="医院" onchange="selchange(this)">
		<option value="-1">请选择</option>
		<option value="1">服务商</option>
			<%
				for(int i=0;i<shlist.size();i++){
					ShopHospital sh = shlist.get(i);
					out.print("<option value='"+sh.getId()+"'>"+sh.getName()+"</option>");
				}
			%>
		</select> --%>
		<input type="button" value="选择医院" class="btn btn-primary btn-xs" onclick="showhospitalsearch()" />
		<input type="button" value="使用服务商" class="btn btn-primary btn-xs" onclick="selAgent();" />
		</td>

		<td>医院价格、服务商显示价格：</td>
		<td><input name="proprice" mask="float" alt="医院价格、服务商显示价格"/></td>
		
		<td id="_agent">医院（厂商）价格：</td>
		<td id="_agentV"><input name="agentprice" mask="float" alt="医院（服务商）价格"/></td>
		
		
		<!-- <td id="_agent">服务商（厂商）价格（底价）：</td>
		<td id="_agentV1"><input name="agentpricenew" mask="float" alt="服务商价格"/></td> -->
		
		
		<td>
			<button type="submit" class="btn btn-primary">添加</button>
		</td>
	</tr>
</table>
</form>
<form name="form2" action="/ShopPrices.do" method="post" target="_ajax">
<input type="hidden" name="nexturl"/>
<input type="hidden" name="did"/>
<input type="hidden" name="act" value="productdelete"/>
<input type="hidden" name="delone" />
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td><input type="checkbox" onclick="mt.select(form2.dids,checked)"/></td>
  <td>序号</td>
  <td>医院/服务商</td>
  <td>医院价格、服务商显示价格</td>
  <td>医院（厂商）价格</td>
  <!-- <td>服务商（厂商）价格（底价）</td> -->
  <td>操作</td>
</tr>
<%
if(sum<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
	sql.append(" order by hospital_id,membertype");
  Iterator it=ShopPriceSet.find(sql.toString(),pos,20).iterator();
  for(int i=1+pos;it.hasNext();i++)
  {
	  ShopPriceSet t=(ShopPriceSet)it.next();
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
    <td><input type="checkbox" name="dids" value="<%=t.id%>"/></td>
    <td><%=i%></td>
    <td><%=MT.f((t.hospital_id==1?"服务商":ShopHospital.find(t.hospital_id).getName()))%></td>
    <%-- <td><%=MT.f(Profile.MEMBER_TYPE[t.memberType])%></td> --%>
    <td><%=MT.f(t.price)%></td>
    <td><%=MT.f(t.agentPrice)%></td>
    <%-- <td><%=MT.f(t.agentPriceNew)%></td> --%>
    <td><a href='javascript:void(0);' onclick="delprice(<%= t.id %>)">删除</a></td>
  </tr>
  <%}
  if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
}%>
</table>
<div class="center mt15">
<button class="btn btn-primary" type="button" name="multi" onclick="f_act('productdelete',0)">批量删除</button></div>
</form>

<script>
mt.disabled(form2.dids);
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
		form2.act.value = 'delone';
		form2.did.value = num;
		form2.submit();
	};
}
function showhospitalsearch(){
	mt.show("/jsp/yl/shop/HospitalSearch.jsp?inpname=hospital",2,"查询医院",900,500);
}
mt.receive=function(h,n){
	//$("#"+n).val(h);
	//fchange(h,n);
	form3.hospital.value=h;
	form3.hospitals.value=n;
	document.getElementById('_agent').style.display='';
	document.getElementById('_agentV').style.display='';
	//document.getElementById('_agentV1').style.display='';

}
function fchange(value,b)
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
}
function dlschange(obj){
	if(obj.value==0){
		document.getElementById("hosname").disabled=false;
	}else{
		document.getElementById("hosname").disabled=true;
	}
}
function selAgent(){
	form3.hospital.value=1;form3.hospitals.value='服务商';
	document.getElementById('_agent').style.display='none';
	document.getElementById('_agentV').style.display='none';
	//document.getElementById('_agentV1').style.display='none';
}
</script>
</body>
</html>
