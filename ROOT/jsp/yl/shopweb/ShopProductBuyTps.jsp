<%@page import="util.Config"%>
<%@page import="tea.ui.yl.shop.ShopIntegralRuless"%>
<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@ page import="tea.ui.yl.shop.ShopProductModels" %>
<%

	Http h=new Http(request,response);

	//int category=h.getInt("category");
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

%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>产品</title>
	<link rel="Shortcut Icon" href="/res/Home/favicon.ico"/>
	<script src="/tea/mt.js" type="text/javascript"></script>
	<script src="/tea/view.js" type="text/javascript"></script>
	<!-- <script src='/tea/jquery-1.3.1.min.js'></script> -->
	<script src="/tea/yl/jquery.min.js"></script>
	<script src="/tea/yl/superslide.2.1.js"></script>

	<script type="text/javascript" src="/tea/jquery.imagezoom.js"></script>
	<script src="/tea/yl/jquery.cookie.js"></script>
	<script language="javascript" src="/tea/load.js"></script>
	<script language="javascript" src="/tea/tea.js"></script>
	<script language="javascript" src="/tea/ym/ymPrompt.js"></script>
	<script language="javascript" src="/tea/mt.js?t=0917"></script>
	<script>var lang=1,node={id:19070106,father:19052227,community:'Home',type:0,hidden:false},member={id:0};member={id:18010374,username:'DDD',type:0,verifgtime:''};cook.set('community',node.community);</script>
	<link href="/res/Home/cssjs/19060001L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/19060001L1.js"></script>
	<link href="/res/Home/cssjs/19060004L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/19060004L1.js"></script>
	<link href="/res/Home/cssjs/19070023L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/19070023L1.js"></script>
	<link href="/res/Home/cssjs/19070026L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/19070026L1.js"></script>
	<link href="/res/Home/cssjs/14110279L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/14110279L1.js"></script>
	<link href="/res/Home/cssjs/19070115L1.css" rel="stylesheet" type="text/css"/><script language="javascript" src="/res/Home/cssjs/19070115L1.js"></script>
	<link rel="stylesheet" href="/jsp/yl/shopjt/css/product.css">

	<script>
		var ls=parent.document.getElementsByTagName("HEAD")[0];
		document.write(ls.innerHTML);
		var arr=parent.document.getElementsByTagName("LINK");
		for(var i=0;i<arr.length;i++)
		{
			document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
		}
	</script>
    <style>
        .sbbutton{
            color: #ffffff;
            margin-left: 100px;
            background: #086bb3;
            width: 126px;
            height: 40px;
            text-indent: 0;
            font-weight: normal;
            border:none
        }
    </style>
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
		<h1><%= p.name[1]%></h1>
	</div>
	<form action="" name='form1' >
		<input name='category' value='<%= category%>' type="hidden" />
		<input name='product' value='<%= product%>' type="hidden" />
		<input name='modelid' value='<%= p.model_id%>' type="hidden" />
		<input name='attribute' value='粒子活度' type="hidden" />
		<input name='productstockcount' value='0' type="hidden" />

		<div class='rightin right-tps'>
			<ul>
				<%--<li style='border-bottom: solid 1px #eeeeee;padding-bottom: 10px;'>
					<strong>&yen;&nbsp;<%= p.price%>/次</strong>
				</li>--%>
				<%
						/*out.print("<li>软件大小："+p.color+"</li>");*/
					out.print("<li>软件大小：410M</li>");
						/*out.print("<li>软件版本："+p.size+"</li>");*/
					out.print("<li>软件版本：v4.21</li>");
				%>
				<li><%

						//if(product>0) {
							float price = p.price;
							ArrayList alist=ShopIntegralRules.find(" and item=0", 0, 1);
							if(alist.size()>0){
								int integral=((ShopIntegralRules)alist.get(0)).getIntegral();
								out.print("商品积分："+(int)price/integral);
							}
						//}

				%> 　　
					<span style="color:#ee7605;">用户下单方可获取相应积分</span>

				</li>

				<li style='border-bottom: solid 1px #eeeeee;padding-bottom: 20px;margin-bottom:20px;'>商品编号：<%= p.yucode%></li>
					<li class='huod'><span>医院：</span>
						<select  class='hosids' name='hosid' id="hosids">
							<option value='0'>请选择医院</option>
						</select>
						<%--<select class="hosids" id="hosids" name="hosids" onchange="changehospital()" ></select>--%>
					</li>
				<li class='huod'>
					<span>购买方式：</span>
					<%
					List<ShopCategory> sclist = ShopCategory.find(" AND father="+sc.father+" ORDER BY sequence",0,200);
						for (int i = 0; i < sclist.size(); i++) {
							ShopCategory sc1 = sclist.get(i);
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
						}
					%>
				</li>
				<li class="huod2" style="border-bottom: solid 1px #eeeeee;padding-bottom: 20px;margin-bottom:20px;overflow: hidden;">
					<span  style="float:left">　　　　　</span>
					<p style="float:left;padding:12px 32px;background: #edf0f3;" class="modelp">
					</p>
				</li>
			</ul>
		</div>
	</form>

	<div class='sharbox'>
		<span  style="float:left">　　　　　</span>
		<input type="button" value="立即购买" onClick="jump()"/>
	     <button class="sbbutton" onclick="jump2()"><img src="/res/zzfwzs.png">增值服务</button>
	</div>
</div>
<div style='height:5px;font-size:0;clear:both;overflow:hidden'></div>


<!-- 产品详情 -->
<div class='prod-con'>
	<p class='prod-tit'>产品详细</p>
    <div><%= p.activity %></div>
</div>

</body>

<script>
	jQuery(function(){
		jQuery('.rightin .huod i').click(function(){
			jQuery(this).addClass('bgred').siblings('i').removeClass('bgred');
		})
		jQuery('.rightin .huod2 i').click(function(){
			jQuery(this).addClass('bgred').siblings('i').removeClass('bgred');
		})
	})
	jQuery(".pro-slide").slide({mainCell:".bd ul",autoPage:true,effect:"leftLoop",vis:3});
	mt.fit();

</script>
</html>



<script type="text/javascript">

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

	function changemodelp(category,product){
		var str = "";
		mt.send("/mobjsp/yl/shop/ajax.jsp?act=findmodel&category="+category+"&product="+product,function(data) {
			data = eval('(' + data + ')');
			var ja = data.ja;

			for(var i in ja){
				var ja1 = ja[i];
				if(ja1.product=="0"){
					str += "<i onclick=mt.show('暂无产品！'); "+((form1.modelid.value==ja1.modelid?"class='bgred'":""))+"><a >"+ja1.model+"</a></i>";
				}else{
					str += "<i onclick=parent.location='/html/folder/19081600-1.htm?product="+ja1.product+"' "+((form1.modelid.value==ja1.modelid?"class='bgred'":""))+"><a >"+ja1.model+"</a></i>";
				}
			}
			jQuery(".modelp").html(str);
			if(ja.length>1){
				jQuery(".modelp").show();
			}else{
				jQuery(".modelp").hide();
			}
		});

	}

	jQuery(function(){
		changemodelp(form1.category.value,form1.product.value);
        showhos();
		jQuery(".jqzoom").imagezoom();
		jQuery("#thumblist li a").click(function(){
			jQuery(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
			jQuery(".jqzoom").attr('src',jQuery(this).find("img").attr("mid"));
			jQuery(".jqzoom").attr('rel',jQuery(this).find("img").attr("big"));
		});
		initshow();
		jQuery(".pro-slide").slide({mainCell:".bd ul",autoPage:true,effect:"leftLoop",vis:3});
	})

    function jump() {
        if(form1.hosid.value==0){
            mt.show("请选择医院！");
            return;
        }
        location = "/jsp/yl/shopweb/ShopOrderFormUnitTpsNew.jsp?product="+form1.product.value+"&hosid="+form1.hosid.value;

    }
    function jump2() {
		window.open("http://www.bird.surgi-plan.com/zzfw.html");
    }

</script>
