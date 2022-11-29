<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="util.DateUtil" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int puid = h.getInt("puid");
ProcurementUnit p = ProcurementUnit.find(puid);
%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
<link rel="stylesheet" href="/tea/new/css/common.css">
</head>
<body >
<h1>厂商管理</h1>
<table id="tablecenter">
	<tr>
		<td width="100">厂商名称:</td>
		<td><%=p.getName()%></td>
	</tr>

    <tr>
        <td>全称:</td>
        <td><%=p.getFullname()==null?"--":p.getFullname()%></td>
    </tr>
    <tr>
        <td>英文全称:</td>
        <td><%=p.getFullnameen()==null?"--":p.getFullnameen()%></td>
    </tr>
    <tr>
        <td>联系人:</td>
        <td><%=p.getPerson()==null?"--":p.getPerson()%></td>
    </tr>
    <tr>
        <td>手机:</td>
        <td><%=p.getMobile()==null?"--":p.getMobile()%></td>
    </tr>
    <tr>
        <td>邮箱:</td>
        <td><%=p.getEmail()==null?"--":p.getEmail()%></td>
    </tr>
    <tr>
        <td>邮编:</td>
        <td><%=p.getZipcode()==null?"--":p.getZipcode()%></td>
    </tr>
    <tr>
        <td>传真:</td>
        <td><%=p.getFax()==null?"--":p.getFax()%></td>
    </tr>

    <tr>
        <td>排序:</td>
        <td><%=p.getSort()%></td>
    </tr>


    <tr>
        <td>是否停止供货:</td>
        <td><%=p.getIsStopSupply()==0?"否":"是"%></td>
    </tr>
    <tr>
        <td>辐射安全许可证:</td>
        <td><%=p.getRadiationSafetyTime()%> <a href="<%=p.getRadiationSafetyUrl()%>" target="_blank">查看</a>
        <%
            int day = DateUtil.countTwoDate(p.getRadiationSafetyTime());
            if (day<=30){
                    %>
            <span style="color: red;">辐射安全许可证还有<%=day%>天到期</span>
                    <%
            }
        %>
        </td>
    </tr>
    <tr>
        <td>企业营业执照:</td>
        <td> <%=p.getBusinessLicenseTime()%> <a href="<%=p.getBusinessLicenseUrl()%>" target="_blank">查看</a>
            <%
                day = DateUtil.countTwoDate(p.getBusinessLicenseTime());
                if (day<=30){
                    %>
                        <span style="color: red;">企业营业执照还有<%=day%>天到期</span>
                    <%

                }
            %>
        </td>
    </tr>
    <tr>
        <td>放射药品生产许可证:</td>
        <td><%=p.getProductionLicenseTime()%> <a href="<%=p.getProductionLicenseUrl()%>" target="_blank">查看</a>
            <%
                day = DateUtil.countTwoDate(p.getProductionLicenseTime());
                if (day<=30){
            %>
            <span style="color: red;">放射药品生产许可证还有<%=day%>天到期</span>
            <%

                }
            %>
        </td>
    </tr>
    <tr>
        <td>转让审批表:</td>
        <td><%=p.getApprovalFormTime()%> <a href="<%=p.getApprovalFormUrl()%>" target="_blank">查看</a>
            <%
                day = DateUtil.countTwoDate(p.getApprovalFormTime());
                if (day<=30){
            %>
            <span style="color: red;">转让审批表还有<%=day%>天到期</span>
            <%

                }
            %>
        </td>
    </tr>
    <tr>
        <td>药品GMP证书:</td>
        <td><%=p.getGmpCertificateTime()%> <a href="<%=p.getGmpCertificateUrl()%>" target="_blank">查看</a>
            <%
                day = DateUtil.countTwoDate(p.getGmpCertificateTime());
                if (day<=30){
            %>
            <span style="color: red;">药品GMP证书还有<%=day%>天到期</span>
            <%

                }
            %>
        </td>
    </tr>
    <tr>
        <td>药品再注册批件:</td>
        <td><%=p.getRegistrationApprovalTime()%> <a href="<%=p.getRegistrationApprovalUrl()%>" target="_blank">查看</a>
            <%
                day = DateUtil.countTwoDate(p.getRegistrationApprovalTime());
                if (day<=30){
            %>
            <span style="color: red;">药品再注册批件还有<%=day%>天到期</span>
            <%

                }
            %>
        </td>
    </tr>
    <tr>
        <td>授权委托书:</td>
        <td><%=p.getPowerOfAttorneyTime()%> <a href="<%=p.getPowerOfAttorneyUrl()%>" target="_blank">查看</a>
            <%
                day = DateUtil.countTwoDate(p.getPowerOfAttorneyTime());
                if (day<=30){
            %>
            <span style="color: red;">授权委托书还有<%=day%>天到期</span>
            <%

                }
            %>
        </td>
    </tr>
    <tr>
        <td>证件到期预警电话:</td>
        <td>厂商预留电话:<%=p.getManufactorMobile()%><br/>
            平台预留电话:<%=p.getPlatformMobile()%></td>
    </tr>

</table>


<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="rate animate-box" data-animate-effect="fadeInLeft">
                <span class="<%if(p.getStatus()>=1){out.print("active ");}%> animate-box" data-animate-effect="fadeInLeft"><em>1</em><br>采购员</span>
                <span class="<%if(p.getStatus()>=2){out.print("active ");}%>animate-box" data-animate-effect="fadeInLeft"><em>2</em><br>采购负责人</span>
                <span class="<%if(p.getStatus()>=3){out.print("active ");}%>animate-box" data-animate-effect="fadeInLeft"><em>3</em><br>质量管理员</span>
                <span class="<%if(p.getStatus()>=4){out.print("active ");}%>animate-box last" data-animate-effect="fadeInLeft"><em>4</em><br>质量负责人</span>
            </div>
        </div>
    </div>
</div>

<button class="btn btn-default" style="background: #00a1e9;border-color: #00a1e9; color: #fff;" type="button" onclick="remind()">资质提醒</button>

<button class="btn btn-default" type="button" onclick="history.back(-1)">返回</button>

<button class="btn btn-default" style="background: #00a1e9;border-color: #00a1e9; color: #fff;" type="button" onclick="isStopSupply()"><%=p.getIsStopSupply()==0?"停止":"继续"%>供货</button>


<script type="text/javascript">
    var puid = getParam("puid");
    //资质提醒
    function remind(){
            fn.ajax("/ProcurementUnitServlet.do?act=remind", "puid="+puid, function (data) {
                if (data.type > 0) {
                    if (data.type == 1) {
                        return;
                    }
                    mtDiag.close();
                    mtDiag.show(data.mes);
                    return;
                } else {
                    mtDiag.show("操作成功！", "alert");
                }
            });
    }

    //是否停止供货
    function isStopSupply(){
        fn.ajax("/ProcurementUnitServlet.do?act=isStopSupply", "puid="+puid, function (data) {
            if (data.type > 0) {
                if (data.type == 1) {
                    return;
                }
                mtDiag.close();
                mtDiag.show(data.mes);
                return;
            } else {
                mtDiag.show("操作成功！", "alert");
                location.reload();
            }
        });

    }


</script>

</body>
</html>
