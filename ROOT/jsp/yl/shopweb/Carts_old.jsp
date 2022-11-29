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
					+"已是网站会员，点击 <a href=javascript:parent.location='/html/folder/14102033-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>登录</a>"
					+"&nbsp;&nbsp;还不是网站会员，点击 <a href=javascript:parent.location='/html/folder/14102034-1.htm' target='_blank' style='font-weight:bold;font-size:14px;color:#0079D2'>注册</a>");
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
				out.print("对不起！您还未提交资质或已提交但审核未通过或资质已过期，不能去结算，请尽快提交您资质审核资料！<br/>如想尽快完成订，请致电：<b style='color:#FF7F00;font-size:16px'>010-12345678</b><p align='center'>我要提交 <a href='/html/folder/14110054-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>资质审核</a></p>");
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
<link href="/res/cssjs/base.css" rel="stylesheet" type="text/css"/>
<link href="/res/cssjs/my.css" rel="stylesheet" type="text/css"/>
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
<%-- <%=s.header%> --%>
<div class="Mycontent">
<div class="Mytop"></div>
<div class="Mycon">
<div class="ShoppingCart">
<ul class="Order_cart" id="Order_cart_S1">
	<li class="step1">1.我的购物车</li>
	<li class="step2">2.填写核对订单信息</li>
	<li class="step3">3.成功提交订单</li>
</ul>
<div class="cartimg"></div>
<%
if(ps.length<1)
{
  out.print("<div class='cartnone' style='height:98px;margin:0;background:#f3f3f3 url(/tea/image/cart-empty-bg.png) no-repeat 250px 22px'>购物车内暂时没有商品，您可以去<a href='/' style='color:#0079D2;'>首页</a>挑选喜欢的商品</div>");
}else
{
%>
<div class="carttitle">
<h2>我挑选的商品</h2>
<form name="fcar" action="/Favs.do" method="post" target="_ajax">
<input type="hidden" name="fav"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table class="cart" cellpadding="0" cellspacing="0">
<tr>
  <th style='text-align:left;width:60px;padding-left:15px'><label><input type="checkbox" onclick="cheall(this);car.update0(this);" id="cheallNode"/>&nbsp;全选</label></th>
  <th>商品图片</th>
  <th>商品名称</th>
  <th>商品单价</th>
  <th>规格型号</th>
  <th>选择医院</th>
  <th>商品数量</th>
  <th>操作</th>
</tr>
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
	    int hosid = Integer.parseInt(h.getCook(p.product+"","0"));
	    if(p.isExist){
	    	  /* if(p.category==ShopCategory.getCategory("lzCategory")){//商品中有粒子
		    	  buyflag = true;
		      } */
			  pname=p.getAnchor(h.language);
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
						/* ShopPriceSet sps = ShopPriceSet.find(1,p.product,0);
						if(sps.price>0){
							price=sps.price;
						} */
					float myprice = ShopPriceSet.findpirce(p, hosid, h.member);
					if(myprice>0){
						price = myprice;
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
	    out.print("<tr class='"+(p.isExist?"proCar":"tzCar")+"' >");
		out.print("<td style='text-align:left;padding-left:15px'><input type='checkbox' name='proid' value='"+ps[i]+"' onclick='car.update0(this,"+product_id+")'/>&nbsp;&nbsp;&nbsp;&nbsp;</td>");
	    out.print("<td>");
		  if(p.isExist)
			  out.print(p.getAnchor('t'));
		  out.print("</td>");
		  out.print("<td>"+pname);
		  out.print("</td>");
		  out.print("<td><span style='font-size:13px;'>&yen;</span>"+price+"</td>");
		  ShopProductModel spm = ShopProductModel.find(p.model_id);
		  out.print("<td>"+spm.getModel()+"</td>");
		  if(hosid==0){
		  	out.print("<td>无</td>");
		  }else{
			  ShopHospital sh =  ShopHospital.find(hosid);
			  out.print("<td>"+sh.getName()+"</td>");
		  }
			  
		  out.print("<td align='center' valign='middle' class='td_01'>");
		  out.print("<a class='qsub' href='javascript:;' onClick='car.update(this,false)'>-</a><input name='quantity' class='quan'  value='"+arr[1]+"'  product='"+ps[i]+"' price='"+price+"' onChange='car.update(this)' /><a href='javascript:;' onClick='car.update(this,true)'>+</a></td>");
		  out.print("<td><a href='###' onClick=\"car.del(this,'"+ps[i]+"','"+(p.isExist?MT.f(p.name[h.language]):"[套装]"+MT.f(spage.getPackageName()))+"')\">删除</a></td>");
		  out.print("</tr>");
	    
		if(!p.isExist){
			for(int n=0;n<spagePList.size();n++){
			    ShopProduct s1 = spagePList.get(n);
			    price = s1.price;
			    out.print("<tr class='tzproCar'>");
			    out.print("<td></td>");
		    	out.print("<td>"+s1.getAnchor('t')+"</td>");
		    	out.print("<td>"+s1.getAnchor(h.language)+"</td>");
		    	out.print("<td><span style='font-size:13px;'>&yen;</span>"+price+"</td>");
		    	out.print("<td></td>");
		    	out.print("<td></td>");
		    	out.print("</tr>");
			}
		}
	}

%>
<tr>
<td colspan="2" style='text-align:left;padding-left:15px'><span><label><input type="checkbox" onclick="cheall(this);car.update0(this)"/>&nbsp;全选</label></span><span class='delepc'><a href="javascript:delche()">删除选中的商品</a></span><span class='gobuy'><a href="javascript:location='/'">继续购物</a></span></td>
<td colspan="6" align="right" class='textright'>

<!-- 重量总计：<span id="gross">0.00</span>kg　原始金额：￥<span id="price">0.00</span>元  --><!-- - 返现：￥0.00元 -->
<!-- <br/> -->商品总金额：<b>&yen<span id="total">0.00</span>元</b></td></tr>
</table>
<div class="EmptyCart">
<!-- <a href="javascript:car.clear();">清空购物车</a>
<input type="button" value="&lt;&lt;继续购物" onClick="location='/'" class='btn1'/> -->
<%-- <%
	if(buyflag){
		Profile myp = Profile.find(h.member);
		if(myp.qualification==1||myp.membertype==2){//已通过审核可以购买
			if(ps.length==2){
			%>
			<input type="button" class='btn2' value="去结算&gt;&gt;" onClick="<%= (flag?"alert('购物车里有下架商品不能提交！');":"parent.location='/html/folder/14110150-1.htm'")%>"/>
			<%
			}else{
				%>
				<input type="button" class='btn2' value="去结算&gt;&gt;" onclick='showlz();' />
				<%
			}
		}else{
			if(h.member<1){
				%>
				<input type="button" class='btn2' value="去结算&gt;&gt;" onclick='showuser();' />
				<%
			}else{
				%>
				<input type="button" class='btn2' value="去结算&gt;&gt;" onclick='showmes();' />
				<%
			}
		}
	}else{
		%>
	<input type="button" class='btn2' value="去结算&gt;&gt;" onClick="<%= (flag?"alert('购物车里有下架商品不能提交！');":"parent.location='/html/folder/14110150-1.htm'")%>"/>
		<%
	}
%> --%>
    <input type="button" class='btn2' value="去结算&gt;&gt;" onClick="<%= (flag?"alert('购物车里有下架商品不能提交！');":"checkCart()")%>"/>
</div>
</form>

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
<script type="text/javascript">
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
				parent.location='/html/folder/14110150-1.htm';
			}else{
				mt.show(d);
			}
		}
	);
}


function showmes(){
	mt.show("对不起！您还未提交资质或已提交但审核未通过或资质已过期，不能去结算，请尽快提交您资质审核资料！<br/>如想尽快完成订，请致电：<b style='color:#FF7F00;font-size:16px'>010-68533123</b><p align='center'>我要提交 <a href='/html/folder/14110054-1.htm' style='font-weight:bold;font-size:14px;color:#0079D2'>资质审核</a></p>");
}
function showuser(){
	mt.show("&nbsp;&nbsp;&nbsp;&nbsp;对不起！您还未登录，登陆后才可提交订单！<br/>"
			+"已是网站会员，点击 <a href='/html/folder/14102033-1.htm' target='_blank' style='font-weight:bold;font-size:14px;color:#0079D2'>登录</a>"
			+"&nbsp;&nbsp;还不是网站会员，点击 <a href='/html/folder/14102034-1.htm' target='_blank' style='font-weight:bold;font-size:14px;color:#0079D2'>注册</a>");
}
function showlz(){
	mt.show("粒子产品只能单独购买，每次只能购买一种活度的粒子，请检查购物车里的商品再去结算。");
}

function cheall(obj){
	//alert(222);
	obj.className=obj.checked?"checked":"checkbox";
	
	var chearr = document.getElementsByTagName("INPUT");	
	for(var i=0;i<chearr.length;i++){
		if(chearr[i].type=='checkbox'){
			chearr[i].checked = obj.checked;
		}
		
	}
	
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

var cheallNode = document.getElementById("cheallNode");
cheallNode.checked=true;
cheall(cheallNode);
car.update0(cheallNode);

//car.update(null);
</script>
<script>
mt.fit();
</script>
<%-- <%=s.footer%> --%>
</body>
</html>
