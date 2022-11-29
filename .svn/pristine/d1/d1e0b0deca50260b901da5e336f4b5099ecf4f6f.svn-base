<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="tea.entity.*" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.entity.yl.shop.EmpowerRecord" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.Consignee" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int id = h.getInt("orderId");

%><!DOCTYPE html>
<html>
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
        }
        .per-add-inp {
            border: none;
            height: 45px;
            line-height: 45px;
            font-size:0.3rem;
            flex:2;

        }
        .per-add-save {
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
       /* .person-con4 .per-con3-a2{
            border:none;
        }*/
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

        textarea,input[type=button], input[type=submit], input[type=text],input[type=file], button {
            cursor: pointer; -webkit-appearance: none; }
        @media screen and (max-width: 321px)  {
            .tps-fp{padding-right:30px;}
        }
        .fp-p .act{
            background:#044694;
            color:#fff;
        }
    </style>
</head>
<body>
<%--<div class="qualification con">
    <form name="form2" action="/ShopOrders.do" id="form2" method="post" enctype="multipart/form-data">
        <input type="hidden" name="nexturl">
        <input type="hidden" name="act">
        <input type="hidden" name="id" value="<%=h.get("orderid")%>">
        <input type="hidden" name="isorder">
        <table id="tablecenter" cellspacing="0" class="right-tab4" style="background:none;">
            <tr>
                <td class="text-r">名称：</td>
                &lt;%&ndash;<td class="text-r"><em>*</em>收货人：</td>&ndash;%&gt;
                <td><input name="invoiceName" alt="名称不能为空!" class="form-control" style="width:292px" /></td>
            </tr>
            <tr>
                <td class="text-r">税号：</td>
                <td ><input name="invoiceDutyParagraph" alt="税号不能为空!" class="form-control" style="width:292px"  /></td>
            </tr>
            <tr>
                <td class="text-r">地址：</td>
                <td ><script>mt.city("city0","city1","invoiceProvinces",'');</script></td>
            </tr>
            <tr>
                <td class="text-r">开户行：</td>
                <td ><input name="invoiceOpeningBank"  alt="开户行不能为空!" class="form-control" style="width:292px" /></td>
            </tr>
            <tr>
                <td class="text-r">详细地址：</td>
                <td ><input name="invoiceAddress" alt="详细地址不能为空!" class="form-control" style="width:292px" /></td>
            </tr>
            <tr>
                <td class="text-r">费用名称：</td>
                <td ><input name="invoiceCostName" alt="费用名称不能为空!" class="form-control" style="width:292px"  /></td>
            </tr>
            <tr>
                <td class="text-r">电话：</td>
                <td ><input name="invoiceMobile" alt="电话不能为空!" class="form-control" style="width:292px"  /></td>

            </tr>
            <tr>
                <td class="text-r">账号：</td>
                <td ><input name="invoiceAccountNumber" alt="账号不能为空!" class="form-control" style="width:292px"  /></td>

            </tr>

        </table>
    </form>

</div>--%>

<form name="form2" action="/ShopOrders.do" id="form2" target="_ajax" method="post" enctype="multipart/form-data">
    <input type="hidden" name="nexturl">
    <input type="hidden" name="ismobile" value="1">
    <input type="hidden" name="act">
    <input type="hidden" name="id" value="<%=MT.dec(h.get("orderId"))%>">
    <input type="hidden" name="isorder">
    <div class="person-con4">
        <p class="per-con3-a per-con3-a2">
            <span class="fl-left ft16 fcol-666 con3-span">名称</span>
            <input type="text" name="invoiceName" alt="名称不能为空!" class="per-add-inp ft16">
        </p>
        <p class="per-con3-a per-con3-a2">
            <span class="fl-left ft16 fcol-666 con3-span">电话</span>
            <input type="text" name="invoiceMobile" alt="电话不能为空!" class="per-add-inp ft16">

        </p>
        <p class="per-con3-a per-con3-a2">
            <span class="fl-left ft16 fcol-666 con3-span">所在地区</span>

            <script>mt.city("city0","city1","invoiceProvinces",'');</script>
        </p>
        <p class="per-con3-a" >
            <span class="fl-left ft16 fcol-666 con3-span">详细地址</span>
            <input type="text" name="invoiceAddress" alt="详细地址不能为空!" class="per-add-inp ft16">
        </p>
        <p class="per-con3-a per-con3-a2" >
            <span class="fl-left ft16 fcol-666 con3-span">账号</span>
            <input type="text" name="invoiceAccountNumber" alt="账号不能为空!" class="per-add-inp ft16">
        </p>
        <p class="per-con3-a per-con3-a2">
            <span class="fl-left ft16 fcol-666 con3-span">税号</span>
            <input type="text"name="invoiceDutyParagraph" alt="税号不能为空!" class="per-add-inp ft16">
        </p>
        <p class="per-con3-a" style="margin-bottom:10px;">
            <span class="fl-left ft16 fcol-666 con3-span">开户行</span>
            <input type="text" name="invoiceOpeningBank"  alt="开户行不能为空!" class="per-add-inp ft16">
        </p>
        <p class="per-con3-a per-con3-a2" style="margin-top:10px;margin-bottom:10px;">
            <span class="fl-left ft16 fcol-666 con3-span">费用名称</span>
            <input type="text" name="invoiceCostName" alt="费用名称不能为空!" class="per-add-inp ft16">
        </p>
    </div>
</form>
    <%--<p style="margin-top:20px;">
        <input type="button" value="确定" class="per-add-save ft16">
    </p>--%>
<div class="center text-c pd20">
   <%-- <a href="javascript:;" onclick="subEmpower()" class="per-add-save ft16">保存</a>&nbsp;&nbsp;--%>
    <button class="per-add-save ft16" type="button" onclick="closetc()">关闭</button>
    <button class="per-add-save ft16" type="button" onclick="subEmpower()">保存</button>
</div>

</body>
</html>
<script>
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    function closetc() {
        parent.layer.close(index);
    }
    /*var a = parent.document.URL;
    a=a.substring(21,a.length);
    form2.nexturl.value = a;*/
    var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
    var reg1 = /^\d{6}$/;
    var reg3=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    function subEmpower() {
        if (mtDiag.check1($("#form2"))) {
            form2.act.value = 'invoice_edit';
            /*var mob = form2.mobile.value;*/
            var city = form2.invoiceProvinces.value;
            form2.nexturl.value="/jsp/yl/shopweb/PersonalIndex.jsp";
            if(city.length<1){
                mt.show("必选项所在地区");
                form2.invoiceProvinces.focus();
                return false;
            }
           /* if(!reg.test(mob)){
                mt.show("手机格式不正确");
                form2.mobile.focus();
                return false;
            }
            */

                form2.submit();


        }

    }



</script>