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

    int type = h.getInt("type", 0); //0 延期  1超量

    sql.append(" AND type=" + type+" AND hid="+menuid);
    par.append("&type=" + type);


    int pos = h.getInt("pos");
    par.append("&pos=");

    int sum = ApprovalProcess.count(sql.toString());


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
<h1><%=(type == 0 ? "延期申请管理" : "超量申请管理")%>
</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" action="?">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id" value="<%=menuid%>"/>
    <table id="tablecenter" cellspacing="0">
        <tr>
            <td align="center">
                <button class="btn btn-primary" type="button" <%=type==0?"onclick='add()'":"onclick='add2()'"%> >添加</button>
            </td>
        </tr>
    </table>
</form>
<form name="form2" action="/ApprovalProcesss.do" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="id" value="<%=menuid%>"/>
    <input type="hidden" name="apid"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>
    <input type="hidden" name="nobackreason">
    <input type="hidden" name="type" value="<%=type%>">

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
                <th>申请类型</th>
                <th>申请人</th>
                <th>审批状态</th>
                <%if(type==0){%>
                <th>延期至</th>
                <%}else {%>
                <th>超量至</th>
                <%}%>

                <th>操作</th>
            </tr>
            <%
                if (sum < 1) {
                    out.print("<tr><td colspan='8' class='noCont'>暂无记录!</td></tr>");
                } else {
                    Iterator it = ApprovalProcess.find(sql.toString() + " order by id desc ", pos, 15).iterator();
                    for (int i = 1 + pos; it.hasNext(); i++) {
                        ApprovalProcess ap = (ApprovalProcess) it.next();
            %>
            <tr>
                <td align="center"><%=i %>
                </td>
                <td><%=ShopHospital.find(ap.getHid()).getName()%></td>
                <td><%=MT.f(ap.getType() == 0 ? ShopHospital.dqzjArr[ap.getYqlb()] + "延期申请" : "超量申请") %>
                </td>
                <td><%=Profile.find(ap.getCreate_profile()).getMember()%>
                </td>
                <td><%
                    if (ap.getApproval() == 2) {//已拒绝  红色  点击弹出拒绝理由      0 未提交  1 审批中  2 已拒绝 3 已完成
                %>
                    <button type="button" onclick="showReason('<%=ap.getReason()%>')" class="btn btn-type">已拒绝
                    </button>
                    <%} else {%>
                    <%=
                    ap.getApproval() > 0 ? ShopHospital.approvalStatusType[ap.getApproval()] : "未提交"%>
                    <%}%>
                </td>
                <td><%=type==0?MT.f(ap.getYqrq()):ShopHospital.showBq(MT.f(ap.getBq()))%>
                </td>
                <td>
                    <%
                        if (ap.getApproval() == 0 ) {//未提交
                            out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('submitap'," + ap.getId() + ")\">提交</button>");
                            out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('ap_edit'," + ap.getId() + ","+type+")\">编辑</button>");
                        } else if(ap.getApproval() ==1){//审批中展示
                            //out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('apPass'," + ap.getId() + ")\">通过</button>");
                            //out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('apRefuse'," + ap.getId() + ")\">拒绝</button>");
                        } else if(ap.getApproval() == 2 ){//已拒绝展示编辑
                            out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('ap_edit'," + ap.getId() + ","+type+")\">编辑</button>");
                        }

                        out.println("<button type=\"button\" class=\"btn btn-link\" onclick=\"mt.act('ap_detail'," + ap.getId() + ","+type+")\">查看</button>");
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

    mt.act = function (a, id,type) {
        form2.act.value = a;
        form2.apid.value = id;
        if (a == 'submitap') {//提交审核
            if(type==0) {
                mt.show('你确定要提交延期申请么', 2, 'form2.submit()');
            }else {
                mt.show('你确定要提交超量申请么', 2, 'form2.submit()');
            }
        }else if (a == "apRefuse") {//拒绝
            mt.show("<textarea id='_q' cols='28' rows='5'></textarea>", 2, "拒绝原因");
            mt.ok = function () {
                var v = document.getElementById("_q").value;
                if (v == '' || v == 'undefined') {
                    alert("请填写拒绝原因！");
                    return;
                }

                form2.nobackreason.value = v;
                form2.submit();

            }
        }else if (a == "apPass") {//通过
            mt.show('你确定要用过审核么', 2, 'form2.submit()');
        }else if(a=="ap_detail"){//查看详情
            if(type == 0){
                form2.action = '/jsp/yl/shopnew/postponeDetail.jsp';
            }else {
                form2.action = '/jsp/yl/shopnew/excessDetail.jsp';
            }

            form2.target = form2.method = '';
            form2.submit();
        }else if(a=="ap_edit"){//编辑
            if(type == 0) {
                form2.action = '/jsp/yl/shopnew/postponeAdd.jsp';
            }else {
                form2.action = '/jsp/yl/shopnew/excessAdd.jsp';
            }
            form2.target = form2.method = '';
            form2.submit();
        }
    }


    //添加申请
    function add() {
        form2.action = '/jsp/yl/shopnew/postponeAdd.jsp';
        form2.target = form2.method = '';
        form2.submit();
    }

    //添加申请
    function add2() {
        form2.action = '/jsp/yl/shopnew/excessAdd.jsp';
        form2.target = form2.method = '';
        form2.submit();
    }

    function showReason(reason) {
        mt.show(reason, 1, "拒绝原因");
    }
</script>
</body>
</html>
