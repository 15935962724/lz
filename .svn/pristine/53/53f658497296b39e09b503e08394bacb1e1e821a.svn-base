<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.yl.shop.ShopOrder" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="tea.entity.yl.shop.ShopOrderData" %>
<%@ page import="tea.entity.Database" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<%
    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community="
                + h.community);
        return;
    }
    String orderid= MT.dec(h.get("orderId"));
    ShopOrder so=ShopOrder.findByOrderId(orderid);
    Profile profile = Profile.find(so.getMember());
    double price = 0;
    ArrayList sodList = ShopOrderData.find(" AND order_id="+ Database.cite(so.getOrderId()),0,Integer.MAX_VALUE);
    if(sodList.size()>0){
        ShopOrderData sorderdata = (ShopOrderData)sodList.get(0); //订单详细
        price=sorderdata.getAmount().floatValue();
    }
%>
<head>
    <meta charset="UTF-8">
    <title>支付页面</title>
    <link href="/res/cssjs/base.css" rel="stylesheet" type="text/css" />
    <link href="/res/cssjs/my.css" rel="stylesheet" type="text/css" />
    <script src="/tea/mt.js" type="text/javascript"></script>

</head>
<style>
    .bio .oks{background:none;border:none;}
    .bio .bigtit{background: none;border:none;line-height: 28px;}
    .bio .account{background: rgba(242, 242, 242, 1);border-top:1px solid #FF7E00;padding:25px 0 25px 30px}
    .oks .cos{text-align: center;background: none;height:auto;margin-bottom:0;}
    .oks .cos strong{height:30px;display: block;background: url(/tea/yl/img/u140.svg) 32% 5px no-repeat;font-size:18px;font-weight: normal;}
    .order-num{text-align: center;font-size:16px;margin-top:15px;color:#000;}
    .order-num span{color:#000;}
    .order-num span em{font-style:normal;color:#F90000;font-size:16px;}
    .cos .order-ts{font-size:14px;color:#A6A6A6;margin-top:10px;}
    .order-zh{margin-top:60px;}
    .bigtit{font-weight:normal;}
    .account li{line-height: 28px;}
    .account li span{display: inline-block;width:60px;text-align: right;margin-right:10px;}
    .finishPay label input{}
    .finishPay {margin-top:45px;border:1px solid rgba(227, 227, 227, 1);}
    .cho-p{margin:0;}
    .pay-box{margin-top:30px;margin-bottom:30px;overflow: hidden;}
    .pay-box label{position: relative;height:45px;display:inline-block;margin-left:25px;line-height:45px;float:left;margin-right:25px;}
    .pay-box label input{position: absolute;top:11px;width: 15px;height: 15px;-webkit-appearance: none;z-index: 9;background: url(/tea/mobhtml/img/icon14.png) center no-repeat;background-size: 15px 15px;}
    .pay-box label img{margin-left:30px;max-height:39px;}
    .pay-box label input:checked {background: url(/tea/mobhtml/img/icon15.png) center no-repeat;background-size: 15px 15px;}
    .pay-box label span{margin-left:25px;width:100px;position: absolute;top:-2px;}
    .pay-mon{background:#f9fbfd;height:50px;line-height: 50px;margin-top:45px;}
    .pay-btn{float:right;color: #fff;background: #044694;border: none;font-size: 16px;padding: 8px 30px;margin-top:5px;}
    .pay-je{float:right;margin-right:20px;}
    .pay-je b{color: #df6c0a;font-size: 16px;}
    .cho-w{padding:0 10px;display:inline-block;background:rgba(255, 165, 78, 1);height:40px;line-height:40px;color:#fff;font-size:15px;}
</style>

<body>
<div class="bio">
    <div class="oks">
        <div class='cos'>
            <strong>提交订单成功，请您尽快支付！</strong>
            <p class='order-num'>
                <span>订单号：<%= so.getOrderId()%></span>
                <span style='margin-left:20px;'>订单金额：
						<em>&yen<%= price%></em>
				</span>
            </p>
            <p class="order-ts">请您在提交订单后7天内完成支付，否则订单会自动取消！</p>
        </div>
    </div>
    <form name="form2">
    <div class="finishPay">
        <p class="cho-p"><span class="cho-w">请选择支付方式</span></p>
        <div class="pay-box">
            <label for="zfb">
                <input name="paytype" type="radio" value="0" id="zfb">
                <img src="/tea/new/img/u433.png" alt="">
            </label>
            <label for="wx">
                <input name="paytype" type="radio"  value="1"  id="wx">
                <img src="/tea/new/img/u432.png" alt="">
            </label>
            <label for="zz">
                <input name="paytype" type="radio"  value="2"  id="zz">
                <span>转账汇款</span>
            </label>

        </div>
    </div>
    </form>
    <div class="pay-mon">
        <input type="button" value="去支付" onclick="pay()" class="pay-btn">
        <span class="pay-je">应付金额：<b>￥<%= price%></b></span>
    </div>




</div>
<script>
    mt.fit();
    function pay(){
        var paytype = form2.paytype.value;
        if(paytype==0){

        }else if(paytype==1){

        }else{
            //host
            //test 19090775
            parent.location = '/html/folder/19092427-1.htm?orderId=<%= h.get("orderId")%>';
        }
    }
</script>

</body>
</html>