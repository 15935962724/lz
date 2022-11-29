<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int category=h.getInt("category");
//category = 14102671;
%><!DOCTYPE html><html><head>
<title>类别介绍</title>
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


<div class="showlist">
<ul>
	<%
	List<ShopCategory> clist = ShopCategory.find(" AND father = "+category+" AND hidden = 0 order by sequence asc", 0, 100);
	for(int i=0;i<clist.size();i++){
		ShopCategory cg = clist.get(i);
		List<ShopProduct_data> spdlist = ShopProduct_data.find(" AND hidden=0 AND category = "+cg.category+" AND type=0 AND showtype=0 order by sort asc", 0, 1);
		if(spdlist.size()>0){
			ShopProduct_data spd = spdlist.get(0);
			//List<ShopProduct> splist = ShopProduct.find(" AND ca.path like '%|"+cg.category+"|%' order by product desc ",0,1);
			Attch a = Attch.find(spd.logo);
			/* String aLink = "###";
			if(splist.size()>0){
				ShopProduct sp = splist.get(0);
				aLink = "ShopProductBuy.jsp?product=" + sp.product + "";
			} */
			out.print("<li><span class='pic'><a href='###' onclick=mt.act('ShopProducts',"+cg.category+");><img onload='AutoResizeImage(195,125,this)' src='" + a.path + "' onerror='javascript:this.src=\"/tea/image/404.jpg\"' /></a></span>");
			out.print("<div class='tit'><div class='titout'><a href='###' onclick=mt.act('ShopProducts',"+cg.category+");>"+cg.name[1]+"（查看该类商品）</a></div>");
			
			if(MT.f(spd.content.replaceAll("<[^>]+>|&nbsp;","")).length()>135){
				out.print("<div class='texts'>"+MT.f(spd.content.replaceAll("<[^>]+>|&nbsp;",""),270)+"&nbsp;&nbsp;<a href='###' onclick=mt.act('proAuDescription',"+cg.category+","+spd.id+");>详细>></a></div>");
			}else{
				out.print("<div class='texts'>"+MT.f(spd.content.replaceAll("<[^>]+>|&nbsp;",""),270)+"&nbsp;&nbsp;</div>");
			}
			/* out.print("<div class='nowGo'><a href='###' onclick=mt.act('proAuDescription',"+cg.category+","+spd.id+");>详细</a></div>"); */
			out.print("</li>");
		}else{
			out.print("<li><span class='pic'><a href='###' onclick=mt.act('ShopProducts',"+cg.category+");><img onload='AutoResizeImage(195,125,this)' src='/tea/image/404.jpg' /></a></span>");
			out.print("<div class='tit'><div class='titout'><a href='###' onclick=mt.act('ShopProducts',"+cg.category+");>"+cg.name[1]+"</a></div>");
			out.print("<div class='texts'></div>");
			/* out.print("<div class='nowGo'><a href='###' onclick=mt.act('proAuDescription',"+cg.category+","+spd.id+");>详细</a></div>"); */
			out.print("</li>");
		}
		
	}
	%>
</ul>
</div>


<script>
mt.act=function(act,c,t){
	if("proAuDescription"==act){
		location = "ShopProAuDescription.jsp?productdata="+t+"&category="+c;
	}else if("ShopProducts"==act){
		//parent.location = "ShopProducts.jsp?category="+c;
		parent.location = "/html/folder/14110208-1.htm?category="+c;
	}
	
};
</script>
<script>
mt.fit();
</script>

</body>
</html>
