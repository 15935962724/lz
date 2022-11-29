<%@page import="util.Config"%>
<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.yl.shop.*"%><%@page import="tea.entity.member.Profile"%>
<%
    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>

    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <link rel="stylesheet" href="/tea/new/css/style.css">
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <style>
        /* .con-left .bd:nth-child(2){
            display:block;
        }
        .con-left .bd:nth-child(2) li:nth-child(1){
            font-weight: bold;
        } */
        .con-left-list .tit-on3{color:#044694;}

    </style>
</head>
<body style='min-height:800px;'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
    <div class="con-left">
        <%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
    </div>
    <div class="con-right">
        <div class="con-right-box con-right-box2">
            <div class="right-line1">
                <p>
                    <span>订单时间：</span>
					<input name="time0" value=""  class="right-box-data1"/>
					<span style="padding:0 8px">至</span>
					<input name="time1" value=""  class="right-box-data1"/>
                    <span class="right-box-tit">订单编号：</span>
                    <input type="text" class="right-box-inp" name="orderId"/>
                </p>
            </div>
            <input type="submit" class="right-search right-search2" value="查询">
        </div>
        <div class="right-list">
            <ul class="right-list-zt">
                <li>
                    <a href="###" class="current">全部订单(1)</a>
                </li>
                <li>
                    <a href="###" class="">待付款(1)</a>
                </li>
                <li>
                    <a href="###" class="">待发货(0)</a>
                </li>
                <li>
                    <a href="###" class="">待收货(7)</a>
                </li>
                <li>
                    <a href="###" class="">未开票(206)</a>
                </li>
                <li>
                    <a href="###" class="">已完成(206)</a>
                </li>
                <li>
                <a href="###" class="">已取消(5)</a>
                </li>
                <li>
                    <a href="###" class="">已退货(32)</a>
                </li>
            </ul>
            <table class="right-tab" border="1" cellspacing="0">
                <tr>
                    <th class="th2">序号</th>
                    <th>订单编号</th>
                    <th>设备名称</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>订单金额</th>
                    <th>支付方式</th>
                    <th>下单时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>
