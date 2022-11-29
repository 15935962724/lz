<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.entity.member.Profile" %>
<%
    //高科医院满意度
    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int profile_id = h.member;
    Profile profile = Profile.find(profile_id);
    //根据用户查医院名称
    String hospital_id  =   MT.f(profile.hospital);

%>
<html>
<head>
    <meta charset="UTF-8">
    <title>高科医院满意度调查</title>
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
            <input type="hidden" name="act" value="addGkAgreed">
            <input type="hidden" name="hospital_id" value="<%=hospital_id%>">
            <p align="center"><span style="font-size: 20px">原子高科股份有限公司碘-125密封籽源</span></p>
            <p align="center"><span style="font-size: 20px">客户满意度调查表</span></p>
            <br>
            <p align="left" class="bor-b"><span style="font-size: 10px">说明：请在选择对应的评分，在备注一栏中列举评分为“一般”“不满意”的原因和事实。</span></p>

            <p class="bor-b">
                <span>科室</span>
                <input type="text" name="keshi"/>
            </p>
            <%
                for (int i = 0; i < Agreed.TIMU.length; i++) {%>

            <p class="bor-b">
                <span><%=i + 1%>.<%= Agreed.TIMU[i]%></span>
            </p>
            <p class="bor-b">
                <%
                    for (int j = 0; j < Agreed.DAAN.length; j++) {
                %>
                <input type="radio" value="<%=j+1%>" name="<%="myd"+(i+1)%>"
                       id="check<%=(i*Agreed.DAAN.length)+(j+1)%>"><%=Agreed.DAAN[j]%>
                <%
                    }

                %>
            </p>
            <p class="bor-b" id="mydbz<%=(i+1)%>" style="display: none">
                <span >
                <label>请输入原因</label>
                 <input type="text" id="mydbzstr<%=(i+1)%>" name="mydbz<%=(i+1)%>" value=""/>
                </span>
            </p>
            <%}%>

            <p class="bor-b">
                <span><%=Agreed.TIMU.length+2%>.新产品需求</span>
            </p>
            <p class="bor-b">
            <input type="radio" value="1" name="cpxq" id="cpxq1"/>有
            <input type="radio" value="2" name="cpxq" id="cpxq2"/>无
            </p>
            <p class="bor-b" id="cpxqsm" style="display: none">
                <span >
                <label>请输入对哪些产品有需求</label>
                 <input type="text"  name="cpxqsmstr" value="" id="cpxqsmstr"/>
                </span>
            </p>
            <p class="bor-b"><span>对本公司其他方面的意见或建议</span></p>
            <p>
                <span>
                 <input type="text"  name="idea" value="" />
                </span>
            </p>
            <p style="margin-top:15px;" >
                <button class="per-add" type="submit">提交问卷</button>
            <p>
        </form>
    </div>
</div>
<script>
    $('input:radio[name="myd1"]').change(function () {
        if ($("#check1").is(":checked")) {
            $("#mydbz1").hide();
            $("#mydbzstr1").text('');
        }
        if ($("#check2").is(":checked")) {
            $("#mydbz1").hide();
            $("#mydbzstr1").text('');
        }
        if ($("#check3").is(":checked")) {
            $("#mydbz1").show();
        }
        if ($("#check4").is(":checked")) {
            $("#mydbz1").show();
        }
    });

    $('input:radio[name="myd2"]').change(function () {
        if ($("#check5").is(":checked")) {
            $("#mydbz2").hide();
            $("#mydbzstr2").text('');
        }
        if ($("#check6").is(":checked")) {
            $("#mydbz2").hide();
            $("#mydbzstr2").text('');
        }
        if ($("#check7").is(":checked")) {
            $("#mydbz2").show();
        }
        if ($("#check8").is(":checked")) {
            $("#mydbz2").show();
        }
    });
    $('input:radio[name="myd3"]').change(function () {
        if ($("#check9").is(":checked")) {
            $("#mydbz3").hide();
            $("#mydbzstr3").text('');
        }
        if ($("#check10").is(":checked")) {
            $("#mydbz3").hide();
            $("#mydbzstr3").text('');
        }
        if ($("#check11").is(":checked")) {
            $("#mydbz3").show();
        }
        if ($("#check12").is(":checked")) {
            $("#mydbz3").show();
        }
    });
    $('input:radio[name="myd4"]').change(function () {
        if ($("#check13").is(":checked")) {
            $("#mydbz4").hide();
            $("#mydbzstr4").text('');
        }
        if ($("#check14").is(":checked")) {
            $("#mydbz4").hide();
            $("#mydbzstr4").text('');
        }
        if ($("#check15").is(":checked")) {
            $("#mydbz4").show();
        }
        if ($("#check16").is(":checked")) {
            $("#mydbz4").show();
        }
    });
    $('input:radio[name="myd5"]').change(function () {
        if ($("#check17").is(":checked")) {
            $("#mydbz5").hide();
            $("#mydbzstr5").text('');
        }
        if ($("#check18").is(":checked")) {
            $("#mydbz5").hide();
            $("#mydbzstr5").text('');
        }
        if ($("#check19").is(":checked")) {
            $("#mydbz5").show();
        }
        if ($("#check20").is(":checked")) {
            $("#mydbz5").show();
        }
    });
    $('input:radio[name="myd6"]').change(function () {
        if ($("#check21").is(":checked")) {
            $("#mydbz6").hide();
            $("#mydbzstr6").text('');
        }
        if ($("#check22").is(":checked")) {
            $("#mydbz6").hide();
            $("#mydbzstr6").text('');
        }
        if ($("#check23").is(":checked")) {
            $("#mydbz6").show();
        }
        if ($("#check24").is(":checked")) {
            $("#mydbz6").show();
        }
    });
    $('input:radio[name="myd7"]').change(function () {
        if ($("#check25").is(":checked")) {
            $("#mydbz7").hide();
            $("#mydbzstr7").text('');
        }
        if ($("#check26").is(":checked")) {
            $("#mydbz7").hide();
            $("#mydbzstr7").text('');
        }
        if ($("#check27").is(":checked")) {
            $("#mydbz7").show();
        }
        if ($("#check28").is(":checked")) {
            $("#mydbz7").show();
        }
    });
    $('input:radio[name="myd8"]').change(function () {
        if ($("#check29").is(":checked")) {
            $("#mydbz8").hide();
            $("#mydbzstr8").text('');
        }
        if ($("#check30").is(":checked")) {
            $("#mydbz8").hide();
            $("#mydbzstr8").text('');
        }
        if ($("#check31").is(":checked")) {
            $("#mydbz8").show();
        }
        if ($("#check32").is(":checked")) {
            $("#mydbz8").show();
        }
    });
    $('input:radio[name="myd9"]').change(function () {
        if ($("#check33").is(":checked")) {
            $("#mydbz9").hide();
            $("#mydbzstr9").text('');
        }
        if ($("#check34").is(":checked")) {
            $("#mydbz9").hide();
            $("#mydbzstr9").text('');
        }
        if ($("#check35").is(":checked")) {
            $("#mydbz9").show();
        }
        if ($("#check36").is(":checked")) {
            $("#mydbz9").show();
        }
    });
    $('input:radio[name="myd10"]').change(function () {
        if ($("#check37").is(":checked")) {
            $("#mydbz10").hide();
            $("#mydbzstr10").text('');
        }
        if ($("#check38").is(":checked")) {
            $("#mydbz10").hide();
            $("#mydbzstr10").text('');
        }
        if ($("#check39").is(":checked")) {
            $("#mydbz10").show();
        }
        if ($("#check40").is(":checked")) {
            $("#mydbz10").show();
        }
    });
    $('input:radio[name="myd11"]').change(function () {
        if ($("#check41").is(":checked")) {
            $("#mydbz11").hide();
            $("#mydbzstr11").text('');
        }
        if ($("#check42").is(":checked")) {
            $("#mydbz11").hide();
            $("#mydbzstr11").text('');
        }
        if ($("#check43").is(":checked")) {
            $("#mydbz11").show();
        }
        if ($("#check44").is(":checked")) {
            $("#mydbz11").show();
        }
    });
    $('input:radio[name="myd12"]').change(function () {
        if ($("#check45").is(":checked")) {
            $("#mydbz12").hide();
            $("#mydbzstr12").text('');
        }
        if ($("#check46").is(":checked")) {
            $("#mydbz12").hide();
            $("#mydbzstr12").text('');
        }
        if ($("#check47").is(":checked")) {
            $("#mydbz12").show();
        }
        if ($("#check48").is(":checked")) {
            $("#mydbz12").show();
        }
    });
    $('input:radio[name="myd13"]').change(function () {
        if ($("#check49").is(":checked")) {
            $("#mydbz13").hide();
            $("#mydbzstr13").text('');
        }
        if ($("#check50").is(":checked")) {
            $("#mydbz13").hide();
            $("#mydbzstr13").text('');
        }
        if ($("#check51").is(":checked")) {
            $("#mydbz13").show();
        }
        if ($("#check52").is(":checked")) {
            $("#mydbz13").show();
        }
    });
    $('input:radio[name="myd14"]').change(function () {
        if ($("#check53").is(":checked")) {
            $("#mydbz14").hide();
            $("#mydbzstr14").text('');
        }
        if ($("#check54").is(":checked")) {
            $("#mydbz14").hide();
            $("#mydbzstr14").text('');
        }
        if ($("#check55").is(":checked")) {
            $("#mydbz14").show();
        }
        if ($("#check56").is(":checked")) {
            $("#mydbz14").show();
        }
    });
    $('input:radio[name="myd15"]').change(function () {
        if ($("#check57").is(":checked")) {
            $("#mydbz15").hide();
            $("#mydbzstr15").text('');
        }
        if ($("#check58").is(":checked")) {
            $("#mydbz15").hide();
            $("#mydbzstr15").text('');
        }
        if ($("#check59").is(":checked")) {
            $("#mydbz15").show();
        }
        if ($("#check60").is(":checked")) {
            $("#mydbz15").show();
        }
    });
    $('input:radio[name="myd16"]').change(function () {
        if ($("#check61").is(":checked")) {
            $("#mydbz16").hide();
            $("#mydbzstr16").text('');
        }
        if ($("#check62").is(":checked")) {
            $("#mydbz16").hide();
            $("#mydbzstr16").text('');
        }
        if ($("#check63").is(":checked")) {
            $("#mydbz16").show();
        }
        if ($("#check64").is(":checked")) {
            $("#mydbz16").show();
        }
    });
    $('input:radio[name="myd17"]').change(function () {
        if ($("#check65").is(":checked")) {
            $("#mydbz17").hide();
            $("#mydbzstr17").text('');
        }
        if ($("#check66").is(":checked")) {
            $("#mydbz17").hide();
            $("#mydbzstr17").text('');
        }
        if ($("#check67").is(":checked")) {
            $("#mydbz17").show();
        }
        if ($("#check68").is(":checked")) {
            $("#mydbz17").show();
        }
    });
    $('input:radio[name="myd18"]').change(function () {
        if ($("#check69").is(":checked")) {
            $("#mydbz18").hide();
            $("#mydbzstr18").text('');
        }
        if ($("#check70").is(":checked")) {
            $("#mydbz18").hide();
            $("#mydbzstr18").text('');
        }
        if ($("#check71").is(":checked")) {
            $("#mydbz18").show();
        }
        if ($("#check72").is(":checked")) {
            $("#mydbz18").show();
        }
    });
    $('input:radio[name="myd19"]').change(function () {
        if ($("#check73").is(":checked")) {
            $("#mydbz19").hide();
            $("#mydbzstr19").text('');
        }
        if ($("#check74").is(":checked")) {
            $("#mydbz19").hide();
            $("#mydbzstr19").text('');
        }
        if ($("#check75").is(":checked")) {
            $("#mydbz19").show();
        }
        if ($("#check76").is(":checked")) {
            $("#mydbz19").show();
        }
    });
    $('input:radio[name="cpxq"]').change(function () {
        if ($("#cpxq2").is(":checked")) {
            $("#cpxqsm").hide();
            $("#cpxqsmstr").text('');
        }
        if ($("#cpxq1").is(":checked")) {
            $("#cpxqsm").show();
        }
    });

</script>
</body>
</html>