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
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=0">
    <title>订单提交</title>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <link rel="stylesheet" href="../css/common.css">
</head>
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
<style>
    body{margin:0}
    .bio .oks{background:none;border:none;padding:0 4%;}
    .bio .bigtit{background: none;border:none;line-height: 28px;}
    .bio .account{background:#fef9ee;padding:25px 4%;}
    .oks .cos{text-align: center;background: none;height:auto;margin-bottom:0;}
    .oks .cos strong{display: block;background: url(/tea/yl/img/u140.svg) 32% 5px no-repeat;font-size:18px;font-weight: normal;}
    .order-num{text-align: center;font-size:16px;margin-top:15px;color:#000;}
    .order-num span{color:#000;}
    .cos .order-ts{font-size:14px;color:#A6A6A6;margin-top:10px;}
    .order-zh{margin-top:35px;}
    @media only screen and (max-width: 320px) {
        .account li .span1{}
        .account li .span1{width:64px;}
        .bigtit{flex:0.8;}
    }
    .bio .account{background: rgba(242, 242, 242, 1);border-top:1px solid #FF7E00;padding:25px 0 25px 30px}
    .oks .cos strong{height:30px;display: block;background: url(/tea/yl/img/u140.svg) 32% 5px no-repeat;font-size:18px;font-weight: normal;}
    .order-num span em{font-style:normal;color:#F90000;font-size:16px;}
    .bigtit{font-weight:normal;}
    .finishPay label input{}
    .finishPay {margin-top:45px;border:1px solid rgba(227, 227, 227, 1);}
    .cho-p{margin:0;overflow:hidden;}
    .pay-box{margin-top:30px;margin-bottom:30px;overflow: hidden;}
    .pay-box label{position: relative;height:45px;line-height:45px;display:inline-block;float:left;margin-right:25px;}
    .pay-box label input{position: absolute;top:15px;width: 15px;height: 15px;-webkit-appearance: none;z-index: 9;background: url(/tea/mobhtml/img/icon14.png) center no-repeat;background-size: 15px 15px;}
    .pay-box label img{margin-left:30px;max-height:30px;}
    .pay-box label input:checked {background: url(/tea/mobhtml/img/icon15.png) center no-repeat;background-size: 15px 15px;}
    .pay-box label span{margin-left:30px;width:100px;position: absolute;top:2px;font-size:15px;}
    .pay-mon{background:#f9fbfd;height:50px;line-height: 50px;margin-top:45px;}
    .pay-btn{float:right;color: #fff;background: #044694;border: none;font-size: 16px;padding: 8px 30px;margin-top:5px;}
    .pay-je{float:right;margin-right:20px;}
    .pay-je b{color: #df6c0a;font-size: 16px;}
    input[type=button], input[type=submit], input[type=text], input[type=file], button {cursor: pointer;-webkit-appearance: none;}
    .detail04 {height: 60px;position: fixed;bottom: 0;left: 0;width: 100%;background: #fff;border-top: 1px solid #D0D0D0;border-bottom: 1px solid #D0D0D0;display: -webkit-flex;}
    .deta-je {flex: 0.6;line-height: 60px;text-align: right;margin-right: 10px;display: inline-block;color: #999;font-size:0.3rem;}
    .deta-je2 {flex: 1;line-height: 60px;display: inline-block;color: #df6c0a;font-size: 18px;}
    .detail04 input {flex: 1;height:61px;border-radius: 0;background: #044694;color: #fff;border: none;font-size:15px;margin-right:-2px;}
    .cho-w{float:left;padding:0 10px;display:inline-block;background:rgba(255, 165, 78, 1);height:40px;line-height:40px;color:#fff;font-size:15px;}
</style>
<body>
<div class="bio">
    <p style='text-align:center;margin-top:50px'><img src='/res/lizi/img/icon114.png' style='width:50px;'></p>
    <div class="oks">
        <div class='cos'>
            <p style='font-size:0.3rem;'>提交订单成功，请您尽快支付！</p>
            <p class='order-num' style='color:#6a6a6a;'>
                <span  style='color:#6a6a6a;'>订单号：<%=orderid%></span>
                <span style='margin-left:20px;color:#6a6a6a;'>订单金额：
						<em>&yen<%=MT.f((double)so.getAmount(),2) %></em>
				</span>
            </p>
            <p class="order-ts">请您在提交订单后7天内完成支付，否则订单会自动取消！</p>
        </div>
    </div>
    <div class="finishPay">
        <form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
            <input type="hidden" name="act" value="orderPayment"/>
            <input type="hidden" name="orderId" value="<%=orderid%>"/>

            <!-- input type="submit" value="完成支付"/ -->

    </div>
    <div class="order-zh" style='margin:30px 4% 0;border:1px solid rgba(227, 227, 227, 1)'>
        <p class="cho-p"><span class="cho-w">请选择支付方式</span></p>
        <div class="pay-box">
            <label for="wx" style="margin-left:4%;">
                <input type="radio"   value="1" id="wx" name="paytype" >
                <img src="/tea/new/img/u432.png" alt="">
            </label>
            <label for="zz">
                <input type="radio" id="zz" checked  value="2"  name="paytype" >
                <span>转账汇款</span>
            </label>
        </div>
    </div>
    </form>
</div>
<div class="detail04 flex">
    <span class="deta-je">应付总额</span>
    <span class="deta-je2 ">￥<span class="total1"><%= price%></span></span>
    <input type="button" value="去支付" class="butsub" onclick="pay()">
</div>
</body>
<script>
    mt.fit();
    function pay(){
        var paytype = form2.paytype.value;
        if(paytype==0){

        }else if(paytype==1){

        }else{
            //host
            parent.location = '/mobjsp/yl/shopweb/ShopOrderPaymentTps.jsp?orderId=<%= h.get("orderId")%>';
        }
    }
</script>
</html>