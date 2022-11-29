<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int product=h.getInt("product");
ShopProduct p=ShopProduct.find(product);
p.updateclick();
if(p.time==null)
{
  response.sendError(404);
  return;
}

%><!DOCTYPE html><html><head>
<link href="/res/cssjs/base.css" rel="stylesheet" type="text/css"/>
<link href="/res/cssjs/product.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<div class="Mycontent">
<div class="Mytop"></div>
<div class="Mycon">
<div class="CommodityInfo">

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
			out.print("<li class='tb-selected'><div class='tb-pic tb-s40'><a href='javascript:void(0);'><img width='45' height='45' src='"+a.path+"' mid='"+a.path+"' big='"+a.path+"'></a></div></li>");
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

<div class="right">
	<div class="manyBtn"><input type="button" value="购买" alt='购买' onClick="car.add(<%=product%>)" id='buy' /></div>
</div>

</div>
</div>
</div>


<script>
mt.act=function(act,t){
	form1.act.value = act;
	if("products"==act){
		form1.action="/ShopProducts.jsp?category="+typeid;
		form1.target=form1.method="";
		form1.submit();
	}
	
};
</script>
</script>

</body>
</html>
