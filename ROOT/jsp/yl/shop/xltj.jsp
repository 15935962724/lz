<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.ShopOrderData" %>
<%@ page import="tea.DateUtil" %>
<%@ page import="java.util.*" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%
    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int puid = h.getInt("puid", -1);//类别
    StringBuffer sp = new StringBuffer();
    if(puid>=0){//选择了
        sp.append(" AND puid="+puid);
    }
    String year = h.get("year", util.DateUtil.getStringFromDate(new Date(), "yyyy"));//年
    String month = h.get("month",util.DateUtil.getStringFromDate(new Date(), "MM"));//月
    String arr = "7180,7182,7184,7186,7188,7190,7192,7194,7196,7198,7200,7202,7204,7206,7208,7210,7212,7214,7216,7218,7220,7222,7224,7226,7228,7230,7232,7234,7236,7238,7240,21508";
    String cityName = "北京,天津,河北,山西,内蒙古,辽宁,吉林,黑龙江,上海,江苏,浙江,安徽,福建,江西,山东,河南,湖北,湖南,广东,广西,海南,重庆,四川,贵州,云南,西藏,陕西,甘肃,青海,宁夏,新疆";
    String[] split1 = cityName.split(",");
    String[] split = arr.split(",");
    ArrayList<Integer>arrayList = new ArrayList<Integer>();
    int quantitySum = 0;
    for (int i = 0; i < split.length; i++) {
        int quantityMax = 0;
        int hos_area = Integer.parseInt(split[i]);// 哪个省 自治区  直辖市
        ArrayList<ShopOrderData> shopOrderData = new ArrayList<ShopOrderData>();
        if(Integer.parseInt(month)==0){//算全年的
            for (int j = 1; j <13 ; j++) {
                ArrayList<ShopOrderData>shopOrderData2= ShopOrderData.find(" AND order_id in(select order_id from shoporder where year(createdate)="+year+" AND month(createdate)="+j+sp.toString()+") AND order_id in( select order_id from ShopOrderDispatch where a_hospital_id in(select id from shopHospital  where area=" + hos_area + "))", 0, Integer.MAX_VALUE);
                for (int k = 0; k < shopOrderData2.size(); k++) {
                    shopOrderData.add(shopOrderData2.get(k));
                }
            }
        }else {
            shopOrderData= ShopOrderData.find(" AND order_id in(select order_id from shoporder where year(createdate)="+year+" AND month(createdate)="+month+sp.toString()+") AND order_id in( select order_id from ShopOrderDispatch where a_hospital_id in(select id from shopHospital  where area=" + hos_area + "))", 0, Integer.MAX_VALUE);
        }

        if (shopOrderData.size() > 0) {
            for (int j = 0; j < shopOrderData.size(); j++) {
                ShopOrderData sod = shopOrderData.get(j);
                int quantity = sod.getQuantity();
                quantityMax = quantityMax+quantity;
            }
        }
        arrayList.add(quantityMax);
        quantitySum+=quantityMax;
    }
    System.out.println("ok");
%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>中国同辐粒子销量统计</title>
    <link rel="stylesheet" href="/tea/yl/tj/css/bootstrap.css">
    <link rel="stylesheet" href="/tea/yl/tj/css/base.css">
    <link rel="stylesheet" href="/tea/yl/tj/css/style.css">

    <style>
        .t_btn {
            margin-top: 20px;
        }

        .t_btn li {
            display: inline-block;
            margin: 0 0px 20px 20px;
        }

        .t_btn button,
        .t_a {
            display: inline-block;
            padding: 10px 5px;
            width: 80px;
            border-style: solid;
            border-width: 0;
            cursor: pointer;
            font-family: inherit;
            font-weight: bold;
            line-height: normal;
            margin: 0 0 0.5em 0;
            position: relative;
            text-decoration: none;
            text-align: center;
            display: inline-block;
            font-size: 1em;
            background-color: #2C58A6;
            border-color: #0263ff;
            color: white;
            box-shadow: 0 -2px 0 rgba(0, 0, 0, 0.2) inset !important;
            margin-right: 0.5em;
            border-radius: 4px;
        }

        .t_height {
            line-height: 80px;
            position: absolute;
            right: 28px;
            top: 0;
        }
    </style>
</head>

<body onload="time()">

<div class="header">
    <div class="bg_header">
        <div class="header_nav fl t_title">
            <h1 class="gradient-title">中国同辐股份有限公司销量统计</h1>
        </div>
    </div>
    <div class="header_nav fl">
    </div>
    <div class="header_myself fr t_height">

    </div>
</div>
<div class="data_content">
    <div class="data_main">
        <div class="main_left fl" style="margin-top: -2px;">

            <div class="left_1 t_btn1" style="height: 452px;margin-top:20px;">

                <div class="group-profile shadow-box-bd">
                    <h3><span class="words" id="group-intro-name">中国同辐股份有限公司   <%=quantitySum%></span></h3>
                    <div class="tablebox ">
                        <table id="tableId" border="0" cellspacing="0" cellpadding="0">
                            <thead>
                            <tr>
                                <th>地区</th>
                                <th>销量</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%
                                for (int i = 0; i <split1.length ; i++) {%>
                            <tr>
                                <td>
                                    <a><%=split1[i]%></a>
                                </td>
                                <td>
                                    <span class="project-status-2"><%=arrayList.get(i)%></span>
                                </td>
                            </tr>
                            <%}%>

                            </tbody>
                        </table>

                    </div>
                </div>
            </div>


        </div>
        <div id="container" style="height: 80%"></div>
    </div>

</div>
<div style="text-align:center;">

</div>
</body>
<script src="/tea/yl/tj/js/jquery-1.7.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/map/js/china.js"></script>
<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=jdlTvGgd7XbePz88gGY5dgoE"></script>

<script>
    // 参数1 tableID,参数2 div高度，参数3 速度，参数4 tbody中tr几条以上滚动
    tableScroll('tableId', 360, 60, 4)
    var MyMarhq;

    function tableScroll(tableid, hei, speed, len) {
        clearTimeout(MyMarhq);
        $('#' + tableid).parent().find('.tableid_').remove()
        $('#' + tableid).parent().prepend(
            '<table class="tableid_"><thead>' + $('#' + tableid + ' thead').html() + '</thead></table>'
        ).css({
            'position': 'relative',
            'overflow': 'hidden',
            'height': hei + 'px'
        })
        $(".tableid_").find('th').each(function (i) {
            $(this).css('width', $('#' + tableid).find('th:eq(' + i + ')').width());
        });
        $(".tableid_").css({
            'position': 'absolute',
            'top': 0,
            'left': 0,
            'z-index': 9
        })
        $('#' + tableid).css({
            'position': 'absolute',
            'top': 0,
            'left': 0,
            'z-index': 1
        })

        if ($('#' + tableid).find('tbody tr').length > len) {
            $('#' + tableid).find('tbody').html($('#' + tableid).find('tbody').html() + $('#' + tableid).find('tbody').html());
            $(".tableid_").css('top', 0);
            $('#' + tableid).css('top', 0);
            var tblTop = 0;
            var outerHeight = $('#' + tableid).find('tbody').find("tr").outerHeight();

            function Marqueehq() {
                if (tblTop <= -outerHeight * $('#' + tableid).find('tbody').find("tr").length) {
                    tblTop = 0;
                } else {
                    tblTop -= 1;
                }
                $('#' + tableid).css('margin-top', tblTop + 'px');
                clearTimeout(MyMarhq);
                MyMarhq = setTimeout(function () {
                    Marqueehq()
                }, speed);
            }

            MyMarhq = setTimeout(Marqueehq, speed);
            $('#' + tableid).find('tbody').hover(function () {
                clearTimeout(MyMarhq);
            }, function () {
                clearTimeout(MyMarhq);
                if ($('#' + tableid).find('tbody tr').length > len) {
                    MyMarhq = setTimeout(Marqueehq, speed);
                }
            })
        }

    }

    var dom = document.getElementById("container");
    var myChart = echarts.init(dom);
    var app = {};
    option = null;
    option = {
        title: {
            text: '',
            subtext: '',
            left: 'center'
        },
        tooltip: {
            trigger: 'item'
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['iphone']
        },
        visualMap: {
            min: 0,
            max: 2500,
            left: 'left',
            top: 'bottom',
            text: ['高', '低'],           // 文本，默认为数值文本
            calculable: true
        },
        toolbox: {
            show: true,
            orient: 'vertical',
            left: 'right',
            top: 'center',
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        series: [
            {
                name: '粒子销量',
                type: 'map',
                mapType: 'china',
                roam: false,
                label: {
                    normal: {
                        show: false
                    },
                    emphasis: {
                        show: true
                    }
                },
                data: [
                    {name: '北京', value: <%=arrayList.get(0)%>},
                    {name: '天津', value: <%=arrayList.get(1)%>},
                    {name: '河北', value: <%=arrayList.get(2)%>},
                    {name: '山西', value: <%=arrayList.get(3)%>},
                    {name: '内蒙古', value: <%=arrayList.get(4)%>},
                    {name: '辽宁', value: <%=arrayList.get(5)%>},
                    {name: '吉林', value: <%=arrayList.get(6)%>},
                    {name: '黑龙江', value: <%=arrayList.get(7)%>},
                    {name: '上海', value: <%=arrayList.get(8)%>},
                    {name: '江苏', value: <%=arrayList.get(9)%>},
                    {name: '浙江', value: <%=arrayList.get(10)%>},
                    {name: '安徽', value: <%=arrayList.get(11)%>},
                    {name: '福建', value: <%=arrayList.get(12)%>},
                    {name: '江西', value: <%=arrayList.get(13)%>},
                    {name: '山东', value: <%=arrayList.get(14)%>},
                    {name: '河南', value: <%=arrayList.get(15)%>},
                    {name: '湖北', value: <%=arrayList.get(16)%>},
                    {name: '湖南', value: <%=arrayList.get(17)%>},
                    {name: '广东', value: <%=arrayList.get(18)%>},
                    {name: '广西', value: <%=arrayList.get(19)%>},
                    {name: '海南', value: <%=arrayList.get(20)%>},
                    {name: '重庆', value: <%=arrayList.get(21)%>},
                    {name: '四川', value: <%=arrayList.get(22)%>},
                    {name: '贵州', value: <%=arrayList.get(23)%>},
                    {name: '云南', value: <%=arrayList.get(24)%>},
                    {name: '西藏', value: <%=arrayList.get(25)%>},
                    {name: '陕西', value: <%=arrayList.get(26)%>},
                    {name: '甘肃', value: <%=arrayList.get(27)%>},
                    {name: '青海', value: <%=arrayList.get(28)%>},
                    {name: '宁夏', value: <%=arrayList.get(29)%>},
                    {name: '新疆', value: <%=arrayList.get(30)%>}
                ]
            }
        ]
    };
    if (option && typeof option === "object") {
        myChart.setOption(option, true);
    }
</script>

</html>