<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.admin.*"%><%

Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}



%><!DOCTYPE html><html>
<head>
<title>商品分类管理</title>
</head>
<frameset border=0 framespacing=0 rows=* frameborder=yes cols=200,*>
  <frame name="category_tree" src="/jsp/yl/shop/ShopCategoryTree.jsp" frameborder=no noresize scrolling=yes>
  <frame name="category_edit" src="about:blank" noresize scrolling=yes>
</frameset>
</html>
