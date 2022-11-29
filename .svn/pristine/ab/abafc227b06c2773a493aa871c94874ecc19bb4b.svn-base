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
		int data_list_id=h.getInt("data_list_id");
		ShopProduct_data_list spdl = ShopProduct_data_list.find(data_list_id);
		out.println("<ul>");
		out.println("<li class='detailTit'>"+MT.f(spdl.title)+"</li>");
		out.println("<li class='detailCon'>"+spdl.content+"</li>");
		//out.println("<li><a href='javascript:history.back();'>返回</a></li>");
		//out.println("<li><input type='button' value='立即订购' onClick='mt.act(\"productbuy\","+product+")''></li>");
		out.println("</ul>");
		%>
	</div>


<script>
mt.fit();
</script>
</body>
</html>
