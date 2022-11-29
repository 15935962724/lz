<%--
  Created by IntelliJ IDEA.
  User: zyj32
  Date: 2019/7/18
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*"%>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.db.DbAdapter" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }


%>
<html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=0">
    <title>账号设置</title>
    <script src="/tea/mt.js"></script>
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
</head>
<body>
    <div class="body">
        <div class="Content">
            <div class="person-con3">
                <a href="/mobjsp/yl/shopweb/UpProfile.jsp" class="per-con2-a bor-b">
                    <span class="fl-left ft16">基本信息</span>
                    <img src="/tea/mobhtml/img/icon9.png" class="fl-right" alt="">
                </a>
                <a href="/mobjsp/yl/shopweb/G-PersonalAddressSetting.jsp" class="per-con2-a bor-b">
                    <span class="fl-left ft16">收货地址</span>
                    <img src="/tea/mobhtml/img/icon9.png" class="fl-right" alt="">
                </a>
                <a href="/mobjsp/yl/shopweb/G-PersonalSecuritySetting.jsp" class="per-con2-a">
                    <span class="fl-left ft16">安全设置</span>
                    <img src="/tea/mobhtml/img/icon9.png" class="fl-right" alt="">
                </a>
            </div>
        </div>
    </div>
</body>
</html>
<script>
    mt.fit();
</script>
