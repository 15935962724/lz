<%@page import="tea.db.DbAdapter" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Database" %>
<%@page import="tea.entity.Http" %>
<%@page import="tea.entity.MT" %>
<%@page import="tea.entity.member.Profile" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        String param = request.getQueryString();
        String url = request.getRequestURI();
        if (param != null)
            url = url + "?" + param;
        response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
        return;
    }

    int orderType = h.getInt("orderType");
    int menu = h.getInt("id");
    StringBuffer sql = new StringBuffer(), par = new StringBuffer("?");
    par.append("&menu=" + menu);


    sql.append(" AND fws_id=" + h.member);
    par.append("&member=" + h.member);



    String orderId = h.get("orderId", "");
    if (orderId.length() > 0) {
        sql.append(" AND order_id =" + Database.cite(orderId));
        par.append("&orderId=" + orderId);
    }

    Date time0 = h.getDate("time0");
    if (time0 != null) {
        sql.append(" AND createtime>=" + DbAdapter.cite(time0));
        par.append("&time0=" + MT.f(time0));
    }
    Date time1 = h.getDate("time1");
    if (time1 != null) {
        sql.append(" AND createtime<=" + DbAdapter.cite(time1));
        par.append("&time1=" + MT.f(time1));
    }


    String[] TAB = {"全部订单", "已下单", "已推送", "已完成"};
    String[] SQL = {"  ", " AND status=1", " AND status=2", " AND status=3"};
    int tab = h.getInt("tab", 0);
    par.append("&tab=" + tab);

    int pos = h.getInt("pos");
    par.append("&pos=");


%><!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=0">
    <title><%= (orderType==1?"TPS":"设备")%>订单</title>

    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
</head>
<body>

<div class="body">
    <form name="form1" action="?">
        <input type="hidden" name="id" value="<%=menu%>"/>
        <input type="hidden" name="tab" value="<%=tab%>"/>
        <input type="hidden" name="orderType" value="<%=h.getInt("orderType")%>">
        <div class="order-sea">
            <div class="order-sea-left fl-left">
                <p>
                    <span class="ft14 order-l-span">订单编号：</span>
                    <input type="text" class="right-box-inp" name="orderId" value="<%=MT.f(orderId)%>"/>
                </p>
                <p>
                    <span class="ft14 order-l-span">订单时间：</span>
                    <span class="time">
                        <input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
                        <span style="">~</span>
                        <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
                    </span>
                </p>
            </div>
            <input type="submit" class="fl-right order-cxb order-cxb2 ft14" value="查询">
        </div>

    </form>

    <div class="order-lx">
        <%
            out.print("<ul>");
            for (int i = 0; i < TAB.length; i++) {
                out.print("<li class='ft14 fl-left " + (i == tab ? "on" : "") + "'><a href='javascript:mt.tab(" + i + ")'>" + TAB[i] + "(" + TpsOrder.count(sql.toString() + SQL[i]) + ")</a></li>");
            }
            out.print("</ul>");
        %>
    </div>

    <form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
        <input type="hidden" name="orderId"/>
        <input type="hidden" name="status"/>
        <input type="hidden" name="cancelReason"/>
        <input type="hidden" name="tab" value="<%=tab%>"/>
        <input type="hidden" name="nexturl"/>
        <input type="hidden" name="act"/>


        <%
            sql.append(SQL[tab]);
            System.out.println(sql.toString());
            int sum = TpsOrder.count(sql.toString());
            if (sum < 1) {
                out.print("<p class='text-c'>暂无记录!</p>");
            } else {
                //sql.append(" order by createDate desc");
                Iterator it = TpsOrder.find(sql.toString() + " order by id desc ", pos, 20).iterator();
                for (int i = 1 + pos; it.hasNext(); i++) {
                    TpsOrder t = (TpsOrder) it.next();
                    Profile profile = Profile.find(t.getConsignees_id());
        %>
        <div class="order-list">
            <p class="order-line1 ft14">
                <span class="fl-left order-tit"><%=MT.f(ShopHospital.find(t.getHospital_id()).getName()) %></span>
                <span class="fl-right order-zt"><%=t.getStatus()==1?"已下单":t.getStatus()==2?"已推送":"已完成"%></span>
            </p>
            <ul class="ft14">
                <li>
                    <span class="list-spanr5 fl-left">订单编号：</span>
                    <span class="list-spanr fl-left"><%=t.getOrder_id()%></span>
                </li>
                </li>
                <li>
                    <span class="list-spanr5 fl-left">类别：</span>
                    <span class="list-spanr fl-left"><%=t.getXdms()%></span>
                </li>
                <li>
                    <span class="list-spanr5 fl-left">规格：</span>
                    <span class="list-spanr fl-left"><%=t.getHpcs()%></span>
                </li>
                <li>
                    <span class="list-spanr5 fl-left">收货人：</span>
                    <span class="list-spanr fl-left"><%= profile.getMember()%></span>
                </li>
                <li>
                    <span class="list-spanr5 fl-left">邮箱：</span>
                    <span class="list-spanr fl-left"><%= t.getEmail()%></span>
                </li>
                <li>
                    <span class="list-spanr5 fl-left">下单时间：</span>
                    <span class="list-spanr fl-left"><%= MT.f(t.getCreatetime(),1)%></span>
                </li>

            </ul>
            <p class="order-btnp">
                <%
                    if(t.getStatus()==1){
                        out.println("<a class='btn' href=\"javascript:mt.act('submitsbm','"+t.getId()+"');\">提交设备码</a>");
                    }
                    out.println("<a class='btn' href=\"javascript:mt.act('detail','"+t.getId()+"');\">查看详情</a>");
                %>
            </p>
        </div>

        <%
                }
                if (sum > 5)
                    out.print("<div id='ggpage'>" + new tea.htmlx.FPNL(h.language, par.toString(), pos, sum, 5) + "</div>");
            }
        %>


        <%
            Profile pro = Profile.find(h.member);
            if (pro.getMembertype() == 2) {
                sql.append(" AND isLzCategory=1");
                sql.append(" order by createDate desc");
        %>
        <!--div class='center text-c pd20'><button class="btn btn-primary btn-blue" type="button" onclick="dcorder()">导出</button></div-->
        <%} %>

    </form>


</div>
<script>
    form2.nexturl.value = location.pathname + location.search;
    mt.act = function (a, orderId, status, statusContent) {
        form2.act.value = a;
        form2.orderId.value = orderId;
        if (a == 'detail') {
            location.href="/mobjsp/yl/shopweb/ShopTpsOrderDatasNew.jsp?orderId="+orderId;
        }else if (a == "submitsbm"){
            mt.show('请在电脑端提交设备码！');
        }
    };

</script>
</body>
</html>
