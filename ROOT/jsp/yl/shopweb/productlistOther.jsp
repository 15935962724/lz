<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.yl.shop.ShopCategory" %>
<%@ page import="tea.entity.yl.shop.ShopProduct" %>
<%@ page import="util.Config" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Http h=new Http(request,response);
    StringBuffer par = new StringBuffer();
    int category = h.getInt("category",-1);
    par.append("?category="+category);
    String product_name = h.get("product_name","");//获取查询string
    par.append("&product_name="+product_name);
    int type = h.getInt("type");
    par.append("&type="+type);
    int pos=h.getInt("pos");
    par.append("&pos=");
    int pageSize = 6;


    int mysum = ShopProduct.count("  AND category in (select category from shopcategory where path like '%"+category+"%') AND state  = 0 ");

    /*if(1!=h.getInt("type")) {
        if (!"".equals(product_name)) {//查询产品
            List<ShopProduct> sh_list = ShopProduct.find("AND state=0 AND name1 like '%" + product_name + "%'", 0, 1);
            if (sh_list.size() > 0) {//有数据，判断是哪个jsp
                ShopProduct sh = sh_list.get(0);
                ShopCategory shopCategory = ShopCategory.find(sh.category);
                int categpry = shopCategory.father;
                int tps = Config.getInt("tps");
                int lizi = Config.getInt("lizi");
                int shebei = Config.getInt("shebei");
                String product_name1 = URLEncoder.encode(h.get("product_name"), "UTF-8");//解决中文乱码
                if (categpry == tps) {//tps
                    response.sendRedirect("/html/folder/19081308-1.htm?product_name=" + MT.f(product_name1) + "&type=1");
                    return;


                } else if (shebei == categpry) {//设备
                    if (Config.getInt("category1") == sh.category) {
                        response.sendRedirect("/html/folder/19081608-1.htm?category=" + sh.category + "&product_name=" + MT.f(product_name1) + "&type=1");
                        return;

                    }
                    if (Config.getInt("category2") == sh.category) {
                        response.sendRedirect("/html/folder/19081628-1.htm?category=" + sh.category + "&product_name=" + MT.f(product_name1) + "&type=1");
                        return;

                    }
                    if (Config.getInt("category3") == sh.category) {
                        response.sendRedirect("/html/folder/19081641-1.htm?category=" + sh.category + "&product_name=" + MT.f(product_name1)+ "&type=1");
                        return;


                    }
                    if (Config.getInt("category4") == sh.category) {
                        response.sendRedirect("/html/folder/19081642-1.htm?category=" + sh.category + "&product_name=" + MT.f(product_name1) + "&type=1");
                        return;

                    }

                } else if (14102672 == categpry) {
                    response.sendRedirect("/html/folder/19081608-1.htm?category=14102672" + "&product_name=" +MT.f(product_name1)+ "&type=1");
                    return;

                } else if(categpry == lizi) {//粒子
                    response.sendRedirect("/html/folder/19080995-1.htm?product_name=" + MT.f(product_name1)+ "&type=1");
                    return;

                }
            }

        }
    }
*/
%>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>产品</title>
    <link rel="stylesheet" href="/res/lizi/css/bootstrap.css">
    <link rel="stylesheet" href="/res/lizi/css/animate.css">
    <link rel="stylesheet" href="/res/lizi/css/style1.css">
    <link rel="stylesheet" href="/res/lizi/css/product.css">
    <link rel="stylesheet" href="/res/lizi/css/common.css">
    <link href="http://www.brachysolution.com/res/Home/cssjs/19062066L1.css" rel="stylesheet" type="text/css"/>
    <%--<script src="/res/lizi/js/jquery-1.11.3.min.js"></script>--%>
    <script src="/res/lizi/js/bootstrap.min.js"></script>
    <script language="javascript" src="/tea/mt.js"></script>
    <script src="/tea/view.js" type="text/javascript"></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <script src='/tea/jquery-1.11.1.min.js'></script>
    <script src='/tea/yl/common.js' type="text/javascript"></script>
    <script>
        $(function(){
            $(".bd div").click(function(){
                $(this).addClass("headv-check").siblings().removeClass("headv-check");
                $(this).parents(".bd").siblings().children("div").removeClass("headv-check");
            });
        });
    </script>
</head>
<style>
    body{background: none;}
    .first a:after {
        content: '';
        width: 2px;
        position: absolute;
        height: 36px;
        background: #044694;
        display: block;
        left: -1px;
        top: 5px;
    }
    .first1 a {
    color: #044694 !important;
    }
</style>
<body>

<div class="container pd0 shopCar">
    <div class="row clearfix">
        <div class="col-md-12 column"  style="height:82px;">
            <form id="form1" name="form1" action="?" type="_ajax">
            <div class="searchPro">
                <input type="text" class="txt" placeholder="输入产品名称" name="product_name"  value="<%=MT.f(h.get("product_name"))%>"/>
                <input type="text" style="display: none" name="category" value="<%=h.getInt("category")%>">
                <input type="button" class="btn" onclick="select_name()">
            </div>
            </form>
        </div>
        <div class="col-md-12 column column1" style="padding-right:0px;">
            <div class="node-nav x12 headv mt15 animated" >
                <div class="hd" ><a href="/html/folder/19080995-1.htm" style="background: none;">近距离治疗药物</a></div>
                <div class="hd" ><a href="/html/folder/19081308-1.htm" style="background: none;">治疗计划系统TPS</a></div>
                <div class="hd hd3" onclick='alt();'><a>放射性粒子商城</a></div>
                <div class="bd bd3" style='display:block;'>
                    <div <%= (Config.getInt("category1")==category?"class='first'":"")%> ><a href="/html/folder/19081608-1.htm?category=<%= Config.getInt("category1")%>">粒子治疗器械及耗材</a></div>
                    <div <%= (Config.getInt("category2")==category?"class='first'":"")%> ><a href="/html/folder/19081608-1.htm?category=<%= Config.getInt("category2")%>">粒子治疗相关设备</a></div>
                    <div <%= (Config.getInt("category3")==category?"class='first'":"")%> ><a href="/html/folder/19081608-1.htm?category=<%= Config.getInt("category3")%>">辐射检测</a></div>
                    <div <%= (Config.getInt("category4")==category?"class='first'":"")%> ><a href="/html/folder/19081608-1.htm?category=<%= Config.getInt("category4")%>">辐射防护</a></div>
                </div>
                <div class="hd <%= (Config.getInt("category5")==category?"first1":"")%>"><a  style="background: none;" href="/html/folder/19081645-1.htm?category=<%= Config.getInt("category5")%>" >前列腺设备支持服务</a></div>

            </div>

            <%
                int num=0;
                if(10==type){//没查到结果%>
            <div class="col-md-12 mt15 column2 animated" >
                <span  style='display: inline-block;width: 100%; text-align: center; margin-top: 100px; font-size: 18px; color: #333;'>
                    暂无产品
                    <!--<div class="desc">
                        <h3><span class="icon iconfont icon-tubiaolunkuo-"></span></h3>
                    </div>-->
                </span>


            </div>
                <%}else {
                List<ShopProduct> prolist = ShopProduct.find("  AND category in (select category from shopcategory where path like '%"+category+"%') AND state  = 0 ",pos, pageSize);
                for (int j = 0; j < prolist.size(); j++) {
                    ShopProduct p1 = prolist.get(j);
                    if(!product_name.equals("")){//查询操作
                        /*if(!p1.name[1].equals(product_name)){//相同*/
                            if(p1.name[1].indexOf(product_name)==-1){//是否包含查询的东西
                                if(j==prolist.size()-1&&num==0){//没有数据%>
            <div class="col-md-12 mt15 column2 animated" >
                <span  style='display: inline-block;width: 100%; text-align: center; margin-top: 100px; font-size: 18px; color: #333;'>
                    暂无产品
                    <!--<div class="desc">
                        <h3><span class="icon iconfont icon-tubiaolunkuo-"></span></h3>
                    </div>-->
                </span>


            </div>
            <%}
                            continue;
                        };
                    }
                    num++;

            %>
            <div class="col-md-4 mt15 column2 animated" >
                <span class="project pic" >
                    <a href="/html/folder/19081677-1.htm?product=<%= p1.product%>"><img src="<%= p1.getPicture('1')%>" /></a>
                    <%
                        if(p1.category!=Config.getInt("fuwu")){
                    %>
                    <%--<div class="desc"><!--onclick="car.addlist('<%= p1.product %>',1,'')"-->--%>
                        <%--<h3><span class="icon iconfont icon-tubiaolunkuo-"></span></h3>--%>
                    <%--</div>--%>
                    <%
                        }
                    %>
                </span>
                <span class="tit" style="height: 60px;">
                    <a href="/html/folder/19081677-1.htm?product=<%= p1.product%>" ><%= p1.name[1]%></a>

                </span>
                <span class="fot">
                    <a href="/html/folder/19081677-1.htm?product=<%= p1.product%>" class="btn btn-default">立即购买</a>
                </span>
                <%--<span class="list-jg money">￥<%= p1.price%></span>--%>
                <%--<span class="fot" ><a href="/html/folder/19081677-1.htm?product=<%= p1.product%>" class="btn btn-default">立即购买</a></span>--%>
            </div>
            <%
                }}
            %>
            <%

                //num=200;
                if(mysum>pageSize){%>
    <style>
        .con-fy a{color:#333;font-weight:normal;}
        .con-fy #go{color:#333;}
    .con-fy #go input{font-size:14px;padding:0 10px;}

    </style>
        <div style='width:100%; overflow:hidden;text-align:center;'>

            <div class='con-fy' style='font-weight:bold;margin-top:25px;margin-right:15px;color:#044694;'><%--<%=new tea.htmlx.FPNL(h.language,par.toString(),pos,pageSize)%>--%>
            <%= new tea.htmlx.FPNL(h.language, par.toString(), pos, mysum,pageSize)%>
            </div>
                <%}
                   /* out.print("<tr><td colspan='10' align='right'>"+new tea.htmlx.FPNL(h.language,par.toString(),num,pageSize));*/ %>
        </div>
        </div>
    </div>
</div>

<script src="js/jquery.waypoints.min.js"></script>
<script src="js/main.js"></script>
<script>
    mt.fit();

    function alt(){
        if(jQuery('.bd3').css('display')=='block'){
            jQuery('.bd3').slideUp();
        }else{
            jQuery('.bd3').slideDown();

        }
    }
    function select_name() {
        var name = form1.product_name.value;
        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=select_product&name=" + name, "", function (data) {

            if (data.type == 0) {//没有产品
                location.href="/html/folder/19081608-1.htm?type=10&product_name="+name;
            }if(data.type == 1){
                if(data.url.length==0){//没有产品
                    location.href = "/html/folder/19081608-1.htm?type=10&product_name=" + name;
                }else {
                    var a = data.url;
                    location.href = a;
                }
            }

        });
    }
    $("body").keydown(function (event) {
        if (event.keyCode == "13") {//keyCode=13是回车键；数字不同代表监听的按键不同
            select_name();
        }
    });


</script>
</body>
</html>

