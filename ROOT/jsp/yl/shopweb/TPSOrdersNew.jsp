<%@page import="tea.db.DbAdapter" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Database" %>
<%@page import="tea.entity.Http" %>
<%@page import="tea.entity.MT" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    int menu = h.getInt("id");
    StringBuffer sql = new StringBuffer(), par = new StringBuffer("?");
    par.append("&menu=" + menu);

    sql.append(" AND fws_id=" + h.member);
    par.append("&member=" + h.member);

    String orderId = h.get("orderId", "");
    if (orderId.length() > 0) {
        sql.append(" AND order_Id LIKE " + Database.cite("%" + orderId + "%"));
        par.append("&orderId=" + h.enc(orderId));
    }


    Date time0 = h.getDate("time0");
    if (time0 != null) {
        sql.append(" AND createDate>" + DbAdapter.cite(time0));
        par.append("&createDate=" + MT.f(time0));
    }
    Date time1 = h.getDate("time1");
    if (time1 != null) {
        sql.append(" AND createDate<" + DbAdapter.cite(time1));
        par.append("&createDate=" + MT.f(time1));
    }

    String[] TAB = {"全部订单", "已下单", "已推送", "已完成"};
    String[] SQL = {"  ", " AND status=1", " AND status=2", " AND status=3"};

    int tab = h.getInt("tab", 0);
    par.append("&tab=" + tab);

    int pos = h.getInt("pos");
    par.append("&pos=");


%><!DOCTYPE html><html><head>


<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>

    .con-left-list .tit-on2 {
        color: #044694;
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
        <form name="form1" action="?">
            <input type="hidden" name="id" value="<%=menu%>"/>
            <input type="hidden" name="tab" value="<%=tab%>"/>
            <div class="con-right-box">
                <div class="right-line1">
                    <p>
                        <span class="right-box-tit">订单编号：</span>
                        <input type="text" class="right-box-inp" name="orderId" value="<%=MT.f(orderId)%>"/>
                        <span>订单时间：</span>
                        <input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="right-box-data1"/>
                        <span style="padding:0 8px">至</span>
                        <input name="time1" value="<%=MT.f(time1)%>" onclick="mt.date(this)" class="right-box-data1"/>
                    </p>
                </div>
                <input type="submit" class="right-search" value="查询">
            </div>
        </form>
        <div class="right-list">
            <%
                out.print("<ul class='right-list-zt'>");
                for (int i = 0; i < TAB.length; i++) {
                    out.print("<li><a href='javascript:mt.tab(" + i + ")' class='" + (i == tab ? "current" : "") + "'>" + TAB[i] + "(" + TpsOrder.count(sql.toString() + SQL[i]) + ")</a></li>");
                }
                out.print("</ul>");
            %>
            <form name="form2" action="/ShopTps.do" method="post" target="_ajax">
                <input type="hidden" name="orderId"/>
                <input type="hidden" name="status"/>
                <input type="hidden" name="jqm"/>
                <input type="hidden" name="tab" value="<%=tab%>"/>
                <input type="hidden" name="nexturl"/>
                <input type="hidden" name="act"/>
                <table class="right-tab" border="1" cellspacing="0">
                    <tr>

                        <th>序号</th>
                        <th>医院名</th>
                        <th>订单编号</th>
                        <th>类别</th>
                        <th>规格</th>
                        <th>收货人</th>
                        <th>邮箱</th>
                        <th>下单时间</th>
                        <th>操作</th>

                    </tr>
                    <%
                        sql.append(SQL[tab]);

                        int sum = TpsOrder.count(sql.toString());
                        if (sum < 1) {
                            out.print("<tr><td colspan='10' align='center'>暂无记录!</td></tr>");
                        } else {
                            //sql.append(" order by createDate desc");
                            Iterator it = TpsOrder.find(sql.toString() + " order by id desc ", pos, 20).iterator();
                            for (int i = 1 + pos; it.hasNext(); i++) {
                                TpsOrder t = (TpsOrder) it.next();
                                Profile profile = Profile.find(t.getConsignees_id());

                    %>
                    <tr>
                        <td><%=i%>
                        </td>
                        <td><%=ShopHospital.find(t.getHospital_id()).getName()%></td>
                        <td class="orderId"><%=t.getOrder_id()%>
                        </td>
                        <td><%=t.getXdms()%>
                        </td>
                        <td><%=t.getHpcs()%>
                        </td>
                        <td><%=profile.getMember()%>
                        </td>
                        <td><%=t.getEmail()%></td>
                        <td><%=MT.f(t.getCreatetime(),1)%></td>
                        <td><%if(t.getStatus()==1){
                            out.println("<a href=\"javascript:mt.act('submitsbm','" + t.getId() + "');\">提交设备码</a>");
                        }
                            out.println("<a href=\"javascript:mt.act('detail','" + t.getId() + "');\">查看详情</a>");

                        %></td>
                    </tr>
                    <%
                            }
                            if (sum > 20)
                                out.print("<tr><td colspan='10' id='ggpage' align='right'>" + new tea.htmlx.FPNL(h.language, par.toString(), pos, sum, 20));
                        }
                    %>
                </table>
            </form>
        </div>
    </div>
</div>


<script>
    form2.nexturl.value = location.pathname + location.search;
    mt.act = function (a, orderId) {
        form2.act.value = a;
        form2.orderId.value = orderId;
        if (a == 'submitsbm') {
            mt.show("<textarea id='_content' cols='33' rows='6' title='请填写机器码...'></textarea>",2,'机器码',348);
            mt.ok=function()
            {
                var t=parent.$$('_content');
                if(t.value=='')
                {
                    alert('机器码不能为空！');
                    return false;
                }
                form2.jqm.value=t.value;
                form2.submit();
            };
        }else if(a == "detail"){

            location.href = "/jsp/yl/shopweb/ShopTpsOrderDatas.jsp?ids="+orderId;
        }
    };
</script>
</body>
</html>
