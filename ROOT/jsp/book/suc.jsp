<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Http h=new Http(request);
String nexturl=h.get("nexturl","/html/jskxcbs/folder/14010055-1.htm");
%>
	<ul class="Order_cart">
    	<li class="step1">1.我的购物车</li>
        <li class="step2">2.填写核对订单信息</li>
        <li class="step3">3.成功提交订单</li>
    </ul>
<div class="dingdan">
    <p class="p1"><img src="/res/jskxcbs/structure/dg.png" />您已成功提交订单，请等待计算运费！</p>
    <p class="p2">我们会根据您买到书籍的重量和收货地址来计算您所应承担的运费金额，请您耐心等待，我们会在您提交订单后24小时内完成计算，请注意查询。</p>
    <p class="p1"><img src="/res/jskxcbs/structure/jt00.png" /></p>
    <p class="p1">查询运费金额</td>
    <p class="p2">等我们把您的运费计算好后，会显示在您的订单中，请您查询运费金额去我的订单中查询。如有疑问，请电话联系我们。</p>
    <p class="p1"><img src="/res/jskxcbs/structure/jt00.png" /></p>
    <p class="p1">补充付款信息</p>
    <p class="p2">查询运费完毕后，请将您购买图书金额与本次运费金额总计人民币金额，汇款到<span>中国工商银行北京厢红旗支行</span>，卡号<span>0200004509008681215</span>，汇款成功后，将汇款单号提交到我的订单中<span>补充付款信息</span>，完成订单。填写完补充付款信息后，我们的工作人员将在24小时之内电话和Email予以确认，确认之后，我们将进行订单处理。您的订单重复提交或您填写的收货地址的信息不准确时，我们会尽快与您取得联系。</p>
     <table id="bank" cellpadding="0" cellspacing="0">
          <tr>
            <td rowspan="3" class="td3"><img src="/res/jskxcbs/structure/icbc.png" /></td>
            <td class="td1">收款人：</td>
            <td class="td2">军事科学出版社</td>
          </tr>
          <tr>
            <td class="td1">卡号：</td>
            <td class="td2">0200004509008681215</td>
          </tr>
          <tr>
            <td class="td1">开户行：</td>
            <td class="td2">中国工商银行北京厢红旗支行</td>
          </tr>
      </table>
      <p class="p1"><img src="/res/jskxcbs/structure/jt00.png" /></p>
      <p class="p1">完成订单</p>
      <p class="p2">待您把付款信息提交后，我们核对好金额无误后，会在第一时间为您发货，请您耐心等待收货。</p>
</div>
<div id="sp">
    <!--<img src="/res/jskxcbs/structure/tjdd.jpg" />-->
    <a href="<%=nexturl%>" class="gw">继续购物</a>
    <a href="/html/jskxcbs/folder/14010980-1.htm" class="Dd">查看我的订单</a>
</div>