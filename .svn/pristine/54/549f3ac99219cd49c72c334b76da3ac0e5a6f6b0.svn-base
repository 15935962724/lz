<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int product=h.getInt("product");//从htm传过来的值
//product=14102773;
int category=h.getInt("category");
//category = 14102669;
boolean switchOpen = true;
%><!DOCTYPE html>
<html><head>
<title>介绍页</title>
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
    <ul class="showul clt">
		<%
		List<ShopProduct_data> spdlist = ShopProduct_data.find(" AND hidden=0 AND category = "+category+" AND type=0 AND showtype=0 order by sort asc", 0, 100);
		for(int i=0;i<spdlist.size();i++){
			ShopProduct_data spd = spdlist.get(i);
			Attch a=Attch.find(spd.logo);
			//out.println("<ul>");
			out.println("<li><span class='pic'><a href='###' onclick=mt.act('productDescription',"+product+","+category+","+spd.id+");><img onload='AutoResizeImage(195,140,this)' src="+a.path+" alt="+spd.title+" rel="+a.path+" class='jqzoom' onerror='javascript:this.src=\"/tea/image/404.jpg\"' /></a></span>");
			out.println("<div class='tit'><div class='titout'> <a href='###' onclick=mt.act('productDescription',"+product+","+category+","+spd.id+");>"+spd.title+"</a></div>");
			if(MT.f(spd.content.replaceAll("<[^>]+>|&nbsp;","")).length()>30){
				out.println("<div class='texts'>"+MT.f(spd.content.replaceAll("<[^>]+>|&nbsp;",""),60)+"&nbsp;&nbsp;<a href='###' onclick=mt.act('productDescription',"+product+","+category+","+spd.id+");>详细</a></div>");	
			}else{
				out.println("<div class='texts'>"+MT.f(spd.content.replaceAll("<[^>]+>|&nbsp;",""),60)+"</div>");
			}
			/* out.println("<div class='nowGo'><a href='###' onclick=mt.act('productDescription',"+product+","+category+","+spd.id+");>详细</a></div>"); */
			//out.println("</ul>");
		}
		%>
	</ul>
	<div>
	</div>
</div>

<div class='buyBtn'>
	<%
	if(product>0){
		out.println("<a href='javascript:void(0);' onclick=parent.location='/xhtml/folder/14110010-1.htm?product="+product+"'>立即订购</a>");
	}else{
		out.println("<a href='/xhtml/folder/14110071-1.htm' target='_blank'>如何授权</a>");
	}
	%>
</div>


<script>
mt.act=function(act,spid,cid,spdid){
	if("productDescription"==act){//cid=14102669碘I125粒子
		location = "ShopProductDescription.jsp?product="+spid+"&category="+cid+"&productdata="+spdid;
	}else if("productbuy"==act){
		//location = "product="+spid;
	}
	
};
</script>

<script>
mt.fit();
</script>
</body>
</html>
