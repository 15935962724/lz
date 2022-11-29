<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.yl.shop.ShopProduct" %>
<%@ page import="java.util.List" %>
<%@ page import="util.Config" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>其他列表</title>
    <link href="/res/Home/cssjs/19071925L1.css" rel="stylesheet" type="text/css" />
    <script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<style>

    .cplist {
        padding: 15px;
        overflow: hidden;
        min-height:300px;
    }
    .cplist li span {
        display: block;
        text-align: center;
    }
    .cplist li {
        width: 46%;
        float: left;
        margin: 0 2% 4%;
    }
    .cplist li #GoodsIDname a {
        color: #000;
        font-size: .3rem;
    }
    .cplist li #GoodsIDmeasure {
        margin: 10px 0;
        font-size: .3rem;
        color: #F18320;
    }
    .cplist #GoodsIDname{
        height:45px;
        overflow:hidden;
        text-overflow:ellipsis;
        display:-webkit-box;
    -webkit-line-clamp:2;
    -webkit-box-orient:vertical;
    }
    #GoodsIDsmallpicture {
    background: #F9F9F9;
    padding: 15px 4%;
    height:187px;
    }
    .cplist #GoodsIDname{
    padding: 13px 4% 0;
    }
</style>
<%
    Http h=new Http(request,response);

    int category = h.getInt("category",-1);

%>
<div class="cplist">
    <ul>
        <%
            List<ShopProduct> prolist = ShopProduct.find("  AND category in (select category from shopcategory where path like '%"+category+"%') AND state  = 0 ",0,Integer.MAX_VALUE);
            for (int j = 0; j < prolist.size(); j++) {
                ShopProduct p1 = prolist.get(j);
        %>
        <li>
<span id="GoodsIDsmallpicture">
<a onclick="parent.location='/mobjsp/yl/shopweb/ShopProductBuyOther.jsp?product=<%= p1.product%>';" id="GoodsIDAsmallpicture" >
<img border="0" src="<%= p1.getPicture('1')%>" id="Goodssmallpicture">
</a>
</span><!-- onclick="parent.location='/mobjsp/yl/shopweb/ShopProductBuyOther.jsp?product=<%= p1.product%>';"-->
            <span id="GoodsIDname"><a  id="GoodsIDAname"><%= p1.name[1]%></a></span>
            <%--<span class="GoodsIDname" style='font-size:.3rem;color:#FF7F27;'>￥<%= p1.price%></span>--%>
        </li>
        <%
            }
        %>
    </ul>
</div>
</body>
    <script src="/tea/mobhtml/js/jquery.min.js"></script>
<script>
    window.onload = function(){
        mt.fit();
    }
</script>
</html>
