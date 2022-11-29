<%@page import="tea.ui.yl.shop.ShopIntegralRuless"%>
<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1){
	String param = request.getQueryString();
	String url = request.getRequestURI();
	if(param != null)
		url = url + "?" + param;
	response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
	return;
}
	
int product=h.getInt("product");
//product=15010269;
ShopProduct p=ShopProduct.find(product);
if(!p.isExist)
{
  response.sendError(404);
  
  return;
}
p.updateclick();

ShopCategory sc = ShopCategory.find(p.category);

//是否显示“加入购物车”和“数量”
boolean isBuyCarFlag = false;
boolean isDownloadFlag = false;
String isBuyCarCategorys = "("+ShopCategory.getCategory("lzCategory")+","+ShopCategory.getCategory("sysCategory")+","+ShopCategory.getCategory("qxCategory")+")";
String isDownloadCategorys = "("+ShopCategory.getCategory("sysCategory")+")";
List<ShopCategory> isBuyCarCategoryslist = ShopCategory.find(" AND (category in "+isBuyCarCategorys+" or father in "+isBuyCarCategorys+") AND category="+sc.category+" AND hidden = 0", 0, 1);
List<ShopCategory> isDownloadCategoryslist = ShopCategory.find(" AND father in "+isDownloadCategorys+" AND category="+sc.category+" AND hidden = 0", 0, 1);
if(isBuyCarCategoryslist!=null&&isBuyCarCategoryslist.size()>0)
	isBuyCarFlag = true;
if(isDownloadCategoryslist!=null&&isDownloadCategoryslist.size()>0)
	isDownloadFlag = true;


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
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src='/tea/jquery.js' type="text/javascript"></script>

<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<title>申购粒子</title>
</head>
<body>
<header class="header"><!-- <a href="javascript:history.go(-1)"></a> -->申购粒子</header>

<div class='bigtit'>
<h2><%=p.name[1] %></h2>
<%
if(!sc.offswitch)
{
%>
<div class='cartsbtn'><span><%=carSum>0?carSum:"0"%></span><a href="javascript:void()" onclick="parent.location='/mobjsp/yl/shopweb/Carts_wx.jsp'" ><img src="/res/Home/structure/14124104.png" /></a></div>
<%
}
%>
</div>

<div class='radiusBox newlist wSpan'>
		<ul class='seachr'>
			<%
			float price = p.price;
			Profile pf = Profile.find(h.member);
			if(pf.qualification==1&&p.category==ShopCategory.getCategory("lzCategory")){
				ShopQualification sq = ShopQualification.findByMember(h.member);
				if(sq.id>0){
					ShopPriceSet sps = ShopPriceSet.find(sq.hospital_id,product,0);
					if(sps.price>0){
						price=sps.price;
					}
				}				
			}
			if(pf.membertype==2){//代理商价格
					ShopPriceSet sps = ShopPriceSet.find(1,product,0);
					if(sps.price>0){
						price=sps.price;
					}
			}
			if(p.price_display==1){
				String priceStr = "";
				if("".equals(MT.f(p.price_type)))
					priceStr = "面议";
				else
					priceStr = p.price_type;
				//out.print("<li><span>市场价格：</span><strong style='font-size:12px;'>&nbsp;"+ priceStr +"</strong></li>");
			}else{
				//out.print("<li class='colorSize'><span>市场价格：</span><strong>&yen;&nbsp;"+ price +"</strong></li>");
			}
			%>
			<li><span>商品编号：</span><%=MT.f(p.yucode)%></li>
			<%
			//商品规格类型
			if(p.category>0&&p.model_id>0){
				List<ShopProductModel> spmlist = ShopProductModel.find(" AND category = "+p.category, 0, 100);
				if(spmlist.size()>0){
					if(MT.f(sc.attribute)!=null&&MT.f(sc.attribute).length()>0){
						out.println("<li class='Btext'><span>"+MT.f(sc.attribute)+"：</span>");
						for(int i=0;i<spmlist.size();i++){
							ShopProductModel spm = spmlist.get(i);
							ShopProduct sp = ShopProduct.find(p.brand,spm.getId());
							if(sp.product>0)
								out.println("<i "+(spm.getId()==p.model_id?"class='bgred'":"")+"><a href='/mobjsp/yl/shopweb/ShopProductBuy_wx.jsp?product="+sp.product+"' target='_parent'>"+spm.getModel()+"</a></i>");
						}
						out.println("</li>");
					}
					
				}
				
			}
			if(ShopCategory.getCategory("lzCategory")==p.category){
				out.print("<li class='huod'>法定工作日8:30至16:30处理订单并安排发货(非法定假日的周六将在8:30至14:30处理订单并安排发货)，否则将顺延至下一工作区间处理。遇特殊节假日，将在网站首页通知接受订单及发货时间；</li>");
			}
			//商品数量
			if(isBuyCarFlag)
			{
				out.println("<li class='are'><span style='float:left;'>购买数量：</span><a href='###' onclick='numDec()'>-</a><input type='text' id='quantity' value='1' onkeyup='keyup()'/><a href='###' onclick='numAdd()'>+</a></li>");
			}
			%>


<%
if(!sc.offswitch&&isBuyCarFlag && p.price_display == 0)
{
%>
<li><button type="button" value="" onClick="car.add(<%=product%>,document.getElementById('quantity').value,'/mobjsp/yl/shopweb/Carts_wx.jsp')"/>加入购物车</button>
</li>
<%
}
%>
</ul>

</div>
<%
List<ShopPackage> spl = new ArrayList<ShopPackage>();
if(p.category!=ShopCategory.getCategory("lzCategory")){
	spl = ShopPackage.find(" AND product_id = "+product+" order by id ",0,100);
}
%>

<div id="picScroll" class="picScroll"  <%= (spl.size()>0?"":"style='display: none;'")  %> >
<%
if(spl.size()>0){
%>
<!-- <div class="hd">
						<span class="next"></span> 
						<ul></ul>
						<span class="prev"></span>
						<h3>套餐 共<%= spl.size() %>款</h3>
</div>
<div class="bd" style=""> -->
	<%
	
  
        	out.print("<ul>");
				for(int i=0;i<spl.size();i++){
					out.print("<li onclick=parent.location='/xhtml/folder/14128332-1.htm?product="+product+"' ><span class='name'>套装"+(i+1)+"</span><span class='pic'>");
					ShopPackage sp = spl.get(i);
					String [] sarr = sp.getProduct_link_id().split("\\|");
					//for(int j=1;j<sarr.length;j++){
						ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[1]));
						//String[] arr1=s1.picture.split("[|]");
						out.print("<img src='"+s1.getPicture('s')+"' width='50' height='50' /></span></li>");
					//}
					if((i+1)%3==0){
						out.print("</ul><ul>");
					}
				}
				out.print("</ul>");
        }
	%>
    
   </div>
   <!-- <script type="text/javascript">
				TouchSlide({ 
					slideCell:"#picScroll",
					titCell:".hd ul", //开启自动分页 autoPage:true ，此时设置 titCell 为导航元素包裹层
					autoPage:true, //自动分页
					pnLoop:"false", // 前后按钮不循环
					switchLoad:"_src" //切换加载，真实图片路径为"_src" 
				});
				$(document).ready(function(){
				$(".hd").click(function(){
					if($(".bd").css('display')=='none'){
	    				$(".bd").show();
					}else{
						$(".bd").hide();
					}
					mt.fit();
  				});
			});
	</script>
 --></div>

<script type="text/javascript">
$(document).ready(function(){
  $("#quantity").onclick(function(){
      $(this).select()
  })
})
</script>

<div class="<%out.print(p.view_type==1?"p1":"p2");%>">

		<%
		
		List<ShopProduct_data> spdlist=null;//文章/列表
		spdlist = ShopProduct_data.find(" AND hidden=0 AND (type=0 OR type=1) AND product_id = "+p.product+" order by type asc,sort asc", 0, 100);//在商品中查看商品的说明（文章/列表形式）
		
		if(spdlist.size()<1){
			spdlist = ShopProduct_data.find(" AND hidden=0 AND showtype=1 AND (type=0 OR type=1) AND category = "+p.category+" order by type asc,sort asc", 0, 100);//在商品中查看类的说明（文章/列表形式）
		}
		
		if(spdlist.size()>0){
			///////////////////guo-modify:2014-12-31////////////////////////
			int index=0;
			int index1=0;
			int temp=0;
			for(int i=1;i<=spdlist.size();i++){
				ShopProduct_data spd = spdlist.get(i-1);
				if(i%3 == 1){
					index++;
					out.print("<div class='switch'><ul>");
					out.println("<li><a href='###' onclick='mt.tab(this);mt.fit();' name='a_tab"+index+"' class='current'>"+spd.title+"</a></li>");
				}else if(i%3 == 0){
					out.println("<li><a href='###' onclick='mt.tab(this);mt.fit();' name='a_tab"+index+"' class=''>"+spd.title+"</a></li>");
					out.print("</ul></div>");
					//页签里的内容
					index1++;
					boolean display = true;
					int j = 0;
					for(j=i-3;j<i;j++){
						ShopProduct_data spd_info = spdlist.get(j);
						if(spd_info.type==0){
							out.println("<div class='gous' name='tab"+index1+"' "+(display?"":"style='display:none'")+">"+spd_info.content+"</div>");
						}else{
							out.println("<ul class='gous' name='tab"+index1+"' "+(display?"":"style='display:none'")+">");
							List<ShopProduct_data_list> spdlMorelist=ShopProduct_data_list.find(" AND data_id="+spd_info.id,0,100);
							for(int k=0;k<spdlMorelist.size();k++){
								ShopProduct_data_list spdl = spdlMorelist.get(k);
								out.println("<li><a href='/html/folder/14110146-1.htm?data_list_id="+spdl.id+"' target='_blank'>"+spdl.title+"</a></li>");
							}
							out.println("</ul>");
						}
						display = false;
					}
					temp = j;
				}else{
					out.println("<li><a href='###' onclick='mt.tab(this);mt.fit();' name='a_tab"+index+"' class=''>"+spd.title+"</a></li>");
				}
				
				if(i == spdlist.size()){
					out.print("</ul></div>");
					//页签里的内容
					index1++;
					boolean display = true;
					for(int j=temp;j<i;j++){
						ShopProduct_data spd_info = spdlist.get(j);
						if(spd_info.type==0){
							out.println("<div class='gous' name='tab"+index1+"' "+(display?"":"style='display:none'")+">"+spd_info.content+"</div>");
						}else{
							out.println("<ul class='gous' name='tab"+index1+"' "+(display?"":"style='display:none'")+">");
							List<ShopProduct_data_list> spdlMorelist=ShopProduct_data_list.find(" AND data_id="+spd_info.id,0,100);
							for(int k=0;k<spdlMorelist.size();k++){
								ShopProduct_data_list spdl = spdlMorelist.get(k);
								out.println("<li><a href='/html/folder/14110146-1.htm?data_list_id="+spdl.id+"' target='_blank'>"+spdl.title+"</a></li>");
							}
							out.println("</ul>");
						}
						display = false;
					}
				}
			}
			/////////////////////^END///////////////////////////////////////
		}
	
	
	
	
%>

</div>

<script>
zxForm.nexturl.value=location.pathname+location.search;
mt.act=function(act,t){
	if("productbuy"==act){
		location = "ShopProductBuy.jsp?product="+t;
	}
	
};

/*商品数量框输入*/
function keyup(){
	var quantity = document.getElementById("quantity").value;
	var re = /^[0-9]+[0-9]*]*$/;
	if(!re.test(quantity) ||  parseInt(quantity)!=quantity || parseInt(quantity)<1){
		document.getElementById("quantity").value = 1;
		return;
    }
	if(quantity>=1000){
		document.getElementById("quantity").value=quantity.substring(0,quantity.length-1);
		mt.show("商品数量不能大于1000");
	}
}

/*商品数量+1*/
function numAdd(){
	var quantity = document.getElementById("quantity").value;
 	var num_add = parseInt(quantity)+1;
 	if(quantity==""){
 	 	num_add = 1;
 	}
 	if(num_add>=1000){
 		document.getElementById("quantity").value=num_add-1;
 		mt.show("商品数量不能大于1000");
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

function submitZx(){
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
  foLogin.verify.value='';
  foLogin.verify.focus();
};

function showtab(num){
	jQuery("#myul li").hide();
	jQuery("#myul li:eq("+num+")").show();
	jQuery("#titul li").removeClass("fblue").addClass("tz");
	jQuery("#titul li:eq("+num+")").removeClass("tz").addClass("fblue");
}
</script>
</body>
</html>
