<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.admin.*"%><%

Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String str = h.get("str");
int type = h.getInt("type");


%><!DOCTYPE html><html>
<head>
<title>商品分类管理</title>
</head>
<script src="/tea/mt.js" type="text/javascript"></script>
<frameset border=0 framespacing=0 rows=* frameborder=yes cols=150,*>
  <frame name="category_tree" src="/jsp/yl/shop/ShopProductCategoryTree.jsp?type=<%= type %>&str=<%= str %>" frameborder=no noresize scrolling=yes>
  <frame name="category_edit" src="about:blank" noresize scrolling=yes>
</frameset>
</html>
