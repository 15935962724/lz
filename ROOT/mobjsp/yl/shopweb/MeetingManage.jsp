<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.entity.yl.shop.TbMeeting" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.entity.MT" %>
<%
    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }
    int member = h.member;

    String []str={"审核中","审核通过","审核未通过","已取消"};
    StringBuffer sql = new StringBuffer(), par = new StringBuffer("?");
    sql.append("AND member="+member);
    String meet_name = h.get("meet_name");//获取会议名称
    if(meet_name!=null){
        sql.append("AND name="+ DbAdapter.cite(meet_name));
    }
    int tab = h.getInt("tab", 0);
    par.append("&tab=" + tab);
    String[] TAB = {"全部会议","审核中", "已通过","未通过","已取消"};
    String[] SQL = {" ", " AND type=0", " AND type=1", " AND type=2"," AND type=3"};

    if(tab!=0){
        sql.append(SQL[tab]);
    }
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
    <script src="/tea/mt.js" type="text/javascript"></script>
    <script src="/jsp/sup/sup.js" type="text/javascript"></script>
    <%--<link rel="stylesheet" href="/tea/new/css/style.css">--%>
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <title>会议管理</title>
</head>
<style>
.order-lx ul{width:200%;}
@media screen and (max-width: 321px){
.order-lx ul {
    width: 240%;
}}
</style>
<body>
    <div class="body">
        <div class="invoice">
            <input type="button" onclick="location.href='/mobjsp/yl/shopweb/MeetingContent.jsp'" value="会议申请" class="invoice-btn ft16">
        </div>
        <%--<form name="form1" action="?">
        <div class="con-right-box con-right-box2">
            <div class="right-line1">
                <p>
                    <span class="right-box-tit">会议名称：</span>
                    <input type="text" class="right-box-inp" name="meet_name" value="<%=MT.f(meet_name)%>"/>
                </p>
            </div>
            <input type="submit" class="right-search right-search2" value="查询">
        </div>
        </form>--%>
        <form name="form1" action="?">
        <div class="order-sea" style="margin-bottom: 10px;">
            <div class="order-sea-left fl-left">
                <p>
                    <span class="ft14 order-l-span">会议名称：</span>
                    <input type="text" name="meet_name" value="<%=MT.f(meet_name)%>">
                </p>
            </div>
            <input type="submit" class="fl-right order-cxb ft14" style='margin-top:12px;' value="查询">
        </div>


        </form>
        <div class="order-lx">
            <%out.print("<ul>");
                for(int i=0;i<TAB.length;i++)
                {
                    out.print("<li class='ft14 fl-left "+(i==tab?"on":"")+"'><a href='javascript:mt.tab("+i+")'>"+TAB[i]+"</a></li>");///*("+TbMeeting.count(sql.toString()+SQL[i])+")*/
                }
                out.print("</ul>");
            %>
        </div>
        <%

            List<TbMeeting> list = TbMeeting.find(sql.toString(), 0, Integer.MAX_VALUE);
            if(meet_name!=null){
                list=TbMeeting.find(sql.toString(),0,Integer.MAX_VALUE);
            }
            int sum = list.size();
            if (sum == 0) {//无记录%>
        <div class="order-sea" style="margin-bottom: 10px; text-align: center;">

                <span>暂无记录！</span>

        </div>
        <%}else {
            for (TbMeeting tb : list) {
        %>
        <div class="order-list">
            <p class="order-line1 ft14">
                <span class="fl-left order-tit"><%=MT.f(tb.getName())%></span>
            </p>
            <ul class="ft14">
                <li>
                    <span class="list-spanr5 fl-left">申请时间：</span>
                    <span class="list-spanr fl-left"><%=MT.f(tb.getCreate_Data())%></span>
                </li>
                <li>
                    <span class="list-spanr5 fl-left">状态：</span>
                    <span class="list-spanr fl-left"><%=str[tb.getType()]%></span>
                </li>

            </ul>
            <p class="order-btnp">
                <a href="/mobjsp/yl/shopweb/MeetingContent.jsp?id=<%=tb.getId()%>" class="btn order-btn-ck fl-right ft14">详情</a>
            </p>
        </div>

        <%}}%>



    </div>
</body>
</html>
<script>
    mt.tab=function(a)
    {
        location.href="/mobjsp/yl/shopweb/MeetingManage.jsp?tab="+a;
    };
</script>