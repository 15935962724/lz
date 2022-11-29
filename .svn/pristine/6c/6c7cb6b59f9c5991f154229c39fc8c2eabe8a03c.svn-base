<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Http" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.EmpowerRecord" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="java.util.List" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    StringBuffer sql = new StringBuffer(), par = new StringBuffer();
    int member = h.member;
    Profile p = Profile.find(member);
    String[] stateArr = {"<font color=blue>申请中</font>", "<font color=green>申请成功</font>", "<font color=red>申请失败</font>"};
    String[] uptypeArr = {"服务商", "vip"};


%>
<head>
    <%--<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
    <title>安全设置</title>--%>
        <title>安全设置</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,user-scalable=0">
        <script src='/tea/mt.js'></script>
        <script src='/tea/city.js'></script>
        <script src="/tea/tea.js" type="text/javascript"></script>
        <script src='/tea/jquery-1.3.1.min.js'></script>
        <script src="/tea/new/js/jquery.min.js"></script>
        <script src="/tea/new/js/superslide.2.1.js"></script>
        <script src="/tea/yl/mtDiag.js"></script>
        <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
</head>
<body>
    <div class="body">
        <!-- <div class="Header">
            <p class="header-tit ft18"><a href="" class="head-back"></a>账户管理<img src="img/icon2.png" alt="" class="head-list"></p>
        </div> -->
        <div class="Content">
            <div class="person-con4">
                <p href="" class="per-con3-a bor-b">
                    <span class="fl-left ft16 fcol-666">邮箱</span>
                    <!-- <span class="fl-right">123@qq.com</span> -->
                    <!-- 已绑定 -->
                    <%if(p.getEmail()==null||"".equals(p.getEmail())){%>
                    <span class="fl-right per-con3-yy" onclick=oncheckpage('email','绑定邮箱')>绑定邮箱</span>
                    <%}else {%>
                    <span class="fl-right per-con3-yy" onclick=oncheckpage('email','绑定邮箱')><%=p.getEmail()%>修改</span>
                    <%}%>

                </p>
                <p href="" class="per-con3-a bor-b">
                    <span class="fl-left ft16 fcol-666">手机号码</span>
                    <span class="fl-right"><%=MT.f(p.mobile)%></span>
                    
                </p>
                <p href="" class="per-con3-a">
                    <span class="fl-left ft16 fcol-666">登录密码</span>
                    <img src="/tea/mobhtml/img/icon10.png" class="fl-left per-mm" alt="">
                    <span class="fl-right per-con3-yy" onclick=oncheckpage('editPW','修改密码')>******修改</span>
                </p>
            </div>
        </div>
        <!-- <div class="Footer bor-t">
            <a href="" class="fl-left">
                <img src="img/foot1-1.png" alt="">
                <span class="ft14">首页</span>
            </a>
            <a href="" class="fl-left">
                <img src="img/foot2-2.png" alt="">
                <span class="ft14">产品</span>
            </a>
            <a href="" class="fl-left">
                <img src="img/foot3-2.png" alt="">
                <span class="ft14">我的</span>
            </a>
        </div> -->
    </div>
<script>
    function oncheckpage(type, tit) {
        layer.open({
            type: 2,
            title: tit,
            shadeClose: true,
            area: ['90%', '270px'],
            closeBtn: 1,
            /* content: '/jsp/yl/shopweb/ShopEmailMobile.jsp?type=' + type*/
            content: '/jsp/yl/shopweb/ShopCheckEmaiupdate.jsp?type='+type+"&nexturl=/mobjsp/yl/shopweb/G-PersonalSecuritySetting.jsp"
        });
        //location = '/jsp/yl/shopweb/ShopEmailMobile.jsp?type='+type;
    }
    function edit_pw(type) {
        layer.open({
            type: 2,
            title:"修改密码",
            shadeClose: true,
            rea: ['90%', '270px'],
            closeBtn:1,
            //content: '/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type='+type
            content: '/jsp/yl/shopweb/ShopCheckEmaiupdate.jsp?type='+type+"&nexturl=/mobjsp/yl/shopweb/G-PersonalSecuritySetting.jsp"
        });
    }
</script>
</body>
</html>