<%@page import="util.Config" %>
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
    int member = h.member;

    String []str={"审核中","审核通过","审核未通过","已取消"};
    StringBuffer sql = new StringBuffer(), par = new StringBuffer("?");
    sql.append("AND member="+member);
    String meet_name = h.get("meet_name");//获取会议名称
    if(meet_name!=null){
        sql.append("AND name="+DbAdapter.cite(meet_name));
    }
    int tab = h.getInt("tab", 0);
    par.append("&tab=" + tab);
    String[] TAB = {"全部会议","审核中", "已通过","未通过","已取消"};
    String[] SQL = {" ", " AND type=0", " AND type=1", " AND type=2"," AND type=3"};

    if(tab!=0){
        sql.append(SQL[tab]);
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
        /* .con-left .bd:nth-last-child(2){
            display:block;
        }
        .con-left .bd:nth-child(2) li:nth-child(1){
            font-weight: bold;
        } */
        .con-left-list .tit-on6 {
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
        <p class="right-zhgl right-zhgl2" style="line-height:40px;height:40px;">
            <span>会议管理</span>
            <input <%--disabled='disabled'--%> type="button" onclick="location.href='/jsp/yl/shopweb/ApplyMeeting.jsp'" value="会议申请"
                   class="right-fp-inp" style='background:#8a8a8a'>
        </p>
        <form name="form1" action="?">
        <div class="con-right-box con-right-box2">
            <div class="right-line1">
                <p>
                    <span class="right-box-tit">会议名称：</span>
                    <input type="text" class="right-box-inp" name="meet_name" value="<%=MT.f(meet_name)%>"/>
                </p>
            </div>
            <input type="submit" class="right-search right-search2" value="查询">
        </div>
        </form>
        <div class="right-list">
            <%
                out.print("<ul class='right-list-zt'>");
                for (int i = 0; i < TAB.length; i++) {
                    out.print("<li><a href='javascript:mt.tab(" + i + ")' class='" + (i == tab ? "current" : "") + "'>" + TAB[i] +/* "(" + TbMeeting.count(sql.toString() + SQL[i]) + ")*/"</a></li>");
                }
                out.print("</ul>");
            %>
            <table class="right-tab" border="1" cellspacing="0">
                <tr>
                    <th class="th2">序号</th>
                    <th>会议名称</th>
                    <th>申请时间</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                <%

                    List<TbMeeting> list = TbMeeting.find(sql.toString(), 0, Integer.MAX_VALUE);
                    if(meet_name!=null){
                        list=TbMeeting.find(sql.toString(),0,Integer.MAX_VALUE);
                    }
                    int sum = list.size();
                    if (sum == 0) {//无记录%>
                <tr>
                    <td colspan="5">无记录</td>
                </tr>
                <%
                } else {
                    for (int i = 1; i < list.size() + 1; i++) {
                        TbMeeting tbMeeting = list.get(i - 1);

                %>
                <tr>
                    <td><%=i%></td>
                    <td><%=MT.f(tbMeeting.getName())%></td>
                    <td><%=MT.f(tbMeeting.getCreate_Data())%></td>
                    <td><%=str[tbMeeting.getType()]%></td>
                    <td>
                        <a onclick="xiangxi('<%=tbMeeting.getId()%>');">详细</a>
                        <%if(tbMeeting.getType()==2){//不通过%>
                        <a onclick="tuihui('<%=tbMeeting.getId()%>');">退回原因</a>
                        <%}%>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
                <%

                    if (sum > 20)
                    out.print("<tr><td colspan='10' id='ggpage' align='right'>" + new tea.htmlx.FPNL(h.language, par.toString(), 0, sum, 20));

                %>
            </table>
        </div>
    </div>
</div>
</body>
</html>
<script>
    function xiangxi(id) {
        location.href="/jsp/yl/shopweb/ApplyMeeting.jsp?id="+id+"&type=10";
        /*parent.window.location.reload();*/
    }
    function tuihui(id) {
        location.href="/jsp/yl/shopweb/ApplyMeeting.jsp?id="+id;

    }
    mt.tab=function(a)
    {
        location.href="/jsp/yl/shopweb/MeetingManage.jsp?tab="+a;
    };
</script>