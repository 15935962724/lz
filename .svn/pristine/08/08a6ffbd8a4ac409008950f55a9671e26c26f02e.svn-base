<%@page import="util.Config" %>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.yl.shopnew.*" %>
<%@page import="tea.entity.yl.shop.*" %>
<%@page import="tea.entity.member.Profile" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    StringBuffer sql = new StringBuffer(), par = new StringBuffer("?");
    int member = h.member;
    Profile p = Profile.find(member);
    String[] stateArr = {"<font color=blue>申请中</font>", "<font color=green>申请成功</font>", "<font color=red>申请失败</font>"};
    String[] uptypeArr = {"服务商", "vip"};


    int pos = h.getInt("pos");
    par.append("&pos=");
    List<UpProfile> list = UpProfile.find(" and profile=" + p.profile, 0, Integer.MAX_VALUE);
    int sum = 0;
    if (list.size() != 0) {
        sum = EmpowerRecord.count(" and upid=" + list.get(0).getUpid());
    }
%>
<html>
<head>
    <title>升级申请</title>

    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.3.1.min.js'></script>
    <link rel="stylesheet" href="/tea/new/css/style.css">
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
</head>
<style>
    .con-left-list .tit-on5 {
        color: #044694;
    }

</style>
<body style="min-height:800px;">
<%@ include file="/jsp/yl/shopweb/PersonalTop.jsp" %>
<div id="Content">
    <div class="con-left">
        <%@ include file="/jsp/yl/shopweb/PersonalLeft.jsp" %>
    </div>
    <div class="con-right">
        <div class="qualification">
            <%

                String[] arr1 = {"授权申请审核中", "授权申请审核通过", "授权申请失败"};
                String[] arr2 = {"未提交医院资质", "医院资质审核中", "审核完成", "提交医院资质审核不通过"};
                if (list.size() != 0 && list.get(0).getState() == 1) {
                    List<EmpowerRecord> erList = EmpowerRecord.find(" and upid=" + list.get(0).getUpid(), pos, 10);
            %>

            <p class="right-zhgl right-zhgl2" style="line-height:40px;height:40px;">
                <span>医院管理</span>
                <input type="button" onclick="addHos('<%=list.get(0).getUpid()%>','')" value="添加医院"
                       class="right-fp-inp">
            </p>
            <div class="right-list">
                <p class="yy-listp">列表（<em><%=erList.size()%>
                </em>）</p>
                <table class="right-tab" border="1" cellspacing="0">
                    <tr id="tableonetr">
                        <th width="50">序号</th>
                        <th>医院名称</th>
                        <th>授权申请到期时间</th>
                        <th>状态</th>
                        <%if (erList.size() > 0) {%>
                        <th style="max-width:200px;">操作</th>
                        <%}%>
                    </tr>
                    <%
                        if (erList.size() > 0) {
                            for (int i = 0; i < erList.size(); i++) {
                                EmpowerRecord er = erList.get(i);
                                int hos = er.getHospital();
                                ShopHospital sh = ShopHospital.find(hos);

                    %>
                    <tr>
                        <td><%=(i + 1)%>
                        </td>
                        <td><%=sh.getName()%>
                        </td>
                        <td><%=MT.f(er.getEndTime())%>
                        </td>

                        <td><%=(er.getPerfect() == 0 ? arr1[er.getState()] : arr2[er.getPerfect()])%>
                        </td>
                        <td style="padding:0px 20px;">
                            <%
                                if (er.getState() == 0) {
                            %>
                            <a class="btn-link" href="javascript:;"
                               onclick="mt.act('data1','<%=er.getEid()%>','<%=er.getUpid()%>')">查看</a>
                            <%
                                } else if (er.getState() == 1) {
                            %>
                            <a class="btn-link" href="javascript:;" onclick="mt.act('data','<%=er.getEid()%>')">查看</a>&nbsp;&nbsp;
                            <%
                                if (er.getPerfect() == 1) {%>

                            <%
                                }
                                if (er.getPerfect() == 2&&er.getContract()==0) {
                            %>
                            <a class="btn-link" href="javascript:;" onclick="mt.act('gxhetong','<%=er.getEid()%>')"
                               style="color:#f18019">上传购销合同</a>&nbsp;&nbsp;
                            <%
                                }
                                if (er.getPerfect() == 3) {%>
                            <a class="btn-link" href="javascript:;"
                               onclick="mtDiag.show('<%=er.getDescribe()%>')">不通过原因</a>&nbsp;&nbsp;
                            <%
                                    }
                                    if(er.getPerfect() == 0){%>
                            <a class="btn-link" href="javascript:;" onclick="mt.act('subhosp','<%=er.getEid()%>')"
                               style="color:#f18019">提交医院资质</a>&nbsp;&nbsp;
                                    <%}

                                if (er.getCertificate()!= 0) {
                        %>
                            <a href='javascript:void(0);'
                               onclick="downatt('<%= MT.enc(er.getCertificate()) %>');">下载授权书</a>
                            <%
                                }
                                if(er.getPerfect() == 2&&er.getNumber_mail()!=null){//已邮寄%>
                            <a href='javascript:void(0);'
                               onclick="chakan('<%=er.getEid()%>');">授权书邮寄信息</a>

                                <%}else if(er.getPerfect() == 2&&er.getNumber_mail()==null){%>
                            <a href='javascript:void(0);'
                               >未邮寄授权书</a>

                                <%}

                            } else if (er.getState() == 2) {
                            %>
                            <a class="btn-link" href="javascript:;" onclick="mt.act('data','<%=er.getEid()%>')">查看</a>&nbsp;&nbsp;
                            <a class="btn-link" href="javascript:;"
                               onclick="addHos2('<%=er.getUpid()%>','<%=er.getEid()%>')">重新申请</a>&nbsp;&nbsp;
                            <a class="btn-link" href="javascript:;"
                               onclick="mtDiag.show('<%=er.getDescribe()%>')">退回原因</a>
                            <%}%>
                        </td>
                    </tr>
                    <%
                        }

                    } else {
                    %>
                    <tr>
                        <td colspan="7" style="text-align: center;">暂无授权申请记录</td>
                    </tr>

                    <%
                        }
                        if (sum > 10)
                            out.print("<tr><td colspan='10' align='right' id='ggpage'>" + new tea.htmlx.FPNL(h.language, par.toString(), pos, sum, 10) + "</td></tr>");
                    %>
                </table>
            </div>

            <%
            } else {%>
            <p class="right-zhgl right-zhgl2" style="line-height:40px;height:40px;">
                <span>医院管理</span>
                <input type="button" onclick="addHos('','')" value="添加医院"
                       class="right-fp-inp">
            </p>
            <div class="right-list">
                <p class="yy-listp">列表</p>
                <table class="right-tab" border="1" cellspacing="0">
                    <tr id="tableonet">
                        <th width="50">序号</th>
                        <th>医院名称</th>
                        <th>授权申请到期时间</th>
                        <th>状态</th>
                        <th style="max-width:200px;">操作</th>
                    </tr>
                    <tr>
                        <td colspan="5">暂无数据</td>
                    </tr>
                </table>
            </div>

            <%
                }
            %>
        </div>
    </div>
</div>

<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down"/>
    <input name="attch" type="hidden"/>
</form>

</body>
</html>
<script>
    function addHos(upid, eid) {
        layer.open({
            type: 2,
            id: 'addhosp',
            title: '添加医院',
            shadeClose: true,
            area: ['645px', '570px'],
            closeBtn: 1,
            content: '/jsp/yl/shopweb/EmpowerRecord.jsp?upid=' + upid + '&eid=' + eid
        });
        //location = '/jsp/yl/shopweb/ShopEmailMobile.jsp?type='+type;
    }
    function addHos2(upid, eid) {
        layer.open({
            type: 2,
            id: 'addhosp',
            title: '添加医院',
            shadeClose: true,
            area: ['645px', '570px'],
            closeBtn: 1,
            content: '/jsp/yl/shopweb/EmpowerRecord.jsp?again=1&upid=' + upid + '&eid=' + eid
        });
        //location = '/jsp/yl/shopweb/ShopEmailMobile.jsp?type='+type;
    }

    mt.receive = function (h, n) {
        $('#addhosp iframe').contents().find("#hospital").val(h);
        $('#addhosp iframe').contents().find("#hospitals").val(n);
    }
    mt.act = function (a, b, c) {
        if (a == "data") {
            layer.open({
                type: 2,
                title: '医院授权申请详情',
                shadeClose: true,
                area: ['645px', '540px'],
                closeBtn: 1,
                content: '/jsp/yl/shop/EmpowerInfo2.jsp?eid=' + b
            });
        } else if (a == "data1") {
            layer.open({
                type: 2,
                title: '医院授权申请详情',
                shadeClose: true,
                area: ['645px', '540px'],
                closeBtn: 1,
                content: '/jsp/yl/shopweb/EmpowerRecord.jsp?eid=' + b + '&upid=' + c
            });
        } else if (a == 'subhosp') {
            layer.open({
                type: 2,
                title: '提交医院资质',
                shadeClose: true,
                area: ['645px', '480px'],
                closeBtn: 1,
                content: '/jsp/yl/shopweb/Perfect.jsp?eid=' + b
            });

        } else if (a == "gxhetong") {
            layer.open({
                type: 2,
                title: '提交医院资质',
                shadeClose: true,
                area: ['645px', '480px'],
                closeBtn: 1,
                content: '/jsp/yl/shopweb/Perfect.jsp?type=11&eid=' + b
            });
        }
    }

    function downatt(num) {
        form9.attch.value = num;
        form9.submit();
    }

    function chakan(id) {
        layer.open({
            shade: 0,
            type: 2,
            title: '邮寄授权书',
            shadeClose: true,
            area: ['400px', '300px'],
            closeBtn:1,
            content: '/jsp/yl/shopweb/AmilShouQuan.jsp?onlyread=1&eid='+id
        });
    }


</script>