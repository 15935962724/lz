<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tea.entity.yl.shop.ShopCategory"%>
<%@page import="tea.entity.yl.shop.ShopProduct_data"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.util.Lucene"%><%

Http h=new Http(request,response);

StringBuffer sql=new StringBuffer();
ShopCategory root = ShopCategory.getRoot();
int category=root.category;
sql.append(" AND category = "+category);

sql.append(" AND type=0");

sql.append(" AND hidden=0");

sql.append(" order by sort asc");

ArrayList list = ShopProduct_data.find(sql.toString(),0,3);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.current{color:#FF0000}
</style>
</head>
<body>

<form name="form1" action="?">
<input type="hidden" name="category" value=""/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<div>
<%
if(list.size()<1)
{
    out.print("<span>暂无记录!</span>");
}else
{
	out.println("<div class='switch'><ul>");
	for (int i = 0; i<list.size(); i++) {
		ShopProduct_data sd = (ShopProduct_data)list.get(i);
		out.println("<li><a href='###' onclick='mt.tab(this)' name='a_tab' "+(i==0?"class='current'":"")+">"+sd.title+"</a></li>");
	}
	out.println("</ul></div>");
	out.println("<div>");
	for (int i = 0; i<list.size(); i++) {
		ShopProduct_data sd = (ShopProduct_data)list.get(i);
		out.println("<table name='tab' "+(i==0?"":"style='display:none;'")+">");
		out.println("<tr><td>"+MT.f(Lucene.t(sd.content),258)+"&nbsp;&nbsp;<a href='AboutView.jsp?sid="+sd.id+"&category="+category+"'>>更多</a></tr>");
		out.println("</table>");
	}
	out.println("</div>");
}
%>

</div>

</form>

</body>
</html>
