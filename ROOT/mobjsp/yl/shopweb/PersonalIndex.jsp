<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.Http"%>
<%@ page import="tea.entity.member.Profile" %>
<%
    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }
    Profile p1 = Profile.find(h.member);
%>
<html>
<head>
    <title>个人中心</title>
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
    <script src="/tea/mt.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=0">
</head>
<body>
    <div class="body">
        <div class="Content">
            <div class="person-con1">
                <p class="ft16 person-con1-tit">粒子订单</p>
                <ul class="person-con1-ul">
                    <li class="fl-left mr-b15">
                        <a href="/mobjsp/yl/shopweb/ShopOrdersNew.jsp" class="ft14">
                            <span class="person-iconi">
                                <em class="ft14">1</em>
                                <img src="/tea/mobhtml/img/icon3.png" alt="">
                            </span>
                            <span class="person-icont">粒子订单</span>
                        </a>
                    </li>
                    <li class="fl-left mr-b15">
                        <a href="/mobjsp/yl/shopweb/ShopExchangedListNew.jsp" class="ft14">
                            <span class="person-iconi">
                                <em class="ft14">1</em>
                                <img src="/tea/mobhtml/img/icon4.png" alt="">
                            </span>
                            <span class="person-icont">我的退货</span>
                        </a>
                    </li>
                    <li class="fl-right mr-b15">
                        <a href="/mobjsp/yl/shopweb/ListInvoice.jsp" class="ft14">
                            <span class="person-iconi">
                                <em class="ft14">1</em>
                                <img src="/tea/mobhtml/img/icon5.png" alt="">
                            </span>
                            <span class="person-icont">发票管理</span>
                        </a>
                    </li>
                    <li class="fl-left">
                        <a href="/mobjsp/yl/shopweb/ListReplyMoney.jsp" class="ft14">
                            <span class="person-iconi">
                                <em class="ft14">1</em>
                                <img src="/tea/mobhtml/img/icon6.png" alt="">
                            </span>
                            <span class="person-icont">回款管理</span>
                        </a>
                    </li>
                    <li class="fl-left con1-ul-m">
                        <a href="/mobjsp/yl/shopweb/ListCharge.jsp" class="ft14">
                            <span class="person-iconi">
                                <em class="ft14">1</em>
                                <img src="/tea/mobhtml/img/icon7.png" alt="">
                            </span>
                            <span class="person-icont">通知单</span>
                        </a>
                    </li>
                    <li class="fl-right">
                        <a href="/mobjsp/yl/shopweb/ListUrged.jsp" class="ft14">
                            <span class="person-iconi">
                                <em class="ft14">1</em>
                                <img src="/tea/mobhtml/img/icon8.png" alt="">
                            </span>
                            <span class="person-icont">催缴记录</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="person-con2">
                <a href="/mobjsp/yl/shopweb/TPSOrdersNew.jsp" class="per-con2-a bor-b">
                    <span class="fl-left ft16">TPS订单</span>
                    <img src="/tea/mobhtml/img/icon9.png" class="fl-right" alt="">
                </a>
                <a href="/mobjsp/yl/shopweb/TPSOrders.jsp?orderType=2" class="per-con2-a">
                    <span class="fl-left ft16">设备耗材订单</span>
                    <img src="/tea/mobhtml/img/icon9.png" class="fl-right" alt="">
                </a>
            </div>
            <div class="person-con2">
                <%if(p1.getMembertype()==2){%>
                <a href="/mobjsp/yl/shopweb/Empower.html" class="per-con2-a bor-b">
                    <span class="fl-left ft16">医院管理</span>
                    <img src="/tea/mobhtml/img/icon9.png" class="fl-right" alt="">
                </a>
                <%}%>
                <%if(p1.getMembertype()==2){%>
                <a href="/mobjsp/yl/shopweb/MeetingManage.jsp" class="per-con2-a bor-b">
                    <span class="fl-left ft16">会议管理</span>
                    <img src="/tea/mobhtml/img/icon9.png" class="fl-right" alt="">
                </a>
                <%}%>
                <%if(p1.getMembertype()==1){%>
                <a href="/mobjsp/yl/shopweb/G-PersonalIntegral.html" class="per-con2-a">
                    <span class="fl-left ft16">我的积分</span>
                    <img src="/tea/mobhtml/img/icon9.png" class="fl-right" alt="">
                </a>
                <%}%>
            </div>
            <div class="person-con2">
                <a href="/mobjsp/yl/shopweb/PersonalAccount.jsp" class="per-con2-a ">
                    <span class="fl-left ft16">账户管理</span>
                    <img src="/tea/mobhtml/img/icon9.png" class="fl-right" alt="">
                </a>
                <a href="/mobjsp/yl/shopweb/PersonalCenter.jsp" class="per-con2-a">
                    <span class="fl-left ft16">申请服务商/医生</span>
                    <img src="/tea/mobhtml/img/icon9.png" class="fl-right" alt="">
                </a>
            </div>
            <div class="person-con2"><!--href="/servlet/Logout?nexturl=/mobjsp/yl/user/login_wx.jsp"-->
                <a onclick="logout()" class="per-con2-a">
                    <span  style='text-align:center;width:100%;' class="fl-left ft16">退出登录</span>
                </a>
            </div>
        </div>
    </div>
<script src="/tea/mobhtml/js/jquery.min.js"></script>
<script src="/tea/mobhtml/js/m-home.js"></script>
<script>
    mt.fit();
    function logout(){
        localStorage.clear();
        mt.show("是否确认退出登录？",2);
        mt.ok = function(){
            mt.send("/mobjsp/yl/shop/ajax.jsp?act=logoutopenid", function(data) {
                data = eval('(' + data + ')');
                if(data.type=='1'){
                    mt.show("操作成功！");
                    mt.ok = function(){
                        location = '/mobjsp/yl/user/login_mob.html';
                    }
                }
            });
        }
    }
</script>
</body>
</html>
