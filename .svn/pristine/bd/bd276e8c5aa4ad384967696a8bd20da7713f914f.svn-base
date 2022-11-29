<%--
  Created by IntelliJ IDEA.
  User: zyj32
  Date: 2019/5/27
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Http" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.EmpowerRecord" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="java.util.List" %>
<%

    Http h = new Http(request, response);
    if (h.member < 1) {
        response.sendRedirect("/servlet/StartLogin?community=" + h.community);
        return;
    }

    StringBuffer sql = new StringBuffer(), par = new StringBuffer();
    int member = h.member;
    Profile p = Profile.find(member);
    String[] stateArr = {"<font color=blue>申请中</font>", "<font color=green>申请成功</font>", "<font color=red>申请失败</font>"};
    String[] uptypeArr = {"服务商", "vip"};


%>
<html>
<head>
    <title>基本信息</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,user-scalable=0">
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.3.1.min.js'></script>
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src="/tea/new/js/superslide.2.1.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <link rel="stylesheet" href="/tea/mobhtml/m-style.css">
    <style>
        .per-con3-a a {
            color: #044694;
        }

        .per-con3-a em {
            color: #999;
            font-style: normal;
        }
    </style>
</head>
<body style="min-height:800px;">

<div class="body">

    <div class="Content">
        <div class="person-con4">
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">用户名</span>
                <%-- <img src="/tea/mobhtml/img/icon9.png" class="fl-right per-m-yx" alt=""> --%>
                <span class="fl-right" style='color:#9a9a9a;'><%=MT.f(p.member)%></span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">手机</span>
                <%-- <img src="/tea/mobhtml/img/icon9.png" class="fl-right per-m-yx" alt=""> --%>
                <span class="fl-right" style='color:#9a9a9a;'><% if (!MT.f(p.mobile).equals("")) {
                    out.print(MT.f(p.mobile)/*+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('mobile','修改手机号') >修改</a>"*/);
                } else {
                    out.print("<em>还未绑定手机</em>&nbsp;&nbsp;<a href='javascript:void(0);' onclick=onsetpage('mobile','绑定手机号')>绑定</a>");
                }%></span>

            </p>
            <p href="" class="per-con3-a">
                <span class="fl-left ft16 fcol-666">邮箱</span>
                <img <%--src="/tea/mobhtml/img/icon9.png"--%> class="fl-right per-m-yx" alt="">
                <span class="fl-right"><% if (!MT.f(p.email).equals("")) {
                    out.print(MT.f(p.email)/*+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('email','修改邮箱')>修改</a>"*/);
                } else {
                    out.print("<em>还未绑定邮箱</em>&nbsp;&nbsp;<a href='javascript:void(0);' onclick=onsetpage('email','绑定邮箱') >绑定</a>");
                }%></span>
            </p>
        </div>
        <%--<div class="person-con5">
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">服务商公司名称</span>
                <span class="fl-right word-cc">北京天创有限公司</span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">营业执照</span>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">营业执照.jpg</a>
                    </span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">开户许可证</span>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">许可证.jpg</a>
                    </span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">其他材料</span>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">营业执照.jpg</a>
                    </span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">通过审核时间</span>
                <span class="fl-right">
                        2019-01-01 14:00
                    </span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">技术服务协议</span>
                <span class="fl-right">
                        <input type="button" value="上传技术服务协议" class="btn-sc ft14">
                    <!-- 上传前 -->
                    <!-- <a href="" class="per-con3-yy">技术服务协议.jpg</a> -->
                    <!-- 上传后 -->
                    </span>
            </p>
            <p href="" class="per-con3-a">
                <span class="fl-left ft16 fcol-666">保证金凭证</span>
                <span class="fl-right">
                        <input type="button" value="上传保证金凭证" class="btn-sc ft14">

                    </span>
            </p>
        </div>--%>
        <%

            List<UpProfile> list = UpProfile.find("AND isdele=0 and profile=" + member, 0, Integer.MAX_VALUE);
            if (list.size() == 0) {
                if (p.membertype == 0) {
                }
            } else {
                UpProfile up = list.get(0);

                Profile m = Profile.find(up.getMember());
        %>
        <div class="person-con5">
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">申请时间</span>
                <span class="fl-right word-cc"><%=MT.f(up.getUptime())%></span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">审核时间</span>
                <span class="fl-right word-cc"><%=MT.f(up.getExtime())%></span>
            </p>
            <%
                if(up.getState()!=0){
            %>

            <%
                if(up.getState()==2){
            %>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">审核不通过原因</span>
                <span class="fl-right word-cc"><%=MT.f(up.getDescribe())%></span>
            </p>
            <%
                    }
                }

                if (up.getUptype() == 0) {
                    System.out.println("申请服务商");%>

            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">服务商公司名称</span>
                <span class="fl-right word-cc"><%=MT.f(up.getCompany())%></span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">升级类型</span>
                <span class="fl-right word-cc"><%=uptypeArr[up.getUptype()]%></span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">营业执照</span>
                <%
                    if (up.getBusiness()>0) {
                %>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">营业执照.jpg</a>
                    </span>
                <%}else {%>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">无文件</a>
                    </span>
                <%}%>
            </p>

            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">开户许可证</span>
                <%
                    if (up.getLicense()>0) {
                %>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">许可证.jpg</a>
                    </span>
                <%}else {%>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">无文件</a>
                    </span>
                <%}%>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">其他材料</span>
                <%
                    if (up.getOther()>0) {
                %>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">其他材料.jpg</a>
                    </span>
                <%}else {%>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">无文件</a>
                    </span>
                <%}%>
            </p>
                <%}
                if (up.getUptype() == 1) {
                    System.out.println("申请医生");
                    List<EmpowerRecord> erList = EmpowerRecord.find(" and upid=" + up.getUpid(), 0, 1);
                    EmpowerRecord er = erList.get(0);
                    ShopHospital hos = ShopHospital.find(er.getHospital());
            %>

            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">医院：</span>
                <span class="fl-right word-cc"><%=MT.f(hos.getName())%></span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">转入转出审批表</span>
                <%
                    if (er.getTurnApproval() > 0) {
                %>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">审批表.jpg</a>
                    </span>
                <%}else {%>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">无文件</a>
                    </span>
                <%}%>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">辐射安全许可证</span>
                <%
                    if (er.getRadiationCard()>0) {
                %>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">许可证.jpg</a>
                    </span>
                <%}else {%>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">无文件</a>
                    </span>
                <%}%>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">有效期</span>
                <span class="fl-right"> <%=MT.f(er.getRaditaionStart())%>至<%=MT.f(er.getRadiation())%></span>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">放射诊疗许可证</span>
                <%
                    if (er.getRadiate()>0) {
                %>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">放射诊疗许可证.jpg</a>
                    </span>
                <%}else {%>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">无文件</a>
                    </span>
                <%}%>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">放射性药品使用许可证</span>
                <%
                    if (er.getRadiateCard()>0) {
                %>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">放射性许可证.jpg</a>
                    </span>
                <%}else {%>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">无文件</a>
                    </span>
                <%}%>
            </p>
            <p href="" class="per-con3-a bor-b">
                <span class="fl-left ft16 fcol-666">粒子签收人/发票签收人</span>
                <%
                    if (er.getSignFor()>0) {
                %>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">签收人.jpg</a>
                    </span>
                <%}else {%>
                <span class="fl-right">
                        <a href="" class="per-con3-yy">无文件</a>
                    </span>
                <%}%>
            </p>

        <%
            }
        %>
        <p href="" class="per-con3-a bor-b">
            <span class="fl-left ft16 fcol-666">状态</span>
            <span class="fl-right">
                        <a href="" class="per-con3-yy"><%=stateArr[up.getState()]%></a>
                    </span>
        </p>
        <%
            }

        %>
        </div>
    </div>
</div>

<%-- <div id="Content">
    <div class="con-right">

        <div class="qualification right-list">

            <table id="tab1" class="right-tab4" cellspacing="0" style="background:none;">
                <tr>
                    <td class="td-left">用户名：</td>
                    <td class="td-right"><%=MT.f(p.member)%></td>
                </tr>
                <tr>
                    <td class="td-left">手机：</td>
                    <td class="td-right"><% if(!MT.f(p.mobile).equals("")){
                        out.print(MT.f(p.mobile)/*+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('mobile','修改手机号') >修改</a>"*/);
                    }else{
                        out.print("还未绑定手机&nbsp;&nbsp;<a href='javascript:void(0);' onclick=onsetpage('mobile','绑定手机号')>绑定</a>");
                    }%></td>
                </tr>
                <tr>
                    <td class="td-left">邮箱：</td>
                    <td class="td-right"><% if(!MT.f(p.email).equals("")){
                        out.print(MT.f(p.email)/*+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick=oncheckpage('email','修改邮箱')>修改</a>"*/);
                    }else{
                        out.print("还未绑定邮箱&nbsp;&nbsp;<a href='javascript:void(0);' onclick=onsetpage('email','绑定邮箱') >绑定</a>");
                    }%></td>
                </tr>

                <%

                    List<UpProfile> list = UpProfile.find(" and profile=" + member, 0, Integer.MAX_VALUE);
                    if(list.size()==0){
                        if(p.membertype==0){
                %>
                <tr>
                    <td class="td-left">&nbsp;</td>
                    <td class="td-right"><a href="/jsp/yl/shopweb/Upgrade.jsp?uptype=0">申请升级供应商</a>&nbsp;&nbsp;<a href="/jsp/yl/shopweb/Perfect.jsp?uptype=1">申请升级VIP</a></td>
                </tr>

            </table>
            <%}}else if(list.size()!=0){
                UpProfile up = list.get(0);
            %>
            </table>
            <p class="right-dz" style="margin-top:15px;">
                <span>申请记录</span>
            </p>
            <table id="tablecenter" class="right-tab3"  cellspacing="0" style="background:none;">
                <tr id="tableonetr">
                    <th class="text-c">用户名</th>
                    <th class="text-c">升级类型</th>
                    <th class="text-c">申请时间</th>
                    <th class="text-c">申请状态</th>
                    <%
                        if(up.getState() != 0){
                    %>
                    <th class="text-c">审核时间</th>
                    <%
                        if(up.getState()==2){
                    %>
                    <th class="text-c">描述</th>
                    <th class="text-c">操作</th>
                    <%}if(up.getState()==1){%>
                    <th class="text-c">操作</th>
                    <%}}%>

                </tr>
                <tr>
                    <td><%=MT.f(p.getMember())%></td>
                    <td><%=uptypeArr[up.getUptype()]%></td>
                    <td><%=MT.f(up.getUptime())%></td>
                    <td><%=stateArr[up.getState()]%></td>
                    <%if(up.getState() != 0){%>
                    <td><%=MT.f(up.getExtime())%></td>
                    <%if(up.getState()==2){%>
                    <td><%=MT.f(up.getDescribe())%></td>
                    <%if(up.getUptype()==0){%>
                    <td><a href="/jsp/yl/shopweb/Upgrade.jsp?upid=<%=up.getUpid()%>">重新申请</a></td>
                    <%}else{
                        List<EmpowerRecord> list1 = EmpowerRecord.find(" and upid=" + up.getUpid(), 0, 1);
                    %>
                    <td><a href="/jsp/yl/shopweb/Perfect.jsp?uptype=1&upid=<%=up.getUpid()%>&eid=<%=list1.get(0).getEid()%>">重新申请</a></td>
                    <%}}}%>
                    <%if(up.getState()==1){%>
                    <td><a href="javascript:;" onclick="checkInfo('<%=up.getUpid()%>')">查看详情</a></td>
                    <%}%>

                </tr>
            </table>
            <%}%>
        </div>

    </div>
</div> --%>


</body>
</html>
<script>
    function oncheckpage(type, tit) {
        layer.open({
            type: 2,
            title: tit,
            shadeClose: true,
            area: ['90%', '260px'],
            closeBtn: 1,
            content: '/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type=' + type
        });
    }

    function checkInfo(id) {
        layer.open({
            type: 2,
            title: '申请详情',
            shadeClose: true,
            area: ['90%', '505px'],
            closeBtn: 1,
            content: '/jsp/yl/shop/UpgradeInfo2.jsp?upid=' + id
        });
    }

    function onsetpage(type, tit) {
        layer.open({
            type: 2,
            title: tit,
            shadeClose: true,
            area: ['90%', '270px'],
            closeBtn: 1,
           /* content: '/jsp/yl/shopweb/ShopEmailMobile.jsp?type=' + type*/
            content: '/jsp/yl/shopweb/ShopCheckEmaiupdate.jsp?type='+type+"&nexturl=/mobjsp/yl/shopweb/UpProfile.jsp"
        });
        //location = '/jsp/yl/shopweb/ShopEmailMobile.jsp?type='+type;
    }

    mt.receive = function (h, n) {
        //$("#"+n).val(h);
        //fchange(h,n);
        form1.hospital.value = h;
        form1.hospitals.value = n;
    }
    mt.fit();


</script>