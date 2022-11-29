<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int product = h.getInt("product");//从htm传过来的值
int productdata=h.getInt("productdata");

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
		ShopProduct_data spd = ShopProduct_data.find(productdata);
		
		out.println("<ul>");
		out.println("<li class='detailTit'>"+spd.title+"</li>");
		out.println("<li class='detailCon'>"+spd.content+"</li>");
		out.println("<li class='back'><a href='javascript:history.back();' class='back_1'>返回</a>");
		if(product>0)
			out.println("<a href='/html/folder/14110010-1.htm?product="+product+"' target='_blank' class='backBuy'>立即订购 </a>");
		else
			out.println("<a href='/html/folder/14110071-1.htm' target='_blank' class='backBuy'>如何授权 </a>");
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
