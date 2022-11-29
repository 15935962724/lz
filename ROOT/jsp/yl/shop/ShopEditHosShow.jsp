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

	int pid = h.getInt("pid");
	ProcurementUnitJoin puj = ProcurementUnitJoin.find(pid);


%><!DOCTYPE html>
<html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
	<script src="/tea/mt.js" type="text/javascript"></script>
	<script src="/tea/tea.js" type="text/javascript"></script>
	<script src="/tea/yl/jquery-1.7.js"></script>
	<script src="/tea/yl/top.js"></script>
</head>
<body>
<h1>所属医院</h1>

<form  onSubmit="return mt.check(this)" name="form3" method="post"  >
<input name="act" value="updatehos" type="hidden" />
<input name="profile" value="<%= profile %>" type="hidden" />
<input type="hidden" name="nexturl"/>
<!--<h2>设置医院</h2>
--><%--<div class='radiusBox'>
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
</table></div>--%>
</form>
<form id="form4">
<input type="hidden" name="nexturl"/>
<input type="hidden" name="pid" value="<%= pid%>"/>
<input type="hidden" name="delone" />
<input name="profile" value="<%= profile %>" type="hidden" />
<div class='radiusBox mt15'>
<table id="" cellspacing="0" class='newTable'>
<tr>
<th><input type="checkbox" onclick="mt.select(form4.dids,checked)"/></th>
  <th width='60'>序号</th>
  <th>医院</th>
  <th>到期日</th>
  <th>粒子/发票签收人</th>
	<th>商品厂商</th>
	<th>开票单位</th>
</tr>
<%
String [] sarr = p.hospitals.split("\\|");

String myhospitals = p.hospitals.replace("|",",");
	myhospitals = "0"+myhospitals+"0";


String mysql = " AND (id in ("+myhospitals+") ) OR (id in (0"+MT.f(puj.hoid,"")+"))";


int count = ShopHospital.count(mysql);


if(count<1)
{
  out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
}else
{
	List<ShopHospital> shlist = ShopHospital.find(mysql,0,Integer.MAX_VALUE);
	for(int i=0;i<shlist.size();i++){
		ShopHospital s1 = shlist.get(i);
		List lzList = Profile.find1(" AND particles_sign=1 AND hospital like "+DbAdapter.cite("%"+s1.getId()+"%"), 0, Integer.MAX_VALUE);
		List fpList = Profile.find1(" AND invoice_sign=1 AND hospital like "+DbAdapter.cite("%"+s1.getId()+"%"), 0, Integer.MAX_VALUE);
  %>
  <tr onMouseOver="bgColor='#FFFFCA'" onMouseOut="bgColor=''">
     <td><input type="checkbox" name="dids" value="<%= s1.getId()%>"  <%= ((MT.f(puj.hoid).indexOf(s1.getId()+"")!=-1?"checked":""))%>/></td>
    <td><input name="shid" type="hidden" value="<%= s1.getId()%>" /><%=(i+1)%></td>
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
		<%
			ProcurementUnit pu = ProcurementUnit.find(s1.getProductPuid());
			out.print(pu.getName());
		%>
	</td>
	<td>
			<%
					pu = ProcurementUnit.find(s1.getInvoicePuid());
					out.print(pu.getName());
			%>
	</td>
  </tr>
  <%}
}%>
</table>
</div>
<div class='mt15'><input type="button" onclick="editprocurementunit()" value="保存" class="btn btn-primary"/></div>
<!-- <br/>
<button class="btn btn-primary" type="button" name="multi" onclick="f_act('productdelete',0)">批量删除</button> -->
</form>

<script>

function editprocurementunit(){
	fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=editShopHospitalProfile",$("#form4").serialize(),function(data){
        layer.alert("操作成功！", {
            closeBtn: 0
        }, function(){
            parent.location.reload();
        });
	});
}
</script>
</body>
</html>
