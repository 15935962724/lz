<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.admin.orthonline.Hospital" %>
<%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int upid = h.getInt("upid");
    UpProfile up = UpProfile.find(upid);
    Profile p = Profile.find(up.getProfile());
    Profile m = Profile.find(up.getMember());
    String[] uptypeArr = {"服务商","vip"};
    String[] arr3 = {"粒子签收","发票签收","粒子&发票签收"};

%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js"></script>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>

</head>
<body>
<form name="form2" action="/ServiceInvoices.do" id="form2" method="post" target="_ajax">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>
    <input type="hidden" name="uptype" value="<%=up.getUptype()%>"/>
<table id="tablecenter">
	<tr>
		<td width="100">用户:</td>
		<td><%=MT.f(p.getMember())%></td>
	</tr>
    <tr>
        <td width="100">手机号:</td>
        <td><%=p.getMobile()%></td>
    </tr>
    <tr>
        <td width="100">邮箱:</td>
        <td><%=MT.f(p.getEmail())%></td>
    </tr>
    <tr>
        <td width="100">升级类型:</td>
        <td><%=uptypeArr[up.getUptype()]%></td>
    </tr>
    <tr>
        <td>服务商公司名称:</td>
        <td><%=MT.f(up.getCompany())%></td>
    </tr>
    <%if(up.getUptype()==0){%>
    <tr>
        <td width="100">营业执照:</td>
        <td>
            <%
                if(up.getBusiness()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getBusiness()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>
        </td>
    </tr>
    <tr>
        <td width="100">开户许可证:</td>
        <td>
            <%
                if(up.getLicense()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getLicense()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>
        </td>
    </tr>
    <tr>
        <td width="100">其他材料:</td>
        <td>
            <%
                if(up.getOther()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getOther()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>
        </td>
    </tr>
    <%}%>
    <tr>
        <td width="100">申请时间:</td>
        <td><%=MT.f(up.getUptime())%></td>
    </tr>
    <%
        if(up.getState()!=0){
            %>
    <tr>
        <td>审核时间:</td>
        <td><%=MT.f(up.getExtime())%></td>
    </tr>
    <tr>
        <td>审核人:</td>
        <td><%=m.getMember()%></td>
    </tr>
    <%
        if(up.getState()==2){
    %>
    <tr>
        <td>审核不通过原因:</td>
        <td><%=MT.f(up.getDescribe())%></td>
    </tr>
    <%
            }
        }
        if(up.getUptype()==1){
            List<EmpowerRecord> erList = EmpowerRecord.find(" and upid="+up.getUpid(), 0, 1);
            EmpowerRecord er = erList.get(0);
            ShopHospital hos = ShopHospital.find(er.getHospital());

    %>
    <tr>
        <td>医院:</td>
        <td><%=MT.f(hos.getName())%></td>
    </tr>

        <%}
    %>


</table>
    <%if(up.getUptype()==1){
        List<EmpowerRecord> erList = EmpowerRecord.find(" and upid=" + up.getUpid(), 0, 1);
        if(erList.size()>0){
        EmpowerRecord er = erList.get(0);
        List<SignFor> list = SignFor.find(" and eid=" + er.getEid(), 1, Integer.MAX_VALUE);
    %>

    <h1>签收人</h1>
    <table id="tablecenter" class="newTable" style="width:95.5%;min-width:inherit;">
        <tr>
            <th>收货人</th>
            <th>科室</th>
            <th>手机号</th>
            <th>详细地址</th>
            <th>签收类型</th>
        </tr>
        <%
            for (int i = 0; i < list.size(); i++) {
                SignFor sf = list.get(i);
        %>
        <tr>
            <td><%=MT.f(sf.getSignatory())%></td>
            <td><%=MT.f(SignFor.DEPARTMENT_ARR[sf.getDepartment()])%></td>
            <td><%=MT.f(sf.getMobile())%></td>
            <td><%=MT.f(sf.getAddress())%></td>
            <td><%=MT.f(arr3[sf.getSignType()])%></td>
        </tr>
        <%}%>
    </table>
    <%}}%>
</form>
<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
</form>
<div class="mt15">
    <button class="btn btn-default" type="button" onclick="closeTc()">关闭</button>
</div>
<script>
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    function downatt(num){
        form9.attch.value = num;
        form9.submit();
    }
    function closeTc(){
        parent.layer.close(index);
    }

</script>

</body>
</html>
