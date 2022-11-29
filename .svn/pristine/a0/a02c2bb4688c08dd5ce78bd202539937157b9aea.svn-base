<%@page import="util.Config"%>
<%@page import="tea.ui.yl.shop.ShopIntegralRuless"%>
<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

	Http h=new Http(request,response);

	int category=h.getInt("category");
	int product=h.getInt("product",0);

	int hosid = h.getInt("hosid",0);
	int pusid = h.getInt("pusid",0);

	ShopProduct p=ShopProduct.find(product);  //获取该商品

	Profile pf = Profile.find(h.member);  //获取当前登录的用户

	ProcurementUnit pu = ProcurementUnit.find(p.puid); //获取该产品的厂商


	ShopCategory sc = ShopCategory.find(category);

	if(product==0){
		ArrayList list = ShopProduct.find(" AND category=" + category + " AND state=0 ", 0, 1);
		if(list.size()>0){
			p = (ShopProduct) list.get(0);
		}
	}

//是否显示“加入购物车”和“数量”


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


%><!DOCTYPE html><html><head>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<!-- <script src='/tea/jquery-1.3.1.min.js'></script> -->
<script src="/tea/yl/jquery.min.js"></script>
<script src="/tea/yl/superslide.2.1.js"></script>
<link href="/res/Home/cssjs/19060001L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/19060001L1.js"></script>
<link href="/res/Home/cssjs/19060004L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/19060004L1.js"></script>
<link href="/res/Home/cssjs/19070023L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/19070023L1.js"></script>
<link href="/res/Home/cssjs/19070026L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/19070026L1.js"></script>
<link href="/res/Home/cssjs/14110279L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/14110279L1.js"></script>
<link href="/res/Home/cssjs/19070115L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/19070115L1.js"></script>
<link rel="stylesheet" href="/jsp/yl/shopjt/css/product.css">
<script type="text/javascript" src="/tea/jquery.imagezoom.js"></script>
<!-- <script src="/tea/yl/top.js"></script> -->
<script src="/tea/yl/jquery.cookie.js"></script>
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
<body>
<div class="lefts">

	<div class="left">
		<div class="box">
			<ul class="tb-thumb" id="thumblist">
				<%
					String[] arr=p.picture.split("[|]");
					for(int i=1;i<arr.length;i++)
					{
						Attch a=Attch.find(Integer.parseInt(arr[i]));
						if(i==1){
				%>
				<div class="tb-booth tb-pic tb-s310">
					<a href="javascript:void(0);"><img onload='AutoResizeImage(350,250,this)' src="<%= a.path %>" alt="<%= a.path %>" rel="<%= a.path %>" class="jqzoom" /></a>
				</div>
				<%
						out.print("<div class='pro-slide'><div class='bd'><ul><li class='tb-selected'>");
					}else{
						out.print("<li>");
					}
				%>
				<div class="tb-pic tb-s40"><a href="javascript:void(0);"><img onload='AutoResizeImage(45,45,this)' width="45" height="45" src="<%= a.path %>" mid="<%= a.path %>" big="<%= a.path %>"></a></div></li>
				<%
					}
				%>
			</ul>
		</div>
		<div class='hd'>
			<a class='next'></a>
			<a class='prev'></a>
		</div>
	</div>
	</ul>
</div>
</div>
</div>

<div class="rights">
	<div class='bigtit'>
		<h1><%=p.name[1] %></h1>

	</div>
	<form action="" name='form1'>
		<input name='category' value='<%= category %>' type="hidden" />
		<input name='product' value='<%= product %>' type="hidden" />
		<input name='attribute' value='<%= MT.f(sc.attribute) %>' type="hidden" />
		<input name='pusid' value='<%= MT.f(p.puid) %>' type="hidden" />
		<input name='productstockcount' value='0' type="hidden" />

		<div class='rightin'>
			<ul>
				<li style="margin-top:20px">商品编号：<%= MT.f(p.yucode)%></li>
				<li style="margin-top:20px">生产厂家：<%= MT.f(pu.name)%></li>
				<li style="margin-top:20px">型　　号：<%= MT.f(p.packing)%></li>
				<li>选择医院：<select onchange='changehos(this)' class='hosids' name='hosid'><option value='0'>请选择医院</option></select></li>
				<li style="margin-top:20px">价　　格：<span id="price">0.01</span></li>
				<li class='are are3'><span style='float:left;line-height:30px;'>购买数量：</span><a href='###' onclick='numDec()' style='color:#ccc;'>-</a><input type='text' name='quantity' id='quantity' value='1' onkeyup='keyup()'/><a href='###' onclick='numAdd()' style='color:#000;'>+</a></li>
			</ul>
		</div>
	</form>

	<div class='sharbox'>
		<span style="float:left;">　　　　　</span>
		<input type="button" value="立即购买"  onClick="addcar('<%= product%>')" />
	</div>
</div>
<div style='height:5px;font-size:0;clear:both;overflow:hidden'></div>

<!-- 产品详情 -->
<div class='prod-con'>
	<p class='prod-tit'>产品详细</p>
	<div><%= p.activity %></div>
</div>

<script>
	var perce = '<%=pf.membertype==2||pf.membertype==3?"0.03":"0.01" %>';
	var junan = '<%=Config.getInt("junan")==p.puid?1:0 %>';
	zxForm.nexturl.value=location.pathname+location.search;
	mt.act=function(act,t){
		if("productbuy"==act){
			location = "ShopProductBuyOther.jsp?product="+t;
		}

	};

	/*商品数量框输入*/
	function keyup(){
		var quantity = document.getElementById("quantity").value;
		var re = /^[1-9]+[0-9]*]*$/;
		if(!re.test(quantity) ||  parseInt(quantity)!=quantity || parseInt(quantity)<1){
			document.getElementById("quantity").value = 1;
			return;
		}
		if(quantity>2000){
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

	fc=zxForm.depict;
	fc.onpropertychange=fc.oninput=function()
	{
		var len=200-this.value.length;
		$$('info').innerHTML=len<0?"已经超过":"还能输入";
		var c=$$('count');
		c.innerHTML=Math.abs(len);
		c.style.color=len<0?"red":"";
	};
	fc.oninput();



	//更换验证码
	mt.verifys=function()
	{
		var imgs=document.getElementById('img_verifys');
		imgs.style.visibility = "visible";
		imgs.src=imgs.src.replace(/=[.\d]+/,'='+Math.random());
		zxForm.verify.value='';
		zxForm.verify.focus();
	};

</script>
<script type="text/javascript">
	jQuery(document).ready(function(){

		jQuery(".jqzoom").imagezoom();

		jQuery("#thumblist li a").click(function(){
			jQuery(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
			jQuery(".jqzoom").attr('src',jQuery(this).find("img").attr("mid"));
			jQuery(".jqzoom").attr('rel',jQuery(this).find("img").attr("big"));
		});
		initshow();
		jQuery(".pro-slide").slide({mainCell:".bd ul",autoPage:true,effect:"leftLoop",vis:3});

	});
</script>
<script>
	mt.fit();


	function addcar(product){
		if(form1.hosid.value==0){
			mt.show("请选择医院！");
			return;
		}

		if (showIsStopSupply(form1.pusid.value)){
			mt.show("该厂家已停止供货,请联系客服！");
			return;
		}
		mysub();
	}

	function initshow(){
		if(form1.product.value=='0'){
			inithos();
		}else{
			inithos('<%= hosid %>');
			initpus('<%= hosid %>','<%= pusid %>');
		}
	}

	function initpus(hosid,pusid){
		mt.send("/ShopHospitals.do?act=findpusids&hosid="+hosid+"&productId="+<%=product%>,function(data){
			console.log(data);
			var data = JSON.parse(data)
			console.log("价格:"+data.price+"，type:"+data.type);
			if(data.type>0){
				if(data.type==1){
					//location = '/html/gf/index.html?nexturl='+encodeURIComponent(window.location.pathname+window.location.search);
					return;
				}
				mtDiag.close();
				mtDiag.show(data.mes);
				return;
			}else{
				jQuery("#price").html(data.price);
			}
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



	function mysub(){
		location = "/html/folder/22040007-1.htm?product="+form1.product.value+"&hosid="+form1.hosid.value+"&quantity="+form1.quantity.value+"&activity=0";
	}
	//判断该厂家是否停止供货
	function showIsStopSupply(puid){
		var data;
		var oReq = new XMLHttpRequest();
		oReq.open("GET", "/ProcurementUnitServlet.do?act=showIsStopSupply&puid="+puid, false); // 同步请求
		oReq.send(null);
		data = JSON.parse(oReq.responseText)
		return data.flag;
	}





</script>

<style type="text/css">
	.rights #quantity{width: 63px;}
</style>
</body>
</html>
