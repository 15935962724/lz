<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.Profile" %>
<%@ page import="util.Config" %>
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



    String meet_name = h.get("meet_name","");
    if (meet_name.length() > 0) {
        sql.append(" AND name LIKE " + Database.cite("%" + meet_name + "%"));
        par.append("&meet_name=" + h.enc(meet_name));
    }

    Date time0 = h.getDate("time0");
    if (time0 != null) {
        sql.append(" AND create_Data>" + DbAdapter.cite(time0));
        par.append("&time0=" + MT.f(time0));
    }
    Date time1 = h.getDate("time1");
    if (time1 != null) {
        sql.append(" AND create_Data<" + DbAdapter.cite(time1));
        par.append("&time1=" + MT.f(time1));
    }


    Profile p=null;
    String member = h.get("member", "");
    if (member.length() > 0) {
         p= Profile.find(member);
        if(p!=null){
            sql.append(" AND member=" + p.getProfile());
            par.append("&member=" + p.getProfile());
        }

    }

    String[] TAB = {"全部会议", "未审核", "已确认", "已退回","已取消"};
    String[] SQL = {" ", "  AND type=0 ", " AND type=1 ", " AND type=2 ","AND type=3"};
    String[] type1 = {"未审核","审核通过","审核不通过","已取消"};

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
<h1>会议管理</h1>

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
                <td nowrap="">会议名称：<input name="meet_name" value="<%=MT.f(meet_name)%>"/></td>
                <td nowrap="">用户名称：<input name="member" value="<%=MT.f(member)%>"/></td>
                <td nowrap="">会议申请时间：<input name="time0" value="<%=MT.f(time0)%>" onclick="mt.date(this)" class="date"/> 至
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
        out.print("<a href='javascript:mt.tab(" + i + ")' class='" + (i == tab ? "current" : "") + "'>" + TAB[i] + "（" + TbMeeting.count(sql.toString() + SQL[i]) + "）</a>");
    }
    out.print("</div>");
%>
<form name="form2" action="/TbMeetings.do" method="post" target="_ajax">
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
                <th>会议名称</th>
                <th>申请时间</th>
                <th>申请人</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            <%
                sql.append(SQL[tab]);
                int sum = TbMeeting.count(sql.toString());
                if (sum < 1) {
                    out.print("<tr><td colspan='10' class='noCont'>暂无记录!</td></tr>");
                } else {
                    Iterator it = TbMeeting.find(sql.toString() + " order by create_Data desc ", pos, 20).iterator();
                    for (int i = 1 + pos; it.hasNext(); i++) {
                        TbMeeting t = (TbMeeting) it.next();


            %>
            <tr>
                <td><%=i%></td>
                <td><%=MT.f(t.getName())%></td>
                <td><%=MT.f(t.getCreate_Data())%></td>
                <td><%=MT.f(Profile.find(t.getMember()).getMember())%></td>
                <td><%=type1[t.getType()]%></td>
                <td>
                    <button type="button" class="btn btn-link" onclick="mt.act('data','<%=t.getId()%>')">查看详情</button>
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
    <%--<div class='center mt15'>
        <button class="btn btn-primary" type="button" onclick="dcorder()">导出</button>
    </div>--%>
</form>
<form action="/ShopOrders.do" name="form3" method="post" target="_ajax">
    <input name="act" value="exp_sh" type="hidden"/>
    <input name="exflag" value="0" type="hidden"/>
    <input type='hidden' name='category' value="2">
    <input type='hidden' name="sql" value="<%= sql.toString() %>"/>
</form>
<script>
    form2.nexturl.value = location.pathname + location.search;
    mt.act = function (a, id, status, statusContent) {
        form2.act.value = a;
        form2.orderId.value = id;
        if (a == 'del') {
            mt.show('你确定要删除吗？', 2, 'form2.submit()');
        } else if (a == 'status') {
            form2.status.value = status;
            mt.show('你确定要“' + statusContent + '”吗？', 2, 'form2.submit()');
        } else if (a == 'data') {
           location.href="/jsp/yl/shop/MeetingEdit.jsp?id="+id;
        } else if (a == 'payment') {
            mt.show('你确定要“确认收款”吗？', 2, 'form2.submit()');
        } else if (a == 'exp') {
            form2.soeid.value = status;
            form2.type.value = statusContent;
            form2.action = ("/jsp/yl/shop/ShopExpressEdit.jsp");
            form2.target = '_self';
            form2.method = 'get';
            form2.submit();
        } else if (a == 'updateremarks') {
            mt.show("<textarea id='_content' cols='33' rows='6' title='备注'>" + statusContent + "</textarea>", 2, '备注', 348);
            mt.ok = function () {
                var t = $$('_content');
                /* if(t.value=='')
                {
                  alert('“取消订单原因”不能为空！');
                  return false;
                } */
                form2.remarks.value = t.value;
                form2.submit();
            };
        } else if (a == 'orderPayment') {
            mt.show('你确定要支付吗？', 2, 'form2.submit()');
        } else if (a == 'chushen') {
            form2.soeid.value = status;
            form2.type.value = statusContent;
            form2.action = ("/jsp/yl/shop/ShopExpressChuShen.jsp");
            form2.target = '_self';
            form2.method = 'get';
            form2.submit();
        } else if (a == 'chakan') {
            form2.soeid.value = status;
            form2.type.value = statusContent;
            form2.action = ("/jsp/yl/shop/ShopExpressShow.jsp");
            form2.target = '_self';
            form2.method = 'get';
            form2.submit();
        } else if (a == 'fuhe') {
            form2.soeid.value = status;
            form2.type.value = statusContent;
            form2.action = ("/jsp/yl/shop/ShopExpressFuHe.jsp");
            form2.target = '_self';
            form2.method = 'get';
            form2.submit();
        } else if (a == 'chuku') {
            form2.action = "/ShenheChuku.do";
            mt.show('你确定要出库吗？', 2, 'form2.submit()');
        }
    };

    function dcorder() {
        form3.submit();
    }

    form4.test.value = "123";
</script>
</body>
</html>
