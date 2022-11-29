<%@page import="util.Config" %>
<%@page import="tea.db.DbAdapter" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@ page import="tea.ui.yl.shop.ShopTps" %>
<%@ page import="tea.entity.member.Profile" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }


    int orderId = h.getInt("orderId");
    //根据订单id查询订单信息
    TpsOrder tpsOrder = TpsOrder.find(orderId);


%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=0">
    <title>TPS订单</title>


    <!-- <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
		-->
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <script src="/tea/view.js" type="text/javascript"></script>
    <script src="/tea/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>

</head>
<style>
    .order-sq {
        float: right;
        color: #f25f1c;
        cursor: pointer;
    }
    .detail-list .list-spanr3 {
        width: 125px;
        text-align: right;
    }
</style>
<body>

<div class="body">
    <div class="detail-list">
        <p class="detail-tit ft16">订单信息<em class='order-sq'></em></p>
        <ul class="ft14">
            <li>
                <span class="list-spanr3 fl-left">订单编号：</span>
                <span class="list-spanr fl-left"><%=MT.f(tpsOrder.getOrder_id())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">下单时间：</span>
                <span class="list-spanr fl-left"><%=MT.f(tpsOrder.getCreatetime(),1)%></span></li>
            <li>
                <span class="list-spanr3 fl-left">当前状态：</span>
                <span class="list-spanr fl-left"><%=MT.f(tpsOrder.getStatus()==1?"已下单":tpsOrder.getStatus()==2?"已推送":"已获取") %></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">支付方式：</span>
                <span class="list-spanr fl-left">抵扣</span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">医院名称：</span>
                <span class="list-spanr fl-left"><%= MT.f(ShopHospital.find(tpsOrder.getHospital_id()).getName())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">收货人姓名：</span>
                <span class="list-spanr fl-left"><%=MT.f(Profile.find(tpsOrder.getConsignees_id()).member) %></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">邮箱号：</span>
                <span class="list-spanr fl-left"><%=MT.f(tpsOrder.getEmail()) %></span></li>
            <li>
                <span class="list-spanr3 fl-left">类别：</span>
                <span class="list-spanr fl-left"><%=MT.f(tpsOrder.getXdms()) %></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">规格：</span>
                <span class="list-spanr fl-left"><%=MT.f(tpsOrder.getHpcs())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">机器码：</span>
                <span class="list-spanr fl-left"><%= MT.f(tpsOrder.getJqm())%></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">机器码提交时间：</span>
                <span class="list-spanr fl-left"><%= MT.f(tpsOrder.getJqmtime(),1) %></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">激活码：</span>
                <span class="list-spanr fl-left"><%= MT.f(tpsOrder.getJhm()) %></span>
            </li>
            <li>
                <span class="list-spanr3 fl-left">激活码获取时间：</span>
                <span class="list-spanr fl-left"><%= MT.f(tpsOrder.getGetjhmtime(),1) %></span>
            </li>
        </ul>
    </div>


    </form>
</div>
</div>
<script>
    $('.order-sq').click(function () {
        if ($(this).parent().next().is(":hidden")) {
            $(this).html('收起');
            $(this).parent().next().slideDown();
        } else if ($(this).parent().next().is(":visible")) {
            $(this).html('展开');
            $(this).parent().next().slideUp();
        }
    })

    form2.nexturl.value = location.pathname + location.search;
    mt.act = function (a, oid, did) {
        if (a == 'refund') {
            location.href = "/jsp/yl/shopweb/ShopExchangedAdd.jsp?oid=" + oid + "&did=" + did;
        }
    };

    function printView(orderId) {
        window.open("/html/folder/14110866-1.htm?orderId=" + orderId);
    };
    mt.fit();
</script>
</body>
</html>
