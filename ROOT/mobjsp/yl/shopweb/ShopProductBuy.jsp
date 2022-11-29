<%@page import="tea.ui.yl.shop.ShopIntegralRuless"%>
<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
	
int product=h.getInt("product");
//product=14102773;
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
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>


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

<style>
.scroll{width:320px;height:140px;margin:0px auto 0 auto; position:relative;overflow:hidden;}
.mod_01{float:left;text-align:center;width:320px;}
.mod_01 img{max-width:320px;height:140px;}
.dotModule_new{padding:0 5px;height:11px;line-height:6px;-webkit-border-radius:11px;background:rgba(45,45,45,0.5);position:absolute;bottom:5px;right:10px;z-index:11;}
#slide_01_dot{text-align:center;margin:0px 0 0 0;}
#slide_01_dot span{display:inline-block;margin:0 3px;width:5px;height:5px;vertical-align:middle;background:#f7f7f7;-webkit-border-radius:5px;}
#slide_01_dot .selected{background:#66ff33;}
</style>
<script type="text/javascript" src="/res/Home/cssjs/scroll.js"></script>
<div class="scroll">
	<div class="slide_01" id="slide_01">
		<%
		String[] arr=p.picture.split("[|]");
		for(int i=1;i<arr.length;i++)
		{
			Attch a=Attch.find(Integer.parseInt(arr[i]));
			out.print("<div class='mod_01'><img src='"+a.path+"' /></div>");
		}
		%>
		</div>
	<div class="dotModule_new">
		<div id="slide_01_dot"></div>
	</div>
</div>
<script type="text/javascript">
if(document.getElementById("slide_01")){
	var slide_01 = new ScrollPic();
	slide_01.scrollContId   = "slide_01"; //内容容器ID
	slide_01.dotListId      = "slide_01_dot";//点列表ID
	slide_01.dotOnClassName = "selected";
	slide_01.arrLeftId      = "sl_left"; //左箭头ID
	slide_01.arrRightId     = "sl_right";//右箭头ID
	slide_01.frameWidth     = 320;
	slide_01.pageWidth      = 320;
	slide_01.upright        = false;
	slide_01.speed          = 10;
	slide_01.space          = 30; 
	slide_01.initialize(); //初始化
}
</script>
</div>
</div>
</div>

<div class='bigtit'>
<h1><%=p.name[1] %></h1>
<%
if(!sc.offswitch)
{
%>
<div class='cartsbtn'><span><%=carSum>0?carSum:"0"%></span><a href="javascript:void()" onclick="parent.location='/xhtml/folder/14110112-1.htm'" ><img src="/res/Home/structure/14124104.png" /></a></div>
<%
}
%>
</div>

<div class="rights">
<div class='rightin'>
		<ul>
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
				out.print("<li>市场价格：<strong style='font-size:12px;'>&nbsp;"+ priceStr +"</strong></li>");
			}else{
				out.print("<li>市场价格：<strong>&yen;&nbsp;"+ price +"</strong></li>");
			}
			%>
			<li>商品编号：<%=MT.f(p.yucode)%></li>
			<%
			ArrayList alist=ShopIntegralRules.find(" and item=0", 0, 1);
			if(alist.size()>0){
				int integral=((ShopIntegralRules)alist.get(0)).getIntegral();
				if(integral>0&&p.category==ShopCategory.getCategory("lzCategory")){
					out.print("<li>商品积分："+(int)price/integral+"</li>");
				}
			}
			
			if(p.activity!=null&&p.activity.length()>0){
				out.println("<li class='xxiang'>促销信息：<span class='org'>"+MT.f(p.activity.replaceAll("<[^>]+>|&nbsp;",""),20));
				if(p.activity.length()>=20){
					//out.println("&nbsp;&nbsp;<a href=javascript:mt.show('"+p.activity+"'); target='_blank'>详情</a>");
					out.println("</span>&nbsp;&nbsp;<a href='/xhtml/folder/14110148-1.htm?product="+p.product+"' target='_blank'>详情</a>");
				}
				out.println("</li>");
			}
			%>
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
								out.println("<i "+(spm.getId()==p.model_id?"class='bgred'":"")+"><a href='/xhtml/folder/14110010-1.htm?product="+sp.product+"' target='_parent'>"+spm.getModel()+"</a></i>");
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

</ul>		
<%
if(isDownloadFlag){
	out.println("<div class='download'>");
	out.println("<input type='button' value='立即下载'/>");
	out.println("<input type='button' value='申请试用'/>");
	out.println("</div>");
}

%>			
</div>

<script src='/tea/jquery.js'></script>
<script>
$(function(){
	
$(".fenx").click(function(){
	
    $(".fenxiang").slideToggle("slow");
  });
});
</script>
<div class='sharbox'>
<%
if(!sc.offswitch&&isBuyCarFlag && p.price_display == 0)
{
%>
<input type="button" value="加入购物车" onClick="car.add(<%=product%>,document.getElementById('quantity').value,'/xhtml/folder/14110112-1.htm')"/>
<%
}
%>
<div class="fenx"><img src="/res/Home/structure/14124117.png" /></div>
<div class="fenxiang">
<span class="sharein"><div class="bshare-custom"><div class="bsPromo bsPromo2"></div>分享到：<a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"s></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=2ddd3036-1080-4a31-a715-a180bd963380&amp;pophcol=1&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="/tea/bshareC0.js"></script></span>
<script type="text/javascript" charset="utf-8">
bShare.addEntry({
    title: "<%=p.name[1]%>",
    url: parent.location.href+"|"+location.href,
    summary: "粒子治疗“一站式”解决方案",
    pic: "http://"+location.host+"<%=p.getPicture('s')%>"
});
</script>
</div>

</div>
</div>
<div style='height:5px;font-size:0;clear:both;overflow:hidden'></div>
<%
List<ShopPackage> spl = new ArrayList<ShopPackage>();
if(p.category!=ShopCategory.getCategory("lzCategory")){
	spl = ShopPackage.find(" AND product_id = "+product+" order by id ",0,100);
}
%>

<script src="/tea/TouchSlide.1.1.js"></script>
<style>
	.picScroll{ width:94%;padding:0px 3%;margin:0px auto; text-align:center;  }
	.picScroll .bd{display:none;}
	.picScroll .bd ul{ width:100%;  float:left; padding-top:10px;  }
	.picScroll .bd li{ width:33%; float:left; font-size:14px; text-align:center;  }
	.picScroll .bd li a{-webkit-tap-highlight-color:rgba(0, 0, 0, 0); /* 取消链接高亮 */ }
	.picScroll .bd li img{ width:68px; height:108px;border:1px #ddd solid;background:url(/res/Home/structure/14128147.gif) #fff center center no-repeat;  }
	.picScroll .hd{ height:30px; line-height:30px;font-size:14px; border-top:1px #ddd solid;border-bottom:1px solid #ddd;overflow:hidden; text-align:left; }
	.picScroll .hd ul{ float:right; padding-top:11px; display:none;  }	
	.picScroll .hd li{ float:left; width:8px; height:8px; background:#D0D0D0; margin:0 5px; overflow:hidden; 
	-webkit-border-radius:8px; -moz-border-radius:8px; border-radius:8px; 
	}
	.picScroll .bd li span.name{padding:0px 6px;overflow:hidden;width:12px;background:#e2e2e2;height:110px;font-size:10px;float:left;display:block;writing-mode:lr-tb;overflow:hidden;text-align:center;}
	.picScroll .bd li span.pic{display:block;float:left;height:100%;}
	.picScroll .hd .on{ background:#80BD6D;  }
	.picScroll .prev,.picScroll .next{ float:right;  width:18px; height:18px; background:url(/res/Home/structure/14128138.gif) -6px -7px no-repeat; overflow:hidden; margin:6px 5px 0 5px;  display:none;}
	.picScroll .next{ background-position:-34px -7px; }
	.picScroll .prevStop{ background-position:-6px -40px; }
	.picScroll .nextStop{ background-position:-34px -40px; }

</style>

<div id="picScroll" class="picScroll"  <%= (spl.size()>0?"":"style='display: none;'")  %> >
<%
if(spl.size()>0){
%>
<div class="hd">
						<span class="next"></span> 
						<ul></ul>
						<span class="prev"></span>
						<h3>套餐 共<%= spl.size() %>款</h3>
</div>
<div class="bd" style="">
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
   <script type="text/javascript">
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
</div>
<%-- <%
	if(p.category!=ShopCategory.getCategory("lzCategory")){
		List<ShopPackage> spl = ShopPackage.find(" AND product_id = "+product+" order by id ",0,100);
        if(spl.size()>0){
			out.print("<div class='packbox'>");
			out.print("<div class='packtit'>优惠套装</div>");
				out.print("<ul id='titul' class='titul'>");
					for(int i=0;i<spl.size();i++){
						out.print("<li class='"+(i==0?"fblue":"tz")+"'><a href='javascript:void(0);' onclick='showtab("+i+")'>优惠套装"+(i+1)+":"+spl.get(i).getPackageName()+"</a></li>");
					}
				out.print("</ul>");
				out.print("<div class='myulbox'>");
				out.print("<ul id='myul'>");
				for(int i=0;i<spl.size();i++){
					ShopPackage sp = spl.get(i);
					out.print("<li "+(i==0?"":" style='display: none;'")+" >");
					out.print("<div class='liIn'><img onload='AutoResizeImage(100,70,this)' src="+p.getPicture('s')+" alt="+p.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' /><br>");
					out.print(p.name[1]);
					String [] sarr = sp.getProduct_link_id().split("\\|");
					for(int j=1;j<sarr.length;j++){
						ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[j]));
						String[] arr1=s1.picture.split("[|]");
						out.print("</div><img src='/res/Home/structure/ico+.jpg' class='bod'>");
						out.print("<div class='liIn'><img onload='AutoResizeImage(100,70,this)' src="+s1.getPicture('s')+" alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' /><br>");
						out.print(s1.name[1]);
						//out.print(s1.price);
					}
					out.print("</div><div class='right'><img src='/res/Home/structure/ico=.jpg' class='bod'>");
					out.print("<div class='yesl'>套餐价：<span class='org'>"+sp.getSetPrice()+"</span><br>");
					out.print("原价：<span class='del'>"+sp.getPrice()+"</span><br>");
					out.print("立即节省：<span class='blues'>"+(sp.getPrice()-sp.getSetPrice())+"</span><br/>");
					if(!sc.offswitch)
						out.print("<input type='button' class='btns' value='购买套餐' onClick=car.add("+sp.getId()+",1,'/xhtml/folder/14110112-1.htm') />");
					out.print("</div></div>");
					out.print("</li>");
				}
				out.print("</ul>");
				out.print("</div>");
				out.print("</div>");
        }
	}
%> --%>

<div class="<%out.print(p.view_type==1?"p1":"p2");%>">

		<%
		
		List<ShopProduct_data> spdlist=null;//文章/列表
		spdlist = ShopProduct_data.find(" AND hidden=0 AND (type=0 OR type=1) AND product_id = "+p.product+" order by type asc,sort asc", 0, 100);//在商品中查看商品的说明（文章/列表形式）
		
		if(spdlist.size()<1){
			spdlist = ShopProduct_data.find(" AND hidden=0 AND showtype=1 AND (type=0 OR type=1) AND category = "+p.category+" order by type asc,sort asc", 0, 100);//在商品中查看类的说明（文章/列表形式）
		}
		
		if(spdlist.size()>0){
			/*
			int count=0;
			int index=0;
			boolean display = false;
			out.print("<div class='switch'><ul>");
			for(int i=0;i<spdlist.size();i++){
				ShopProduct_data spd = spdlist.get(i);
				
				if(count%3==0){
					index++;
					display = true;
					//if(count!=0)
						//out.println("<br/>");
				}
				count++;
				out.println("<li><a href='###' onclick='mt.tab(this);mt.fit();' name='a_tab"+index+"' "+(display?"class='current'":"")+">"+spd.title+"</a></li>");
				display = false;
				//out.println("<div><table name='tab' "+(i==0?"":"style='display:none'")+"><tr><td>"+spd.content+"</td></tr></table></div>");
			}
			out.print("</ul></div>");
			count=0;
			index=0;
			display = false;
			for(int i=0;i<spdlist.size();i++){
				ShopProduct_data spd = spdlist.get(i);
				if(count%3==0){
					index++;
					display = true;
					//if(count!=0)
						//out.println("<br/>");
				}
				count++;
				if(spd.type==0){
					out.println("<div class='gous' name='tab"+index+"' "+(display?"":"style='display:none'")+">"+spd.content+"</div>");
					display = false;
				}else{
					out.println("<ul class='gous' name='tab"+index+"' "+(display?"":"style='display:none'")+">");
					display = false;
					List<ShopProduct_data_list> spdlMorelist=ShopProduct_data_list.find(" AND data_id="+spd.id,0,100);
					for(int j=0;j<spdlMorelist.size();j++){
						ShopProduct_data_list spdl = spdlMorelist.get(j);
						out.println("<li><a href='/xhtml/folder/14110146-1.htm?data_list_id="+spdl.id+"' target='_blank'>"+spdl.title+"</a></li>");
					}
					out.println("</ul>");
				}
				
			}
			*/
			
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
<div class='magess'>
<form name="zxForm" action="/ShopAdvisorys.do" method="post" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="act" value="submit"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
<input type="hidden" name="product_id" value="<%=product%>"/>
<div class="mtit">我要咨询</div>
<table id="tablecenter" cellspacing="0">
<tr><td colspan="2"><span style="color:#999999;font-size:12px">购买前，如果您有不清楚的地方，可以在线留言</span></td></tr>
  <tr>
    <!--<td align="right" valign="bottom">咨询内容:</td>-->
    <td align="left" class="textar" colspan="2"><textarea name="depict" rows="5" cols="80" alt="咨询内容" class="ttar"></textarea><div class='chus'><span id="info">还能输入</span><b id="count">200</b>字</div></td>
  </tr>
 <tr>
    
			    <td align="left" colspan="2"><div style="float:left">验证码：</div>
			    	<div class='very'><input style="text-transform: uppercase; width:93px;" alt="验证码" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off" class="input" style='width:100px'/>
					<a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a>
					看不清？<a href="javascript:mt.verifys()" style="color:blue">换一张</a>	</div>		    	
                    <div class="subss"><input type="button" onclick="submitZx()" value="提交咨询" class="subs"/></div>
    </td>
  </tr>
</table>

</form>

</div>
<div class='masgee'>
<form name="zxlistform" action="?">
<%
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
sql.append(" AND product_id="+product);
par.append("?product_id="+product);

sql.append(" AND isDelete=0");
par.append("&isDelete=0");

sql.append(" AND replymember>0");
par.append("&replymember>0");

int pos=h.getInt("pos");
int sum=ShopAdvisory.count(sql.toString());
par.append("&pos=");

%>
<div class="divcenter">
<table id="tablecenter" cellspacing="0" width="100%">
	<%
	if(sum<1)
	{
	    //out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
	}else{
		sql.append(" order by createdate desc");
		List<ShopAdvisory> salist = ShopAdvisory.find(sql.toString(),pos,2);
		for(int i=0;i<salist.size();i++){
			ShopAdvisory sa = salist.get(i);
			String uname = MT.f(Profile.find(sa.getMember()).member);
		    String replayuname = MT.f(Profile.find(sa.getReplyMember()).member);
			out.println("<tr><td>");
			out.println("<div class='mastit'><strong>"+uname+"</strong><span>发表于："+MT.f(sa.getCreatedate(),1)+"</span></div>");
			out.println("</td></tr>");
			out.println("<tr><td>");
			out.println("<div class='madcon'>"+MT.f(sa.getDepict())+"</div>");
			out.println("</td></tr>");
			out.println("<tr><td>");
			out.println("<div class='rl'><div class='rcon'>"+MT.f(sa.getReplycont())+"</div>");
			//out.println("</td></tr>");
			//out.println("<tr><td>");
			out.println("<div class='rltit'><strong>"+replayuname+"</strong>&nbsp;&nbsp;&nbsp;&nbsp;发表于："+MT.f(sa.getReplyTime(),1)+"</div></div>");
			out.println("</td></tr>");
		}
	}
	
	%>
 
</table>
</div>
</form>
</div>

<%
List<ShopProduct> splist = ShopProduct.find(" AND state=0 AND category="+p.category+" AND product!="+product+" order by product desc",0,6);
if(splist.size()>0){
	out.println("<div class='othesList'>");
	out.println("<div class='otit'>您可能还需要以下产品</div>");
	out.println("<ul>");
	for(int i=0;i<splist.size();i++){
		ShopProduct likesp = splist.get(i);
		out.println("<li><div class='likeLeft'>");
		out.println("<a href='javascript:void(0);' onclick=parent.location='/xhtml/folder/14110010-1.htm?product="+likesp.product+"' ><img src='" + likesp.getPicture('b') + "'  onerror='javascript:this.src=\"/tea/image/404.jpg\"' /></a>");
		out.println("</div>");
		out.println("<div class='likeRight'>");
		out.println("<span ><a href='javascript:void(0);' onclick=parent.location='/xhtml/folder/14110010-1.htm?product="+likesp.product+"'  title='"+likesp.name[1]+"'>"+MT.f(likesp.name[1],10)+"</a></span>");
			float price2 = likesp.price;
			if(pf.qualification==1&&likesp.category==ShopCategory.getCategory("lzCategory")){
				ShopQualification sq = ShopQualification.findByMember(h.member);
				if(sq.id>0){
					ShopPriceSet sps = ShopPriceSet.find(sq.hospital_id,likesp.product,0);
					if(sps.price>0){
						price2=sps.price;
					}
				}			
			}
			if(pf.membertype==2){//代理商价格
					ShopPriceSet sps = ShopPriceSet.find(1,likesp.product,0);
					if(sps.price>0){
						price2=sps.price;
					}
			}
			if(likesp.price_display==1){
				String priceStr = "";
				if("".equals(MT.f(likesp.price_type)))
					priceStr = "面议";
				else
					priceStr = likesp.price_type;
				out.print("<span class='orgs'>&yen;"+priceStr+"</span>");
			}else{
				out.print("<span class='orgs'>&yen;"+price2+"</span>");
			}
		//out.println("<span class='orgs'>&yen;"+price2+"</span>");
		if(!sc.offswitch && likesp.price_display == 0)
		{
			out.println("<span class='gobtns'><input type='button' onclick=car.add("+likesp.product+",1,'/xhtml/folder/14110112-1.htm') value='加入购物车'/></span>");
		}
		out.println("</div></li>");
	}
	out.println("</ul>");
	out.println("</div>");
	out.println("</div>");
}
%>
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
	var re = /^[1-9]+[0-9]*]*$/;
	if(!re.test(quantity) ||  parseInt(quantity)!=quantity || parseInt(quantity)<1){
		document.getElementById("quantity").value = 1;
		return;
    }
	if(quantity>=200){
		document.getElementById("quantity").value=quantity.substring(0,quantity.length-1);
		mt.show("商品数量不能大于200");
	}
}

/*商品数量+1*/
function numAdd(){
	var quantity = document.getElementById("quantity").value;
 	var num_add = parseInt(quantity)+1;
 	if(quantity==""){
 	 	num_add = 1;
 	}
 	if(num_add>=200){
 		document.getElementById("quantity").value=num_add-1;
 		mt.show("商品数量不能大于200");
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
<script>
mt.fit();
</script>
</body>
</html>
