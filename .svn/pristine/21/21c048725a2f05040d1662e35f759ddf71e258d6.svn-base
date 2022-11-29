<%@page import="tea.entity.yl.shop.ShopProduct"%>
<%@page import="tea.entity.yl.shop.ShopPackage"%>
<%@page import="java.util.List"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.yl.shop.ShopHospital"%>
<%@page import="tea.entity.yl.shop.ShopQualification"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<%
Http h=new Http(request,response);
String nexturl = h.get("nexturl");
int sid = h.getInt("sid",0);
ShopPackage sp = ShopPackage.find(sid);
%>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src='/tea/mt.js'></script>
<script src='/tea/tea.js'></script>
<script src='/tea/city.js'></script>
<script src='/tea/jquery.js'></script>
<body>
<h1>添加套餐</h1>
<form action="/ShopPackages.do" name="form2" method="post" target="" onSubmit="return checksubmit(this)" >
<input name="act" type="hidden" value="edit" />
<input name="sid" type="hidden" value="<%= sid %>" />
<div class='radiusBox'>
<table id="tdbor" cellspacing="0" class='newTable'>
<thead>
<tr><td colspan='5' class='bornone'>&nbsp;</td></tr>
</thead>
<tr>
		<td>套餐名称：</td>
		<td><input name="packagename" value="<%= MT.f(sp.getPackageName()) %>"  alt="套餐名称" /></td>
	</tr>
	<tr>
		<td>主商品：</td>
		<td><input name="productid" id="productid" value="<%= MT.f(sp.getProduct_id()) %>" type="hidden"/><input  id="productid1"  readonly="readonly" value="<%= MT.f(ShopProduct.find(sp.getProduct_id()).name[1]) %>"  alt="主商品" />&nbsp;<button class="btn btn-primary btn-xs" type="button" onclick="showproductsearch()">选择商品</button></td>
	</tr>
	<tr>
		<td>套餐原价：</td>
		<td><input name="price" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"  alt="套餐原价" value="<%= MT.f(sp.getPrice(),2) %>" /></td>
	</tr>
	<tr>
		<td>套餐价格：</td>
		<td><input name="setprice" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"  alt="套餐价格" value="<%= MT.f(sp.getSetPrice(),2) %>" /></td>
	</tr>
	<tr>
		<td colspan="2">
 		副商品：<button class="btn btn-primary btn-xs" type="button" onclick="showproductsearch1()">选择商品</button>
			<table id="mytab"  cellspacing="0" class='mt15' width='100%'>
		<!-- 		<thead>
				<tr><td colspan='5' class='bornone'>副商品：<input value="查询" class="btn btn-primary" type="button" onclick="showproductsearch1()" /></td></tr>
				</thead> -->
				<tr>
					<th>
						名称
					</th>
					<th>
						价格
					</th>
					<th>
						操作
					</th>
				</tr>
				<%
				if(sid>0){
				String [] sarr = sp.getProduct_link_id().split("\\|");
					for(int i=1;i<sarr.length;i++){
						ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[i]));
						out.print("<tr name='mtr' ><td><input type='hidden' name='myproduct' value='"+s1.product+"' />"+s1.name[1]+"</td><td>"+MT.f((double)s1.price,2)+"</td><td><a href='javascript:void(0);' onclick='mt.deltr(this)'>删除</a></td></tr>");
					}
				}else{
					out.print("<tr><td colspan='10' align='center' style='text-align:center;padding:10px 0'>暂无记录!</td></tr>");
				}
				%>
			</table>	
		</td>
	</tr>
<!--   <tr>
  	<td colspan="2">
  	</td>
  </tr> -->
</table>
</div>
<div class='center mt15'>
  		<input type="submit" class="btn btn-primary" value="提交" /> <input class="btn btn-default" type="button" value="返回" onclick="history.back();"/>


	<input name="act" type="hidden" value="addmember" />
	<input name="nexturl" type="hidden" value="<%= nexturl %>" /></div>
</form>
</body>
<script type="text/javascript">
function showproductsearch(){
	//mt.show("/jsp/yl/shop/ShopProductCategorys.jsp?type=0",2,"查询商品",800,400);
	var str = "(0";
	if($("#mytab tr[name='mtr']").length>0){
		$("#mytab input[name='myproduct']").each(function(){
			str += ","+ this.value ;
		});
	}
	str+=")";
	//alert(str);
	mt.show("/jsp/yl/shop/ShopProductCategorys.jsp?type=0&str="+str,2,"查询商品",800,400);
}
function showproductsearch1(){
	var productid = $("#productid").val()
	if(productid==""){
		mt.show("抱歉，请先选择主商品！");
	}else{
		var str = "("+productid;
		if($("#mytab tr[name='mtr']").length>0){
			$("#mytab input[name='myproduct']").each(function(){
				str += ","+ this.value ;
			});
		}
		str+=")";
		//alert(str);
		mt.show("/jsp/yl/shop/ShopProductCategorys.jsp?type=1&str="+str,2,"查询商品",800,400);
	}
	
}
mt.receive1=function(h,n){
	$("#"+n).val(h);
};

mt.addtr = function(h,n,p){
	$("#mytab tr").each(function(){
		//alert(this.innerHTML);
	});
	if($("#mytab tr[name='mtr']").length==0){
		$("#mytab tr:eq(1)").remove();
	}
	var mtr = "<tr name='mtr'><td><input type='hidden' name='myproduct' value='"+h+"' />"+n+"</td><td>"+p+"</td><td><a href='javascript:void(0);' onclick='mt.deltr(this)'>删除</a></td></tr>";
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

function checksubmit(obj){
	if(mt.check(obj)){
		if($("#mytab tr[name='mtr']").length==0){
			mt.show("请选择副商品！");
			return false;
		}
	}else{
		return false;
	}
}

</script>
</html>