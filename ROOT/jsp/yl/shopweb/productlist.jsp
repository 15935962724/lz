<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.yl.shop.ShopCategory" %>
<%@ page import="tea.entity.yl.shop.ShopProduct" %>
<%@ page import="util.Config" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Http h = new Http(request, response);
    String product_name = h.get("product_name", "");

%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" href="/res/lizi/css/bootstrap.css">
    <link rel="stylesheet" href="/res/lizi/css/animate.css">
    <link rel="stylesheet" href="/res/lizi/css/style1.css">
    <link rel="stylesheet" href="/res/lizi/css/common.css">
    <link href="/res/Home/cssjs/19062066L1.css" rel="stylesheet" type="text/css"/>
    <%--<script src='/res/lizi/js/jquery-1.11.3.min.js' type="text/javascript"></script>--%>
    <script src="/res/lizi/js/bootstrap.min.js"></script>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <script src='/tea/jquery-1.11.1.min.js'></script>
    <script src='/tea/yl/common.js' type="text/javascript"></script>
    <script>
        $(function () {
            $(".bd div").click(function () {
                $(this).addClass("headv-check").siblings().removeClass("headv-check");
                $(this).parents(".bd").siblings().children("div").removeClass("headv-check");
            });
        })
    </script>
</head>
<style>
    body {
        background: none;
    }

    .first a {
        color: #044694 !important;
    }
</style>
<body>

<div class="container pd0 shopCar">
    <div class="row clearfix">
        <form id="form1" name="form1" action="?" type="_ajax">
            <div class="col-md-12 column " style="height:82px;">
                <div class="searchPro">
                    <input type="text" class="txt" placeholder="??????????????????" name="product_name"
                           value="<%=MT.f(h.get("product_name"))%>"/>
                    <input type="text" style="display: none" name="category" value="<%=h.getInt("category")%>">
                    <input type="button" class="btn" onclick="select_name()">
                </div>
            </div>
        </form>
        <div class="col-md-12 column column1" style="padding-right:0px;">
            <div class="node-nav x12 headv mt15 animated">
                <div class="hd first "><a href="/html/folder/19080995-1.htm">?????????????????????</a></div>
                <div class="hd "><a style="background:none;" href="/html/folder/19081308-1.htm">??????????????????TPS</a></div>
                <div class="hd "><a>?????????????????????</a></div>
                <div class="bd">
                    <div><a href="/html/folder/19081608-1.htm?category=<%= Config.getInt("category1")%>">???????????????????????????</a>
                    </div>
                    <div><a href="/html/folder/19081628-1.htm?category=<%= Config.getInt("category2")%>">????????????????????????</a>
                    </div>
                    <div><a href="/html/folder/19081641-1.htm?category=<%= Config.getInt("category3")%>">????????????</a></div>
                    <div><a href="/html/folder/19081642-1.htm?category=<%= Config.getInt("category4")%>">????????????</a></div>
                </div>
                <div class="hd"><a href="/html/folder/19081645-1.htm?category=<%= Config.getInt("category5")%>"
                                   style="background: none;">???????????????????????????</a></div>
            </div>

            <%

                    String sql = "select P.* ,M.model from shopproduct P left join shopProduct_model M on P.model_id = m.id where p.category = '14102669' and P.state =0";
                    DbAdapter db = new DbAdapter();
                    ResultSet resultSet =  db.executeQuerySql(sql.toString());

                while(resultSet.next()) {
                        %>
                        <div class="col-md-4 mt15 column2 animated">
                            <span class="project pic ">
                                <a href="/html/folder/19080996-1.htm?category=14102669">
                                    <img src="/res/Home/product/14112077/19092842_s.jpg"/>
                                </a>
                            </span>
                            <span class="tit mt15" style="height: 60px;">
                                <a href="/html/folder/19080996-1.htm?category=14102669"><%=resultSet.getString("name1")%><%=resultSet.getString("model")%></a>
                            </span>
                            <span class="fot ">
                                <a href="/html/folder/19080996-1.htm?category=14102669" class="btn btn-default">????????????</a>
                            </span>
                        </div>
                        <%
                            }
            %>


        </div>
    </div>
</div>

</body>
<script>

    mt.fit();
    function select_name() {
        var name = form1.product_name.value;
        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=select_product&name=" + name, "", function (data) {
            if (data.type == 0) {//????????????
                location.href = "/html/folder/19081608-1.htm?type=10&product_name=" + name;
            } if(data.type == 1){
                if(data.url.length==0){//????????????
                    location.href = "/html/folder/19081608-1.htm?type=10&product_name=" + name;
                }else {
                    var a = data.url;
                    location.href = a;
                }
            }

        });
    }

    $("body").keydown(function (event) {
        if (event.keyCode == "13") {//keyCode=13??????????????????????????????????????????????????????
            select_name();
        }
    });
</script>
</html>