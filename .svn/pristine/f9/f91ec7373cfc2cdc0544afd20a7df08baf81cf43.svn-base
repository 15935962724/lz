<%@page import="tea.entity.yl.shop.*"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
/* if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
} */
/* 

Site s=Site.find(1); */

String act = h.get("act");
if("checkCart".equals(act))
{
	int checkLength = 0;
	boolean isLzCategory = false;
	boolean includeLzCar = false;
	String[] ps=h.getCook("cart","|").split("[|]");
	for(int i=1;i<ps.length;i++){
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
	}
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
}

String[] ps=h.getCook("cart","|").split("[|]");
boolean flag = false;
//boolean buyflag = false;

%><!doctype html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<script src="/tea/load.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">

<title>购物车订单</title>


</head>
<body>
<header class="header"><a href="javascript:history.go(-1)"></a>购物车订单</header>


<%-- <%=s.header%> --%>

<%
if(ps.length<1)
{
  out.print("<div class='cartnone'>购物车内暂时没有商品，您可以去首页挑选喜欢的商品</div>");
}else
{
%>

<form name="fcar" action="/Favs.do" method="post" target="_ajax">
<input type="hidden" name="fav"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<div class='radiusBox newlist wSpan'>
<ul class='seachr'>

<%

	for(int i=1;i<ps.length;i++){
		String[] arr=ps[i].split("&");
		//判断product_id是否商品的id，如果不是则为套装id
	    int product_id=Integer.parseInt(arr[0]);
	    int quantity=Integer.parseInt(arr[1]);//数量
	    
		ShopProduct p=ShopProduct.find(product_id);
		ShopPackage spage = new ShopPackage(0);
		List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
	    String pname = "";
	    float price = 0.0f;
	    
	    if(p.isExist){
	    	  /* if(p.category==ShopCategory.getCategory("lzCategory")){//商品中有粒子
		    	  buyflag = true;
		      } */
			  pname=p.getAnchorX(h.language);
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
	    out.println("<li  class='"+(p.isExist?"proCar":"tzCar")+"' >");
		  /* out.println("<td style='display:none;'>");
		  if(p.isExist)
			  out.println(p.getAnchor('t'));
		  out.println("</td>"); */
		  out.print("<input type='checkbox' value='"+ps[i]+"' name='proid' class='checkbox' id='check_item' onclick='chemy(this);car.update0(this,"+product_id+");'/>");
		  out.println(pname+"</li>");
		  //out.println("</td>");
		  //out.println("<em>&yen;"+price+"</em></li>");
		  //out.println("<td align='center' valign='middle' class='td_01'  nowrap colspan='2'>");
		  out.println("<li class='proCar dlt'><a class='qsub' href='javascript:void();' onClick='car.update(this,false)'>-</a><input name='quantity' class='quan'  value='"+arr[1]+"'  product='"+ps[i]+"' price='"+price+"' onChange='car.update(this)' /><a href='javascript:void();'class='qsub' onClick='car.update(this,true)'>+</a>");
		  out.print("<a href='###' onClick=\"car.del(this,'"+ps[i]+"','"+(p.isExist?MT.f(p.name[h.language]):"[套装]"+MT.f(spage.getPackageName()))+"')\">删除</a>");
		  out.println("</li>");
	    
		if(!p.isExist){
			for(int n=0;n<spagePList.size();n++){
			    ShopProduct s1 = spagePList.get(n);
			    price = s1.price;
			    out.println("<li class='tzproCar'>");
		    	//out.println("<td></td>");
		    	out.println(s1.getAnchorX(h.language));
		    	out.println("&nbsp;"+price);
		    	//out.println("<td></td>");
		    	//out.println("<td></td>");
		    	out.println("</li>");
			}
		}
	}

%>
<li><input type='checkbox' name='allproid' class="checkbox" id="cheallNode" onclick="cheall(this);car.update0(this);"/>全选　<a onclick="delche()" href="javascript:void();" /><b>ｘ</b>&nbsp;删除选中商品</a></td>
</li>
<!--<tr>
<td colspan="5" align="right" class='textright'>
<!-- 重量总计：<span id="gross">0.00</span>kg　原始金额：￥<span id="price">0.00</span>元  --><!-- - 返现：￥0.00元 -->
<!-- <br/> </td></tr>-->
<li class='total'>合计：<em>&yen;<dfn id="total">0.00</dfn></em> 元</li>
<!-- <li><button onclick="parent.location='/xhtml/folder/14100002-1.htm';">继续购物</button> -->

<li><button type="button" class='btn2' value="" onClick="<%= (flag?"alert('购物车里有下架商品不能提交！');":"checkCart()")%>"/>去结算&gt;&gt;</button></li>
</ul>
</div>
</form>

<%
}
%>

<script>
//car.update(null);
fcar.nexturl.value=location.pathname+location.search;
</script>
</div>
</div>
<div class="Mybottom"></div>
</div>
<script type="text/javascript">
my.del=function(a,p,n)
{
  mt.show(mt.res("确定要删除“{0}”吗？",n),2);
  mt.ok=function()
  {
    cookie.set('cart',cookie.get('cart').replace(new RegExp("[|]"+p.substring(0,p.lastIndexOf('&')+1)+"\\d+[|]"),"|"));
    location.reload();
  };
}

function checkCart(){
	mt.send("?act=checkCart",
		function(d){
			if(d==1){
				parent.location='/mobjsp/yl/shopweb/ShopOrderForm_wx.jsp';
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
cheall(cheallNode);
car.update0(cheallNode);
</script>
<script>
/* $(function(){
	//单独选择某一个
	$("input[name='proid']").click(function(){
			var index=$("input[name='proid']").index(this);
			$("input[name='proid']").eq(index).toggleClass("checked");//伪复选
	});	
	//全选
	$("#check_all,#box_all").click(function(){
     $("input[name='proid']").attr("checked",$(this).attr("checked"));
	 $("input[name='proid'],#check_all,#box_all").toggleClass("checked");
	});

}); */
</script>
<script>
mt.fit();
</script>
<%-- <%=s.footer%> --%>
</body>
</html>
