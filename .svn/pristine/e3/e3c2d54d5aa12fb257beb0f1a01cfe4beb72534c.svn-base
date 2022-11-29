<%@page import="util.Config" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%

    Http h = new Http(request, response);
    if(h.member<1){
        String param = request.getQueryString();
        String url = request.getRequestURI();
        if(param != null)
            url = url + "?" + param;
        response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
        return;
    }

    int member = h.member;
    Profile profile = Profile.find(h.member);


//发票信息
    ShopNvoice sn = ShopNvoice.getObjByMember(member);

    ShopQualification sqq = ShopQualification.findByMember(member);

    String token = System.currentTimeMillis() + new Random().nextInt() + "";
    request.getSession().setAttribute("token", token);

    String tpsbz = h.get("tpsbz");
    String sbbz = h.get("sbbz");


    int carSum = 0;
    String[] ps = h.getCook("cart", "|").split("[|]");

    int istps = 0;
    if (ps.length > 0) {
        for (int i = 1; i < ps.length; i++) {
            String[] arr = ps[i].split("&");

            int product_id = Integer.parseInt(arr[0]);
            ShopProduct sp1 = ShopProduct.find(product_id);
            ShopCategory sc1 = ShopCategory.find(sp1.category);

            if (sc1.path.indexOf(Config.getString("tps")) != -1) {//tps
                int checkFlag = Integer.parseInt(arr[2]);
                if (checkFlag != 0) {
                    istps = 1;
                }
                ;
            }

            int quantity = Integer.parseInt(arr[1]);//数量
            carSum += quantity;
        }
    }

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=0">
    <title>订单确认</title>
    <%--    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">--%>
    <script src="/mobjsp/yl/js/swiper.min.js"></script>
    <link rel="stylesheet" href="/mobjsp/yl/css/common.css">
    <link rel="stylesheet" href="/mobjsp/yl/css/swiper.min.css">

    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src='/tea/city.js' type="text/javascript"></script>
    <script src="/tea/jquery-1.11.1.min.js"></script>
    <script src="/tea/yl/top.js"></script>
    <script src="/tea/view.js" type="text/javascript"></script>
    <style>
    .detail01{
    border-bottom:0.02rem solid #dcdcdc;
    }
    .detail01 .pic{
    height:1.8rem;
    width:2.25rem;
    }
    .detail01 .nr{
    justify-content: center;
    align-items: left;
    }
    .detail01 .nr span{
    margin:0 !important;
    line-height:160% !important;
    }
    input, input[type=button], input[type=text], input[type=password], input[type=checkbox], input[type=submit], input[type=file], button {
    cursor: pointer;
    -webkit-appearance: none;
    }
    .tit input[type=radio],.fp-p input[type=radio]{
    -webkit-appearance: none;
    background:none;
    border:none;
    opacity: 0;
    position:absolute;
    }
    .tps-ad-xg{
    display:none;
    position:fixed;
    height:100%;
    width:100%;
    top:0;
    background:#eef4fb;
    z-index:10;
    }
    .fp-box{
    display:none;
    position:fixed;
    height:100%;
    width:100%;
    top:0;
    background:#eef4fb;
    z-index:10;
    }
    .person-con4 {
    background: #fff;
    width: 100%;
    padding: 0px 4%;
    overflow: hidden;

    }
    .person-con5 {
    background: #fff;
    width: 100%;
    padding: 0px 4%;
    overflow: hidden;

    }
    .per-add-line1{
    width: 100%;
    overflow: hidden;
    padding:10px 0;
    position:relative;
    border-bottom:1px solid #e8e8e8;
    }
    .per-add-xm {
    line-height: 200%;
    font-size:0.3rem;
    }
    .per-add-w {
    width: 85%;
    color: #666666;
    line-height: 150%;
    float:left;

    }
    .per-add-bj {
    width: 12%;
    text-align: right;
    color: #999999;
    float:right;
    border-left: 1px solid #e8e8e8;
    font-size:0.28rem;

    }
    .inp-ad{
    cursor: pointer;
    position: absolute;
    border:none;
    top: 12px;
    left: -1px;
    width: 17px;
    height: 17px;
    -webkit-appearance: none;
    z-index: 9;
    background: url(/tea/mobhtml/img/icon14.png) center no-repeat;
    background-size: 17px 17px;
    }
    .inp-ad:checked {
    background: url(/tea/mobhtml/img/icon15.png) center no-repeat;
    background-size: 17px 17px;
    opacity: 1;
    }
    .ad-xm{
    margin-left:30px;
    }
    .mr{
    background:#FDF1EC;
    color:#E2490A;
    display:inline-block;
    padding:3px;
    font-style:normal;
    }
    .ad-box-bj{
    display:none;
    position:fixed;
    height:100%;
    width:100%;
    top:0;
    background:#eef4fb;
    z-index:10;
    }
    .per-con3-a {
    width: 100%;
    height: 46px;
    line-height: 46px;
    display: flex;
    border-bottom: 1px solid #e8e8e8;
    font-size:0.3rem;
    }
    .con3-span {
    text-align: right;
    margin-right: 15px;
    width:18.5%;
    font-size:0.28rem;
    }
    .per-add-inp {
    border: none;
    height: 45px;
    line-height: 45px;
    font-size:0.3rem;
    flex:2;

    }
    .per-add-save,.per-add-save2 {
    width: 180px;
    height: 40px;
    line-height: 40px;
    margin: 10px auto;
    background: #044694;
    color: #fff;
    border: none;
    border-radius: 2px;
    display: block;
    font-size:0.3rem;
    }
    .tps-fp{
    float:right;
    background:url(/tea/mobhtml/img/icon9.png) 71px 1px no-repeat;
    background-size:auto 18px;
    padding-right:25px;
    height:25px;
    font-size:0.28rem;
    width: 87px;
    text-align: right;
    }
    .tps-fpw{
    float:left;
    font-size:0.28rem;

    }
    .person-con4 .per-con3-a2，.person-con5 .per-con3-a2{
    border:none;
    }
    .fp-inp{
    border:1px solid #044694;
    color:#044694;
    padding: 0 15px;
    height: 33px;
    line-height: 33px;
    float:left;
    margin-right:0.5rem;
    background:#fff;
    border-radius:2px;
    }
    .fp-p{
    overflow:hidden;
    background:#fff;
    padding:15px 4%;
    border-bottom:1px solid #e8e8e8;
    }
    .per-con3-a select{
        height:30px;
    margin-top:8px;
    }
    textarea,input[type=button], input[type=submit], input[type=text],input[type=file], button {
    cursor: pointer; -webkit-appearance: none;border-radius:0;}
    @media screen and (max-width: 321px)  {
    .tps-fp{padding-right:30px;}
    .person-con5 select{
        width: 23%;
        height: 30px;
        margin-top: 8px;
    }
    }
    .fp-p .act{
    background:#044694;
    color:#fff;
    }
    .detail04 input{
        margin:0;
    }
    .detail04{
        height:auto;
    }
    .person-con5 select{
        width: 25%;
        height: 30px;
        margin-top: 8px;
    }
   .tps-ad-xg .btn {
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: normal;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
    height:auto;
    }
    .tps-ad-xg .fh-zhuym{
        color: #333 !important;
        background-color: #fff !important;
        border: 1px solid #ccc !important;
        font-weight: 400 !important;
    }
    .tps-ad-xg .per-add{
        color: #044694 !important;
        background-color: #fff !important;
        border: 1px solid #044694 !important;
        font-weight: 400 !important;
    }
    .person-con4-1 {
    background: #fff;
    width: 100%;
    padding: 0px 4%;
    overflow: hidden;
    }

    </style>
</head>
<body>
<div id="Body">
    <!-- <div id="Header">
        <header class="flex">
            <div class="logo"><img src="http://www.brachysolution.com/res/Home/structure/14112579.png" /></div>
            <div class="head-r flex">
                <div class="search"></div>
                <nav>
                    <em></em>
                </nav>
            </div>
        </header>
    </div> -->

    <form id="form0" name="form0">
    <div class="address flex" id="tab1">

        <%
            List<Consignee> list = Consignee.find("AND member=" + h.member + "order by xuanzhong desc", 0, Integer.MAX_VALUE);
            int i = 1;
            for (Consignee c : list) {

        %>
        <p class="tit"><input  name="address_ok" type="radio" checked value="<%= c.getId()%>" />
            <%
                if (i == 1) {%>
     <a class='che-ad' onclick="xg_shr()">修改收货人</a>
<%}%>

            <span style='display:block'><%=MT.f(c.getName())%>&nbsp;&nbsp;<%= MT.f(c.getMobile()) %></span>
               <%
                   String a = c.getCity() + "";
                   String b = a.substring(0, 2);
                   int pro = Integer.valueOf(b);
                   int src = Integer.valueOf(a);
               %>
            <span style='display:block;margin-top:5px;color:#666;'>
                    <script>
                        var a = getProvince("<%=pro%>");
                        var b = getSrcity2('<%=pro%>', '<%=src%>');
                        document.write(a);
                        document.write(b);
                    </script>
               <%=c.getAddress()%>
</span>
            </p>
        <%
                i++;
                break;
            }
            if (list.size() == 0) {%>
        <span class="tit">

     <a class='che-ad' onclick="xg_shr()">修改收货人</a>
         <%}%>
    </div>
    <div class='tps-ad-xg'>
        <div class="person-con4">
            <%
                list = Consignee.find("AND member=" + h.member + "order by xuanzhong desc", 0, Integer.MAX_VALUE);

                if(list.size()==0){
                    %>
            <input type="hidden"  value="" class='inp-ad'>
            <%
                }else{

                for (int j = 0; j < list.size(); j++) {
                    Consignee c = list.get(j);
                    {%>
            <div class="per-add-line1 bor-b">
                <p class="ft16 per-add-xm">
                    <%if (j == 0) {%>
                    <input type='radio' value="<%= c.getId()%>" class='inp-ad'>
                    <%}%>
                    <span class='ad-xm'><%=MT.f(c.getName())%></span>
                    <span><%=c.getMobile()%></span>
                </p>
                <p class="fl-left ft14 per-add-w">
                    <%if (c.getIsmoren() == 1) {%><em class="ft12 mr">默认</em><%} else {%>

                    <%}%>
                    <%=MT.f(c.getAddress())%>
                </p>
                <%if (c.getXuanzhong() == 0) {%>
                <a href="#" onclick="bianji('<%=c.getId()%>')" class="fl-right ft16 per-xuanze-bj bor-l">选择</a>
                <%}%>
                <a href="#" onclick="bianji('<%=c.getId()%>')" class="fl-right ft16 per-add-bj bor-l">编辑</a>
            </div>
            <%
                    }
                }

                }
            %>
        </div>
        <p style="margin-top:20px;text-align:center;">

            <input type="button" value="返回" class="fh-zhuym btn">
            <input type="button" value="新增" class="per-add btn" style='margin-right:10px'>


    </p>
    </div>
        <div class='ad-box-bj'>
            <div class='person-con4-1'>
                <p class="per-con3-a bor-b">
                    <span class="fl-left ft16 fcol-666 con3-span">收货人</span>
                    <input type="text" name="name" value="" class="per-add-inp ft16">
                </p>
                <p class="per-con3-a bor-b">
                    <span class="fl-left ft16 fcol-666 con3-span">手机号码</span>
                    <input type="text" name="mobile" value="" class="per-add-inp ft16">
                </p>
                <p class="per-con3-a bor-b">
                    <span class="fl-left ft16 fcol-666 con3-span">所在地区</span>
                    <script>mt.city("city0", "city1", "", '');</script>

                </p>
                <p class="per-con3-a">
                    <span class="fl-left ft16 fcol-666 con3-span">详细地址</span>
                    <input type="text" name="address" value="" class="per-add-inp ft16">
                </p>
                <p class="per-con3-a">
                    <span class="fl-left ft16 fcol-666 con3-span">邮箱</span>
                    <input type="text" name="mail" value="" class="per-add-inp ft16">
                </p>
                <p class="per-con3-a">
                    <span class="fl-left ft16 fcol-666 con3-span">邮编</span>
                    <input type="text" name="youbian" value="" class="per-add-inp ft16">
                </p>

            </div>
                <p style="margin-top:20px;">
                <input type="button" value="返回" class="per-add-save2 ft16">
                </p>
                <p style="margin-top:20px;">
                <input type="button" value="保存并选中" onclick="update_address()" class="per-add-save ft16">
                </p>
        </div>
    </form>
    <script>

        $('.fh-zhuym').click(function () {
            $('.tps-ad-xg').hide();
            $('.address flex').show();
        })
<%--        地址列表返回按钮--%>
        $('.che-ad').click(function () {
            $('.tps-ad-xg').show();
        })
<%--        修改收货人--%>
        function initshow() {
            $('.che-ad').click(function () {
                $('.tps-ad-xg').show();
            })
        }

        $('.per-xuanze-bj').click(function () {
            $('.tps-ad-xg').hide();
            $('.address flex').show();
        })

        function initzhnashi() {
            $('.per-add-bj').click(function () {
                $('.ad-box-bj').show();
                $('.tps-ad-xg').hide();
            })
        }

        $('.per-add').click(function () {
            $('.tps-ad-xg').hide();
            $('.ad-box-bj').show();

            var citystr = "";

            citystr += $("select[name='city0']")[0].outerHTML;
            citystr += $("select[name='city1']")[0].outerHTML;
            var tamp =
                '<input type=\"hidden\" name=\"id\" value=\"\" class=\"per-add-inp ft16\">' +
                //'<div class=\"ad-box-bj \">' +
                '<div >' +
                '<div class=\"person-con4\">' +
                '<p class=\"per-con3-a bor-b\">' +
                '<span class=\"fl-left ft16 fcol-666 con3-span\">姓名</span>' +
                '<input type=\"text\" name=\"name\" value=\"\" class=\"per-add-inp ft16\">' +
                '</p>' +
                '<p class=\"per-con3-a bor-b\">' +
                '<span class=\"fl-left ft16 fcol-666 con3-span\">手机号码</span>' +
                '<input type=\"text\" name=\"mobile\" value=\"\" class=\"per-add-inp ft16\">' +
                '</p>' +
                '<p class=\"per-con3-a bor-b\">' +
                '<span class=\"fl-left ft16 fcol-666 con3-span\">所在地区</span>' +
                citystr +
                '</p>' +
                '<p class=\"per-con3-a \">' +
                '<span class=\"fl-left ft16 fcol-666 con3-span\">详细地址</span>' +
                '<input type=\"text\" name=\"address\" value=\"\" class=\"per-add-inp ft16\">' +
                '</p>' +
                '<p class=\"per-con3-a \" >' +
                '<span class=\"fl-left ft16 fcol-666 con3-span\" >邮箱</span>' +
                '<input type=\"text\" name=\"mail\" value=\"\" class=\"per-add-inp ft16\">' +
                '</p>' +
                '<p class=\"per-con3-a\">' +
                '<span class=\"fl-left ft16 fcol-666 con3-span\">邮编</span>' +
                '<input type=\"text\" name=\"youbian\" value=\"\" class=\"per-add-inp ft16\">' +
                '</p>' +
                '</div>' +
                '<p style=\"margin-top:20px;\">' +
                '<input type=\"button\" value=\"返回\" class=\"per-add-save2 ft16\">' +
                '</p>' +
                '<p style=\"margin-top:20px;\">' +
                '<input type=\"button\" value=\"保存并选中\" onclick=\"update_address()\" class="per-add-save ft16">' +
                '</p>' +
                '</div>';
            $('.ad-box-bj').html(tamp);
            initback();


        })
<%--        列表新增按钮--%>
        $('.per-add-bj').click(function () {
            $('.ad-box-bj').show();
            $('.tps-ad-xg').hide();
        })
    <%--        列表编辑按钮--%>
        $('.per-add-save2').click(function () {
            $('.ad-box-bj').hide();
        })
<%--        编辑、新增填写页面返回--%>
        function initback() {
            $('.per-add-save2').click(function () {
                $('.ad-box-bj').hide();
            })
        }
    </script>
    <form id="form5" name="form5" action="/ShopOrders.do" method="post"  onsubmit="return mt.check(this)">
        <div class='xiangxi'>
            <div class="pro-info flex">
                <h2 class="h2 flex bold">商品清单</h2>

                <%
                    float totalprice = 0.0f;
                    //isLzCategory = ps.length==2;
                    int checkLength = 0;
                    int num  = 0;
                    int count = 0;
                    for(int j=1;j<ps.length;j++) {
                        String[] arr = ps[j].split("&");
                        int checkFlag = Integer.parseInt(arr[2]);
                        if (checkFlag == 0) continue;
                        checkLength++;
                        //判断product_id是否商品的id，如果不是则为套装id
                        int product_id = Integer.parseInt(arr[0]);
                        int quantity = Integer.parseInt(arr[1]);//数量
                        num = quantity;
                        if(istps==1){//tps只能1
                            quantity = 1;
                        }

                        ShopProduct p = ShopProduct.find(product_id);

                %>
                <div class="detail01 flex">
                    <span class="pic flex">
                        <%= p.getAnchor('t')%>
                    </span>
                    <span class="nr flex">
                    <%
                        //int num=0;//数量

                        ShopPackage spage = new ShopPackage(0);
                        List<ShopProduct> spagePList = new ArrayList<ShopProduct>();
                        String pname = "";

                        float price = 0.0f;
                        price = p.price;
                        totalprice += price * quantity;
                                out.println("</td>");

                    %>
                        <span class="tit bold"><%= p.name[1]%><input name='product_id' type='hidden' value='<%= product_id%>' /></span>
                        <%
                            if(istps==1){
                                ShopCategory sc1 = ShopCategory.find(p.category);
                                ShopProductModel spm = ShopProductModel.find(p.model_id);
                                %>
                        <span class="version"><em>软件大小</em><%= MT.f(p.size)%></span>
                        <span class="version"><em>软件版本</em><%= MT.f(p.color)%></span>
                        <span class="version"><em>购买方式</em><%= MT.f(sc1.name[1]+spm.getModel())%></span>
                        <%
                            }
                        %>

                    <span class="version"><input name='quantity' type='hidden' value='<%= quantity%>' /><em>商品单价</em>￥<%= MT.f(price, 2)%></span>
                    <span class="version"><em>商品数量</em><%= quantity%></span>
                    </span>
                </div>
            </div>

<%
    }
%>


            <div class="sign03 flex">
                <textarea placeholder="备注说明:" name="userRemarks" ><%= MT.f((istps==1?tpsbz:sbbz))%></textarea>
            </div>
            <div class="sign02 flex" style="border-top: 0.1rem #eef4fb solid;padding:0.3rem 0.32rem 0.3rem;display: block; overflow: hidden;">
                <span class="tps-fpw">发票</span>
                <a class="tps-fp">不开发票</a>
            </div>
            <div class="fp-box">
                <p class="fp-p">
                    <label class="fp-inp fp-inp2" ><input type="radio" name="isinvoice" value="1" style='position:absolute;'>开发票</label>
                    <label class="fp-inp fp-inp1 act"><input type="radio" checked name="isinvoice"  value="0"  style='position:absolute;'>不开发票</label>
                </p>
                <div class="person-con5" style="display: none;">
                    <p class="per-con3-a per-con3-a2">
                        <span class="fl-left ft16 fcol-666 con3-span">名称</span>
                        <input type="text" name="invoiceName" value="" class="per-add-inp ft16">
                    </p>
                    <p class="per-con3-a per-con3-a2">
                        <span class="fl-left ft16 fcol-666 con3-span">电话</span>
                        <input type="text" name="invoiceMobile" value="" class="per-add-inp ft16">

                    </p>
                    <p class="per-con3-a per-con3-a2">
                        <span class="fl-left ft16 fcol-666 con3-span">所在地区</span>
                        <script>mt.city("city0","city1","invoiceProvinces",'');</script>
                    </p>
                    <p class="per-con3-a" style="margin-bottom:10px;">
                        <span class="fl-left ft16 fcol-666 con3-span">详细地址</span>
                        <input type="text" name="invoiceAddress" value="" class="per-add-inp ft16">
                    </p>
                    <p class="per-con3-a per-con3-a2" style="margin-top:10px;">
                        <span class="fl-left ft16 fcol-666 con3-span">账号</span>
                        <input type="text" name="invoiceAccountNumber" value="" class="per-add-inp ft16">
                    </p>
                    <p class="per-con3-a per-con3-a2">
                        <span class="fl-left ft16 fcol-666 con3-span">税号</span>
                        <input type="text" name="invoiceDutyParagraph" value="" class="per-add-inp ft16">
                    </p>
                    <p class="per-con3-a" style="margin-bottom:10px;">
                        <span class="fl-left ft16 fcol-666 con3-span">开户行</span>
                        <input type="text" name="invoiceOpeningBank" value="" class="per-add-inp ft16">
                    </p>
                    <p class="per-con3-a per-con3-a2" style="margin-top:10px;margin-bottom:10px;">
                        <span class="fl-left ft16 fcol-666 con3-span">费用名称</span>
                        <input type="text" name="invoiceCostName" value="" class="per-add-inp ft16">
                    </p>
                </div>
                <p style="margin-top:20px;">
                    <input type="button" value="确定" class="per-add-save ft16">
                 </p>
            </div>
            <script>
                $('.tps-fp').click(function(){
                    $(".tps-ad-xg").hide();
                    $('.fp-box').show();

                })
                $('.per-add-save').click(function(){
                    $(".tps-fp").html((form5.isinvoice.value==1?"开发票":"不开发票"));
                    $('.fp-box').hide();
                })
                $('.fp-inp1').click(function(){
                    $('.person-con5').hide();
                    $('.fp-inp1').addClass('act')
                    $('.fp-inp2').removeClass('act');
                })
                $('.fp-inp2').click(function(){
                    $('.person-con5').show();
                    $('.fp-inp2').addClass('act')
                    $('.fp-inp1').removeClass('act');
                })
            </script>
            <div class="detail04 flex">
                <span class="deta-je">应付总额</span>
                <span class="deta-je2 ">￥<span class="total1"><%= totalprice%></span></span>
                <input type="button" value="提交订单" class="butsub" onclick="return fnsub()"/>
            </div>
        </div>
        <%-- <input type="hidden" name="puid" value="<%=puid %>" /> --%>
        <%-- <input type="hidden" name="quantity" value="<%=num %>"/> --%>
        <input type="hidden" name="amount" value="<%=totalprice%>"/>
        <input type="hidden" name="iswx" value="1"/>
        <input type="hidden" name="cityname"/>

        <input type="hidden" name="allocate"/>
        <input type="hidden" name="allocatetype"/>
        <input type="hidden" name="orderType" value="<%= (istps==1?"1":"2")%>" />
        <input type="hidden" name="address_ok"/>

        <input type="hidden" name="act" value="submit"/>
        <input type="hidden" name="nexturl" value=""/>
        <input type="hidden" name="payType" value=""/>
        <input type="hidden" name="isLzCategory" value=""/>
        <input type="hidden" name="token" value="<%=token %>"/>
        <input name="address_id" type="hidden" value="">
    </form>
</div>
<div class="citydiv" hidden>
    <script>mt.city("city0", "city1", "", '0');</script>
</div>
<script>
    $(function () {
        $("em.flex i").click(function () {
            $(this).addClass('cur').siblings("i").removeClass("cur");
        });

    })
</script>
<script>

    <%
        out.print("function delcar(){");
        for(int c=1;c<ps.length;c++) {
            String[] arr = ps[c].split("&");
            int checkFlag = Integer.parseInt(arr[2]);
            if (checkFlag == 0) continue;
            out.print("car.delsubmit('','"+ps[c]+"','','');");
        }
        out.print("}");
        %>

    function myact(a, id) {
        if (a == "edit") {
            $("#tab1").hide();
            $("#tab2").show();
        }
    }

    //form1.nexturl.value = location.pathname + location.search;


    //选择发票类型
    function selNvoice(v) {
        if (v == 1) {
            document.getElementById('nvoice_t').style.display = 'none';
            form3.type.value = '1';
        } else {
            document.getElementById('nvoice_t').style.display = '';
            form3.type.value = '2';
        }
        mt.fit();
    }

    //修改发货人信息
    function setAddress() {
        /*document.getElementById('nvoice_show').style.display = 'none';
        document.getElementById('nvoice_edit').style.display = '';
        document.getElementById('address_up').style.display = '';*/
        myact('edit', '0');
        var hospital = form1.hospital_id.value;
        var consignees = form1.consignees.value;
        //查找收货人
        mt.send("/Members.do?act=getsign&hospital=" + hospital + "&consignees=" + consignees, function (d) {
            var sel = document.getElementById("_consignees");
            sel.innerHTML = d;
        });

        mt.fit();
    }


    function keyupActivity(obj) {
        obj.value = obj.value.replace(/[^\d.]/g, ""); //清除"数字"和"."以外的字符
        obj.value = obj.value.replace(/^\./g, ""); //验证第一个字符是数字而不是
        obj.value = obj.value.replace(/^[2-9]/g, ""); //验证第一个字符是数字而不是
        obj.value = obj.value.replace(/\.{2,}/g, "."); //只保留第一个. 清除多余的
        obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
        obj.value = obj.value.replace(/^(\-)*(\d+)\.(\d\d).*$/, '$1$2.$3'); //只能输入两个小数
        findProductStockCount();
    }

    function blurActivity(obj, activityMin, activityMax) {
        if (obj.value != '' && (obj.value < activityMin || obj.value > activityMax)) {
            mt.show("活度超出范围 " + activityMin + "-" + activityMax + "！");
            obj.value = activityMin;
            findProductStockCount();
        }
    }



    function fnsub() {
        var addressCheck=$('input:radio[name="address_ok"]').is(":checked");
        if(addressCheck==false){
            mt.show('请选择收货地址！');
            return;
        }
        var fpCheck=$('input:radio[name="isinvoice"]').is(":checked");
        if(fpCheck==false){
            mt.show('请选择是否开发票！');
            return;
        }
        form5.address_ok.value = form0.address_ok.value;

        fn.ajax("/ShopOrders.do?act=submitajaxtps", $("#form5").serialize(), function (data) {
            if (data.type > 0) {
                if (data.type == 1) {
                    mt.show('对不起！您还未登录，登陆后才可提交订单！');
                    return;
                }
                if (data.type == 3) {
                    mt.show(data.mes);
                    return;
                }
            } else {
                //host 14110391
                //test 19070110

                ///html/folder/19090023-1.htm

                delcar();
                location = '/mobjsp/yl/shopweb/pay.jsp?orderId=' + data.orderId;
            }
        });


    }

    function allocatefun() {
        mt.show("库存不足，是否同意调配？", 2);
        mt.ok = function () {
            form5.allocate.value = 1;
            form5.allocatetype.value = 0;
            $(".butsub").click();
        }
        mt.cancel = function () {
            form5.allocate.value = 1;
            form5.allocatetype.value = 1;
            $(".butsub").click();
        }
        //fnsub();

    }


    function setCityName(obj) {
        if (mt.check(obj)) {
            var cityid = document.getElementsByName("city2")[0].value;
            mycity(cityid);
        } else {
            return false;
        }
    };

    function showfp() {
        document.getElementById("stab1").style.display = 'none';
        document.getElementById("stab2").style.display = 'none';
        document.getElementById("fap").style.display = '';
    }

    function showRecipient() {
        mt.show("/jsp/yl/shopweb/RecipientSearch.jsp", 2, "查询收货人", 500, 450);
    }

    mt.receive = function (id, n, m) {
        form1.sor_id.value = id;
        form1.consignees.value = n;
        form1.mobile.value = m;
    }


    mt.fit();

    jQuery(document).ready(function () {


        jQuery(".hospital_id").change();
    });

    /*商品数量+1*/
    function numAdd() {
        var quantity = document.getElementById("quantity").value;
        var num_add = parseInt(quantity) + 1;
        if (quantity == "") {
            num_add = 1;
        }
        if (num_add >= 2000) {
            document.getElementById("quantity").value = num_add - 1;
            mt.show("商品数量不能大于2000");
        } else {
            document.getElementById("quantity").value = num_add;
            calculatetotal();
        }
    }

    /*商品数量-1*/
    function numDec() {
        var quantity = document.getElementById("quantity").value;
        var num_dec = parseInt(quantity) - 1;
        if (num_dec > 0) {
            document.getElementById("quantity").value = num_dec;
            calculatetotal();
        }
    }

    /*商品数量框输入*/
    function keyup() {
        var quantity = document.getElementById("quantity").value;
        var re = /^[1-9]+[0-9]*]*$/;
        if (!re.test(quantity) || parseInt(quantity) != quantity || parseInt(quantity) < 1) {
            document.getElementById("quantity").value = 1;
            calculatetotal();
            return;
        }
        if (quantity >= 2000) {
            document.getElementById("quantity").value = quantity.substring(0, quantity.length - 1);
            mt.show("商品数量不能大于2000");
        }
        calculatetotal();
    }

    function calculatetotal() {
        //var total = 2.368;
        /*var orderprice = form5.orderprice.value;
        var quantity = form5.quantity.value;
        var total = orderprice * quantity;
        $(".total1").html(total);
        form5.amount.value = total;*/
    }

    calculatetotal();




    function update_address() {
        var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
        var reg1 = /^\d{6}$/;
        var reg3=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        var mob = form0.mobile.value;
        var city = form0.city1.value;
        if(city.length<1){
            mt.show("保存失败，必选项所在地区");
            form0.city.focus();
            return false;
        }
        if(!reg.test(mob)){
            mt.show("保存失败，手机格式不正确");
            form0.mobile.focus();
            return false;
        }
        var mail = form0.mail.value;
        if(mail.length>0&&!reg3.test(mail)){
            mt.show("保存失败，邮箱格式不正确");
            form0.mail.focus();
            return false;
        }
        var youbian = form0.youbian.value;
        if(!reg1.test(youbian)){
            mt.show("保存失败，邮编格式不正确");
            form0.youbian.focus();
            return false;
        }

        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=update_address", $("#form0").serialize(), function (data) {
            if (data.type > 0) {
                mtDiag.close();
                mtDiag.show(data.mes);
                return;
            } else {
                var a = getProvince(data.pro);
                var b = getSrcity2(data.pro, data.src);
                var tamp =
                    '<span class=\"tit\">' +
                    '<a class=\"che-ad\" onclick=\"xg_shr()\">修改收货人</a>' +
                    '<a class=\"version\">' + data.name + a + b + '' + data.address + '</a>' +
                    '</span>';
                $("#tab1").html(tamp);
                $('.ad-box-bj').hide();
                initshow();


            }
        });


    }

    function xg_shr() {
        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=xg_shr", {}, function (data) {
                if (data.type > 0) {
                    mtDiag.close();
                    mtDiag.show(data.mes);
                    return;
                } else {
                    $(".person-con4").children().remove();
                    var ids = data.id.toString();
                    var s = ids.split(",");
                    var names = data.name.toString();
                    var c = names.split(",");
                    var mobiles = data.mobile.toString();
                    var d = mobiles.split(",");
                    var addresss = data.address.toString();
                    var e = addresss.split(",");
                    var a = data.pro.toString();
                    var f = a.split(",");
                    var b = data.src.toString();
                    var g = b.split(",");
                    var h = data.isxuanzhong.toString();
                    var z =h.split(",");

                    var morenarr = data.moren.toString();
                    var moren =morenarr.split(",");

                    for (var i = 0; i < z.length; i++) {
                        var asd = getProvince(f[i]);
                        var zxc = getSrcity2(f[i], g[i]);
                        var tamp = '';
                        var str='';
                        if(z[i].indexOf("0")==-1){
                            str='<input type="radio" class="inp-ad"  disabled checked="checked" >';
                        }else{
                            str='<input type="radio" class="inp-ad"  disabled >';
                        }
                        tamp +=
                            '<div class=\"per-add-line1 bor-b\"  >' +
                            '<p class=\"ft16 per-add-xm\" onclick=\"xuanzhong(' + s[i] + ')\" >' +
                                str+
                            '<span class=\"ad-xm\">' + c[i] + '</span>&nbsp;&nbsp;' +
                            '<span>' + d[i] + '</span>' +
                            '</p>' +
                            '<p class=\"fl-left ft14 per-add-w\" onclick=\"xuanzhong(' + s[i] + ')\">'+(moren[i]=="1"?"<em class=\"ft12 mr\">默认</em>":"")+asd+zxc+ e[i] +
                            '</p>' +
                            /*'<a href=\"#\"  class=\"per-xuanze-bj\">选择</a>' +*/
                            '<a href=\"#\" onclick=\"bianji(' + s[i] + ')\" class=\"fl-right ft16 per-add-bj bor-l\">编辑</a>' +
                            '</div>';
                        $(".person-con4").append(tamp);
                        initzhnashi();

                    }


                }
            }
        )
    };

    function xuanzhong(id) {
        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=xuanzhong_address", {id: id}, function (data) {
                if (data.type > 0) {

                    mtDiag.close();
                    mtDiag.show(data.mes);
                    return;
                } else {
                    var a = getProvince(data.pro);
                    var b = getSrcity2(data.pro, data.src);
                    var tamp =
                        '<span class=\"tit\"><input  name="address_ok" checkde type="radio" value="'+data.id+'" />' +
                        '<a class=\"che-ad\" onclick=\"xg_shr()\">修改收货人</a>' +
                        '<a class=\"version\">' + data.name + a + b + '' + data.address + '</a>' +
                        '</span>';
                    $("#tab1").html(tamp);
                    $('.tps-ad-xg').hide();
                    $('.address flex').show();
                    initshow();

                }
            }
        )
    };

    function bianji(id) {
        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=bianji_address", {id: id}, function (data) {
            if (data.type > 0) {

                mtDiag.close();
                mtDiag.show(data.mes);
                return;
            } else {
                var a = data.city;
                var citystr = "";

                /*$("select[name='city0']").val(13);
                $("select[name='city0']").change();

                $("select[name='city1']").val(1301);
                $("select[name='city1']").change();*/

                //console.log($("select[name='city1']")[0].outerHTML);

                citystr += $("select[name='city0']")[0].outerHTML;
                citystr += $("select[name='city1']")[0].outerHTML;
                /*var cityarr = $(".citydiv").find("select");//[0].outerHTML
                for(var i=0;i<cityarr.length;i++){
                    citystr += cityarr[i].outerHTML;

                }*/
                /* console.log(citystr);*/
                var tamp =
                    '<input type=\"hidden\" name=\"id\" value=\"' + data.id + '\" class=\"per-add-inp ft16\">' +
                    //'<div class=\"ad-box-bj \">' +
                    '<div  >' +
                    '<div class=\"person-con4\">' +
                    '<p class=\"per-con3-a bor-b\">' +
                    '<span class=\"fl-left ft16 fcol-666 con3-span\">姓名</span>' +
                    '<input type=\"text\" name=\"name\" value=\"' + data.name + '\" class=\"per-add-inp ft16\">' +
                    '</p>' +
                    '<p class=\"per-con3-a bor-b\">' +
                    '<span class=\"fl-left ft16 fcol-666 con3-span\">手机号码</span>' +
                    '<input type=\"text\" name=\"mobile\" value=\"' + data.mobile + '\" class=\"per-add-inp ft16\">' +
                    '</p>' +
                    /* +*/

                    '<p class=\"per-con3-a bor-b\">' +
                    '<span class=\"fl-left ft16 fcol-666 con3-span\">所在地区</span>' +

                    citystr +
                    '</p>' +

                    '<p class=\"per-con3-a \">' +
                    '<span class=\"fl-left ft16 fcol-666 con3-span\">详细地址</span>' +
                    '<input type=\"text\" name=\"address\" value=\"' + data.address + '\" class=\"per-add-inp ft16\">' +
                    '</p>' +
                    '<p class=\"per-con3-a \" >' +
                    '<span class=\"fl-left ft16 fcol-666 con3-span\" >邮箱</span>' +
                    '<input type=\"text\" name=\"mail\" value=\"' + data.mail + '\" class=\"per-add-inp ft16\">' +
                    '</p>' +
                    '<p class=\"per-con3-a\">' +
                    '<span class=\"fl-left ft16 fcol-666 con3-span\">邮编</span>' +
                    '<input type=\"text\" name=\"youbian\" value=\"' + data.youbian + '\" class=\"per-add-inp ft16\">' +
                    '</p>' +
                    '</div>' +
                    '<p style=\"margin-top:20px;\">' +
                    '<input type=\"button\" value=\"返回\" class=\"per-add-save2 ft16\">' +
                    '</p>' +
                    '<p style=\"margin-top:20px;\">' +
                    '<input type=\"button\" value=\"保存并选中\" onclick=\"update_address()\" class="per-add-save ft16">' +
                    '</p>' +
                    '</div>';
                $('.ad-box-bj').html(tamp);
                var tempdiv = $(".person-con4");
                var city0 = $(tempdiv).find("select[name='city0']");
                var a = data.city.toString();
                var b = a.substring(0, 2);
                city0.val(b);
                city0.change();
                var city1 = $(tempdiv).find("select[name='city1']");
                city1.val(a);
                /*$("select[name='city0']").val(13);
                $("select[name='city0']").change();

                $("select[name='city1']").val(1301);
                $("select[name='city1']").change();*/


                /* $('.ad-box-bj').show();
                 $('.tps-ad-xg').hide();*/
                initback();

            }
        });


    }


</script>
</body>
</html>