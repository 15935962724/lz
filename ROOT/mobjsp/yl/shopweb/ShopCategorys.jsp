<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

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
<%-- <ul>
<%
List<ShopCategory> clist = ShopCategory.find(" AND father = 14102667 AND hidden = 0", 0, 100);
	for(int i=0;i<clist.size();i++){
		ShopCategory cg = clist.get(i);
		out.print("<li><a href='ShopProducts.jsp?category="+cg.category+"' target='_blank'>"+cg.name[1]+"</a></li>");
	}
%>
</ul> --%>
<ul>
<li><a href='ShopProClasDetail.jsp?category=14102669' target='_blank'>碘I125粒子</a></li>
<li><a href='ShopProducts.jsp?category=14102670' target='_blank'>治疗计划系统</a></li>
<li><a href='ShopProducts.jsp?category=14102671' target='_blank'>粒子植入器械</a></li>
<li><a href='ShopProducts.jsp?category=14102672' target='_blank'>前列腺专用设备租赁</a></li>
<li><a href='ShopProducts.jsp?category=14102673' target='_blank'>辐射防护/检测</a></li>
</ul>
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
