<%@page import="tea.entity.member.Profile"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int product=h.getInt("product");
//product=14102773;
ShopProduct p=ShopProduct.find(product);
p.updateclick();

ShopCategory sc = ShopCategory.find(p.category);

if(p.time==null)
{
  response.sendError(404);
  return;
}

//购物车中商品数量
int carSum=0;
String[] ps=h.getCook("cart","|").split("[|]");

if(ps.length<1)
{
  out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
}else
{
	for(int i=1;i<ps.length;i++)
	  {
	    String[] arr=ps[i].split("&");
	    
	    int quantity=Integer.parseInt(arr[1]);//数量
	    
	  	//判断product_id是否商品的id，如果不是则为套装id
	    int product_id=Integer.parseInt(arr[0]);
	    ShopProduct carP = ShopProduct.find(product_id);
	    if(carP.isExist){
	    	carSum += quantity;
	    }else{
	    	ShopPackage spage = ShopPackage.find(product_id);
	    	String [] sarr = spage.getProduct_link_id().split("\\|");
			for(int m=1;m<sarr.length;m++){
			    ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[m]));
			    if(s1.isExist){
			    	carSum += quantity;
			    }
			}
	    }
	  }
}

%><!DOCTYPE html><html><head>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/view.js" type="text/javascript"></script>
<script src='/tea/jquery-1.3.1.min.js'></script>
<!-- <link href="/tea/product.css" rel="stylesheet" type="text/css"/>
 --><script type="text/javascript" src="/tea/jquery.imagezoom.js"></script>

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
<div class='bigtit'>
<h1><%=p.name[1] %></h1>
<%
if(!sc.offswitch)
{
%>
<div class='cartsbtn'><span><%=carSum%></span><a href="Carts.jsp">去购物车结算</a></div>
<%
}
%>
</div>
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
		<a href="javascript:void(0);"><img src="<%= a.path %>" alt="<%= a.path %>" rel="<%= a.path %>" class="jqzoom" /></a>
	</div>
	<%
			out.print("<li class='tb-selected'>");
		}else{
			out.print("<li>");
		}
	  %>
		<div class="tb-pic tb-s40"><a href="javascript:void(0);"><img width="45" height="45" src="<%= a.path %>" mid="<%= a.path %>" big="<%= a.path %>"></a></div></li>
		<!-- <li><div class="tb-pic tb-s40"><a href="javascript:void(0);"><img  src="/res/product/1410/14100481_t.jpg" mid="/res/1409/test.jpg" big="/res/1409/test.jpg"></a></div></li> -->
	<%
	}
	%>
	</ul>
  </div>
</div>
<div class="rights">

		<ul>
			<%
			float price = p.price;
			Profile pf = Profile.find(h.member);
			if(pf.qualification==1&&pf.validity.getTime()>(new Date()).getTime()&&p.view_type==1){
				ShopQualification sq = ShopQualification.findByMember(h.member);
				if(sq.id>0){
					ShopPriceSet sps = ShopPriceSet.find(sq.hospital_id,product,0);
					price=sps.price;
				}				
			}
			%>
			<li>价格：<strong><%=price%> 元</strong></li>
			<li>商品编号：<%=p.product%></li>
			<%
			if(p.activity!=null&&p.activity.length()>0){
				out.println("<li class='xxiang'>促销信息：<span class='org'>"+MT.f(p.activity.replaceAll("<[^>]+>|&nbsp;",""),20));
				if(p.activity.length()>=20){
					//out.println("&nbsp;&nbsp;<a href=javascript:mt.show('"+p.activity+"'); target='_blank'>详情</a>");
					out.println("</span>&nbsp;&nbsp;<a href='ShopProActivity.jsp?product="+p.product+"' target='_blank'>详情</a>");
				}
				out.println("</li>");
			}
			%>
			<li class='are'>购买数量：<a href="###" onclick="numDec()">-</a><input type="text" id="quantity" value="1" onkeyup="keyup()"/><a href="###" onclick="numAdd()">+</a>
			</li>



	<%
	if(p.category>0&&p.model_id>0){
		List<ShopProductModel> spmlist = ShopProductModel.find(" AND category = "+p.category, 0, 100);
		if(spmlist.size()>0){
			if(sc.attribute_type>0){
				out.println("<li class='huod'><span>"+sc.ATTRIBUTE_TYPE[sc.attribute_type]+"：</span>");
				for(int i=0;i<spmlist.size();i++){
					ShopProductModel spm = spmlist.get(i);
					ShopProduct sp = ShopProduct.find(p.brand,spm.getId());
					if(sp.product>0)
						out.println("<i "+(spm.getId()==p.model_id?"class='bgred'":"")+"><a href='/html/folder/14110010-1.htm?product="+sp.product+"' target='_parent'>"+spm.getModel()+"</a></i>");
				}
			}
			
		}
		
	}
	
	%></li>
			</ul>
<div class='sharbox'>
<%
if(!sc.offswitch)
{
%>
<input type="button" value="加入购物车" onClick="car.add(<%=product%>,document.getElementById('quantity').value)"/>
<%
}
%>
<span class="sharein"><div class="bshare-custom"><div class="bsPromo bsPromo2"></div>分享到：<a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="分享到网易微博" class="bshare-neteasemb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=2ddd3036-1080-4a31-a715-a180bd963380&amp;pophcol=1&amp;lang=zh"></script><script type="text/javascript" charset="utf-8" src="/tea/bshareC0.js"></script></span>
</div>
</div>
<div style='height:5px;font-size:0;clear:both;overflow:hidden'></div>


<div class='packbox'>
<div class='packtit'>优惠套装</div>
	<%
		List<ShopPackage> spl = ShopPackage.find(" AND product_id = "+product+" order by id ",0,100);
		if(spl.size()>0){
			out.print("<ul>");
				for(int i=0;i<spl.size();i++){
					out.print("<li><a href='javascript:void(0);' onclick='showtab("+i+")';>优惠套装"+(i+1)+":"+spl.get(i).getPackageName()+"</a></li>");
				}
			out.print("</ul>");
			out.print("<div>");
			out.print("<ul id='myul'>");
			for(int i=0;i<spl.size();i++){
				ShopPackage sp = spl.get(i);
				out.print("<li "+(i==0?"":" style='display: none;'")+" >");
				out.print("<img width='45' src="+p.getPicture('b')+" alt="+p.name[1]+" class='jqzoom' onerror='javascript:this.src=\"/tea/image/404.jpg\"' />");
				out.print(p.name[1]);
				String [] sarr = sp.getProduct_link_id().split("\\|");
				for(int j=1;j<sarr.length;j++){
					ShopProduct s1 = ShopProduct.find(Integer.parseInt(sarr[j]));
					String[] arr1=s1.picture.split("[|]");
					out.print("+");
					out.print("<img width='45' src="+s1.getPicture('b')+" alt="+s1.name[1]+" class='jqzoom' onerror='javascript:this.src=\"/tea/image/404.jpg\"' />");
					out.print(s1.name[1]);
					out.print(s1.price);
				}
				out.print("=");
				out.print("套餐价："+sp.getSetPrice());
				out.print("原价："+sp.getPrice());
				out.print("立即节省："+(sp.getPrice()-sp.getSetPrice()));
				out.print("<input type='button' value='购买套餐' onClick='car.add("+sp.getId()+",1)''/>");
				out.print("</li>");
			}
			out.print("</ul>");
			out.print("</div>");
		}
	%>
</div>


<div class="<%out.print(p.view_type==1?"p1":"p2");%>">
文章11：
	<%
	List<ShopProduct_data> spdOnelist=null;//文章
	spdOnelist = ShopProduct_data.find(" AND showtype=1 AND type=0 AND category = "+p.category, 0, 100);//在商品中查看类的说明（文章形式）
	if(spdOnelist.size()>0){
		out.print("<div class='switch'>");
		for(int i=0;i<spdOnelist.size();i++){
			ShopProduct_data spd = spdOnelist.get(i);
			out.println("<a href='###' onclick='mt.tab(this)' name='a_spdOnelist' "+(i==0?"class='current'":"")+">"+spd.title+"555</a>");
			//out.println("<div><table name='tab' "+(i==0?"":"style='display:none'")+"><tr><td>"+spd.content+"</td></tr></table></div>");
		}
		out.print("</div>");
		for(int i=0;i<spdOnelist.size();i++){
			ShopProduct_data spd = spdOnelist.get(i);
			out.println("<table name='tab' "+(i==0?"":"style='display:none'")+"><tr><td>"+spd.content+"</td></tr></table>");
		}
	}else{
		spdOnelist = ShopProduct_data.find(" AND showtype=0 AND type=0 AND category = "+p.category, 0, 100);//在商品中查看商品的说明（文章形式）
		if(spdOnelist.size()>0){
			int count=0;
			int index=0;
			boolean display = false;
			out.print("<div class='switch'>");
			for(int i=0;i<spdOnelist.size();i++){
				ShopProduct_data spd = spdOnelist.get(i);
				
				if(count%3==0){
					index++;
					display = true;
					if(count!=0)
						out.println("<br/>");
				}
				count++;
				out.println("<a href='###' onclick='mt.tab(this)' name='a_tab"+index+"' "+(display?"class='current'":"")+">"+spd.title+"</a>");
				display = false;
				//out.println("<div><table name='tab' "+(i==0?"":"style='display:none'")+"><tr><td>"+spd.content+"</td></tr></table></div>");
			}
			out.print("</div>");
			count=0;
			index=0;
			display = false;
			for(int i=0;i<spdOnelist.size();i++){
				ShopProduct_data spd = spdOnelist.get(i);
				if(count%3==0){
					index++;
					display = true;
					if(count!=0)
						out.println("<br/>");
				}
				count++;
				out.println("<table name='tab"+index+"' "+(display?"":"style='display:none'")+"><tr><td>"+spd.content+"</td></tr></table>");
				display = false;
			}
		}
	}
%>
</div>
<br/>
<br/>
<div ><%-- style="display:<%out.print(p.view_type!=2?"none":"block");%>;" --%>
列表333：
<%
	List<ShopProduct_data> spdMorelist=null;//列表
	spdMorelist = ShopProduct_data.find(" AND showtype=1 AND type=1 AND category = "+p.category, 0, 100);//在商品中查看类的说明（列表形式）
	if(spdMorelist.size()>0){
		out.print("<div class='switch'>");
		for(int i=0;i<spdMorelist.size();i++){
			ShopProduct_data spd = spdMorelist.get(i);
			out.println("<div><a href='###' onclick='mt.tab(this)' name='a_spdOnelist' "+(i==0?"class='current'":"")+">"+spd.title+"</a></div>");
			List<ShopProduct_data_list> spdlMorelist=ShopProduct_data_list.find(" AND data_id="+spd.id,0,100);
			for(int j=0;j<spdlMorelist.size();j++){
				ShopProduct_data_list spdl = spdlMorelist.get(j);
				out.println("<div><a href='ShopProDataDetail.jsp?data_list_id="+spdl.id+"' target='_blank'>"+spdl.title+"</a></div>");
			}
		}
		out.print("<div class='switch'>");
	}else{
		spdMorelist = ShopProduct_data.find(" AND showtype=0 AND type=1 AND category = "+p.category, 0, 100);//在商品中查看商品的说明（列表形式）
		if(spdMorelist.size()>0){
			for(int i=0;i<spdMorelist.size();i++){
				ShopProduct_data spd = spdMorelist.get(i);
				out.println("<div>"+spd.title+"</div>");
				List<ShopProduct_data_list> spdlMorelist=ShopProduct_data_list.find(" AND data_id="+spd.id,0,100);
				for(int j=0;j<spdlMorelist.size();j++){
					ShopProduct_data_list spdl = spdlMorelist.get(j);
					out.println("<div><a href='ShopProDataDetail.jsp?data_list_id="+spdl.id+"' target='_blank'>"+spdl.title+"</a></div>");
				}
			}
		}
	}
	
	
	%>
</div>
<div>
<form name="zxForm" action="/ShopAdvisorys.do" method="post" target="_ajax">
<input type="hidden" name="act" value="submit"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
<input type="hidden" name="product_id" value="<%=product%>"/>
<h1>我要咨询</h1>
<span>购买前，如果您有不清楚的地方，可以在线留言</span>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>咨询内容</td>
    <td align="left"><textarea name="depict" rows="5" cols="80"></textarea></td>
  </tr>
 <tr>
    <td></td>
    <td align="left">
    	<table>
    		<tr>
			    <td>验证码：</td>
			    <td align="left">
			    	<input style="text-transform: uppercase; width:93px;" alt="验证码" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off" class="input" style='width:100px'/>
					<a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a>
					看不清？<a href="javascript:mt.verifys()">换一张</a>
			    </td>
			    <td align="right">
			    	<input type="submit" value="提交咨询"/>
			    </td>
			</tr>
    	</table>
    </td>
  </tr>
</table>

</form>

</div>
<div>
咨询列表
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

<table id="tablecenter" cellspacing="0">
	<%
	if(sum<1)
	{
	    out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
	}else{
		sql.append(" order by createdate desc");
		List<ShopAdvisory> salist = ShopAdvisory.find(sql.toString(),pos,2);
		for(int i=0;i<salist.size();i++){
			ShopAdvisory sa = salist.get(i);
			String uname = MT.f(Profile.find(sa.getMember()).getName(h.language));
		    if(uname.trim()==null||uname.trim().equals("")||uname.trim().length()<1){
		        uname = Profile.find(sa.getMember()).member;
		    }
		    String replayuname = MT.f(Profile.find(sa.getReplyMember()).getName(h.language));
		    if(replayuname.trim()==null||replayuname.trim().equals("")||replayuname.trim().length()<1){
		    	replayuname = Profile.find(sa.getReplyMember()).member;
		    }
			out.println("<tr><td>");
			out.println("<span>"+uname+"&nbsp;&nbsp;&nbsp;&nbsp;发表于："+MT.f(sa.getCreatedate(),1)+"</span>");
			out.println("</td></tr>");
			out.println("<tr><td>");
			out.println("<span>"+MT.f(sa.getDepict())+"</span>");
			out.println("</td></tr>");
			out.println("<tr><td>");
			out.println("<span>&nbsp;&nbsp;&nbsp;&nbsp;"+MT.f(sa.getReplycont())+"</span>");
			out.println("</td></tr>");
			out.println("<tr><td>");
			out.println("<span>&nbsp;&nbsp;&nbsp;&nbsp;"+replayuname+"&nbsp;&nbsp;&nbsp;&nbsp;发表于："+MT.f(sa.getReplyTime(),1)+"</span>");
			out.println("</td></tr>");
		}
	}
	
	%>
 
</table>

</form>
</div>

<div>

<h1>您可以还需要以下产品</h1>

<%
List<ShopProduct> splist = ShopProduct.find(" AND state!=2 AND category="+p.category+" order by product desc",0,6);
for(int i=0;i<splist.size();i++){
	ShopProduct likesp = splist.get(i);
	out.println("<div class='likeLeft'>");
	out.println("<a href='/html/folder/14110010-1.htm?product="+likesp.product+"' target='_blank'><img width='100px;' src='" + likesp.getPicture('t') + "' /></a>");
	out.println("</div>");
	out.println("<div class='likeRight'>");
	out.println("<span><a href='/html/folder/14110010-1.htm?product="+likesp.product+"' target='_blank'>"+likesp.name[1]+"</a></span>");
	out.println("<span>&yen;"+likesp.price+"</span>");
	if(!sc.offswitch)
	{
		out.println("<span><input type='button' onclick='car.add("+likesp.product+",1)' value='加入购物车'/></span>");
	}
	out.println("</div>");
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
	if(isNaN(quantity) ||  parseInt(quantity)!=quantity || parseInt(quantity)<1){
		quantity = 1;
		return;
    }
	if(quantity>=200){
		document.getElementById("quantity").value=quantity.substring(0,quantity.length-1);
		alert("商品数量不能大于200");
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
	    alert("商品数量不能大于200");
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

});
</script>
<script>
mt.fit();
</script>
</body>
</html>
