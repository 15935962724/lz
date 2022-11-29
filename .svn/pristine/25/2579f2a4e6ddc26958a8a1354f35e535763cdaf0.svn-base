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
        .con-left .bd:nth-child(2){
            display:block;
        }
        .con-left .bd:nth-child(2) li:nth-child(1){
            font-weight: bold;
        }
    </style>
</head>
<body style='min-height:800px;'>
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
    <div class="con-left">
        <%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
    </div>
    <div class="con-right">
        <div class="con-right-box">
            <div class="right-line1">
                <p>
                    <span class="right-box-tit">订单编号：</span>
                    <input type="text" class="right-box-inp" name="orderId"/>
                    <span class="right-box-tit" style="margin-left:19px;">购买方式：</span>
                    <select name='puid' style="width:342px;"  class="right-box-yy">
                        <option value=''>请选择</option>
                    </select>
                </p>
            </div>
            <input type="submit" class="right-search" value="查询">
        </div>
        <div class="right-list">
            <table class="right-tab" border="1" cellspacing="0">
                <tr>
                    <th class="th2">序号</th>
                    <th>订单编号</th>
                    <th>购买方式</th>
                    <th>开票状态</th>
                    <th>单价</th>
                    <th>下单时间</th>
                    <th>支付方式</th>
                    <th>激活码/授权码</th>
                    <th>订单状态</th>
                    <th>操作</th>
                </tr>
            </table>
        </div>
    </div>
</div>
</body>
</html>