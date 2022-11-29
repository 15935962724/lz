<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.ActivityWarning" %>
<%@ page import="java.util.*" %>
<%@ page import="util.CommonUtils" %>
<%@ page import="tea.entity.yl.shop.ApprovalProcess" %>
<%@ page import="tea.entity.member.ModifyRecord" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="tea.entity.member.Profile" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }
    String nexturl = h.get("nexturl");


    //查询到期的证件
    int apid = h.getInt("apid");
    ApprovalProcess ap = ApprovalProcess.find(apid);
    ShopHospital sh = ShopHospital.find(ap.getHid());

    int yqlb = ap.getYqlb();
    String dateValue = "";
    if (yqlb > -1) {
        switch (yqlb) {

            case 0:
                dateValue = MT.f(sh.getFsaqxkzrq());
                break;
            case 1:
                dateValue = MT.f(sh.getFsxypsyxkzrq());
                break;
            case 2:
                dateValue = MT.f(sh.getFszlxkzrq());
                break;
            case 3:
                dateValue = MT.f(sh.getZfspbrq());
                break;
        }
    }


    StringBuffer url = request.getRequestURL();
    String tempContextUrl = url.delete(url.length() - request.getRequestURI().length(), url.length()).toString();
%>
<html>
<head>
    <link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.11.1.min.js'></script>
    <script src='/tea/yl/top.js'></script>
    <link rel="stylesheet" href="/tea/new/css/style1.css">
    <link rel="stylesheet" href="/tea/new/css/common.css">
    <style>
        em {
            padding-right: 7px;
            color: #000000;
            font-style: normal;
        }

        .btn {
            padding: 10px 40px;
        }
    </style>
</head>
<body onload="changeSelected();">
<h1>预警管理</h1>

<form name="form1" action="/ApprovalProcesss.do" id="form1" method="post"
      enctype="multipart/form-data" target="_ajax">
    <table id="tablecenter">

        <tr>
            <td align="right">医院名称：</td>
            <td><%=MT.f(sh.getName())%>
            </td>
        </tr>
        <tr>
            <td>到期证件:</td>
            <td>
                <%=ShopHospital.dqzjArr[ap.getYqlb()]%>
            </td>
        </tr>
        <tr>
            <td>申请原因:</td>
            <td><%=MT.f(ap.getReason())%>
            </td>
        </tr>
        <tr>
            <td>文件:</td>
            <td>
                <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-9">
                        <a href="<%=CommonUtils.getFileUrlByAttchId(tempContextUrl, ap.getAttchid())%>"
                           target="_blank" style="color: #007aaf">查看</a>
                    </div>
                </div>
            </td>
        </tr>
        <%if (ap.getApproval() == 1) { //审批中展示%>
        <tr>
            <td>原有效期:</td>
            <td><%=dateValue%>
            </td>
        </tr>
        <%}%>

        <tr>
            <td>有效期调整为:</td>
            <td><%=MT.f(ap.getYqrq())%>
            </td>
        </tr>
    </table>
    <div>
        <%
            List<ModifyRecord> modifyRecords = ModifyRecord.find(" AND order_id=" + Database.cite(ap.getId() + "") + " order by id asc ", 0, 10);
            if (modifyRecords.size() > 0) {
        %>
        <table id="tablecenter" cellspacing="0">
            <tr style="font-weight:bold;">
                <td colspan="4" align='left'>审批日志</td>
            </tr>
            <tr id="tableonetr">
                <td>操作人</td>
                <td>时间</td>
                <td>操作类型</td>
                <td>操作内容</td>
            </tr>
            <%
                for (ModifyRecord m : modifyRecords) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
                    String format = sdf.format(m.getModifyTime());
            %>
            <tr>
                <td><%=MT.f(Profile.find(m.getMember()).getMember())%>
                </td>
                <td><%=MT.f(format)%>
                </td>
                <td><%=MT.f(m.getContent())%>
                </td>
                <td><%=  MT.f(m.getContentDetail())%>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>
    <div class="rate animate-box" data-animate-effect="fadeInLeft">
        <%
            int approvalProfile = ap.getApproval_profile();//资质申请流程当前状态
            System.out.println("approvalProfile=" + approvalProfile);
        %>
        <span <%=approvalProfile > 1 ? "class='active animate-box'" : "class='animate-box'"%>
                data-animate-effect="fadeInLeft"><em>1</em><br>资质提交</span>
        <span <%=approvalProfile > 2 ? "class='active animate-box'" : "class='animate-box'"%>
                data-animate-effect="fadeInLeft"><em>2</em><br>客服负责人审核</span>
        <span <%=approvalProfile > 3 ? "class='active animate-box'" : "class='animate-box'"%>
                data-animate-effect="fadeInLeft"><em>3</em><br>质量管理员审核</span>
        <span <%=approvalProfile > 4 ? "class='active animate-box last'" : "class='animate-box last'"%>
                data-animate-effect="fadeInLeft"><em>4</em><br>质量负责人审核</span>
    </div>

    <button class="btn btn-default" type="button" onclick="location='<%=nexturl%>'">返回</button>
</form>


</body>
</html>
