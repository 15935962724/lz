<%@page import="tea.entity.yl.shop.*"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%>
<%@ page import="util.Config" %><%

Http h=new Http(request,response);
/* if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
} */
/* 

Site s=Site.find(1); */

String act = h.get("act");
/*if("checkCart".equals(act))
{
	int checkLength = 0;
	boolean isLzCategory = false;
	boolean includeLzCar = false;
	String[] ps=h.getCook("cart","|").split("[|]");

	List<String> tpslist = new ArrayList<String>();

	List<String> sblist = new ArrayList<String>();

	for (int i = 1; i < ps.length; i++) {
		String[] arr=ps[i].split("&");
		//判断product_id是否商品的id，如果不是则为套装id
		int product_id=Integer.parseInt(arr[0]);
		ShopProduct sp1 = ShopProduct.find(product_id);
		ShopCategory sc1 = ShopCategory.find(sp1.category);

		if(sc1.path.indexOf(Config.getString("tps"))!=-1){//tps
			tpslist.add(ps[i]);
		}else{
			sblist.add(ps[i]);
		}
	}

	*//*for(int i=1;i<ps.length;i++){
		String[] arr=ps[i].split("&");		
		int checkFlag = Integer.parseInt(arr[2]);
		if(checkFlag==1){
			checkLength++;
			//判断product_id是否商品的id，如果不是则为套装id
		    int product_id=Integer.parseInt(arr[0]);
		    ShopProduct p=ShopProduct.find(product_id);
		    if(p.isExist){
		    	if(p.category==ShopCategory.getCategory("lzCategory"))
			      {
  				      includeLzCar = true;
			      }
		    }
		}
	}*//*
	if(checkLength==0){
		out.print("请至少选中一件商品！");
		return;
	}else{
		if(h.member<1){
			out.print("&nbsp;&nbsp;&nbsp;&nbsp;对不起！您还未登录，登陆后才可提交订单！<br/>"
					+"已是网站会员，点击 <a href=javascript:parent.location='/xhtml/folder/14102033-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>登录</a>"
					+"&nbsp;&nbsp;还不是网站会员，点击 <a href=javascript:parent.location='/xhtml/folder/14102034-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>注册</a>");
			return;
		}else if(includeLzCar){
			Profile myp = Profile.find(h.member);
			if(myp.qualification==1||myp.membertype==2){//已通过审核可以购买
				isLzCategory = checkLength==1;
				if(!isLzCategory){					
					out.print("对不起！购物车中有粒子，而且不是单一粒子产品，不能提交订单！");
					return;
				}
			}else{
				out.print("对不起！您还未提交资质或已提交但审核未通过或资质已过期，不能去结算，请尽快提交您资质审核资料！<br/>如想尽快完成订，请致电：<b style='color:#FF7F00;font-size:16px'>010-12345678</b>");//<p align='center'>我要提交 <a href=javascript:parent.location='/html/folder/14110054-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>资质审核</a></p>
				return;
			}
		}
	}
	
	out.print(1);
	return;
}*/

String[] ps=h.getCook("cart","|").split("[|]");
boolean flag = false;
//boolean buyflag = false;

	List<String> tpslist = new ArrayList<String>();

	List<String> sblist = new ArrayList<String>();

	for (int i = 1; i < ps.length; i++) {
		String[] arr=ps[i].split("&");
		//判断product_id是否商品的id，如果不是则为套装id
		int product_id=Integer.parseInt(arr[0]);
		ShopProduct sp1 = ShopProduct.find(product_id);
		ShopCategory sc1 = ShopCategory.find(sp1.category);

		if(sc1.path.indexOf(Config.getString("tps"))!=-1){//tps
			tpslist.add(ps[i]);
		}else{
			sblist.add(ps[i]);
		}
	}

%>
<!doctype html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=0">
<title>购物车</title>
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
<script src="/tea/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="/tea/load.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>

<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>

</head>
<style>
body{font-size:100%;}
.EmptyCart{z-index:10;position:fixed;bottom:0;border-top:1px solid #cccccc;line-height:43px;width:100%;background:#fff;}
.EmptyCart .btn2{float:right;color:#fff;background:#044694;font-size:1rem;width:100%;height:50px;border:none;border-radius:0;}
.car-span{padding-right:3%;float:right;color:#939393;height:43px;line-height:43px;font-size:.875rem}
.car-span b{padding-left:10px;display:inline-block;color:#df6c0a;font-size:1.2rem;}
.inp{position: absolute; top: 12px; left: 11px; width: 17px; height: 17px; -webkit-appearance: none; z-index: 9; background: url(/tea/mobhtml/img/icon14.png) center no-repeat; background-size: 17px 17px;}
.inp:checked {background: url(/tea/mobhtml/img/icon15.png) center no-repeat; background-size: 17px 17px;}
.proCar .inp{left: -4px;}
<%--.Mycontent{background:#fff;}--%>
.car-box{padding:16px 4%;width:92%;background:#fff;margin-bottom: 15px;}
.clear-q{color:#df6c0a;border:1px solid #df6c0a;margin-left:9px;padding:3px 5px;font-size:.875rem;}
.order-line1{background:#fff;}
.order-line1 .order-tit{padding-left:22px;}
.cart img{width:65%;}
.cart{width:100%;border-bottom:1px solid #eee;margin-bottom:15px;font-size:}
.td1{width:40%;text-align:center;}
.cart .car-tit{font-size:1rem;color:#333;}
.cart tr,.cart td{padding:0;font-size:.875rem;height:30px;}
.carttitle .td-bz{margin-top:10px;border:none;background:#F7F7F7;width:92%;border-radius:2px;height:32px;padding:0 4%;color:#A7A7A7;font-size:.875rem;}
.cart .tr1{padding-bottom:8px;}
.cart .tr2{padding-bottom:5px;}
.cart select{width:100%;height:32px;border:1px solid #eee;}
.ShoppingCart{margin-bottom:10px;}
.cart tr .car-pi{font-size:1rem}
.detail02-j {
	border-radius: 2px;
	line-height: 1.7rem;
	display: inline-block;
	width: 1.7rem;
	height: 1.7rem;
	border: 1px solid #e2e2e2;
	background: #fff;
	float: right;
	cursor: pointer;
	outline: 0;
	color: #333;
	text-align: center;
	font-size:1rem;
}
.detail02-inp {
	border-radius: 2px;
	width: 4.5rem;
	margin: 0px 0.4rem;
	height: 1.7rem;
	line-height: 1.7rem;
	border: 1px solid #e2e2e2;
	float: right;
	text-align: center;
	color: #565656;
	outline: 0;
	flex: 0;
}

@media screen and (max-width: 321px)  {
	.car-span b{padding-left:8px;}
	.clear-q{margin-left:6px;}
}
</style>
<body>
<%-- <%=s.header%> --%>
<div class="Mycontent">
<div class="Mytop"></div>
<div class="Mycon">
<div class="ShoppingCart">
<!--<ul class="Order_cart" id="Order_cart_S1">
	<li class="step1">1.我的购物车</li>
	<li class="step2">2.填写核对订单信息</li>
	<li class="step3">3.成功提交订单</li>
</ul-->
<div class="cartimg"></div>
<%
if(ps.length<1)
{
  out.print("<div class='cartnone' style='margin-top:30px;height:160px;background:#F3F3F3 url(/tea/image/cart-empty-bg.png) no-repeat center 110px;text-align:justify;padding:4%;'>购物车内暂时没有商品，您可以去<a onclick=\"parent.location='/xhtml/folder/19080995-1.htm'\"  target='_praent' style='color:#044694;'>产品</a>挑选喜欢的商品<br /></div>");
}else
{
%>
	<form name="fcar" action="/Favs.do" method="post" target="_ajax">

<!--<h2>我挑选的商品</h2>-->

<input type="hidden" name="fav"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<!-- <tr>
  <th style='display:none;'>商品图片</th>
  <th>商品名称</th>
  <th>商品价格</th>
  <th>商品数量</th>
  <th>操作</th>
</tr> -->
<%

	if(tpslist.size()>0) {
		%>
		<div id="tab1" class="mytab" >
	<p class='order-line1 ft16 inv-p'><span class='fl-left inv-tit order-tit'><input type='checkbox' onclick="cheall(this,'tab1');" class='inp'>治疗计划系统TPS</span></p>
	<div class="carttitle">
		<div class='car-box'>
	<%
		for (int i = 0; i < tpslist.size(); i++) {
		    %>
            <table class="cart" cellpadding="0" cellspacing="0">
            <%
			String[] arr = tpslist.get(i).split("&");
			//判断product_id是否商品的id，如果不是则为套装id
			int product_id = Integer.parseInt(arr[0]);
			int quantity = Integer.parseInt(arr[1]);//数量
			String carstr = product_id+"&1&0";

			ShopProduct p = ShopProduct.find(product_id);
			ShopPackage spage = new ShopPackage(0);
			List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
			String pname = "";
			float price = 0.0f;

			if (p.isExist) {
	    	  /* if(p.category==ShopCategory.getCategory("lzCategory")){//商品中有粒子
		    	  buyflag = true;
		      } */
				pname = p.name[1];
				Profile pf = Profile.find(h.member);
				price = p.price;

			}
			out.println("<tr  class='tr1 " + (p.isExist ? "proCar" : "tzCar") + "' >");
			out.println("<td rowspan='3' class='td1' style='position: relative;'><input type='checkbox' class='inp' product='"+product_id+"' name='proid' protype='0' value='"+tpslist.get(i)+"' onclick='car.update0(this,"+product_id+")'/>");
			out.println(p.getAnchor('t'));
			out.println("</td>");
			out.println("<td class='car-tit' colspan='2'>" + pname + "</td>");
			out.println("</tr>");
			out.println("<tr  class='tr2 " + (p.isExist ? "proCar" : "tzCar") + "' >");
			out.println("<td style='width:20%;color:#A7A7A7'>软件大小</td>");
			out.println("<td>" + MT.f(p.color) + "</td>");
			out.println("</tr>");

			out.println("<tr  class='tr2 " + (p.isExist ? "proCar" : "tzCar") + "' >");
			out.println("<td style='color:#A7A7A7'>软件版本</td>");
			out.println("<td>" + MT.f(p.size) + "</td>");
			out.println("</tr>");

			int category = p.category;
			ShopCategory sc = ShopCategory.find(category);
			List<ShopCategory> sclist = ShopCategory.find(" AND father=" + sc.father + " ORDER BY sequence", 0, 200);
			List<ShopProductModel> spmlist = ShopProductModel.find(" AND category = " + sc.category, 0, 20);

			String selstr = "";
				ShopProduct sp = ShopProduct.find(product_id);
				ShopProductModel spm = ShopProductModel.find(p.model_id);
				ShopCategory sc1 = ShopCategory.find(sp.category);
				selstr += (sc1.name[1]+spm.getModel());
			/*selstr += "<select name='' onchange=''>";
			if (sclist.size() > 0) {
				for (int j = 0; j < sclist.size(); j++) {
					ShopCategory sc1 = sclist.get(j);
					selstr += ("<option  " + ((sc1.category == sc.category ? "selected='selected'" : "")) + ">" + sc1.name[1] + "</option>");
				}
			} else {
				selstr += ("<option value='' >暂无</option>");
			}
			selstr += "</select>";
			String selstr1 = "";
			selstr1 += "<select name=''>";
			if (spmlist.size() > 0) {
				for (int j = 0; j < spmlist.size(); j++) {
					ShopProductModel spm1 = spmlist.get(j);

					ShopProduct sp1 = ShopProduct.find(p.brand, spm1.getId());
					selstr1 += ("<option  " + ((spm1.getId() == p.model_id ? "selected='selected'" : "")) + ">" + spm1.getModel() + "</option>");
				}
			} else {
				selstr1 += ("<option value='' >暂无</option>");
			}
			selstr1 += "</select>";*/
			out.println("<tr  style='height:45px;'>");
			out.println("<td><input name='quantity' class='quan'  value='1'  product='"+carstr+"' price='"+price+"' type='hidden' /></td>");
			out.println("<td style='color:#A7A7A7'>购买方式</td>");
			out.println("<td>"+selstr+"</td>");
			out.println("</tr>");


			/*out.println("<tr   >");
			out.println("<td></td><td></td>");
			out.println("<td>"+selstr1+"</td>");
			out.println("</tr>");*/

			out.println("<tr  >");
			out.println("<td></td>");
			out.println("<td colspan='2' class='car-pi'>￥" + price + "</td>");
			out.println("</tr><tr style='height: 15px;line-height: 15px;'><td colspan='3' style='height: 15px;line-height: 15px;'>&nbsp;</td></tr>");

%>
            </table>
                    <%
                    out.println("<p><input type='text' placeholder='备注' name='tpsbz' class='td-bz'></p>");
		}
		out.print("</div>");
		out.print("</div>");
		out.print("</div>");
	}else{
		out.println("<input type='hidden' name='tpsbz' >");
	}
%>
<%
	if(sblist.size()>0){
%>
		<div id="tab2" class="mytab" >
	<p class='order-line1 ft16 inv-p'><span class='fl-left inv-tit order-tit'><input type='checkbox' onclick="cheall(this,'tab2');" class='inp'>设备/耗材</span></p>
	<div class="carttitle" style='margin-bottom:105px;'>
		<div class='car-box'>
			<!--<h2>我挑选的商品</h2>-->
					<%
						for(int i=0;i<sblist.size();i++){
						    %>
            <table  class="cart"  cellpadding="0" cellspacing="0">
            <%
							String[] arr=sblist.get(i).split("&");
							//判断product_id是否商品的id，如果不是则为套装id
							int product_id=Integer.parseInt(arr[0]);
							int quantity=Integer.parseInt(arr[1]);//数量

							String carstr = product_id+"&"+quantity+"&0";

							ShopProduct p=ShopProduct.find(product_id);
							ShopPackage spage = new ShopPackage(0);
							List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
							String pname = "";
							float price = 0.0f;

							if(p.isExist){
	    	  /* if(p.category==ShopCategory.getCategory("lzCategory")){//商品中有粒子
		    	  buyflag = true;
		      } */
								pname=p.name[1];
								Profile pf = Profile.find(h.member);
								price = p.price;
								if(pf.qualification==1&&p.category==ShopCategory.getCategory("lzCategory")){
									ShopQualification sq = ShopQualification.findByMember(h.member);
									if(sq.id>0){
										ShopPriceSet sps = ShopPriceSet.find(sq.hospital_id,p.product,0);
										if(sps.price>0){
											price=sps.price;
										}
									}
								}
								if(pf.membertype==2){//代理商价格
									ShopPriceSet sps = ShopPriceSet.find(1,p.product,0);
									if(sps.price>0){
										price=sps.price;
									}
								}
							}else{
								spage = ShopPackage.find(product_id);
								pname="<strong>[套装]</strong>"+MT.f(spage.getPackageName());
								ShopProduct s = ShopProduct.find(spage.getProduct_id());
								spagePList.add(0,s);
								String [] sarr = spage.getProduct_link_id().split("\\|");
								for(int m=1;m<sarr.length;m++){
									ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[m]));
									spagePList.add(m,s1);
								}
								price = (float)spage.getSetPrice();
							}
							out.println("<tr  class='tr1 "+(p.isExist?"proCar":"tzCar")+"' >");
							out.println("<td rowspan='3' class='td1' style='position: relative;'><input type='checkbox' product='"+product_id+"' class='inp' name='proid' protype='1' value='"+carstr+"' onclick='car.update0(this,"+product_id+")'/>");
							out.println(p.getAnchor('t'));
							out.println("</td>");
							out.println("<td class='car-tit' colspan='2'>"+pname+"</td>");
							out.println("</tr>");

							out.println("<tr  class='"+(p.isExist?"proCar":"tzCar")+"' >");

							out.println("<td colspan='2' class='car-pi'>￥"+price+"</td>");
							out.println("</tr>");


							out.println("<tr  class='"+(p.isExist?"proCar":"tzCar")+"' >");
							//out.println("<td></td>");
							//out.println("<td style='color:#A7A7A7'></td>");
							//out.println("<td>1</td>");
							out.print("<td colspan='2' class='are are3' style='text-align:reight'><a class='detail02-j' href='javascript:;' onClick='car.updatemob(this,true)'>+</a><input name='quantity' class='quan detail02-inp'  value='"+arr[1]+"'  product='"+carstr+"' price='"+price+"' onChange='car.update(this)' /><a class='qsub detail02-j' href='javascript:;' onClick='car.updatemob(this,false)'>-</a></td>");
							out.println("</tr><tr style='height: 15px;line-height: 15px;'><td colspan='2' style='height: 15px;line-height: 15px;'>&nbsp;</td></tr>");



                            %>
            </table>
                    <%
						}

						out.println("<p colspan='3'><input type='text' name='sbbz' placeholder='备注' class='td-bz'></p");

					%>
		</div>
	</div>
		<%
			}else{
				out.println("<input type='hidden' name='sbbz' >");
			}
		%>
		</form>
</div>


</div>
	<div class="EmptyCart">
	<label for='qx'>
	<input type='checkbox' id='qx' onclick="cheall(this);car.update0(this)" class='inp'>
	<span style='padding-left:34px;'>全选</span>
	<a class='clear-q' onclick="delche()">删除</a>
	</label>
	<span class='car-span'>结算金额<b>&yen<span class="total0">0.00</span>元</b></span>
	<input type="button" class='btn2' value="去结算" onClick="<%= (flag?"alert('购物车里有下架商品不能提交！');":"checkCart()")%>"/>


	</div>
<%
}
%>
<%-- <div class="carttitle">
<h2><span class="left">我收藏的商品(现在就放入购物车吧！)</span><a href="/my/Favs.jsp">进入收藏夹>></a></h2>
<table cellspacing="0" cellpadding="0" class="favoritestable">
<%
Iterator it=Fav.findByMember(h.member,0,20).iterator();
if(!it.hasNext())
{
  out.print("<tr><td colspan='5' align='center'>暂无记录!</td></tr>");
}else
{
  for(int i=0;it.hasNext();i++)
  {
    Fav t=(Fav)it.next();
    int id=t.fav;
    ShopProduct p=ShopProduct.find(t.product);
    if(p.time==null)continue;
    if(i%3==0)
	{
		if(i>0)out.print("</tr>");
		out.print("<tr>");
	}
    %>
      <td><img src="<%=p.getPicture('t')%>"/></td>
      <td><%=p.getAnchor(h.language)%><br/><span class="price"><%=MT.f(p.price)%></span><br/><input type="button" value="放入购物车" class="button" onClick="<%= (p.state==0?"car.add("+p.product+")":"alert('由于下架不能添加到购物车中！');")%>"/></td>
  <%}
}
%></tr>
</table>
</div> --%>
<script>
//car.update(null);
fcar.nexturl.value=location.pathname+location.search;
</script>
</div>
</div>
<div class="Mybottom"></div>
</div>
	<script>


		function cheall(obj,name){
			var chearr;
			if(name){
				chearr = jQuery("#"+name).find("input");
			}else{
				chearr = jQuery(".mytab").find("input");
			}

			//obj.className=obj.checked?"checked":"checkbox";

			//var chearr = jQuery("#"+name).find("input");
			//var chearr = document.getElementsByTagName("INPUT");
			for(var i=0;i<chearr.length;i++){
				if(chearr[i].type=='checkbox'){
					chearr[i].checked = obj.checked;
					if(chearr[i].type=='checkbox'){
						chearr[i].checked = obj.checked;
						if(jQuery(chearr[i]).attr("product")){
							car.update0(obj,jQuery(chearr[i]).attr("product"));
						}
					}
				}

			}

		}

		function checkCart(){
			var protype0 = 0;
			var protype1 = 0;
			jQuery('input:checkbox[name=proid]:checked').each(function(i){
				if(jQuery(this).attr("protype")==0){
					protype0++;
				}
				if(jQuery(this).attr("protype")==1){
					protype1++;
				}
			});
			if((protype0+protype1)==0){
				mt.show("请选择商品提交！");
				return;
			}
			if(protype0>0&&protype1>0){
				mt.show("请选择同一种商品提交订单！");
				return;
			}
			/*debugger
			mt.send("?act=checkCart",
					function(d){
						if(d==1){
							//host 19090017
							//test 19090241

						}else{
							mt.show(d);
						}
					}
			)*/
			var tpsbz = fcar.tpsbz.value;
			var sbbz = fcar.sbbz.value;

			location='/mobjsp/yl/shopweb/ShopOrderFormUnitTps.jsp?sbbz='+sbbz+'&tpsbz='+tpsbz;
		}

        function delche(){
            var chearr = document.getElementsByName("proid");
            var delflag = false;
            for(var i=0;i<chearr.length;i++){
                if(chearr[i].checked){
                    delflag = true;
                    break;
                }
            }
            if(delflag){
                mt.show("确定从购物车中删除所有选中商品？",2);
                mt.ok=function()
                {
                    for(var i=0;i<chearr.length;i++){
                        if(chearr[i].checked){
                            var p = chearr[i].value;
                            cookie.set('cart',cookie.get('cart').replace(new RegExp("[|]"+p.substring(0,p.lastIndexOf('&')+1)+"\\d+[|]"),"|"));
                        }
                    }
                    location.reload();
                }
            }else{
                mt.show("请选择商品！");
            }
        }

	</script>
<%--<script type="text/javascript">
my.del=function(a,p,n)
{
  mt.show(mt.res("确定要删除“{0}”吗？",n),2);
  mt.ok=function()
  {
	  /* alert(new RegExp("[|]"+p.substring(0,p.lastIndexOf('&')+1)+"\\d+[|]"));
	  alert("cookie1:"+cookie.get('cart','|'));
    //cookie.set('cart',cookie.get('cart').replace(new RegExp("[|]"+p.substring(0,p.lastIndexOf('&')+1)+"\\d+[|]"),"|"));
    alert("cookie2:"+cookie.get('cart','|'));
    while(a.tagName!="TR")a=a.parentNode;
    a.parentNode.removeChild(a); */
    cookie.set('cart',cookie.get('cart').replace(new RegExp("[|]"+p.substring(0,p.lastIndexOf('&')+1)+"\\d+[|]"),"|"));
    location.reload();
    ///car.update(null,0,0);
  };
}

function checkCart(){
	mt.send("?act=checkCart",
		function(d){
			if(d==1){
				parent.location='/xhtml/folder/14110150-1.htm';
			}else{
				mt.show(d);
			}
		}
	);
}


function showmes(){
	mt.show("对不起！您还未提交资质或已提交但审核未通过或资质已过期，不能去结算，请尽快提交您资质审核资料！<br/>如想尽快完成订，请致电：<b style='color:#FF7F00;font-size:16px'>010-12345678</b><p align='center'>我要提交 <a href='javascript:void(0)' onclick=parent.location='/xhtml/folder/14110054-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>资质审核</a></p>");
}
function showuser(){
	mt.show("&nbsp;&nbsp;&nbsp;&nbsp;对不起！您还未登录，登陆后才可提交订单！<br/>"
			+"已是网站会员，点击 <a href='javascript:void(0)' onclick=parent.location='/xhtml/folder/14102033-1.htm?nexturl=/xhtml/folder/14110112-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>登录</a>"
			+"&nbsp;&nbsp;还不是网站会员，点击 <a href='javascript:void(0)' onclick=parent.location='/xhtml/folder/14102034-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>注册</a>");
}
function showlz(){
	mt.show("粒子产品只能单独购买，每次只能购买一种活度的粒子，请检查购物车里的商品再去结算。");
}
function cheall(obj){
	obj.className=obj.checked?"checked":"checkbox";
	var chearr = document.getElementsByName("proid");	
	for(var i=0;i<chearr.length;i++){
		chearr[i].checked = obj.checked;
		chearr[i].className=obj.checked?"checked":"checkbox";
	}
}
function chemy(obj){
	obj.className=obj.checked?"checked":"checkbox";
}
function delche(){
	var chearr = document.getElementsByName("proid");
	var delflag = false;
	for(var i=0;i<chearr.length;i++){
		if(chearr[i].checked){
			delflag = true;
			break;
		}
	}
	if(delflag){
		mt.show("确定要删除吗？",2);
		  mt.ok=function()
		  {
			  for(var i=0;i<chearr.length;i++){
					if(chearr[i].checked){
						var p = chearr[i].value;
						cookie.set('cart',cookie.get('cart').replace(new RegExp("[|]"+p.substring(0,p.lastIndexOf('&')+1)+"\\d+[|]"),"|"));
					}
				}
			  location.reload();
		  }
	}else{
		mt.show("请选择商品！");
	}
}

var cheallNode = document.getElementById("cheallNode");
cheallNode.checked=true;
//cheall(cheallNode);
car.update0(cheallNode);
</script>--%>
<%-- <%=s.footer%> --%>


</body>
</html>
