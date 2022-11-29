<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Http" %>
<%@page import="tea.entity.MT" %>
<%@page import="tea.entity.admin.AdminUsrRole" %>
<%@page import="tea.entity.member.Profile" %>
<%@page import="tea.entity.yl.shop.ShopHospital" %>
<%@page import="util.Config" %>
<%@page import="util.DateUtil" %>
<%@page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="tea.entity.yl.shop.ApprovalProcess" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    StringBuffer sql = new StringBuffer(), par = new StringBuffer();


    int menuid = h.getInt("id");
    par.append("?community=" + h.community + "&id=" + menuid);

    String name = h.get("name");
    if (!"".equals(name) && name != null) {
        sql.append(" AND name like'%" + name + "%'");
        par.append("&name=" + name);
    }
    int  appp = h.getInt("appp");
    sql.append(" AND ((approvalProfile="+appp+" AND approvalStatus=1 ) OR approvalStatus=3)");

    int spzt = h.getInt("spzt");
    if(spzt>0){
        sql.append(" AND approvalStatus="+spzt);
        par.append("&spzt="+spzt);
    }
    int pos = h.getInt("pos");
    par.append("&pos=");

    int sum = ShopHospital.count(sql.toString());


%>
<!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/jsp/sup/sup.js" type="text/javascript"></script>
<!-- <script src="/tea/jquery.js" type="text/javascript"></script> -->
<script src="/tea/jquery-1.11.1.min.js"></script>
<script src="/tea/yl/top.js"></script>
<style>
    .btn-type, .btn-type:active, .btn-type.active, .btn-type[disabled], fieldset[disabled] .btn-type {
        background-color: transparent;
        box-shadow: none;
    }

    .btn-type {
        border-radius: 0;
        color: #ff3b30;
        border: none;
        font-weight: 400;
        padding: 0 1px;
    }
</style>
</head>
<body>
<h1>医院资质、延期及预警管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id" value="<%=menuid%>"/>
    <table id="tablecenter" cellspacing="0">
        <tr>
            <td class="th">医院名称：</td>
            <td><input name="name" value="<%= MT.f(name)%>"/></td>
            <td>审批状态：
                <select name="spzt">
                    <option value="0">-请选择-</option>
                    <option value="1" <%=spzt==1?"selected='selected'":""%>>审批中</option>
                    <option value="2" <%=spzt==2?"selected='selected'":""%>>已拒绝</option>
                    <option value="3" <%=spzt==3?"selected='selected'":""%>>已完成</option>
                </select>
            </td>
            <td align="center">
                <button class="btn btn-primary" type="submit">查询</button>
            </td>
        </tr>
    </table>
</form>
<form name="form2" action="/ShopHospitals.do" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>
    <input type="hidden" name="nobackreason">
    <input type="hidden" name="type">

    <div class='radiusBox'>
        <table cellspacing="0" class='newTable'>
            <thead>
            <tr>
                <td colspan='20'><span>列表 <%=sum%>&nbsp;</span>
            </tr>
            </thead>
            <tr>
                <th>序号</th>
                <th>医院名称</th>
                <th>审批状态</th>
                <th>操作</th>
            </tr>
            <%
                if (sum < 1) {
                    out.print("<tr><td colspan='8' class='noCont'>暂无记录!</td></tr>");
                } else {
                    Iterator it = ShopHospital.find(sql.toString(), pos, 15).iterator();
                    for (int i = 1 + pos; it.hasNext(); i++) {
                        ShopHospital sh = (ShopHospital) it.next();
            %>
            <tr>
                <td align="center"><%=i %>
                </td>
                <td><%=MT.f(sh.getName()) %>
                </td>
                <td><%
                    if (sh.getApprovalStatus() == 2) {//已拒绝  红色  点击弹出拒绝理由
                %>
                    <button type="button" onclick="showReason('<%=sh.getNobackreason()%>')" class="btn btn-type">已拒绝
                    </button>
                    <%} else {%>
                    <%=
                    sh.getApprovalStatus() > 0 ? ShopHospital.approvalStatusType[sh.getApprovalStatus()] : ""%>
                    <%}%>
                </td>
                <td nowrap><%
                    if (sh.getApprovalStatus() == 1) {//审批中展示查看详情  可查看资质上传的信息
                        out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('certificationPass'," + sh.getId() + ")\">通过</button>");
                        out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('certificationRefuse'," + sh.getId() + ")\">拒绝</button>");
                    }
                    out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('zzsq_detail'," + sh.getId() + ")\">查看资质信息</button>");
                    ArrayList<ApprovalProcess> approvalProcesses = ApprovalProcess.find(" AND approval_profile="+appp+" AND hid=" + sh.getId() + " AND approval=1 AND type=0 ", 0, Integer.MAX_VALUE);
                    if(approvalProcesses.size()>0) {
                        out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('extensionRequest'," + sh.getId() + ")\">延期申请审批</button>");
                    }
                    ArrayList<ApprovalProcess> approvalProcesses2 = ApprovalProcess.find(" AND approval_profile="+appp+" AND hid=" + sh.getId() + " AND approval=1 AND type=1 ", 0, Integer.MAX_VALUE);
                    if(approvalProcesses2.size()>0) {
                        out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('excessRequest'," + sh.getId() + ")\">超量申请审批</button>");
                    }


                %>

                </td>
            </tr>
            <%
                    }
                    if (sum > 15)
                        out.print("<tr><td colspan='12' align='right'>" + new tea.htmlx.FPNL(h.language, par.toString(), pos, sum, 15));
                }%>
        </table>
    </div>
    <%
        //if(acts.contains("oper"))

    %>

</form>
<script>

    form2.nexturl.value = location.pathname + location.search;
    mt.act = function (a, id, b) {
        form2.act.value = a;
        form2.id.value = id;
        if (a == "zzsq_detail") {
            form2.action = '/jsp/yl/shopnew/hospital_certification_detail.jsp';
            form2.target = form2.method = '';
            form2.submit();
        } else if (a == "certificationPass") {
            form2.action = '/ShopHospitals.do';
            mt.show('你确定要通过医院的资质审核么', 2, 'form2.submit()');
        } else if (a == "certificationRefuse") {
            mt.show("<textarea id='_q' cols='28' rows='5'></textarea>", 2, "医院资质审批拒绝原因");
            mt.ok = function () {
                var v = document.getElementById("_q").value;
                if (v == '' || v == 'undefined') {
                    alert("请填写拒绝原因！");
                    return;
                }

                form2.nobackreason.value = v;
                form2.submit();

            }
        } else if(a == "extensionRequest"){//延期审批
            form2.type.value = "0";
            form2.action = '/jsp/yl/shopnew/shopHospitalsextensionRequestList2.jsp';
            form2.target = form2.method = '';
            form2.submit();
        }else if(a == "excessRequest"){//超量审批
            form2.type.value = "1";
            form2.action = '/jsp/yl/shopnew/shopHospitalsextensionRequestList2.jsp';
            form2.target = form2.method = '';
            form2.submit();
        }

    }
    function showReason(reason) {
        mt.show(reason, 1, "拒绝原因");
    }
</script>
</body>
</html>
