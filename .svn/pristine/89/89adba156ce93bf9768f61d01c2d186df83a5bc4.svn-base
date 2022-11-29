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
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<div>
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

<div>
	<input type="button" value="立即订购" onClick="mt.act('productbuy',<%=product%>)"/>
</div>

<div>
	<div>
		<%
		List<ShopProduct_data> spdlist = ShopProduct_data.find(" AND product_id = "+product, 0, 100);
		for(int i=0;i<spdlist.size();i++){
			ShopProduct_data spd = spdlist.get(i);
			out.println("<ul>");
			out.println("<li> >>"+spd.title+"</li>");
			out.println("<li>"+spd.brief+"</li>");
			out.println("<li><a href='ShopProductDescription.jsp?product="+product+"&productdata="+spd.id+"'>详细</a></li>");
			out.println("</ul>");
		}
		%>
	</div>
	<div>
	</div>
</div>


<script>
mt.act=function(act,t){
	if("productbuy"==act){
		location = "ShopProductBuy.jsp?product="+t;
	}
	
};
</script>

</body>
</html>
