<%@page contentType="text/html; charset=UTF-8"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Http"%><%@page import="tea.entity.MT"%><%@page import="tea.entity.admin.AdminUsrRole"%><%@page import="tea.entity.member.Profile"%><%@page import="util.Config"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="tea.entity.yl.shop.CreatDetail" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.entity.member.Data" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.alibaba.fastjson.JSONArray" %>
<%@ page import="com.alibaba.fastjson.JSONObject" %>
<%@ page import="java.util.Calendar" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }
    if(h.isIllegal())
    {
        response.sendError(404,request.getRequestURI());
        return;
    }
    DbAdapter db = new DbAdapter();

%>
<!DOCTYPE html><html>
<head>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
    <script src="/tea/jquery-1.11.1.min.js"></script>
    <script src="/tea/yl/top.js"></script>
    <link href="/jsp/yl/data/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="/jsp/yl/data/assets/css/app.min.css" rel="stylesheet" type="text/css" />

</head>
<body>
<div class="container-fluid">
    <!-- Begin page -->
    <div class="wrapper">
        <div class="content-page">
            <div class="content">

                <div class="row">

                    <div class="col-xl-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title">往年粒子销量</h4>
                                <div id="distributed-column" class="apex-charts"></div>
                            </div>
                            <!-- end card body-->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col-->

                    <div class="col-xl-6">
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title">各个厂家往年销量</h4>
                                <div id="basic-column" class="apex-charts"></div>
                            </div>
                            <!-- end card body-->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col-->
                </div>
                <!-- end row-->

                <div class="row">
                    <div class="col-xl-6" style="position: relative;">
                        <div class="" style="z-index: 80;position: absolute;right: 38px;top: 20px;display: flex;flex-direction: column;align-items: flex-end;">
                            <%--<svg style="z-index: 20;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="none" d="M0 0h24v24H0V0z"></path><path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"></path></svg>--%>
                            <select id="salesDetails" class="yearList" onchange="salesDetails(this)">

                            </select>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title mb-4">近两年销量详情</h4>
                                <div id="line-chart-dashed" class="apex-charts"></div>
                            </div>
                            <!-- end card body-->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col-->

                    <div class="col-xl-6" style="position: relative;">
                        <div class="" style="z-index: 80;position: absolute;right: 38px;top: 20px;display: flex;flex-direction: column;align-items: flex-end;">
                            <%--<svg style="z-index: 20;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="none" d="M0 0h24v24H0V0z"></path><path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"></path></svg>--%>
                            <select id="salesRanking"  class="yearList" onchange="getSalesRanking(this)">

                            </select>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title mb-3">服务商销量排行榜</h4>
                                <div id="datalabels-column" class="apex-charts"></div>
                            </div>
                            <!-- end card body-->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col-->


                </div>
                <!-- end row-->

                <div class="row">

                    <div class="col-xl-6">
                        <%--<div class="" style="z-index: 80;position: absolute;right: 38px;top: 20px;display: flex;flex-direction: column;align-items: flex-end;">
                            <select id="invoicedQuantity"  class="yearList" onchange="getInvoicedQuantity(this)">

                            </select>
                        </div>--%>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title">粒子开票数</h4>
                                <div id="multiple-yaxis-mixed" class="apex-charts"></div>
                            </div>
                            <!-- end card body-->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col-->

                    <div class="col-xl-6">
                        <div class="" style="z-index: 80;position: absolute;right: 38px;top: 20px;display: flex;flex-direction: column;align-items: flex-end;">
                            <select id="invoicedGrew"  class="yearList" onchange="getInvoicedGrew(this)">

                            </select>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title">开票数量同比</h4>
                                <div id="simple-pie" class="apex-charts"></div>
                            </div>
                            <!-- end card body-->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col-->
                </div>
                <!-- end row-->
            </div> <!-- content -->
        </div> <!-- content-page -->

    </div> <!-- end wrapper-->

    <!-- ============================================================== -->
    <!-- End Page content -->
    <!-- ============================================================== -->


</div>
<!-- END Container -->
<!-- App js -->

<!-- third party:js -->
<script src="/jsp/yl/data/assets/js/apexcharts.js"></script>
<!-- third party end -->

<!-- demo:js -->
<%--<script src="/jsp/yl/data/assets/js/pages/demo.apex-column.js"></script>--%>
<!-- demo end -->
<script>
    var myDate = new Date();
    var thisYear = myDate.getFullYear();  // 获取当年年份
    var arrYear = '<option>请选择</option>'; // 声明一个空数组 把遍历出的年份添加到数组里
    for(var i = thisYear; i>= 2015;i--){
        arrYear += '<option value="'+i+'">'+ i +'年</optipn>'
    }
    $(".yearList").append(arrYear)

    function getYear(_this){
        alert($(_this).val())
        var id = $(_this).arrt('id');
    }


    var twoYearLine;//近两年销量情况

    var salesRanking;//销量排行
    var liziLine;//粒子开票数
    var kaipiaoPie;//开票数量同比

    var title = '';//销量排行
    $(function () {
        var chart ,colors;
        var distributed_colors = [];
        var distributed_data = [];
        var distributed_categories = [];

        <%

        String  sql= "select DATENAME(year,O.createdate) as years ,sum(OD.quantity) as quantity from shopOrderData  OD left join shopOrder O on O.order_id = OD.order_id \n" +
                    "where DATENAME(year,O.createdate)  is not null\n" +
                    "GROUP BY DATENAME(year,createdate) order by  DATENAME(year,O.createdate)";
        ResultSet resultSet =  db.executeQuerySql(sql.toString());
            while(resultSet.next()) {
             %>
                distributed_colors.push(randomColor());
                distributed_categories.push(<%=resultSet.getString("years")%>);
                distributed_data.push(<%=resultSet.getInt("quantity")%>);
            <%
            }
        %>
        var options = {
            chart: {
                height: 380, type: "bar", toolbar: {show: !1}, events: {
                    click: function (o, e, t) {

                    }
                }
            },
            colors: distributed_colors,
            plotOptions: {bar: {columnWidth: "45%", distributed: !0}},
            dataLabels: {enabled: !1},
            series: [{
                name:"销量",
                // data: [21, 22, 10, 28, 16, 21, 13, 30]
                data: distributed_data
            }],
            xaxis: {
                // categories: ["John", "Joe", "Jake", "Amber", "Peter", "Mary", "David", "Lily"],
                categories: distributed_categories,
                labels: {style: {colors: distributed_colors, fontSize: "14px"}}
            },
            grid: {row: {colors: ["transparent", "transparent"], opacity: .2}, borderColor: "#f1f3fa"}
        };
        (chart = new ApexCharts(document.querySelector("#distributed-column"), options)).render();


                 var basic_colors = [];
                 var basic_categories = [];
                 var basic_series = [];
                <%
                sql = "select DATENAME(year,O.createdate) as years from  shopOrder O GROUP BY DATENAME(year,createdate) order by  DATENAME(year,O.createdate)";
                  resultSet =  db.executeQuerySql(sql);
                  while(resultSet.next()) {
                      %>
                         basic_categories.push(<%=resultSet.getInt("years")%>);
                     <%
                    }
                JSONArray jsonArray = new JSONArray();
                JSONObject junan = new JSONObject();
                junan.put("name","君安");
                junan.put("code","junan");
                jsonArray.add(junan);
                JSONObject gaoke = new JSONObject();
                gaoke.put("name","高科");
                gaoke.put("code","gaoke");
                jsonArray.add(gaoke);
                JSONObject xinke = new JSONObject();
                xinke.put("name","欣科");
                xinke.put("code","xinke");
                jsonArray.add(xinke);
                for (Object object : jsonArray) {
                    JSONObject jsonObject = JSONObject.parseObject(object.toString());
                    List<Integer>data = new ArrayList<Integer>();
                    sql = "select A.years ,ISNULL ( C.quantity , 0 ) as quantity from \n" +
                    "(select DATENAME(year,O.createdate) as years from  shopOrder O GROUP BY DATENAME(year,createdate) ) as A\n" +
                    "left join (\n" +
                    "select DATENAME(year,O.createdate) as years ,sum(OD.quantity) as quantity from shopOrderData OD \n" +
                    "left join shopOrder O on O.order_id = OD.order_id  \n" +
                    "left join shopproduct P on OD.product_id = P.product where  P.puid = '"+Config.getInt(jsonObject.getString("code"))+"'\n" +
                    "GROUP BY DATENAME(year,O.createdate) \n" +
                    ")  C on A.years = C.years order by A.years";

                    resultSet =  db.executeQuerySql(sql.toString());
                    while(resultSet.next()) {
                      data.add(resultSet.getInt("quantity"));
                    }
                     %>
                    var data = {
                        name:'<%=jsonObject.getString("name")%>',
                        data:<%=data%>
                    };
                    basic_series.push(data);
                    basic_colors.push(randomColor());
                    <%
                }

            %>

        options = {
            chart: {height: 396, type: "bar", toolbar: {show: !1}},
            plotOptions: {bar: {horizontal: !1, endingShape: "rounded", columnWidth: "55%"}},
            dataLabels: {enabled: !1},
            stroke: {show: !0, width: 2, colors: ["transparent"]},
            // colors: ["#727cf5", "#0acf97", "#fa5c7c"],
            colors:basic_colors,

            // series: [
            //     {name: "Net Profit", data: [44, 55, 57, 56, 61, 58, 63, 60, 66]},
            //     {name: "Revenue",data: [76, 85, 101, 98, 87, 105, 91, 114, 94]},
            //     {name: "Free Cash Flow", data: [35, 41, 36, 26, 45, 48, 52, 53, 41]}],
            series: basic_series,
            xaxis: {
                // categories: ["Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct"]
                categories: basic_categories
            },
            legend: {offsetY: -10},
            yaxis: {title: {text: "单位(粒)"}},
            fill: {opacity: 1},
            grid: {row: {colors: ["transparent", "transparent"], opacity: .2}, borderColor: "#f1f3fa"},
            tooltip: {
                y: {
                    formatter: function (o) {
                        return   o + " 粒"
                    }
                }
            }
        };
        (chart = new ApexCharts(document.querySelector("#basic-column"), options)).render();


        var line_chart_dashed_colors = [];
        var line_chart_dashed_series = [];
        <%
            Calendar calendar = Calendar.getInstance();
            int year = calendar.get(Calendar.YEAR);
            for(int i = year-2; i <= year; i++) {
                int years = i;
              sql = "select A.mon ,ISNULL(B.quantity, 0 ) as quantity from (\n" +
                    "SELECT '"+years+"'+'-01' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-02' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-03' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-04' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-05' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-06' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-07' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-08' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-09' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-10' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-11' AS mon UNION\n" +
                    "SELECT '"+years+"'+'-12' AS mon) A \n" +
                    "left join(\n" +
                    "select CONVERT(varchar(7),O.createdate,120) as years ,sum(OD.quantity) as quantity from shopOrderData OD \n" +
                    "left join shopOrder O on O.order_id = OD.order_id \n" +
                    "where DATENAME(year,O.createdate) = '"+years+"'\n" +
                    "group by CONVERT(varchar(7),O.createdate,120) \n" +
                    ") B on A.mon = B.years order by A.mon";
                    DbAdapter year_quantity_db = new DbAdapter();
                    ResultSet year_quantity =  year_quantity_db.executeQuerySql(sql);
                    List<Integer>year_data = new ArrayList<Integer>();
                     while(year_quantity.next()) {
                         year_data.add(year_quantity.getInt("quantity"));
                     }
                        %>
                        var line_chart_dashed_data = {
                            name:'<%=years%>',
                            data:<%=year_data%>
                        };
                        line_chart_dashed_series.push(line_chart_dashed_data);
                        line_chart_dashed_colors.push(randomColor());
                        <%

                        }

%>
        var twoYearOptions = {
            chart: {height: 380, type: "line", zoom: {enabled: !1},toolbar: {show: !1}},
            dataLabels: {enabled: !1},
            stroke: {width: 5, curve: "straight"},
            // series: [
            //     {name: 2017,data: [45, 52, 38, 24, 33, 26, 21, 20, 6, 8, 15, 10]},
            //     {name: 2018,data: [35, 41, 62, 42, 13, 18, 29, 37, 36, 51, 32, 35]},
            //     {name: 2019,data: [87, 57, 74, 99, 75, 38, 62, 47, 82, 56, 45, 47]}
            //     ],
            series: line_chart_dashed_series,
            markers: {size: 0, style: "hollow"},
            xaxis: {
                categories: ["01月", "02月", "03月", "04月", "05月", "06月", "07月", "08月", "09月", "10月", "11月", "12月"]
            },
            colors: line_chart_dashed_colors,
            tooltip: {
                y: {
                    title: {
                        formatter: function (e) {
                            return "Session Duration" === e ? e + " (mins)" : "Page Views" === e ? e + " per session" : e
                        }
                    }
                }
            },
            grid: {borderColor: "#f1f3fa"},
            legend: {offsetY: -10}
        };
        twoYearLine = new ApexCharts(document.querySelector("#line-chart-dashed"), twoYearOptions);
        twoYearLine.render();

        var datalabels_column_categories = [];
        var datalabels_column_data = [];
        var datalabels_column_colors = [];
        <%
    sql = "select top 10 A.member ,B.quantity from Profile A " +
     "left join (select P.umember, sum(OD.quantity) as quantity from shopOrderData OD" +
      " left join shopOrder O on OD.order_id = O.order_id left join Profile P " +
       "on O.member = P.profile where  DATENAME(year,O.createdate) = '"+year+"' GROUP BY P.umember ) B " +
      "on A.profile = B.umember order by quantity desc";
            resultSet =  db.executeQuerySql(sql);
             while(resultSet.next()) {
                  %>
                    datalabels_column_categories.push("<%=resultSet.getString("member")%>");
                    datalabels_column_data.push(<%=resultSet.getInt("quantity")%>);
                    datalabels_column_colors.push(randomColor());
                <%
}
%>

        <%
            %>
             title = <%=year%>+"销量排行";
            <%
        %>



        var salesRankingoptions = {
            chart: {height: 380, type: "bar", toolbar: {show: !1}},
            plotOptions: {bar: {dataLabels: {position: "top"}}},
            dataLabels: {
                enabled: 0, formatter: function (o) {
                    return o + "%"
                },
                // offsetY: -40
                // style: {fontSize: "12px", colors: ["#304758"]}
            },
            colors: datalabels_column_colors,
            series: [{name: "销量", data: datalabels_column_data}],
            xaxis: {
                categories: datalabels_column_categories,
                // position: "top",
                labels: {offsetY: -4},
                // axisBorder: {show: !1},
                // axisTicks: {show: !1},
                crosshairs: {
                    fill: {
                        type: "gradient",
                        gradient: {colorFrom: "#D8E3F0", colorTo: "#BED1E6", stops: [0, 100], opacityFrom: .4, opacityTo: .5}
                    }
                },
                // tooltip: {enabled: !0, offsetY: -35}
            },
            fill: {
                gradient: {
                    enabled: !1,
                    shade: "light",
                    type: "horizontal",
                    shadeIntensity: .25,
                    gradientToColors: void 0,
                    inverseColors: !0,
                    opacityFrom: 1,
                    opacityTo: 1,
                    stops: [50, 0, 100, 100]
                }
            },
            yaxis: {
                axisBorder: {show: !1}, axisTicks: {show: !1}, labels: {
                    show: !1, formatter: function (o) {
                        return o
                    }
                }
            },
            title: {
                text: title,
                floating: !0,
                offsetY: 362,
                align: "center",
                style: {color: "#444"}
            },
            grid: {row: {colors: ["transparent", "transparent"], opacity: .2}, borderColor: "#f1f3fa"}
        };


        salesRanking  = new ApexCharts(document.querySelector("#datalabels-column"), salesRankingoptions);
        salesRanking.render();

        var stacked_column_datas = [];
        var stacked_column_colors = [];
        <%
             for(int j = year; j >=(year-1); j--) {
                    sql = "select puid,sum(num) as num from invoice where status = 2 and DATENAME(year,makeoutdate) = '"+j+"' group by puid order by puid;";
                    resultSet = db.executeQuerySql(sql);
                    List<Integer> datas = new ArrayList<Integer>() ;
                    while (resultSet.next()){
                        datas.add(resultSet.getInt("num"));
                    }
                    %>
                    var stacked_column_data = {
                        name:'<%=j%>'+'年开票数量',
                        type:'column',
                        data:<%=datas%>
                    };
                    stacked_column_datas.push(stacked_column_data);
                    stacked_column_colors.push(randomColor());
                    <%
             }
        %>
        var liziLineOptions = {
            chart: {height: 380, type: "line", stacked: !1, toolbar: {show: !1}},
            dataLabels: {enabled: !1},
            stroke: {width: [0, 0, 3]},
            series: stacked_column_datas,
            colors: stacked_column_colors,
            xaxis: {categories: ['同福','君安','高科']},
            tooltip: {
                followCursor: !0, y: {
                    formatter: function (e) {
                        return void 0 !== e ? e + " 粒" : e
                    }
                }
            },
            grid: {borderColor: "#f1f3fa"},
            legend: {offsetY: -10},
            responsive: [{breakpoint: 600, options: {yaxis: {show: !1}, legend: {show: !1}}}]
        };
        liziLine = new ApexCharts(document.querySelector("#multiple-yaxis-mixed"), liziLineOptions);
        liziLine.render();


        var simple_pie_series = [];
        var simple_pie_labels = [];
        var simple_pie_colors = [];

        <%
            sql = "select PU.name ,sum(I.num) as num from invoice I left join ProcurementUnit PU on I.puid = PU.puid where I.status = 2  group by PU.name";
            resultSet = db.executeQuerySql(sql);
            while (resultSet.next()){
                %>
                simple_pie_series.push(<%=resultSet.getInt("num")%>);
                simple_pie_labels.push("<%=resultSet.getString("name")%>");
                simple_pie_colors.push(randomColor());
                <%
            }
        %>

        console.log(simple_pie_series);
        console.log(simple_pie_labels);
        var kaipiaoOptions = {
            chart: {height: 320, type: "pie"},
            series: simple_pie_series,
            labels: simple_pie_labels,
            colors: simple_pie_colors,
            legend: {
                show: !0,
                position: "bottom",
                horizontalAlign: "center",
                verticalAlign: "middle",
                floating: !1,
                fontSize: "14px",
                offsetX: 0,
                offsetY: -10
            },
            responsive: [{breakpoint: 600, options: {chart: {height: 240}, legend: {show: !1}}}]
        };
        kaipiaoPie = new ApexCharts(document.querySelector("#simple-pie"), kaipiaoOptions);
        kaipiaoPie.render();

    });


    //近两年销量情况
    function salesDetails(_this){
        $.ajax({
            type:"POST",
            url:'/PlatformData.do',
            data:{
                year: $(_this).val()
            },
            dataType:"json",
            async: false,
            success:function (data) {
                twoYearLine.updateOptions({
                    series: data
                });
            }
        });
    }




    //销量排行
    function getSalesRanking(_this){
        $.ajax({
            type:"POST",
            url:'/SalesRanking.do',
            data:{
                year: $(_this).val()
            },
            dataType:"json",
            async: false,
            success:function (data) {
                salesRanking.updateOptions({
                    series: [{name: "销量", data: data.quantity}],
                    xaxis: {
                        categories: data.members,
                        position: "top",
                        labels: {offsetY: -18},
                        axisBorder: {show: !1},
                        axisTicks: {show: !1},
                        crosshairs: {
                            fill: {
                                type: "gradient",
                                gradient: {colorFrom: "#D8E3F0", colorTo: "#BED1E6", stops: [0, 100], opacityFrom: .4, opacityTo: .5}
                            }
                        },
                        tooltip: {enabled: !0, offsetY: -35}
                    },
                    title: {
                        text: data.title,
                        floating: !0,
                        offsetY: 350,
                        align: "center",
                        style: {color: "#444"}
                    }
                });
            }
        });
    }

    //粒子开票数量
    function getInvoicedQuantity(_this){
        $.ajax({
            type:"POST",
            url:'/InvoicedQuantity.do',
            data:{
                year: $(_this).val()
            },
            dataType:"json",
            async: false,
            success:function (data) {
                liziLine.updateOptions({
                    series: data
                })
            }
        });
    }

    //粒子开票数量占比
    function getInvoicedGrew(_this){
        $.ajax({
            type:"POST",
            url:'/InvoicedGrew.do',
            data:{
                year: $(_this).val()
            },
            dataType:"json",
            async: false,
            success:function (data) {
                console.log(data);
                kaipiaoPie.updateOptions({
                    series: data.nums,
                    labels: data.names,
                })
            }
        });
    }





    /*随机颜色*/
    function randomColor() {
        var r = Math.floor(Math.random()*256);
        var g = Math.floor(Math.random()*256);
        var b = Math.floor(Math.random()*256);
        if(r < 16){
            r = "0"+r.toString(16);
        }else{
            r = r.toString(16);
        }
        if(g < 16){
            g = "0"+g.toString(16);
        }else{
            g = g.toString(16);
        }
        if(b < 16){
            b = "0"+b.toString(16);
        }else{
            b = b.toString(16);
        }
        return "#"+r+g+b;
    }

</script>

</body>

</html>
