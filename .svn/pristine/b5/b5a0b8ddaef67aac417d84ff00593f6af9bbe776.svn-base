<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.ui.TeaSession" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
	return;

int fcount = Favorite.countNodes(teasession._strCommunity,teasession._rv,34);

int bcount = Buy.countBuys(teasession._rv,teasession._strCommunity);
%>
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="2" id="goodsche">我的购物车</td>
  </tr>
  <tr>
    <td colspan="2" id="goodsshoucang"><a href="/servlet/AddToFavorite?node=<%=teasession._nNode%>&Language=<%=teasession._nLanguage%>" >放入收藏夹</a><a href="/jsp/node/FavoriteNodes.jsp?community=<%=teasession._strCommunity%>&type=34" >查看收藏夹</a><span id="shoucangyou">收藏夹里有<%=fcount%>件商品</span> <span id="cheliyou"><a href="/jsp/offer/ShoppingCarts.jsp?community=<%=teasession._strCommunity%>" target="_blank">您的购物车现有<%=bcount%>件商品</a></span>
<span id="zongji">总计：
      <%if(bcount>0)out.print(Buy.sumBuys(teasession._rv,teasession._strCommunity,1));else out.print("0.00");%>
元</span> </td>
  </tr>

</table>

