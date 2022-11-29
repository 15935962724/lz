<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.*" %>
<%@ page import="util.Config" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="util.DateUtil" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="tea.entity.yl.shop.ShopOrder" %>
<%@ page import="tea.entity.yl.shop.ShopOrderData" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.ShopOrderDispatch" %>
<%@ page import="java.util.*" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int profile = h.getInt("profile");
    int s1 = h.getInt("year",0);
    int begin = h.getInt("begin");
    int menuid = h.getInt("id");
    int type = h.getInt("type");
    JSONObject jo1 = new JSONObject();
    JSONObject jo2 = new JSONObject();
    JSONObject jo3 = new JSONObject();//銷量
    JSONObject jo4 = new JSONObject();//名称
    JSONObject jo5 = new JSONObject();//颜色



%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/yl/top.js"></script>
<script type="text/javascript" src="/tea/yl/tj/js/highcharts.js"></script>
<script type="text/javascript" src="/tea/yl/tj/js/exporting.js"></script>
<script type="text/javascript" src="/tea/yl/tj/js/export-data.js"></script>
</head>
<body>
<h1>服务商统计图表</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" id="form1" action="?">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id" value="<%=menuid%>"/>
    <input type="hidden" name="begin" value="1">
    <table id="tablecenter" cellspacing="0">
        <tr>
            <%if(type==2){%>
            <td>所属年份:</td>
            <td><select name="year">
                <%
                    for (int i = 2015; i < 2099; i++) {%>
                <option value="<%=i%>" <%=s1==i?"selected":""%>><%=i%>
                </option>
                <%}%>
            </select></td>
                <%}%>
            <td>
                选择服务商
            </td>
            <td>
                <input type="hidden" name="profile" value="<%=MT.f(h.get("profile"))%>"/><input type="text" alt="会员"
                                                                                                name="memberN" readonly
                                                                                                value="<%=MT.f(h.get("memberN"))%>"/>
                <button type="button" class="btn btn-primary btn-xs" onclick="showprofilesearch()">选择服务商</button>
            </td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td colspan="8" align="center">
                <button class="btn btn-primary" type="button" onclick="jump()">搜索</button>
            </td>
        </tr>
    </table>
    <br>
</form>
<%
    ArrayList<String> list_heng = new ArrayList<String>();//横坐标
    ArrayList<Integer> list_shu = new ArrayList<Integer>();//每一个柱状的数据

    if (begin == 1) {

        if (type == 1) {//按年展示服务商销量    横坐标为15年-当前年份
            int yyyy = Integer.parseInt(DateUtil.getStringFromDate(new Date(), "yyyy"));//当前年份
            for (int i = 2015; i <= yyyy; i++) {
                int num = 0;
                list_heng.add(i + "年");
                //当前 i 年 profile 用户下单的总量  从shoporderdata 取 q
                ArrayList<ShopOrderData> shopOrderData = ShopOrderData.find(" AND order_id in(select order_id from shoporder where member=" + profile + " AND year(createdate)=" + i + ")", 0, Integer.MAX_VALUE);
                for (int j = 0; j < shopOrderData.size(); j++) {
                    ShopOrderData sod = shopOrderData.get(j);
                    String orderId = sod.getOrderId();
                    num += sod.getQuantity();
                }
                list_shu.add(num);
            }

        } else {//获取选择的年   横坐标为1-12月销量
            String s = h.get("year");//年
            for (int i = 1; i < 13; i++) {
                int num = 0;
                list_heng.add(i + "月");
                //当前选中的 s 年  i 月 销量
                ArrayList<ShopOrderData> shopOrderData = ShopOrderData.find(" AND order_id in(select order_id from shoporder where member=" + profile + " AND year(createdate)=" + s + " AND month(createdate)=" + i + ")", 0, Integer.MAX_VALUE);
                for (int j = 0; j < shopOrderData.size(); j++) {
                    ShopOrderData sod = shopOrderData.get(j);
                    num += sod.getQuantity();
                }
                list_shu.add(num);
            }

        }


    }
    jo1.put("categories", list_heng);
    jo2.put("categories", list_shu);


%>
<div <%=begin == 1 ? "" : "hidden"%> id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
<%
    ArrayList<String>hosListName = new ArrayList<String>();
    ArrayList<Integer>hosListNum = new ArrayList<Integer>();
    ArrayList<String>hosListColor = new ArrayList<String>();
    if(begin==1&&type!=1){
    Profile p = Profile.find(profile);
    String[] split = p.hospitals.split("[|]");
    ArrayList<ShopOrderData> shopOrderData = ShopOrderData.find(" AND order_id in(select order_id from shoporder where member=" + profile + " AND year(createdate)=" + s1 + ")", 0, Integer.MAX_VALUE);
    for (int i = 0; i <split.length ; i++) {
        if(split[i].length()>1) {
            int hospital_id = Integer.parseInt(split[i]);
            ShopHospital hospital = ShopHospital.find(hospital_id);
            int num = 0;
            for (int j = 0; j < shopOrderData.size(); j++) {
                ShopOrderData sod = shopOrderData.get(j);
                String orderId = sod.getOrderId();
                ShopOrderDispatch byOrderId = ShopOrderDispatch.findByOrderId(orderId);
                if(hospital_id==byOrderId.getA_hospital_id()){
                    num += sod.getQuantity();
                }
            }
            hosListName.add(hospital.getName());
            hosListNum.add(num);
        }
    }
        int size = hosListName.size();
        for (int i = 0; i <size ; i++) {
            String r,g,b;
            Random random = new Random();
            r = Integer.toHexString(random.nextInt(256)).toUpperCase();
            g = Integer.toHexString(random.nextInt(256)).toUpperCase();
            b = Integer.toHexString(random.nextInt(256)).toUpperCase();
            r = r.length()==1 ? "0" + r : r ;
            g = g.length()==1 ? "0" + g : g ;
            b = b.length()==1 ? "0" + b : b ;
            String color = "#"+r+g+b;
            hosListColor.add(color);
        }

        jo3.put("categories",hosListNum);
        jo4.put("categories",hosListName);
        jo5.put("categories",hosListColor);
%>
<h3><%=s1%>年<%=p.member%>服务商各医院订单销量</h3>
<div id="simple-pie" class="apex-charts"></div>
<%}%>
<script>

    function jump() {
        var pro = form1.profile.value;
        var proName = form1.memberN.value;
        if (proName.length == 0) {
            mt.show("请选择服务商");
        } else {
            form1.submit();
        }

    }

    function showprofilesearch() {
        mt.show("/jsp/yl/shop/FuWuShangSearch.jsp", 2, "查询签收人", 900, 500);
    }

    mt.receive = function (h, n) {
        form1.profile.value = h;
        form1.memberN.value = n;
    };
    var json1 = '<%=jo1.toString()%>';
    var json2 = '<%=jo2.toString()%>';
    if(json1.length>1) {
        json1 = json1.substring(14, json1.length - 1);
        json2 = json2.substring(14, json2.length - 1);
        var json11 = json1.replace(/"/g, "'");
        var json12 = json2.replace(/"/g, "'");
        json11 = eval("(" + json11 + ")");
        json12 = eval("(" + json12 + ")");
        console.log(json12);
        Highcharts.chart('container', {
            chart: {
                type: 'column'
            },
            title: {
                text: '中国同辐近距离一站式粒子平台'
            },
            subtitle: {
                text: 'Source: www.brachysolution.com'
            },
            xAxis: {
                categories: json11,
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: {
                    text: '销量(粒)'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} 粒</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                name: '销量展示',
                data: json12

            }]
        });
    }


</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.6.12/apexcharts.min.js"></script>
<script>
    var json3 = '<%=jo3.toString()%>';
    var json4 = '<%=jo4.toString()%>';
    var json5 = '<%=jo5.toString()%>';
    if(json3.length>1) {
        json3 = json3.substring(14, json3.length - 1);
        var json13 = json3.replace(/"/g, "'");
        json13 = eval("(" + json13 + ")");
        json4 = json4.substring(14, json4.length - 1);
        var json14 = json4.replace(/"/g, "'");
        json14 = eval("(" + json14 + ")");
        json5 = json5.substring(14, json5.length - 1);
        var json15 = json5.replace(/"/g, "'");
        json15 = eval("(" + json15 + ")");
        console.log(json13);
        var options = {
            chart: {height: 350, type: "pie"},
            series: json13 ,
            labels: json14 ,
            colors: json15 ,
            legend: {
                show: !0,
                position: "bottom",
                horizontalAlign: "center",
                verticalAlign: "middle",
                floating: !1,
                fontSize: "16px",
                offsetX: 0,
                offsetY: -10
            },
            responsive: [{breakpoint: 600, options: {chart: {height: 240}, legend: {show: !1}}}]
        };
        (chart = new ApexCharts(document.querySelector("#simple-pie"), options)).render();

        function appendData() {
            var e = chart.w.globals.series.map(function () {
                return Math.floor(100 * Math.random()) + 1
            });
            return e.push(Math.floor(100 * Math.random()) + 1), e
        }

        function removeData() {
            var e = chart.w.globals.series.map(function () {
                return Math.floor(100 * Math.random()) + 1
            });
            return e.pop(), e
        }

        function randomize() {
            return chart.w.globals.series.map(function () {
                return Math.floor(100 * Math.random()) + 1
            })
        }

        function reset() {
            return options.series
        }

        (chart = new ApexCharts(document.querySelector("#update-donut"), options)).render(), document.querySelector("#randomize").addEventListener("click", function () {
            chart.updateSeries(randomize())
        }), document.querySelector("#add").addEventListener("click", function () {
            chart.updateSeries(appendData())
        }), document.querySelector("#remove").addEventListener("click", function () {
            chart.updateSeries(removeData())
        }), document.querySelector("#reset").addEventListener("click", function () {
            chart.updateSeries(reset())
        });
    }
</script>
</body>
</html>
