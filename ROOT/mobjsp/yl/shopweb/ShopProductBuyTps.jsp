<%@page import="util.Config"%>
<%@page import="tea.ui.yl.shop.ShopIntegralRuless"%>
<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

	Http h=new Http(request,response);

	int product=h.getInt("product",0);

	ShopProduct p=ShopProduct.find(product);
	Profile pf = Profile.find(h.member);

	int category = p.category;
	ShopCategory sc = ShopCategory.find(category);

	if(product==0){
		ArrayList list = ShopProduct.find(" AND category=" + category + " AND state=0 ", 0, 1);
		if(list.size()>0){
			p = (ShopProduct) list.get(0);
		}
	}

	int hosid = h.getInt("hosid",0);
	int pusid = h.getInt("pusid",0);


//购物车中商品数量
	int carSum=0;
	String[] ps=h.getCook("cart","|").split("[|]");

	if(ps.length>0)
	{
		for(int i=1;i<ps.length;i++)
		{
			String[] arr=ps[i].split("&");

			int quantity=Integer.parseInt(arr[1]);//数量
			carSum += quantity;
		}
	}

	boolean isinterval = false;

	List<ProcurementUnitJoin> pujlist = ProcurementUnitJoin.find(" AND profile = "+h.member, 0, Integer.MAX_VALUE);

%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width,user-scalable=0">
<%--	<title><%= MT.f(p.name[1])%></title>--%>
	<title><%= p.name[1]%></title>
	<link rel="stylesheet" href="/mobjsp/yl/css/common.css">
	<link rel="stylesheet" href="/mobjsp/yl/css/swiper.min.css">
	<script src="/mobjsp/yl/js//swiper.min.js"></script>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/tea/view.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.3.1.min.js'></script>
	<script src="/mobjsp/yl/js/jquery.Spinner.js"></script>
	<script>
		$(function(){
			$(".Spinner").Spinner({value:"1", min:1, len:3, max:"1000"});
		});
	</script>
	<style>
		body{background:#f9f9f9}
		input[type=button], input[type=submit], input[type=text],input[type=file], button { cursor: pointer; -webkit-appearance: none; }
	.purchase {
		overflow: hidden;
		width: 100%;
		background: #fff;
		position: fixed;
		left: 0;
		bottom: 0;

	}
	.cpdetxt .info{
	padding:15px;
	}
	.purchase .purchase-l {
		float: left;
		width: 20%;
		height: 50px;
		background:none;
		background: url(/res/lizi/img/gwc.png) center no-repeat;
		background-size: 26px;
		border-top: 1px solid #ccc;
		border-bottom: 1px solid #ccc;
		border-radius:0;

	}
	.purchase input {
		border: none;
	}
	.purchase .purchase-r {
		float: left;
		width: 80%;
		height: 50px;
		line-height: 50px;
		text-align: center;
		font-size: 0.32rem;
		color: #fff;
		background: #DF6C0A;
	border-radius:0;
	}
	.cpdetxt .cpdetxt-tit {
		display: block;
		height: 40px;
		line-height: 40px;
		font-size: 0.32rem;
		font-weight: 600;
		border-bottom: 1px solid #ccc;
		padding: 0 15px;
	}
	.blue-t {
	height: 15px;
	background: #EEF5FE;
	}
	.detail03{
		padding:0;
	}
	.purme {
		padding: 15px 15px 20px;
	}
	.purme .purme-tit {
		display: block;
		height: 30px;
		line-height: 30px;
		font-size: 0.32rem;
	}
	.purme select {
		width: 200px;
		height: 30px;
		line-height: 30px;
		padding-left: 10px;
		margin-top: 15px;
	}

	</style>
</head>
<body>
<form action="" name='form1'>
	<input name='category' value='<%= category %>' type="hidden" />
	<input name='product' value='<%= product %>' type="hidden" />
	<input name='attribute' value='<%= MT.f(sc.attribute) %>' type="hidden" />
	<input name='productstockcount' value='0' type="hidden" />
	<input name='modelid' value='<%= p.model_id%>' type="hidden" />
	<input name='attribute' value='粒子活度' type="hidden" />




<div id="Body">
<%
		String imgstr = "http://www.brachysolution.com/res/Home/structure/19061406.png";
		String[] arr=p.picture.split("[|]");
	for(int i=1;i<arr.length;i++)
	{
	  Attch a=Attch.find(Integer.parseInt(arr[i]));
		if(i==1){
			imgstr = a.path;
		}
		}
%>
	<div id="Content">
		<div class="detail01 flex">
                <span class="pic flex">
                    <img src="<%= imgstr%>" />
                </span>
			<span class="nr flex">
                    <span class="tit"><%= p.name[1]%></span>
                    <span class="version"><em>商品编号</em><%=MT.f(p.yucode)%></span>
					<span class="version"><em>软件大小</em><%=MT.f(p.color)%></span>
					<span class="version"><em>软件版本</em><%=MT.f(p.size)%></span>
				<%
					 pf = Profile.find(h.member);
					float price = p.price;

					if(pf.membertype==2){//代理商价格
						ShopPriceSet sps = ShopPriceSet.find(hosid,product,0);
						if(sps.agentPrice>0){
							price=sps.price;
						}
					}


					//out.println("<span class='tit' style='margin:0.2rem 0rem;color:#df6c0a'>￥"+price+"</span>");

				%>
                </span>
		</div>
	<div class="blue-t"></div>
	<div class="purme">
		<span class="purme-tit">购买方式</span>
		<p style='border-bottom:1px solid #ccc;padding-bottom:15px'>
			<%--<%
				int mycount = ShopProductModel.count(" AND category = "+sc1.category);//只有一个属性
				if(mycount>1){
					out.print("<i onclick=changemodelp('"+sc1.category+"','"+product+"') "+((sc1.category==sc.category?"class='bgred'":""))+"><a>"+sc1.name[1]+"</a></i>");
				}else{
					ShopProductModel spm = ShopProductModel.findCat(sc1.category);
					ShopProduct sp1 = ShopProduct.find(p.brand,spm.getId());
					if(sp1.product==0){
						out.print("<i onclick=mt.show('暂无产品！');  ><a >"+sc1.name[1]+"</a></i>");
					}else{
						out.print("<i onclick=parent.location='/html/folder/19081600-1.htm?product="+sp1.product+"' "+((product==sp1.product?"class='bgred'":""))+" ><a >"+sc1.name[1]+"</a></i>");

					}
					//out.print("<i onclick=changemodelp('"+sc1.category+"','"+product+"') "+((sc1.category==sc.category?"class='bgred'":""))+"><a>"+sc1.name[1]+"</a></i>");
				}
			%>--%>
				<%
					String opstr = "";
					List<ShopCategory> sclist = ShopCategory.find(" AND father="+sc.father+" ORDER BY sequence",0,200);
					for (int i = 0; i < sclist.size(); i++) {
						ShopCategory sc1 = sclist.get(i);
						int mycount = ShopProductModel.count(" AND category = "+sc1.category);//只有一个属性
						if(mycount>1){
							opstr+=("<option category='"+sc1.category+"' product='"+product+"' flag='2' oproduct='0' "+((sc1.category==sc.category?"selected='selected'":""))+">"+sc1.name[1]+"</option>");
						}else{

							ShopProductModel spm = ShopProductModel.findCat(sc1.category);
							ShopProduct sp1 = ShopProduct.find(p.brand,spm.getId());
							if(sp1.product==0){
								opstr+=("<option category='"+sc1.category+"' product='"+product+"' flag='0' oproduct='"+sp1.product+"' "+((sc1.category==sc.category?"selected='selected'":""))+">"+sc1.name[1]+"</option>");
							}else{
								opstr+=("<option category='"+sc1.category+"' product='"+product+"' flag='1' oproduct='"+sp1.product+"' "+((sc1.category==sc.category?"selected='selected'":""))+">"+sc1.name[1]+"</option>");
							}

							}
						//out.print("<i onclick=changemodelp('"+sc1.category+"','"+product+"') "+((sc1.category==sc.category?"class='bgred'":""))+"><a>"+sc1.name[1]+"</a></i>");
					}
				%>
			<select name="" id="sel1" onchange=changemodelp(this) >
				<%= opstr%>
			</select>
		</p>
		<select name="" id="sel2" onchange="gotomodelp()" class="modelp">

		</select>

		<select  class='hosids' name='hosid' id="hosids">
			<option value='0'>请选择医院</option>
		</select>


	</div>
	<div class="blue-t"></div>

		<div class="detail03 flex cpdetxt">
			<span class="cpdetxt-tit">产品详情</span>
			<span class="info">
                    <%= p.spec[1]%>
                </span>
		</div>
				<div class="detail04 flex">
					<%--<input type="button" class="gm-inp"  onClick="car.add('<%= product %>',1,'/mobjsp/yl/shopweb/Carts.jsp')" value="加入购物车" />--%>
					<input type="button" class="gm-inp" onClick="jump()" value="立即购买" />
				</div>
			<%--<div class="purchase">
				<input type="button" onClick="car.add('<%= product %>',1,'/mobjsp/yl/shopweb/Carts.jsp')" class="purchase-l" />
				<input type="button" class="purchase-r" onClick="car.add('<%= product %>',1,'/mobjsp/yl/shopweb/ShopOrderFormUnitTps.jsp')" value="立即购买" />
			</div>--%>
	</div>

</div>
</form>
<script>
	$(function () {
		$("em.flex i").click(function () {
			$(this).addClass('cur').siblings("i").removeClass("cur");
		});

	})
</script>
<script>
    function showhos(){
        //获取用户名下的医院
        mt.send("/ShopHospitals.do?act=findhosids", function (data) {
            data = eval('(' + data + ')');
            //type=0 返回成功
            if (data.type == 0) {
                var ops = "<option value=0>请选择</option>";

                if (data.data_list != '') {//是否存在数据
                    for (var i = 0; i < data.data_list.length; i++) {
                        var proObj = data.data_list[i];
                        ops += "<option  value='" + proObj.obj.id + "'>" + proObj.obj.name + "</option>";
                    }
                }

                jQuery(".hosids").html(ops);
            } else {
                mtDiag.close();
                mtDiag.show(data.mes);
            }
        });

    }

	var perce = '<%=pf.membertype==2?"0.03":"0.01" %>';
	var junan = '<%=Config.getInt("junan")==p.puid?1:0 %>';
	/*zxForm.nexturl.value=location.pathname+location.search;
    mt.act=function(act,t){
        if("productbuy"==act){
            location = "ShopProductBuyUnit.jsp?product="+t;
        }

    };*/

	/*商品数量框输入*/
	function keyup(){
		var quantity = document.getElementById("quantity").value;
		var re = /^[1-9]+[0-9]*]*$/;
		if(!re.test(quantity) ||  parseInt(quantity)!=quantity || parseInt(quantity)<1){
			document.getElementById("quantity").value = 1;
			return;
		}
		if(quantity>=2000){
			document.getElementById("quantity").value=quantity.substring(0,quantity.length-1);
			mt.show("商品数量不能大于2000");
		}
	}

	/*商品数量+1*/
	function numAdd(){
		var quantity = document.getElementById("quantity").value;
		var num_add = parseInt(quantity)+1;
		if(quantity==""){
			num_add = 1;
		}
		if(num_add>=2000){
			document.getElementById("quantity").value=num_add-1;
			mt.show("商品数量不能大于2000");
		}else{
			document.getElementById("quantity").value=num_add;
		}
	}

	/*商品数量-1*/
	function numDec(){
		var quantity = document.getElementById("quantity").value;
		var num_dec = parseInt(quantity)-1;
		if(num_dec>0){
			document.getElementById("quantity").value=num_dec;
		}
	}

	/*fc=zxForm.depict;
    fc.onpropertychange=fc.oninput=function()
    {
      var len=200-this.value.length;
      $$('info').innerHTML=len<0?"已经超过":"还能输入";
      var c=$$('count');
      c.innerHTML=Math.abs(len);
      c.style.color=len<0?"red":"";
    };
    fc.oninput();*/

	function submitZx(){
		if(zxForm.product_id.value=='0'){
			mt.show("请选择具体商品！");
			return;
		}
		if(mt.check(zxForm)){
			var len = zxForm.depict.value.length;
			if(len>200)
				mt.show("最多只能输入200字！！！");
			else
				zxForm.submit();
		}

	}

	//更换验证码
	mt.verifys=function()
	{
		var imgs=document.getElementById('img_verifys');
		imgs.style.visibility = "visible";
		imgs.src=imgs.src.replace(/=[.\d]+/,'='+Math.random());
		zxForm.verify.value='';
		zxForm.verify.focus();
	};

	function showtab(num){
		jQuery("#myul li").hide();
		jQuery("#myul li:eq("+num+")").show();
		jQuery("#titul li").removeClass("fblue").addClass("tz");
		jQuery("#titul li:eq("+num+")").removeClass("tz").addClass("fblue");
	}
</script>
<script type="text/javascript">
	/*jQuery(document).ready(function(){

		jQuery(".jqzoom").imagezoom();

		jQuery("#thumblist li a").click(function(){
			jQuery(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
			jQuery(".jqzoom").attr('src',jQuery(this).find("img").attr("mid"));
			jQuery(".jqzoom").attr('rel',jQuery(this).find("img").attr("big"));
		});


	});*/
	$(function(){
        showhos();
		//initshow();
	});
</script>
<script>
	mt.fit();



	function initshow(){
		if(form1.product.value=='0'){
			inithos();
		}else{
			inithos('<%= hosid %>');
			initpus('<%= hosid %>','<%= pusid %>');
			findproduct(0,'<%= pusid %>','<%= product %>');
		}
	}

	function initpus(hosid,pusid){
		mt.send("/ShopHospitals.do?act=findpusids&hosid="+hosid,function(data){
			data = eval('(' + data + ')');
			if(data.type>0){
				if(data.type==1){
					//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
					return;
				}
				mtDiag.close();
				mtDiag.show(data.mes);
				return;
			}else{
				var ops = "<option value=0>请选择</option>";
				if(data.data_list!=''){//是否存在数据
					for(var i=0;i<data.data_list.length;i++){
						var proObj = data.data_list[i];
						ops += "<option "+(pusid==proObj.obj.puid?"selected='selected'":"")+" value='"+proObj.obj.puid+"'>"+proObj.obj.name+"</option>";
					}
				}
				jQuery(".pusids").html(ops);
			}

			//$(".hosids").html(ops);
		});
	}

	function inithos(hosid){
		mt.send("/ShopHospitals.do?act=findhosids",function(data){
			data = eval('(' + data + ')');
			if(data.type>0){
				if(data.type==1){
					//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
					return;
				}
				mtDiag.close();
				mtDiag.show(data.mes);
				return;
			}else{
				var ops = "<option value=0>请选择</option>";
				if(data.data_list!=''){//是否存在数据
					for(var i=0;i<data.data_list.length;i++){
						var proObj = data.data_list[i];
						ops += "<option "+(hosid==proObj.obj.id?"selected='selected'":"")+" value='"+proObj.obj.id+"'>"+proObj.obj.name+"</option>";
					}
				}
				jQuery(".hosids").html(ops);
			}
		});
	}
	function changehos(obj){
		var hosid = jQuery(obj).val();
		initpus(hosid,0);
	}

	function changepus(obj){
		var pusid = jQuery(obj).val();
		findproduct(0,pusid,0);
	}
    function changemodelp(obj){
        var str = "";
		//console.log($("#sel1 option:selected").attr("product"));
		var category =$("#sel1 option:selected").attr("category");
		var product =$("#sel1 option:selected").attr("product");

		var flag =$("#sel1 option:selected").attr("flag");
		var oproduct =$("#sel1 option:selected").attr("oproduct");

		if(flag=="0"){
			mt.show("暂无商品！");
		}else if(flag=="1"){
			if(oproduct!="<%= product%>"){
				location = '/mobjsp/yl/shopweb/ShopProductBuyTps.jsp?product='+oproduct;
				return;
			}
		}

        mt.send("/mobjsp/yl/shop/ajax.jsp?act=findmodel&category="+category+"&product="+product,function(data) {
            data = eval('(' + data + ')');
            var ja = data.ja;
				str = "<option value='0' product='0'>请选择</option>";
				for(var i in ja){
					var ja1 = ja[i];
//onchange=parent.location='/mobjsp/yl/shopweb/ShopProductBuyTps.jsp?product="+ja1.product+"'
					str +="<option product='"+ja1.product+"'  "+((form1.modelid.value==ja1.modelid?"selected='selected'":""))+">"+ja1.model+"</option>"

					//str += "<i onclick=parent.location='/mobjsp/yl/shopweb/ShopProductBuyTps.jsp?product="+ja1.product+"' "+((form1.modelid.value==ja1.modelid?"class='bgred'":""))+"><a >"+ja1.model+"</a></i>";
				}
			if(ja.length>1){
				jQuery(".modelp").show();
			}else{
				jQuery(".modelp").hide();
			}
            jQuery(".modelp").html(str);
        });

    }

	changemodelp($("#sel1"));

    function gotomodelp(){
		var product =$("#sel2 option:selected").attr("product");
		if(product!="0"){
			parent.location='/mobjsp/yl/shopweb/ShopProductBuyTps.jsp?product='+product;
		}else{
			mt.show("暂无商品！");
		}
	}


	/*function findproduct(hosid,pusid,productid){
		mt.send("/ShopHospitals.do?act=findproduct&hosid="+hosid+"&pusid="+pusid+"&category="+form1.category.value,function(data){
			data = eval('(' + data + ')');
			if(data.type>0){
				if(data.type==1){
					//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
					return;
				}
				mtDiag.close();
				mtDiag.show(data.mes);
				return;
			}else{
				var ops = "<em class='flex'>";
				if(data.data_list!=''){//是否存在数据
					for(var i=0;i<data.data_list.length;i++){
						var proObj = data.data_list[i];
						ops += "<i "+(productid==proObj.product?"class='bgred'":"")+" ><a  onclick=findproductdes('"+proObj.product+"') target='_parent'>"+proObj.model+"</a></i>";
					}
				}
				if(ops==""){
					ops = "<i>暂无规格</i>";
				}
				ops = ops+"</em>";

				jQuery(".huod").html(ops);
			}
		});
	}
*/
	function findproductdes(proid){
		//19052204 test
		//19060258 host
		//location = '/html/folder/19052204-1.htm?product='+proid+"&hosid="+form1.hosid.value+"&pusid="+form1.pusid.value+"&category="+form1.category.value;
		location = '/mobjsp/yl/shopweb/ShopProductBuyUnit.jsp?product='+proid+"&hosid="+form1.hosid.value+"&pusid="+form1.pusid.value+"&category="+form1.category.value;
	}

	function mysub(){
		//form1.action = '/html/folder/19041335-1.htm';
		//form1.submit();


		/* if(form1.quantity.value>form1.productstockcount.value){
            mt.show("库存不足，是否同意调配？",2);
            var mytype = 0;
            mt.ok = function(){
                mytype = 1;
                parent.location = "/html/folder/19041335-1.htm?product="+form1.product.value+"&hosid="+form1.hosid.value+"&quantity="+form1.quantity.value+"&activity="+form1.activity.value+"&isallocate=1";
                //console.log(123);
            //console.log(mytype+"---");
            }
            mt.cancel = function(){
                parent.location = "/html/folder/19041335-1.htm?product="+form1.product.value+"&hosid="+form1.hosid.value+"&quantity="+form1.quantity.value+"&activity="+form1.activity.value+"&isallocate=0";
                //console.log(mytype+"---");
            }
        }else{
            parent.location = "/html/folder/19041335-1.htm?product="+form1.product.value+"&hosid="+form1.hosid.value+"&quantity="+form1.quantity.value+"&activity="+form1.activity.value;
        } */
		//19041335 host
		//14110150 test
		//location = "/html/folder/14110150-1.htm?product="+form1.product.value+"&hosid="+form1.hosid.value+"&quantity="+form1.quantity.value+"&activity="+form1.activity.value;
		location = "/mobjsp/yl/shopweb/ShopOrderFormUnit.jsp?product="+form1.product.value+"&hosid="+form1.hosid.value+"&quantity="+form1.quantity.value+"&activity="+form1.activity.value;
		//return;
	}
	function blurActivity(obj,activityMin,activityMax){
		if(form1.actcheck.value==1){
			if(obj.value!=''&&(obj.value<activityMin||obj.value>activityMax)){
				mt.show("活度超出范围 "+activityMin+"-"+activityMax+"！");
				obj.value = activityMin;
				findProductStockCount();
				//console.log(123);
			}
		}
	}
	function keyupActivity(obj){
		obj.value = obj.value.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
		obj.value = obj.value.replace(/^\./g,""); //验证第一个字符是数字而不是
		obj.value = obj.value.replace(/^[2-9]/g,""); //验证第一个字符是数字而不是
		obj.value = obj.value.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
		obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
		obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数
		findProductStockCount();
	}


	function findProductStockCount(){
		if(junan==1){
			mt.send("/ProductStocks.do?act=findProductStockCount&activity="+form1.activity.value+"&perce="+perce,function(data){
				data = eval('(' + data + ')');
				if(data.type>0){
					if(data.type==1){
						//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
						return;
					}
					mtDiag.close();
					mtDiag.show(data.mes);
					return;
				}else{
					form1.productstockcount.value = data.count;
					jQuery(".productstockcount").html(data.count);
					//console.log(data);
				}
			});
		}
	}

    function jump() {
        if(form1.hosid.value==0){
            mt.show("请选择医院！");
            return;
        }
        location = "/mobjsp/yl/shopweb/ShopOrderFormUnitTpsNew.jsp?product="+form1.product.value+"&hosid="+form1.hosid.value;

    }
</script>
</body>
</html>