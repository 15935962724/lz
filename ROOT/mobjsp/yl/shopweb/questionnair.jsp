<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.entity.member.Profile" %>
<%
    //君安收货人问卷调查     唐海瑛
    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int profile_id = h.member;
    Profile profile = Profile.find(profile_id);
    //根据收货人的名字查询
    Date date = new Date();
    int month = date.getMonth();
    int year = Integer.parseInt(MT.f(date).substring(0, 4));//年
    int beginmonth = 0;//开始月
    int endmonth = 0;//结束月
    if (month >= 0 && month <= 2) {//第一季度
        beginmonth = 1;
        endmonth = 3;
    } else if (month >= 3 && month <= 5) {//第二季度
        beginmonth = 4;
        endmonth = 6;
    } else if (month >= 6 && month <= 8) {//第三季度
        beginmonth = 7;
        endmonth = 9;
    } else if (month >= 9 && month <= 11) {//第四季度
        beginmonth = 10;
        endmonth = 12;
    }
    System.out.println("sql=== AND order_id in (select order_id from shoporder where status=4 AND year(createDate)=" + year + " AND Month(createDate)>=" + beginmonth + " AND Month(createDate)<=" + endmonth + ") AND a_consignees=" + Database.cite(profile.member));
    ArrayList<ShopOrderDispatch> shopOrderDispatches = ShopOrderDispatch.find(" AND order_id in (select order_id from shoporder where status=4 AND year(createDate)=" + year + " AND Month(createDate)>=" + beginmonth + " AND Month(createDate)<=" + endmonth + ") AND a_consignees=" + Database.cite(profile.member), 0, Integer.MAX_VALUE);

%>
<html>
<head>
    <meta charset="UTF-8">
    <title>问卷调查</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src='/tea/yl/mtDiag.js' type="text/javascript"></script>
    <script src="/tea/jquery-1.3.1.min.js"></script>
    <style>
        input {
            border: 1px solid #ccc;
            padding: 7px 0px;
            border-radius: 3px; /*css3属性IE不支持*/
            padding-left: 5px;
        }
        .per-add {
            width: 180px;
            height: 40px;
            line-height: 40px;
            margin: 10px auto;
            background: #227ed4;
            color: #fff;
            border: none;
            border-radius: 2px;
            display: block;
        }
        .bor-b {
            border-bottom: 1px solid #e8e8e8;
        }
    </style>
</head>
<body>
<div class="body">


    <div class="Content">
        <form name="form2" id="form2" action="/Questions.do" method="get" target="_ajax" onsubmit="return mysupmit()">
            <input type="hidden" name="act" value="add">
            <input type="hidden" name="nexturl" value="https://www.brachysolution.com/">
            <p align="left"><span style="font-size: 20px">各医院单位用药科室：</span></p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;为响应国家相关部门的原始信息收集，2020年度第三季度的用药信息调查已开始,请大家在用药过程中填写《用药信息调查记录》，就我公司提供的碘[1251]密封籽源或氯化[89Sr]注射液二个药品,根据患者使用后的情况如实填写。感谢配合!</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;宁波君安药业科技有限公司</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;浙江省宁波市鄞州区扬帆路999弄研发园B区4号楼9层9-4-5</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联系人:姚林春 13958308013</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;附:<%="<"%>用药信息调查记录>表</p>
            <p align="right">宁波君安药业科技有限公司</p>
            <p align="right">2020/9/21</p>
            <p align="center"><span style="font-size: 25px">用药信息调查记录</span></p>
            <br>
            <p align="right"  class="bor-b"><span style="font-size: 5px">文件编号:RSMP-ADR-003-01&nbsp;&nbsp;版本号:01</span></p>
            <br>
            <%-- <div class="Content">
                 <div class="person-con4">--%>
            <p  class="bor-b">
                <span>调查日期</span>
                <input type="text" value="<%=MT.f(new Date(),2)%>" disabled="disabled"/>
            </p>
            <p  class="bor-b">
                <span>产品名称</span>
                <input type="text" value="碘[125I]密封籽源" disabled="disabled"/>
            </p>
            <p  class="bor-b">
                <span>批号</span>
                <select name="pihao">
                    <option value="0">--请选择--</option>
                    <%
                        for (int i = 0; i < shopOrderDispatches.size(); i++) {
                            ShopOrderDispatch sod = shopOrderDispatches.get(i);
                    %>
                    <option value="<%=sod.getOrder_id()%>"><%=sod.getOrder_id()%>
                    </option>
                    <%}%>
                </select>
            </p>
            <p  class="bor-b">
                <span>订单时间：</span>
                <span>
                        <input name="time0" value="" onclick="mt.date(this)"/>
                        <span style="">~</span>
                        <input name="time1" value="" onclick="mt.date(this)"/>
                    </span>
            </p >
            <p  class="bor-b">
                <span>客户性别</span>
                <input type="radio" value="1" name="gender">男
                <input type="radio" value="2" name="gender">女
            </p>
            <p  class="bor-b">
                <span>年龄</span>
                <input type="text" value="" name="nl">
            </p>
            <p  class="bor-b">
                <span>原患疾病</span>
                <input type="text" value="" name="yhjb">
            </p>
            <p  class="bor-b">
                <span>既往史</span>
                <input type="radio" value="1" name="jws">吸烟史、饮酒史
                <input type="radio" value="2" name="jws">妊娠期、肝病史、肾病史、过敏史
            </p>
            <p  class="bor-b">
                <span>用药原因</span>
                <input type="text" value="" name="yyyy">
            </p>
            <p  class="bor-b">
                <span>药品来源</span>
                <input type="radio" value="1" name="yply">宁波君安药业科技有限公司
                <input type="radio" value="2" name="yply">其他
            </p>
            <p  class="bor-b">
                <span>用量</span>
                碘[125I]密封籽源<input type="text" value="" onkeyup="value=value.replace(/^(0+)|[^\d]+/g,'')"
                                  name="num">粒
            </p>
            <p  class="bor-b">
                <span>联合用药情况</span>
                <input type="radio" value="1" name="lhyyqk" id="islhyyqk">有
                <input type="radio" value="2" name="lhyyqk" id="nolhyyqk">无
            </p>
            <p  class="bor-b" id="lhyyqk1" style="display: none">
                <span >
                <label>请输入联合用药情况</label>
                 <input type="text" name="lhyyqktext" id="lhyyqktext" value=""/>
                </span>
            </p>
            <p  class="bor-b">
                <span>碘[125I]密封籽源：客户使用本药品前后肿瘤是否缩小，生活质量是否改善。</span>
                <input type="radio" value="1" name="sfgs1">有
                <input type="radio" value="2" name="sfgs1">无
                <input type="radio" value="3" name="sfgs1">严重
            </p>
            <p  class="bor-b">
                <span>严重情况说明：（包括症状、体征、临床检验及处理情况）</span>
                <input type="text" value="" name="yzqksm">
            </p>
            <p  class="bor-b">
                <span>不良反应</span>
                <input type="radio" value="1" name="blfy" id="isblfy">有
                <input type="radio" value="2" name="blfy" id="noblfy">无
            </p>
            <p id="myAdmin" style="display: none"  class="bor-b">
                <span >
                <label>请输入不良反应</label>
                 <input type="text" name="blfytext" id="blfytext" value=""/>
                </span>
            </p>
            <p style="margin-top:15px;" >
                <button class="per-add" type="submit">提交问卷</button>
            </p>


        </form>
    </div>
</div>
<script>
    $('input:radio[name="blfy"]').change(function () {
        if ($("#isblfy").is(":checked")) {
            $("#myAdmin").show();
        }
        if ($("#noblfy").is(":checked")) {
            $("#myAdmin").hide();
            $("#blfytext").text('');
        }
    });
    $('input:radio[name="lhyyqk"]').change(function () {
        if ($("#islhyyqk").is(":checked")) {
            $("#lhyyqk1").show();
        }
        if ($("#nolhyyqk").is(":checked")) {
            $("#lhyyqk1").hide();
            $("#lhyyqktext").text('');
        }
    });

    function mysupmit() {
        var pihao = form2.pihao.value;
        var time0 = form2.time0.value;
        var time1 = form2.time1.value;
        var gender = form2.gender.value;
        var nl = form2.nl.value;
        var yhjb = form2.yhjb.value;
        var jws = form2.jws.value;
        var yyyy = form2.yyyy.value;
        var yply = form2.yply.value;
        var num2 = form2.num.value;
        var lhyyqk = form2.lhyyqk.value;
        var lhyyqktext = form2.lhyyqktext.value;
        var sfgs1 = form2.sfgs1.value;
        var yzqksm = form2.yzqksm.value;
        var blfy = form2.blfy.value;
        var blfytext = form2.blfytext.value;


        if (pihao == 0) {
            mt.show("请选择批号");

            return false;
        }
        if (time0.length == 0) {
            mt.show("请选择开始时间");

            return false;
        }
        if (time1.length == 0) {

            mt.show("请选择结束时间");
            return false;
        }
        if (gender.length == 0) {

            mt.show("请选择客户性别");
            return false;
        }
        if (nl.length == 0) {

            mt.show("请输入年龄");
            return false;
        }
        if (yhjb.length == 0) {

            mt.show("请输入原患疾病");
            return false;
        }
        if (jws.length == 0) {

            mt.show("请选择既往史");
            return false;
        }
        if (yyyy.length == 0) {

            mt.show("请输入用药原因");
            return false;
        }
        if (yply.length == 0) {

            mt.show("请选择药品来源");
            return false;
        }
        if (num2.length == 0) {

            mt.show("请输入用量");
            return false;
        }
        if (lhyyqk.length == 0) {

            mt.show("请选择有无联合用药情况");
            return false;
        } else if (lhyyqk == 1) {
            if (lhyyqktext.length == 0) {

                mt.show("请输入联合用药情况");
                return false;
            }
        }
        if (sfgs1.length == 0) {

            mt.show("请选择是否改善");
            return false;
        }
        if (blfy.length == 0) {

            mt.show("请选择有无不良反应");
            return false;
        } else if (blfy == 1) {
            if (blfytext.length == 0) {

                mt.show("请输入不良反应");
                return false;
            }
        }

        form2.submit();

    }

</script>
</body>
</html>