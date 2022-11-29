<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.member.Profile"%>
<%
    Http h1=new Http(request,response);
    int member1 = h1.member;
    if(member1<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }
    Profile p1 = Profile.find(member1);
%>
<%--<%if(p1.membertype != 0){%>服务商和签收人都要看到页面--%>
<h4 class="con-left-list">
    <a class='tit-on1'>粒子订单</a>
    <em></em>
</h4>
<ul class="bd h-line4-ul">
    <li><a href="/jsp/yl/shopweb/ShopOrders.jsp">粒子订单</a></li>
    <li><a href="/jsp/yl/shopweb/ShopExchangedList.jsp">我的退货</a></li>
    <li><a href="/jsp/yl/shopwebnew/ListInvoice.jsp">发票管理</a></li>
    <li><a href="/jsp/yl/shopwebnew/ListReplyMoney.jsp">回款管理</a></li>
    <li><a href="/jsp/yl/shopwebnew/ListCharge.jsp">通知单</a></li>
    <li><a href="/jsp/yl/shopwebnew/ListUrged.jsp">催缴记录</a></li>
</ul>
<%--<%}%>--%>

<h4 class="con-left-list">
    <%--<a class='tit-on2' href="/jsp/yl/shopweb/TPSOrders.jsp?orderType=1">TPS订单管理</a>--%>
        <a class='tit-on2' href="/jsp/yl/shopweb/TPSOrdersNew.jsp?orderType=1">TPS订单管理</a>
</h4>
<ul class="bd h-line4-ul"></ul>

<h4 class="con-left-list">
    <a class='tit-on3' href="/jsp/yl/shopweb/TPSOrders.jsp?orderType=2">设备/耗材订单</a>
</h4>
<ul class="bd h-line4-ul"></ul>

<%
    if(p1.membertype == 1){
        %>

<h4 class="con-left-list">
    <a class='tit-on4' href="/jsp/yl/shopweb/ShopPoint.jsp">我的积分</a>
</h4>
<ul class="bd h-line4-ul"></ul>

<%
    }
%>

<%if(p1.membertype == 2){%>
<h4 class="con-left-list">
    <a class='tit-on5' href="/jsp/yl/shopweb/Empower.jsp">医院管理</a>
</h4>
<ul class="bd h-line4-ul"></ul>
<%}%>

<%if(p1.membertype == 2){%>
<h4 class="con-left-list">
    <a class='tit-on6' href="/jsp/yl/shopweb/MeetingManage.jsp">会议管理</a>
</h4>
<ul class="bd h-line4-ul"></ul>
<%}%>


<%if(p1.membertype == 2){%>
<h4 class="con-left-list">
    <a class='tit-on7' href="/jsp/yl/recall/list.jsp">召回管理</a>
</h4>
<ul class="bd h-line4-ul"></ul>
<%}%>

<h4 class="con-left-list">
    <a class='tit-on8'>帐户管理</a>
    <em></em>
</h4>
<ul class="bd h-line4-ul">
    <li><a href="/jsp/yl/shopweb/UpProfile.jsp">基本信息</a></li>
    <li><a href="/jsp/yl/shopweb/PersonalAddress.jsp">收货地址</a></li>
    <li><a href="/jsp/yl/shopweb/SecuritySetting.jsp">安全设置</a></li>
</ul>
<%if(p1.membertype==2){%>
<%--<h4 class="con-left-list">
    <a class='tit-on8'>销量统计</a>
    <em></em>
</h4>
<ul class="bd h-line4-ul">
    <li><a href="/jsp/yl/shopweb/FuWuShangTongJi.jsp?type=1">服务商销量按年份</a></li>
    <li><a href="/jsp/yl/shopweb/FuWuShangTongJi.jsp?type=2">服务商销量按月份</a></li>
    <li><a href="">医院销量</a></li>
</ul>--%>
<%}%>
<script>
$(".con-left .con-left-list").click(function(){
    if($(this).next($('ul')).css('display')=='block'){
        $(this).next($('ul')).slideUp();
    }else{
        $(".con-left ul").slideUp().removeClass('on');
        $(this).next($('ul')).slideDown().addClass('on');
    }
})

</script>