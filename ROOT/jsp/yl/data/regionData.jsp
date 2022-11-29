<%@page contentType="text/html; charset=UTF-8"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.admin.AdminUsrRole"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="util.Config"%>
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
<!DOCTYPE html>
<html>
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
                    <div class="col-xl-12" style="position: relative;">
                        <div class="" style="z-index: 80;position: absolute;right: 38px;top: 20px;display: flex;flex-direction: column;align-items: flex-end;">
                            <%--<svg style="z-index: 20;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="none" d="M0 0h24v24H0V0z"></path><path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"></path></svg>--%>
                            <select id="salesDetails" class="yearList" onchange="salesDetails(this)">

                            </select>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title mb-4">近两年地区销量详情</h4>
                                <div id="line-chart-dashed" class="apex-charts"></div>
                            </div>
                            <!-- end card body-->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col-->
                </div>
                <!-- end row-->

                <div class="row">
                    <div class="col-xl-12" style="position: relative;">
                        <div class="" style="z-index: 80;position: absolute;right: 38px;top: 20px;display: flex;flex-direction: column;align-items: flex-end;">
                            <%--<svg style="z-index: 20;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="none" d="M0 0h24v24H0V0z"></path><path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"></path></svg>--%>
                            <select id="hospitalDetails" class="yearList" onchange="getHospitalDetails(this)">

                            </select>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title mb-4">医院销量排行榜</h4>
                                <div id="tree-chart-dashed" class="apex-charts"></div>
                            </div>
                            <!-- end card body-->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col-->
                </div>

                <div class="row">
                    <div class="col-xl-12" style="position: relative;">
                        <div class="" style="z-index: 80;position: absolute;right: 38px;top: 20px;display: flex;flex-direction: column;align-items: flex-end;">
                            <%--<svg style="z-index: 20;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="none" d="M0 0h24v24H0V0z"></path><path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"></path></svg>--%>
                            <select id="areaDetails" class="yearList" onchange="getAreaDetails(this)">

                            </select>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title mb-4">全国销量展示</h4>
                                <div id="area-chart-dashed" class="apex-charts" style="height: 1000px;"></div>
                            </div>
                            <!-- end card body-->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col-->
                </div>

                <div class="row">
                    <div class="col-xl-12" style="position: relative;">
                        <div class="" style="z-index: 80;position: absolute;right: 38px;top: 20px;display: flex;justify-content: center;align-items: flex-end;">
                            <%--<svg style="z-index: 20;" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="none" d="M0 0h24v24H0V0z"></path><path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"></path></svg>--%>
                            <select style="margin-right: 20px" id="yearsSelect" class="yearList" onchange="getOrderQuantityBillingQuantity()">

                            </select>
                            厂家：<select id="changjiaList" onchange="getOrderQuantityBillingQuantity()">
                                <option value="">请选择</option>
                                <option value="tongfu">同辐</option>
                                <option value="gaoke">高科</option>
                                <option value="junan">君安</option>
                            </select>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title mb-4">开票数量订单量同比</h4>
                                <div id="Order-quantity-Billing-quantity" class="apex-charts" style="height: 1000px;"></div>
                            </div>
                            <!-- end card body-->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col-->
                </div>


            </div> <!-- content -->
        </div> <!-- content-page -->

    </div> <!-- end wrapper-->

    <!-- ============================================================== -->
    <!-- End Page content -->
    <!-- ============================================================== -->


</div>
<!-- END Container -->
<!-- App js -->

<script src="/jsp/yl/data/assets/js/apexcharts.js"></script>
<!-- third party:js -->
<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.6.12/apexcharts.min.js"></script>--%>
<%--<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>--%>
<!-- third party end -->

<!-- demo:js -->
<%--<script src="/jsp/yl/data/assets/js/pages/demo.apex-column.js"></script>--%>
<!-- demo end -->
<script src="/jsp/yl/data/assets/js/echarts.min.js"></script>
<script src="/jsp/yl/data/assets/js/china.js"></script>
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
    var treeYearLine ;//医院销量排行榜
    var myMap;
    var kaipiaoChart;

    $(function () {
        var chart ,colors;

        <%
        String  sql= "";
        ResultSet resultSet ;
        %>
        var options ;


        var line_chart_dashed_colors = [];
        var line_chart_dashed_series = [];
        var line_chart_dashed_categories = [];
        <%
            Calendar calendar = Calendar.getInstance();
            int thisYear = calendar.get(Calendar.YEAR);
            int lastYear = thisYear-1;
              sql = "select B.name,ISNULL(C.quantity, 0 ) as thisQuantity ,ISNULL(D.quantity, 0 ) as lastQuantity from Areas B left join (\n" +
                    "select A.id, A.name,sum( OD.quantity) as quantity\n" +
                    "from shopOrderData OD left join shopOrder O on OD.order_id  = O.order_id left join ShopOrderDispatch SOD on O.order_id = SOD.order_id\n" +
                    "left join shopHospital H on SOD.a_hospital_id = H.id Left join Areas A on H.area = A.id\n" +
                    "where  DATENAME(year,O.createdate) = '"+thisYear+"' group by A.id, A.name \n" +
                    ") C on B.id = C.id \n" +
                    "left join (\n" +
                    "select A.id, A.name,sum( OD.quantity) as quantity\n" +
                    "from shopOrderData OD left join shopOrder O on OD.order_id  = O.order_id left join ShopOrderDispatch SOD on O.order_id = SOD.order_id\n" +
                    "left join shopHospital H on SOD.a_hospital_id = H.id Left join Areas A on H.area = A.id\n" +
                    "where  DATENAME(year,O.createdate) = '"+lastYear+"' group by A.id, A.name \n" +
                    ") D on B.id = D.id\n" +
                    "order by B.id";
                    resultSet =  db.executeQuerySql(sql);
                    List<Integer>this_year_data = new ArrayList<Integer>();
                    List<Integer>last_year_data = new ArrayList<Integer>();
                    JSONArray jsonArray = new JSONArray();
                     while(resultSet.next()) {
                            %>
                            line_chart_dashed_categories.push('<%=resultSet.getString("name")%>');
                            line_chart_dashed_colors.push(randomColor());
                            <%
                            this_year_data.add(resultSet.getInt("thisQuantity"));
                            last_year_data.add(resultSet.getInt("lastQuantity"));
                    }
                     JSONObject thisYearData = new JSONObject();
                     thisYearData.put("name",thisYear);
                     thisYearData.put("data",this_year_data);
                     jsonArray.add(thisYearData);
                     JSONObject lastYearData = new JSONObject();
                     lastYearData.put("name",lastYear);
                     lastYearData.put("data",last_year_data);
                     jsonArray.add(lastYearData);

%>
        console.log( <%=jsonArray.toJSONString()%>);
        var twoYearOptions = {
            chart: {height: 380, type: "line", zoom: {enabled: !1},toolbar: {show: !1}},
            dataLabels: {enabled: !1},
            stroke: {width: 5, curve: "straight"},
            // series: [
            //     {name: 2017,data: [45, 52, 38, 24, 33, 26, 21, 20, 6, 8, 15, 10]},
            //     {name: 2018,data: [35, 41, 62, 42, 13, 18, 29, 37, 36, 51, 32, 35]},
            //     {name: 2019,data: [87, 57, 74, 99, 75, 38, 62, 47, 82, 56, 45, 47]}
            //     ],
            series: <%=jsonArray.toJSONString()%>,
            markers: {size: 0, style: "hollow"},
            xaxis: {
                // categories: ["01月", "02月", "03月", "04月", "05月", "06月", "07月", "08月", "09月", "10月", "11月", "12月"]
                categories: line_chart_dashed_categories
            },
            colors: ["#727cf5","#0acf97"],
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

        var tree_chart_dashed_data = [];

        <%
             sql = "select top 10 SOD.a_hospital,sum(OD.quantity) quantity from shopOrderData OD left join shopOrder O on OD.order_id = O.order_id\n" +
                "left join shopOrderDispatch SOD on O.order_id = SOD.order_id group by SOD.a_hospital order by quantity desc";
                   resultSet =  db.executeQuerySql(sql);
//                   JSONArray tree_chart_dashed_dtaa = new JSONArray();
                    while(resultSet.next()) {
                        %>
                            var data = {
                                x: "<%=resultSet.getString("a_hospital")%>",
                                y: <%=resultSet.getInt("quantity")%>
                            };
                            tree_chart_dashed_data.push(data);
                        <%
                    }
        %>
        var treeYearOptions = {
            chart: {
                height: 350,
                type: "treemap",
                zoom: {enabled: !1},
                toolbar: {show: !1}
            },
            series: [
                {
                    data: tree_chart_dashed_data
                },
            ],
            plotOptions: {
                treemap: {
                    distributed: true
                }
            }
        }
        treeYearLine = new ApexCharts(document.querySelector("#tree-chart-dashed"), treeYearOptions);
        treeYearLine.render();

        <%
        sql = "select A.mon ,ISNULL(B.quantity, 0 ) as quantity,ISNULL(C.num,0)as num from (\n" +
                "SELECT '"+thisYear+"-01' AS mon UNION\n" +
                "SELECT '"+thisYear+"-02' AS mon UNION\n" +
                "SELECT '"+thisYear+"-03' AS mon UNION\n" +
                "SELECT '"+thisYear+"-04' AS mon UNION\n" +
                "SELECT '"+thisYear+"-05' AS mon UNION\n" +
                "SELECT '"+thisYear+"-06' AS mon UNION\n" +
                "SELECT '"+thisYear+"-07' AS mon UNION\n" +
                "SELECT '"+thisYear+"-08' AS mon UNION\n" +
                "SELECT '"+thisYear+"-09' AS mon UNION\n" +
                "SELECT '"+thisYear+"-10' AS mon UNION\n" +
                "SELECT '"+thisYear+"-11' AS mon UNION\n" +
                "SELECT '"+thisYear+"-12' AS mon) A left join (\n" +
                "select CONVERT(varchar(7),O.createdate,120) as years ,sum(OD.quantity) as quantity from shopOrderData OD left join shopOrder O on OD.order_id = O.order_id \n" +
                "where O.status != 5 and DATENAME(year,O.createdate) = '"+thisYear+"' group by CONVERT(varchar(7),O.createdate,120) \n" +
                ") B on A.mon = B.years left join (\n" +
                "select CONVERT(varchar(7),makeoutdate,120) as makeoutDate ,sum(num) num from invoice where status = 2 and DATENAME(year,makeoutdate) = '"+thisYear+"' group by CONVERT(varchar(7),makeoutdate,120) \n" +
                ") C on A.mon = C.makeoutDate order by A.mon";
        resultSet =  db.executeQuerySql(sql);
        JSONArray orderQuantityBillingQuantity = new JSONArray();
        List<Integer> orderQuantity = new ArrayList<Integer>();
        List<Integer> billingQuantity = new ArrayList<Integer>();

        while (resultSet.next()){
            orderQuantity.add(resultSet.getInt("quantity"));
            billingQuantity.add(resultSet.getInt("num"));
        }
        JSONObject orderQuantityJson = new JSONObject();
        orderQuantityJson.put("data",orderQuantity);
        orderQuantityJson.put("name","下单数量");
        orderQuantityBillingQuantity.add(orderQuantityJson);
        JSONObject billingQuantityJson = new JSONObject();
        billingQuantityJson.put("data",billingQuantity);
        billingQuantityJson.put("name","开票数量");
        orderQuantityBillingQuantity.add(billingQuantityJson);
        %>
        console.log(<%=orderQuantityBillingQuantity%>)
        var kaipiaoOptions = {
            chart: {height: 396, type: "bar", toolbar: {show: !1}},
            plotOptions: {bar: {horizontal: !1, endingShape: "rounded", columnWidth: "55%"}},
            dataLabels: {enabled: !1},
            stroke: {show: !0, width: 2, colors: ["transparent"]},
            colors: ["#727cf5", "#fa5c7c"],
            // series: [
            //     {name: "Net Profit", data: [44, 55, 57, 56, 61, 58, 63, 60, 66,85,93,42]},
            //     {name: "Free Cash Flow", data: [35, 41, 36, 26, 45, 48, 52, 53, 41,69,72,58]}
            //     ],
            series: <%=orderQuantityBillingQuantity%>,
            xaxis: {categories: ["01月", "02月", "03月", "04月", "05月", "06月", "07月", "08月", "09月", "10月", "11月", "12月"]},
            legend: {offsetY: -10},
            yaxis: {title: {text: "单位 (粒)"}},
            fill: {opacity: 1},
            grid: {row: {colors: ["transparent", "transparent"], opacity: .2}, borderColor: "#f1f3fa"},
            tooltip: {
                y: {
                    formatter: function (o) {
                        return  o + " 粒"
                    }
                }
            }
        };
        kaipiaoChart = new ApexCharts(document.querySelector("#Order-quantity-Billing-quantity"), kaipiaoOptions);
        kaipiaoChart.render();

        var areaData = [];
        <%
             sql = "select A.name,sum( OD.quantity) as quantity\n" +
                    "from shopOrderData OD left join shopOrder O on OD.order_id  = O.order_id left join ShopOrderDispatch SOD on O.order_id = SOD.order_id\n" +
                    "left join shopHospital H on SOD.a_hospital_id = H.id Left join Areas A on H.area = A.id group by A.name ";
                   resultSet =  db.executeQuerySql(sql);
//                   JSONArray tree_chart_dashed_dtaa = new JSONArray();
                    while(resultSet.next()) {
                        %>
                    var data = {
                        name: "<%=resultSet.getString("name")%>",
                        value: <%=resultSet.getInt("quantity")%>
                    };
                 areaData.push(data);
        <%
        }
    %>

        var optionMap = {
            backgroundColor: '#FFFFFF',
            title: {
                text: '全国地图大数据',
                subtext: '',
                x:'center'
            },
            tooltip : {
                trigger: 'item'
            },

            //左侧小导航图标
            visualMap: {
                show : true,
                x: 'left',
                y: 'center',
                // color: ['#EF0154','#EACCD2']
                splitList: [
                    {start: 50000, end: 6000000},{start: 40000, end: 50000},
                    {start: 30000, end: 40000},{start: 20000, end: 30000},
                    {start: 10000, end: 20000},{start: 0, end: 10000},
                ],
                color: ['#EF0154', '#F5357E', '#F5578A','#F386A1', '#FFB4C0', '#EACCD2']
            },

            //配置属性
            series: [{
                name: '数据',
                type: 'map',
                mapType: 'china',
                roam: true,
                label: {
                    normal: {
                        show: true  //省份名称
                    },
                    emphasis: {
                        show: false
                    }
                },
                data:areaData  //数据
            }]
        };
        //初始化echarts实例
        myMap = echarts.init(document.getElementById('area-chart-dashed'));

        //使用制定的配置项和数据显示图表
        myMap.setOption(optionMap);

    });


    //近两年销量情况
    function salesDetails(_this){
        $.ajax({
            type:"POST",
            url:'/RegionData.do',
            data:{
                year: $(_this).val()
            },
            dataType:"json",
            async: false,
            success:function (data) {
              console.log(data);
              var seriesLast = [];
              var seriesThis = [];
              var categories = [];
              var lastYear = $(_this).val() - 1;
              for(var i = 0; i < data.length; i++){
                  seriesLast.push(data[i].lastQuantity);
                  seriesThis.push(data[i].thisQuantity);
                  categories.push(data[i].name);
              }
                twoYearLine.updateOptions({
                    series: [{
                        name: lastYear,
                        data: seriesLast
                    },{
                        name: $(_this).val(),
                        data: seriesThis
                    }],
                    xaxis: {
                        categories: categories
                    },
                });
            }
        });
    }

    //医院销量排行
    function getHospitalDetails(_this){
        $.ajax({
            type:"POST",
            url:'/HospitalDetails.do',
            data:{
                year: $(_this).val()
            },
            dataType:"json",
            async: false,
            success:function (data) {
                console.log(data);
                var series = [];
                for(var i =0 ;i < data.length; i++){
                    series.push({
                        x: data[i].a_hospital,
                        y: data[i].quantity
                    })
                }
                treeYearLine.updateOptions({
                    series:[{data: series}]
                })
            }
        });
    }

    //销量开票同比
    function getOrderQuantityBillingQuantity(){
        if( $("#yearsSelect").val() == '请选择'){
            alert("请选择年份！")
            return false;
        }
        $.ajax({
            type:"POST",
            url:'/OrderQuantityBillingQuantity.do',
            data:{
                year: $("#yearsSelect").val(),
                puid: $("#changjiaList").val()
            },
            dataType:"json",
            async: false,
            success:function (data) {
                console.log(data);
                var xiadanNum = {
                    name: "下单数量",
                    data: []
                };
                var kaipiaoNum = {
                    name: "开票数量",
                    data: []
                };
                for(var i = 0; i < data.length; i++){
                    xiadanNum.data.push(data[i].quantity);
                    kaipiaoNum.data.push(data[i].num);
                }
                var serices = [xiadanNum, kaipiaoNum];
                console.log(serices)
                kaipiaoChart.updateOptions({
                    series: serices
                })
            }
        });
    }

    //全国地区销量详情
    function getAreaDetails(_this){
        $.ajax({
            type:"POST",
            url:'/AreaDetails.do',
            data:{
                year: $(_this).val()
            },
            dataType:"json",
            async: false,
            success:function (data) {
                console.log(data);
                var areaData = [];
                for(var i =0 ;i < data.length; i++){
                    areaData.push({
                        name: data[i].name,
                        value: data[i].quantity
                    })
                }

                myMap.setOption({
                    backgroundColor: '#FFFFFF',
                    title: {
                        text: '全国地图大数据',
                        subtext: '',
                        x:'center'
                    },
                    tooltip : {
                        trigger: 'item'
                    },

                    //左侧小导航图标
                    visualMap: {
                        show : true,
                        x: 'left',
                        y: 'center',
                        // color: ['#EF0154','#EACCD2']
                        splitList: [
                            {start: 50000, end: 6000000},{start: 40000, end: 50000},
                            {start: 30000, end: 40000},{start: 20000, end: 30000},
                            {start: 10000, end: 20000},{start: 0, end: 10000},
                        ],
                        color: ['#EF0154', '#F5357E', '#F5578A','#F386A1', '#FFB4C0', '#EACCD2']
                    },

                    //配置属性
                    series: [{
                        name: '数据',
                        type: 'map',
                        mapType: 'china',
                        roam: true,
                        label: {
                            normal: {
                                show: true  //省份名称
                            },
                            emphasis: {
                                show: false
                            }
                        },
                        data:areaData  //数据
                    }]
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
