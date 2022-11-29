<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.entity.member.Profile" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    if (h.isIllegal()) {
        out.println("非法操作！");
        return;
    }

    int menu = h.getInt("id");
    StringBuffer sql = new StringBuffer(), par = new StringBuffer();

    par.append("?id=" + menu);


    String order_id = h.get("order_id", "");
    if (order_id.length() > 0) {
        sql.append(" AND order_id LIKE " + Database.cite("%" + order_id + "%"));
        par.append("&order_id=" + h.enc(order_id));
    }

    Date time0 = h.getDate("time0");
    if (time0 != null) {
        sql.append(" AND createtime>" + DbAdapter.cite(time0));
        par.append("&time0=" + MT.f(time0));
    }
    Date time1 = h.getDate("time1");
    if (time1 != null) {
        sql.append(" AND createtime<" + DbAdapter.cite(time1));
        par.append("&time1=" + MT.f(time1));
    }


    String hospital = h.get("hospital", "");
    if (!"".equals(hospital)) {
        ShopHospital hospital1 = ShopHospital.find(hospital);
        if(hospital1.getId()>0){
            sql.append(" AND  hospital_id="+hospital1.getId() );
        }else {
            sql.append(" AND 1=0 ");
        }
        par.append("&hospital=" + h.enc(hospital));
    }

    String[] TAB = {"全部订单", "已下单", "已推送", "已完成"};
    String[] SQL = {" ", "  AND status= 1", " AND status=2  ", " AND status=3  "};

    int tab = h.getInt("tab", 0);
    par.append("&tab=" + tab);

    int pos = h.getInt("pos");
    par.append("&pos=");


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
</head>
<body>
<h1>订单管理</h1>

<form name="form1" action="?">
    <input type="hidden" name="id" value="<%=menu%>"/>
    <input type="hidden" name="tab" value="<%=tab%>"/>
    <div class='radiusBox'>
        <table id="tdbor" cellspacing="0" class='newTable'>
            <thead>
            <tr>
                <td colspan='6' class='bornone'>查询</td>
            </tr>
            </thead>
            <tr>
                <td nowrap="">订单编号：<input name="order_id" value="<%=MT.f(order_id)%>"/></td>
                <td nowrap="">医院：<input name="hospital" value="<%=MT.f(hospital)%>"/></td>
                <td nowrap="">订单时间：<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> 至
                    <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="date"/></td>
                <td class='bornone'>
                    <button class="btn btn-primary" type="submit">查询</button>
                </td>
            </tr>
        </table>
    </div>
</form>
<%
    out.print("<div class='switch'>");
    for (int i = 0; i < TAB.length; i++) {
        out.print("<a href='javascript:mt.tab(" + i + ")' class='" + (i == tab ? "current" : "") + "'>" + TAB[i] + "（" + TpsOrder.count(sql.toString() + SQL[i]) + "）</a>");
    }
    out.print("</div>");
%>
<form name="form2" action="/ShopOrders.do" method="post" target="_ajax">
    <input type="hidden" name="orderId"/>
    <input type='hidden' name='soeid' value=''>
    <input type='hidden' name='type' value=''>
    <input type="hidden" name="status"/>
    <input type="hidden" name="tab" value="<%=tab%>"/>
    <input type="hidden" name="id" value="<%=menu %>"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>
    <input type='hidden' name='remarks'>
    <div class='radiusBox mt15'>
        <table id="" cellspacing="0" class='newTable'>
            <tr>
                <th width='60'>序号</th>
                <th>订单编号</th>
                <th>下单用户</th>
                <th>类别</th>
                <th>规格</th>
                <th>医院名</th>
                <th>收货人</th>
                <th>邮箱</th>
                <th>下单时间</th>

            </tr>
            <%
                sql.append(SQL[tab]);
                int sum = TpsOrder.count(sql.toString());
                if (sum < 1) {
                    out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
                } else {

                    Iterator it = TpsOrder.find(sql.toString() + " order by id desc ", pos, 20).iterator();
                    for (int i = 1 + pos; it.hasNext(); i++) {
                        TpsOrder t = (TpsOrder) it.next();

            %>
            <tr>
                <td><%=i%>
                </td>
                <td><%=t.getOrder_id()%>
                </td>
                <td><%=Profile.find(t.getFws_id()).getMember()%>
                </td>
                <td><%=t.getXdms()%>
                </td>
                <td><%=t.getHpcs()%>
                </td>
                <td><%=ShopHospital.find(t.getHospital_id()).getName()%>
                </td>
                <td><%=Profile.find(t.getConsignees_id()).getMember()%>
                </td>
                <td><%=t.getEmail()%>
                </td>
                <td><%=t.getCreatetime()%>
                </td>
            </tr>
            <%
                    }
                    if (sum > 20)
                        out.print("<tr><td colspan='10' align='right'>" + new tea.htmlx.FPNL(h.language, par.toString(), pos, sum, 20));
                }
            %>
        </table>
    </div>
</form>
</body>
</html>
