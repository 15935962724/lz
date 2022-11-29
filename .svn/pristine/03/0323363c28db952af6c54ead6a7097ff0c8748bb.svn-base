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

//product=14102773;
ShopProduct p=ShopProduct.find(product);
/* if(!p.isExist)
{
  response.sendError(404);

  return;
} */
//p.updateclick();




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

boolean isinterval = false;

List<ProcurementUnitJoin> pujlist = ProcurementUnitJoin.find(" AND profile = "+h.member, 0, Integer.MAX_VALUE);

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
<!-- <style>
.bigtit{border:none;margin-bottom:0;}
.rightin{border:none}
.bigtit h1{font-size:18px;font-weight: bold;}
.rights ul li strong{font-size:18px;}
.rights ul li{font-size:14px;}
.lefts{margin-top:47px;}
.rights{margin-top:15px;}
.rights{width:500px;}
.lefts{width:413px;}
.rights ul{width:100%;}
.sharbox input{background:#df6c0a;width:126px;height:40px;text-indent:0;font-weight: normal;border-radius:4px}
.rightin select{width:254px;height:29px;border:1px solid #cacaca;}
.rights ul li i{height:33px;width:100px;display:inline-block;text-align: center;line-height:33px;font-size:14px;margin-right:10px;}
.rights #quantity{height:29px;width:63px;margin:0;border:none;border-top:1px solid #cacaca;border-bottom:1px solid #cacaca;float:left;}
.rights ul .are a{width:31px;height:29px;border:none;display: inline-block;line-height:28px;text-align: center;font-weight: bold;font-size:21px;border:none;border:1px solid #cacaca;background:#ededed;float:left;}
.tb-s310, .tb-s310 img{max-width:411px;max-height:415px;}
.tb-s310, .tb-s310 a{width:413px;height:415px;}
.box{width:413px;}
.tb-s310{background: #f8f8f8;}
.tb-booth{border:none;}
.tb-thumb li{background: #f8f8f8;margin:0;padding:0;border:2px solid #f8f8f8;margin-top:12px;margin-left:20px;height:114px;width:105px;padding:2px;}
.tb-thumb li div{border:none;}
.prod-tit{font-size:18px;border-bottom:1px solid #eee;font-weight: bold;margin-bottom:20px;padding-bottom:10px;}
.prod-con{margin-top:30px;}
.p2{border:none;}
.tb-s40, .tb-s40 a{width:101px;height:107px;}
.tb-thumb .tb-selected{border:2px solid #df6c0a;height:auto;background: #f8f8f8;padding:0}
.pro-slide{overflow: hidden;position: relative;margin-top:15px;}
.next{display: block;width: 21px;height: 30px;overflow: hidden;cursor: pointer;background: url(/tea/yl/img/next.png) 0 0 no-repeat;position: absolute;top: 47px;right: -2px;}
.prev{display: block;width: 21px;height: 30px;overflow: hidden;cursor: pointer;background: url(/tea/yl/img/prev.png) 0 0 no-repeat;position: absolute;top: 47px;}
.pro-slide .bd{padding:0 20px;}
</style> -->
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
		<%
		if(!sc.offswitch)
		{
		%>
		<!-- <div class='cartsbtn'><span><%=carSum>0?carSum:"0"%></span><a href="/html/folder/19060267-1.htm" target='_blank'>去购物车结算</a></div> -->
		<%
		}
		%>
	</div>
<form action="" name='form1'>
<input name='category' value='<%= category %>' type="hidden" />
<input name='product' value='<%= product %>' type="hidden" />
<input name='attribute' value='<%= MT.f(sc.attribute) %>' type="hidden" />
<input name='productstockcount' value='0' type="hidden" />

<div class='rightin'>
		<ul>
			<%

			/* Profile profile = Profile.find(h.member);
			String [] hoarr = profile.hospitals.split("\\|");

			String hostr = "";

if(hoarr.length<1)
{
	hostr += "<option>暂无医院</option>";
}else
{
	for(int i=1;i<hoarr.length;i++){
		ShopHospital s1 = ShopHospital.find(Integer.parseInt(hoarr[i]));
		hostr += "<option>"+s1.getName()+"</option>";
	}
} */
Profile pf = Profile.find(h.member);
if(product>0){
	float price = p.price;
	/* if(pf.qualification==1&&category==ShopCategory.getCategory("lzCategory")){
		ShopQualification sq = ShopQualification.findByMember(h.member);
		if(sq.id>0){
			ShopPriceSet sps = ShopPriceSet.find(sq.hospital_id,product,0);
			if(sps.price>0){
				price=sps.price;
			}
		}
	} */
	//所有改为展示商品显示价格
	if(pf.membertype==2||pf.membertype==3){//代理商价格
		/* ShopPriceSet sps = ShopPriceSet.find(1,product,0);
		if(sps.price>0){
			price=sps.price;
		} */
		/*float myprice = ShopPriceSet.findpirce(p, hosid, h.member);
		if(myprice>0){
			price = myprice;
		} */
		ShopPriceSet sps = ShopPriceSet.find(hosid,product,0);
		if(sps.agentPrice>0){
			price=sps.price;
		}
	}

	if(p.price_display==1){
		String priceStr = "";
		if("".equals(MT.f(p.price_type)))
			priceStr = "面议";
		else
			priceStr = p.price_type;
		out.print("<li style='border-bottom: solid 1px #eeeeee;padding-bottom: 10px;'><strong>&nbsp;"+ price +"</strong></li>");
	}else{
		out.print("<li style='border-bottom: solid 1px #eeeeee;padding-bottom: 10px;'><strong>&yen;&nbsp;"+ price +"</strong></li>");
	}
			out.print("<li style='margin-top:20px'>商品编号："+MT.f(p.yucode)+"</li>");
			}
				out.print("<li>选择医院：<select onchange='changehos(this)' class='hosids' name='hosid'><option value='0'>请选择医院</option></select></li>");
			/*

			String pustr = "";
			List<ProcurementUnitJoin> pujlist = ProcurementUnitJoin.find(" AND profile = "+h.member, 0, Integer.MAX_VALUE);
			if(pujlist.size()<1)
			{
				pustr += "<option>暂无厂商</option>";
			}else{
				for(int i=0;i<pujlist.size();i++){
					ProcurementUnitJoin puj = pujlist.get(i);
					ProcurementUnit pu = ProcurementUnit.find(puj.puid);
					pustr += "<option>"+pu.getName()+"</option>";
				}
			} */


				out.print("<li>选择厂商：<select class='pusids' onchange='changepus(this)' name='pusid'><option value='0'>请选择厂商</option></select></li>");




				if(pf.membertype!=2&&pf.membertype!=3) {//不是代理商
					if(product>0) {
						float price = p.price;
						ArrayList alist=ShopIntegralRules.find(" and item=0", 0, 1);
						if(alist.size()>0){
							int integral=((ShopIntegralRules)alist.get(0)).getIntegral();
							if(integral>0&&category==ShopCategory.getCategory("lzCategory")){
								out.print("<li style='border-bottom:1px solid #eeeeee;padding-bottom:10px;'>商品积分："+(int)price/integral+"</li>");
							}
						}
					}
				}


				/*if(p.activity!=null&&p.activity.length()>0){
					out.println("<li class='xxiang'>促销信息：<span class='org'>"+MT.f(p.activity.replaceAll("<[^>]+>|&nbsp;",""),20));
					if(p.activity.length()>=20){
						//out.println("&nbsp;&nbsp;<a href=javascript:mt.show('"+p.activity+"'); target='_blank'>详情</a>");
						out.println("</span>&nbsp;&nbsp;<a href='/html/folder/14110148-1.htm?product="+p.product+"' target='_blank'>详情</a>");
					}
					out.println("</li>");
				}*/
			%>
			<li class='huod'  style="border-top: solid 1px #eeeeee;padding-top: 20px;margin-top:20px;"><span><%= MT.f(sc.attribute) %>：</span><i>暂无规格</i></li>
			<%
			//商品规格类型
			/* if(p.category>0&&p.model_id>0){
				List<ShopProductModel> spmlist = ShopProductModel.find(" AND category = "+p.category, 0, 100);
				if(spmlist.size()>0){
					if(MT.f(sc.attribute)!=null&&MT.f(sc.attribute).length()>0){
						out.println("<li class='huod' style="border-top: solid 1px #eeeeee;padding-top: 20px;margin-top:20px;"><span>"+MT.f(sc.attribute)+"：</span>");
						for(int i=0;i<spmlist.size();i++){
							ShopProductModel spm = spmlist.get(i);
							ShopProduct sp = ShopProduct.find(p.brand,spm.getId());
							if(sp.product>0)
								out.println("<i "+(spm.getId()==p.model_id?"class='bgred'":"")+"><a href='/html/folder/19041058-1.htm?product="+sp.product+"' target='_parent'>"+spm.getModel()+"</a></i>");
						}
						out.println("</li>");
					}

				}

			} */
			double activityMinmy = 0;
			double activityMaxmy = 0;
			if(p.product>0){
				boolean isLiziClazz = false;
				if(p.category==ShopCategory.getCategory("lzCategory"))
						      {
			    				  isLiziClazz = true;
						      }
				if(isLiziClazz){
					int actcheck = 0;
			    			StringBuffer caliBuff = new StringBuffer("<li >");
			    			if(p.model_id>0){
				    	    	ShopProductModel spm = ShopProductModel.find(p.model_id);
				    	    	String activityStr = spm.getModel().replaceAll("[a-zA-Z]","");
				    	    	if(activityStr.contains("[")){
									activityStr = activityStr.split("\\[")[0];
								}
				    	    	if(activityStr.indexOf("-")!=-1){
				    	    		String[] activityArr = activityStr.split("-");
				    	    		Double activityMin =  Double.parseDouble(activityArr[0]);
				    	    		Double activityMax =  Double.parseDouble(activityArr[1]);
				    	    		activityMinmy = activityMin;
				    	    		activityMaxmy = activityMax;
				    	    		isinterval = true;
				    	    		if(Config.getInt("junan")==p.puid){
				    	    			actcheck = 1;
					    	    		caliBuff.append("<span>　　　　　</span><input alt='粒子活度' title='粒子活度范围："+activityStr+"' style='width:210px;height:30px;padding:0 5px;border:1px solid #cacaca;' class='activity' name='activity' value='' onkeyup=\"keyupActivity(this)\" onblur=\"blurActivity(this,"+activityMin+","+activityMax+")\" />");
				    	    		}else{
				    	    			caliBuff.append("<input class='activity' name='activity' type='hidden' value='0' />");
				    	    		}
				    	    	}else{
					    	    	caliBuff.append("<input class='activity' name='activity' type='hidden' value='0' />");
					    	    }
				    	    }
				    	    //caliBuff.append("校准时间：<input alt='校准时间' name='calidate_"+product_id+"' value='' onClick='mt.date(this,false,\""+new Date()+"\",\""+maxDate+"\")' readonly style='width:100px' class='date'/>");
				    	    caliBuff.append("<input name='actcheck' value='"+actcheck+"' type='hidden' /></li>");
			    			out.println(caliBuff.toString());
			    		}
			}
			if(Config.getInt("junan")==p.puid){
				//out.print("<li class='productstockcount'>库存数量：暂无</li>");
			}
			//选择商品
			if(product>0){
				//商品数量

					out.println("<li class='are are3'><span style='float:left;line-height:30px;'>购买数量：</span><a href='###' onclick='numDec()' style='color:#ccc;'>-</a><input type='text' name='quantity' id='quantity' value='1' onkeyup='keyup()'/><a href='###' onclick='numAdd()' style='color:#000;'>+</a></li>");

			}

			%>


</ul>
<!-- <ul class="brand">
	<li>
	<%
		ShopBrand sb = ShopBrand.find(p.brand);
		if(!"".equals(MT.f(sb.logo,""))){
			out.println("<img onload='AutoResizeImage(200,50,this)' src='"+ sb.logo +"'>");
		}
	%>
	</li>
	<%
		if(ShopCategory.getCategory("lzCategory")==category){
			out.print("<li class='Btext'>法定工作日8:30至16:30处理订单并安排发货(非法定假日的周六将在8:30至14:30处理订单并安排发货)，否则将顺延至下一工作区间处理。遇特殊节假日，将在网站首页通知接受订单及发货时间；</li>");
		}
	%>
</ul>		 -->

</div>
</form>

<div class='sharbox'>
<span style="float:left;">　　　　　</span>
<input type="button" value="立即购买" onClick="<%= (pf.membertype==0?"mt.show('由于粒子产品的特殊性，普通用户无法购买，请申请成为医生用户或服务商用户进行购买！');":"addcar('"+product+"')")%>"/>
<!-- <span class="sharein"><div class="bshare-custom"><div class="bsPromo bsPromo2"></div>分享到：<a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=2ddd3036-1080-4a31-a715-a180bd963380&amp;pophcol=1&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="/tea/bshareC0.js"></script></span> -->
<script type="text/javascript" charset="utf-8">
bShare.addEntry({
    title: "<%=p.name[1]%>",
    url: parent.location.href,
    summary: "粒子治疗“一站式”解决方案",
    pic: "http://"+location.host+"<%=p.getPicture('s')%>"
});
</script>
</div>
</div>
<div style='height:5px;font-size:0;clear:both;overflow:hidden'></div>

<%
	/* if(p.category!=ShopCategory.getCategory("lzCategory")){
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
					out.print("<div class='liIn'><a href='/html/folder/19041058-1.htm?product="+p.product+"' target='_blank'><img onload='AutoResizeImage(100,70,this)' src="+p.getPicture('s')+" alt="+p.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' /></a><br>");
					out.print(p.getAnchor(h.language));
					String [] sarr = sp.getProduct_link_id().split("\\|");
					for(int j=1;j<sarr.length;j++){
						ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[j]));
						String[] arr1=s1.picture.split("[|]");
						out.print("</div><img src='/res/Home/structure/ico+.jpg' class='bod'>");
						out.print("<div class='liIn'><a href='/html/folder/19041058-1.htm?product="+s1.product+"' target='_blank'><img onload='AutoResizeImage(100,70,this)' src="+s1.getPicture('s')+" alt="+s1.name[1]+" onerror='javascript:this.src=\"/tea/image/404.jpg\"' /></a><br>");
						out.print(s1.getAnchor(h.language));
						out.print("<span style='font-size:13px;color:#b80c38;'>&yen;</span>&nbsp;<span style='color:#b80c38;'>"+s1.price+"</span>");
					}
					out.print("</div><div class='right'><img src='/res/Home/structure/ico=.jpg' class='bod'>");
					out.print("<div class='yesl'>套餐价：<span class='org'><span style='font-size:13px;'>&yen;</span>&nbsp;"+sp.getSetPrice()+"</span><br>");
					out.print("原价：<span class='del'><span style='font-size:13px;'>&yen;</span>&nbsp;"+sp.getPrice()+"</span><br>");
					out.print("立即节省：<span class='blues'><span style='font-size:13px;'>&yen;</span>&nbsp;"+(sp.getPrice()-sp.getSetPrice())+"</span><br/>");
					if(!sc.offswitch)
						out.print("<input type='button' class='btns' value='购买套餐' onClick=car.add("+sp.getId()+",1,'/html/folder/14110112-1.htm') />");
					out.print("</div></div>");
					out.print("</li>");
				}
				out.print("</ul>");
				out.print("</div>");
				out.print("</div>");
        }
	} */
%>

<!-- <div class="<%out.print(p.view_type==1?"p1":"p2");%>">

		<%
		List<ShopProduct_data> spdlist=null;//文章/列表
		spdlist = ShopProduct_data.find(" AND hidden=0 AND (type=0 OR type=1) AND product_id = "+p.product+" order by type asc,sort asc", 0, (p.view_type!=2?100:1));//在商品中查看商品的说明（文章/列表形式）

		if(spdlist.size()<1){
			spdlist = ShopProduct_data.find(" AND hidden=0 AND showtype=1 AND (type=0 OR type=1) AND category = "+category+" order by type asc,sort asc", 0, (p.view_type!=2?100:1));//在商品中查看类的说明（文章/列表形式）
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
						out.println("<li><a href='/html/folder/14110146-1.htm?data_list_id="+spdl.id+"' target='_blank'>"+spdl.title+"</a></li>");
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
				if(i%4 == 1){
					index++;
					out.print("<div class='switch'><ul>");
					out.println("<li><a href='###' onclick='mt.tab(this);mt.fit();' name='a_tab"+index+"' class='current'>"+spd.title+"</a></li>");
				}else if(i%4 == 0){
					out.println("<li><a href='###' onclick='mt.tab(this);mt.fit();' name='a_tab"+index+"' class=''>"+spd.title+"</a></li>");
					out.print("</ul></div>");
					//页签里的内容
					index1++;
					boolean display = true;
					int j = 0;
					for(j=i-4;j<i;j++){
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

</div> -->
<!-- 产品详情 -->
<div class='prod-con'>
	<p class='prod-tit'>产品详细</p>
	<div><%= p.activity %></div>
</div>
<!-- <div class='magess'>
<form name="zxForm" action="/ShopAdvisorys.do" method="post" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="act" value="submit"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
<input type="hidden" name="product_id" value="<%=product%>"/>
<div class="mtit">我要咨询</div>
<table id="tablecenter" cellspacing="0">
<tr><td width="80">&nbsp;</td><td><span style="color:#999999;font-size:12px">购买前，如果您有不清楚的地方，可以在线留言</span></td></tr>
  <tr>
    <td align="right">咨询内容：</td>
    <td align="left" class="textar"><textarea name="depict" rows="5" cols="80" alt="咨询内容"></textarea><div class='chus'><span id="info">还能输入</span><b id="count">200</b>字</div></td>
  </tr>
 <tr>
    <td>&nbsp;</td>
			    <td align="left"><div style="float:left">验证码：</div>
			    	<div class='very'><input style="text-transform: uppercase; width:93px;" alt="验证码" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off" class="input" style='width:100px'/>
					<a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a>
					看不清？<a href="javascript:mt.verifys()" style="color:blue">换一张</a>	</div>		    	<input type="button" onclick="submitZx()" value="提交咨询" class="subs"/>
    </td>
  </tr>
</table>

</form>

</div> -->
<div class='masgee'>
<form name="zxlistform" action="?">
<%
StringBuffer sql=new StringBuffer(),par=new StringBuffer();
sql.append(" AND product_id="+product);
par.append("?product="+product);

sql.append(" AND isDelete=0");
par.append("&isDelete=0");

sql.append(" AND replymember>0");

int pos=h.getInt("pos");
int sum=ShopAdvisory.count(sql.toString());
par.append("&pos=");

	if(sum>0){
		out.println("<table id='tablecenter' cellspacing='0' width='100%'>");
		sql.append(" order by createdate desc");
		List<ShopAdvisory> salist = ShopAdvisory.find(sql.toString(),pos,20);
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
			out.println("<div class='rl'><i>&nbsp;</i><div class='rcon'>"+MT.f(sa.getReplycont())+"</div>");
			//out.println("</td></tr>");
			//out.println("<tr><td>");
			out.println("<div class='rltit'><strong>"+replayuname+"</strong>&nbsp;&nbsp;&nbsp;&nbsp;发表于："+MT.f(sa.getReplyTime(),1)+"</div></div>");
			out.println("</td></tr>");
		}
		if(sum>20)out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20));
		out.println("</table>");
	}
	%>

</form>
</div>

<%
if(category==ShopCategory.getCategory("lzCategory")){
	//List<ShopProduct> splist = ShopProduct.find(" AND state=0 AND category="+p.category+" AND product!="+product+" order by product desc",0,6);
	List<ShopProduct> splist = ShopProduct.find(" AND state=0 AND category="+ShopCategory.getCategory("qxCategory")+" order by product desc",0,6);
	if(splist.size()>0){
		out.println("<div class='othesList'>");
		out.println("<div class='otit'>您可以还需要以下产品</div>");
		out.println("<ul>");
		for(int i=0;i<splist.size();i++){
			ShopProduct likesp = splist.get(i);
			out.println("<li><div class='likeLeft'>");
			out.println("<a href='/html/folder/19041058-1.htm?product="+likesp.product+"' target='_blank'><img onload='AutoResizeImage(110,80,this)' src='" + likesp.getPicture('s') + "' onerror='javascript:this.src=\"/tea/image/404.jpg\"' /></a>");
			out.println("</div>");
			out.println("<div class='likeRight'>");
			out.println("<span ><a href='/html/folder/19041058-1.htm?product="+likesp.product+"' target='_blank' title='"+likesp.name[1]+"'>"+MT.f(likesp.name[1],10)+"</a></span>");
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
				if(pf.membertype==2||pf.membertype==3){//代理商价格
						ShopPriceSet sps = ShopPriceSet.find(1,likesp.product,0);
						if(sps.price>0){
							price2=sps.price;
						}
				}
			out.println("<span class='orgs'>&yen;&nbsp;"+price2+"</span>");
			if(!sc.offswitch)
			{
				out.println("<span class='gobtns'><input type='button' onclick=car.add("+likesp.product+",1,'/html/folder/19060267-1.htm') value='加入购物车'/></span>");
			}
			out.println("</div></li>");
		}
		out.println("</ul>");
		out.println("</div>");
		out.println("</div>");
	}
}
%>

<script>
var perce = '<%=pf.membertype==2||pf.membertype==3?"0.03":"0.01" %>';
var junan = '<%=Config.getInt("junan")==p.puid?1:0 %>';
zxForm.nexturl.value=location.pathname+location.search;
mt.act=function(act,t){
	if("productbuy"==act){
		location = "ShopProductBuyUnit.jsp?product="+t;
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
	if(form1.pusid.value==0){
		mt.show("请选择厂商！");
		return;
	}
	if (showIsStopSupply(form1.pusid.value)){
		mt.show("该厂家已停止供货,请联系客服！");
		return;
	}

	mysub();
	//jQuery.cookie(product,form1.hosid.value, { expires: 30 });
	//car.add(product,document.getElementById('quantity').value,'/html/folder/14110112-1.htm');
	//console.log(jQuery.cookie(product)+"--");
	//console.log(jQuery.cookie(product)+"==");
}

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


		function findproduct(hosid,pusid,productid){
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
				var ops = "";
				if(data.data_list!=''){//是否存在数据
					for(var i=0;i<data.data_list.length;i++){
						var proObj = data.data_list[i];
						ops += "<i "+(productid==proObj.product?"class='bgred'":"")+" ><a  onclick=findproductdes('"+proObj.product+"') target='_parent'>"+proObj.model+"</a></i>";
					}
				}
				if(ops==""){
					ops = "<i>暂无规格</i>";
				}
				ops = "<span>"+form1.attribute.value+"：</span>"+ops;
					jQuery(".huod").html(ops);
			}
			});
		}

		function findproductdes(proid){
			//19052204 test
			//19060258 host
			//19070106 测试
			//location = '/html/folder/19052204-1.htm?product='+proid+"&hosid="+form1.hosid.value+"&pusid="+form1.pusid.value+"&category="+form1.category.value;
			//19080996 lz
			location = '/html/folder/19080996-1.htm?product='+proid+"&hosid="+form1.hosid.value+"&pusid="+form1.pusid.value+"&category="+form1.category.value;
}

		var activityMinmy= '<%= activityMinmy %>';
		var activityMaxmy = '<%= activityMaxmy %>';
		function mysub(){
			//form1.action = '/html/folder/19041335-1.htm';
			//form1.submit();
			if(<%= (product==0?"true":"false") %>) {
				mt.show("请选择购买活度!");
				return;
			}
			if(<%= isinterval %>){
				if(form1.activity.value==''){
					mt.show("请输入购买活度!");
					return;
				}
				var obj = jQuery(".activity")[0];
				//console.log(obj+"--"+obj.value);
					//obj.value = activityMinmy;
					if(form1.actcheck.value==1){
						if(obj.value!=''&&(obj.value<activityMinmy||obj.value>activityMaxmy)){
							mt.show("活度超出范围 "+activityMinmy+"-"+activityMaxmy+"！");
							//obj.value = activityMinmy;
							//console.log(activityMinmy);
							//jQuery(".activity").val(activityMinmy);
							//console.log(jQuery(".activity").val()+"==="+activityMinmy+"==="+jQuery(".activity").val());
							findProductStockCount();
							return;
						}
					}
			}

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
			//19070108 test
			//location = "/html/folder/14110150-1.htm?product="+form1.product.value+"&hosid="+form1.hosid.value+"&quantity="+form1.quantity.value+"&activity="+form1.activity.value;

			//19082377 test
			//sc 19092398
			location = "/html/folder/19092398-1.htm?product="+form1.product.value+"&hosid="+form1.hosid.value+"&quantity="+form1.quantity.value+"&activity="+form1.activity.value;
			//return;
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
					jQuery(".productstockcount").html("库存："+data.count);
					//console.log(data);
				}
				});
			}
		}
</script>

<style type="text/css">
	.rights #quantity{width: 63px;}
</style>
</body>
</html>
