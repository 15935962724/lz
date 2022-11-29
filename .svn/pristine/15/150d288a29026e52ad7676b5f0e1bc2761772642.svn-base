<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%>
<%@page import="tea.entity.util.Lucene"%><%

Http h=new Http(request,response);

StringBuffer sql=new StringBuffer(),par=new StringBuffer("?");
sql.append(" AND hidden=0");
par.append("&hidden=0");

int category = h.getInt("category",14102669);
sql.append(" AND father="+category);
par.append("&father="+category);

int sum=ShopCategory.count(sql.toString());

int pos=h.getInt("pos");
par.append("&pos=");



%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<form name="form1" action="?">
<input type="hidden" name="category" value=""/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<div class="goodsType">
<%
if(sum<1)
{
    out.print("<span>暂无记录!</span>");
}else
{
	List<ShopCategory> clist = ShopCategory.find(sql.toString(), pos, 20);
	for(int i=0;i<clist.size();i++){
		ShopCategory cg = clist.get(i);
		out.print("<div>");
		out.print("<div><span><a href='ShopProducts.jsp?category="+cg.category+"' target='_blank'>"+cg.name[1]+"</a></span>&nbsp;&nbsp;<span><a href='ShopProducts.jsp?category="+cg.category+"' target='_blank'>>更多软件</a></span></div>");
		List<ShopProduct> splist = ShopProduct.find(" AND ca.path like '%|"+cg.category+"|%' AND state=0 order by pr.time desc ", 0, 1);
		if(splist!=null&&splist.size()>0){
			ShopProduct sp = splist.get(0);
			
			out.print("<div class='proleft'><span class='pic'><a href='ShopProductBuy.jsp?product="+sp.product+"'><img src='" + sp.getPicture('s') + "' onload='AutoResizeImage(195,140,this)'  /></a></span></div>");
			out.print("<div class='proright'>");
				out.print("<div><b class='tt'><a href='ShopProductBuy.jsp?product="+sp.product+"'>"+sp.name[1]+"</a></b></div>");
				out.print("<div class='texts' title='"+Lucene.t(sp.content[1])+"'>"+ MT.f(Lucene.t(sp.content[1]),258)+"&nbsp;&nbsp;<a href='ShopProductBuy.jsp?product="+sp.product+"'>>了解更多</a></div>");
			out.print("</div>");
		}
		out.print("</div>");
	}
	if(sum>20)out.print("<div>"+new tea.htmlx.FPNL(h.language, par.toString(), pos, sum,20)+"</div>");
}
%>

</div>

</form>

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
