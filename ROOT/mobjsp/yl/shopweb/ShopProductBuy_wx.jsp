<%@page import="org.apache.fop.datatypes.FixedLength"%>
<%@page import="tea.ui.yl.shop.ShopIntegralRuless"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.db.DbAdapter"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%


Http h=new Http(request,response);
Filex.logs("gdhWXLogOut.txt", "member="+h.member);

String community = h.get("community","");
if(community.equals("")){
community = h.getCook("community", "Home");
}
h.setCook("community", community, Integer.MAX_VALUE);

if(true){
	out.print("<script>alert('因网站改版，请重新关注微信进行操作！');</script>");
return;
}

    String openid=h.getCook("openid",null);
	if(openid==null){
		response.sendRedirect("/PhoneProjectReport.do?act=openid&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()+"&r="+Math.random()));
		return;
	}
	
	List<Profile> lstp= Profile.find1(" and openid="+DbAdapter.cite(openid), 0, 1);
	if(lstp.size()==0){
		String param = request.getQueryString();
		String url = request.getRequestURI();
		if(param != null)
			url = url + "?" + param;
		response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
		return;
	}
	Profile p1=lstp.get(0);
	if(p1.profile>0){
		h.member=p1.profile;
		session.setAttribute("member",h.member);
		//out.print("<script>alert('a:"+h.member+"');</script>");
		
	}
/* if(h.member<1){
	String param = request.getQueryString();
	String url = request.getRequestURI();
	if(param != null)
		url = url + "?" + param;
	response.sendRedirect("/mobjsp/yl/user/login_wx.jsp?nexturl="+url);
	return;
} */
//out.print("<script>alert('a:"+h.member+"');</script>");
int product=h.getInt("product");
//product=15010269;
ShopProduct p=ShopProduct.find(product);
if(!p.isExist){
  response.sendError(404);
  return;
}
//购买粒子验证
String act = h.get("act");
if("checkOrder".equals(act)){
	Profile myp = Profile.find(h.member);
	
	//判断是否具有购买资质
	if(myp.qualification!=1 && myp.membertype!=2){
		out.print("对不起！您还未提交资质或已提交但审核未通过或资质已过期，不能去结算，请尽快提交您资质审核资料！<br/>如想尽快完成订，请致电：<b style='color:#FF7F00;font-size:16px'>010-68533123</b>");
		return;
	}
	out.print(1);
	return;
}
//商品分类
ShopCategory sc = ShopCategory.find(p.category);

%>
<!DOCTYPE html><html><head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src='/tea/jquery.js' type="text/javascript"></script>
	<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
	<script src="/tea/mt.js" type="text/javascript"></script>
	<title>申购粒子</title>
</head>
<body>
<header class="header"><!-- <a href="javascript:history.go(-1)"></a> -->申购粒子</header>

<div class='bigtit'>
	<h2><%=p.name[1] %></h2>
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
	%>
		<li class='are'>
			<span>购买数量：</span>
			<a href='###' onclick='numDec()'>-</a>
			<input type='text' id='quantity' value='1' onkeyup='keyup(this)' />
			<a href='###' onclick='numAdd()'>+</a>
		</li>
		<li><button type="button" onclick="checkOrder()">立即购买</button></li>
	</ul>
</div>

<script type="text/javascript">

	/*商品数量框输入*/
	function keyup(va){
		var quantity = document.getElementById("quantity").value;
		var re = /^[0-9]+[0-9]*]*$/;
		if(!re.test(quantity)){
			document.getElementById("quantity").value = quantity.replace(/\D/g,'');
			return;
	    }
		
		if(parseInt(quantity)>2000){
			document.getElementById("quantity").value=2000;
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
	 	if(num_add>2000){
	 		document.getElementById("quantity").value=2000;
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
	
	//提交验证
	function checkOrder(){
		
		var product = "<%=product%>";
		var price = "<%=price%>";
		var quantity = document.getElementById("quantity").value;
		if(quantity == 0 || quantity == ""){
			quantity = 1;
			document.getElementById("quantity").value=1;
			mt.show("商品数量必须大于0");
			return;
		}
		mt.send("?act=checkOrder&product=<%=product%>",
			function(d){
				if(d==1){
					parent.location="/mobjsp/yl/shopweb/ShopOrderForm_wx.jsp?product="+product+"&price="+price+"&quantity="+quantity;
				}else{
					mt.show(d);
				}
			}
		);
	}
</script>
</body>
</html>
