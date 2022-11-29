<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.yl.shop.ShopProduct" %>
<%@ page import="java.util.List" %>
<%@ page import="util.Config" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>tps列表</title>
    <link href="/res/Home/cssjs/19071925L1.css" rel="stylesheet" type="text/css" />
    <script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<style>

    .cplist {
        padding: 15px;
        overflow: hidden;
        min-height:350px;
    }
    .cplist li span {
        display: block;
        text-align: justify;
        padding:0 4%;

    }
    .cplist li {
        width: 46%;
        float: left;
        margin: 0 2% 4%;
    }
    .cplist li .GoodsIDname a {
        color: #000;
        font-size: .3rem;
    }
    .cplist li #GoodsIDmeasure {
        margin: 10px 0;
        font-size: .3rem;
        color: #F18320;
    }
    .cplist .tps-pri{
        color: #df6c0a;
        font-size:.3rem;
        text-align:center;
        height:30px;
    }
    #GoodsIDsmallpicture {
        background: #F9F9F9;
        padding: 30px 4%;
    height:187px;
    }
    .cplist .GoodsIDname{
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
            String catstr = "";
            List<ShopProduct> prolist = ShopProduct.find("  AND category in (select category from shopcategory where path like '%"+ Config.getInt("tps")+"%')  AND state = 0  ",0,Integer.MAX_VALUE);
            for (int j = 0; j < prolist.size(); j++) {
                ShopProduct p1 = prolist.get(j);
                if(catstr.indexOf(""+p1.category)!=-1){
                    continue;
                }
                catstr += ","+p1.category;
        %>
        <li>
<span id="GoodsIDsmallpicture">
<a onclick="parent.location='/mobjsp/yl/shopweb/ShopProductBuyTps.jsp?product=<%= p1.product%>';" target="_self" id="GoodsIDAsmallpicture" >
<img border="0" src="<%= p1.getPicture('1')%>" id="Goodssmallpicture">
</a>
</span>
            <!-- onclick="parent.location='/mobjsp/yl/shopweb/ShopProductBuyTps.jsp?product=<%= p1.product%>';"  -->
            <span class="GoodsIDname"><a ><%= p1.name[1]%></a></span>
            <%--<span class="GoodsIDname tps-pri">￥<%= p1.price%>/次</span>--%>
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
