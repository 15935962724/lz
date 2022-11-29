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
        .con-left-list .tit-on6{color:#044694;}

    </style>
</head>
<body style='min-height:800px;'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
    <div class="con-left">
        <%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
    </div>
    <div class="con-right">
        <p class="right-zhgl right-zhgl2" style="line-height:40px;height:40px;">
            <span>会议申请</span>

        </p>
        <table class='meet-tab'>
            <tr>
                <td class='td1'>会议名称：</td>
                <td>学术会议</td>
            </tr>
            <tr>
                <td class='td1'>会议通知：</td>
                <td>xxx.pdf</td>
            </tr>
            <tr>
                <td class='td1'>招商函：</td>
                <td>xxx.jpg</td>
            </tr>
            <tr>
                <td class='td1'>会议申请表：</td>
                <td>xxx.pdf</td>
            </tr>
            <tr>
                <td class='td1'>状态：</td>
                <td>审核中</td>
            </tr>
            <tr>
                <td class='td1'>未通过原因：</td>
                <td style='color:red;'>电子件不清楚，请重新处理上传</td>
            </tr>
        </table>
        <p style='width:100%;text-align:center;'>
            <button class='meet-xg'>修改上传</button>
            <button class='meet-fh'>返回</button>
        </p>
    </div>

</div>
</body>
</html>