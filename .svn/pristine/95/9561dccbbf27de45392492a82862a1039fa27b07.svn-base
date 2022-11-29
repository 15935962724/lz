<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

%><!DOCTYPE html><html><head>
<script src="/tea/mt.js" type="text/javascript"></script>
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
<div class='detail'>
		<%
		int productdata=h.getInt("productdata");
		ShopProduct_data spd = ShopProduct_data.find(productdata);
		
		int category = h.getInt("category");
		List<ShopProduct> splist = ShopProduct.find(" AND category="+category+" AND state=0",0,1);
		
		out.println("<ul>");
		out.println("<li class='detailTit'>"+MT.f(spd.title)+"</li>");
		//out.println("<li class='detailGuide'> 导语："+MT.f(spd.brief)+"</li>");
		out.println("<li class='detailCon'>"+spd.content+"</li>");
		out.println("<li class='back'><a href='javascript:history.back();' class='back_1'>返回</a>");
		if(splist.size()>0&&category!=ShopCategory.getCategory("zlCategory")&&category!=ShopCategory.getCategory("fsCategory")){
			ShopProduct sp = splist.get(0);
			ShopCategory sc = ShopCategory.find(category);
			String category_s = ShopCategory.getCategory("zlCategory") + "";
			if(sc.path.indexOf(category_s) < 0)
				out.println("<a href='/html/folder/14110010-1.htm?product="+sp.product+"' target='_blank' class='backBuy'>立即订购 </a>");
		}
		
		out.println("</li></ul>");
		%>
	</div>

<script>
mt.act=function(act,t){
	if("productbuy"==act){
		location = "product="+t;
	}
	
};
</script>
<script>
mt.fit();
</script>

</body>
</html>
