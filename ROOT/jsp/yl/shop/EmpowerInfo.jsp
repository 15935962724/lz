<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.sup.*"%>
<%@page import="tea.entity.yl.shop.*"%>
<%@ page import="tea.entity.member.Profile" %><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
    int eid = h.getInt("eid");
    EmpowerRecord er = EmpowerRecord.find(eid);
    Profile p = Profile.find(er.getProfile());
    ShopHospital hos = ShopHospital.find(er.getHospital());
    String[] arr = {"授权申请审核中","授权申请通过","授权申请失败"};
    String[] arr2 = {"未提交医院资质","提交医院资质未审核","提交医院资质审核通过","提交医院资质审核不通过","已提交购销合同"};
    String[] arr3 = {"粒子签收","发票签收","粒子&发票签收"};
%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js"></script>
<script src="/tea/yl/jquery-1.7.js"></script>
<script src="/tea/yl/top.js"></script>
<script src='/tea/laydate-master/laydate.dev.js'></script>
<script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
</head>
<body>
<h1>医院授权申请</h1>
<form name="form2" action="/EmpowerRecords.do" id="form2" method="post" target="_ajax" enctype="multipart/form-data">
    <input type="hidden" name="community" value="<%=h.community%>"/>
    <input type="hidden" name="nexturl"/>
    <input type="hidden" name="act"/>
    <input type="hidden" name="eid" value="<%=eid%>"/>
    <input type="hidden" name="perfect"/>
    <input type="hidden" name="desc"/>
<table id="tablecenter">
	<tr>
		<td width="170">服务商:</td>
		<td><%=MT.f(p.getMember())%></td>
	</tr>
    <tr>
        <td width="100">医院名称:</td>
        <td><%=MT.f(hos.getName())%></td>
    </tr>
    <tr>
        <td width="100">授权有效期:</td>
        <td>
            <%=MT.f(er.getStateTime())%> 至
            <%=MT.f(er.getEndTime())%>&nbsp;&nbsp;
            <%if(er.getState()==0){%><a href="javascript:;" onclick="$('#editTime').show()">修改授权有效期</a><%}%>
        </td>
    </tr>
    <%if(er.getState()==0){%>
    <tr id="editTime" style="display: none;">
        <td>&nbsp;</td>
        <td>
            <input name="stateTime" class="Wdate" value="<%=MT.f(er.getStateTime())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate" type="text" />&nbsp;&nbsp;--&nbsp;&nbsp;
            <input name="endTime" class="Wdate" value="<%=MT.f(er.getEndTime())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate" type="text" />&nbsp;&nbsp;
            <a href="javascript:;" class="btn btn-default" onclick="myact('editTime','1')">修改</a>
        </td>
    </tr>
    <%}%>
    <tr>
        <td width="100">受委托人:</td>
        <td><%=MT.f(er.getClient())%></td>
    </tr>
    <tr>
        <td width="100">受委托人身份证复印件:</td>
        <td>
            <%
                if(er.getClientID()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getClientID()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>
        </td>
    </tr>
    <tr>
        <td width="100">辐射安全许可证:</td>
        <td>
            <%
                if(er.getRadiationCard()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiationCard()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>
        </td>
    </tr>

    <tr>
        <td width="100">辐射安全许可证有效期:</td>
        <td><%=MT.f(er.getRaditaionStart())%>&nbsp;至&nbsp;<%=MT.f(er.getRadiation())%></td>
    </tr>
    <tr>
        <td width="100">放射诊疗许可证:</td>
        <td>
            <%
                if(er.getRadiate()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiate()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>

        </td>
    </tr>
    <tr>
        <td width="100">放射性药品使用许可证:</td>
        <td>
            <%
                if(er.getRadiateCard()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiateCard()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>
        </td>
    </tr>
    <tr>
        <td width="100">授权申请:</td>
        <td>
            <%
                if(er.getEmpower()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getEmpower()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>

        </td>
    </tr>
    <tr>
        <td width="100">转入/转出审批表:</td>
        <td>
            <%
                if(er.getTurnApproval()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getTurnApproval()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>

        </td>
    </tr>
    <tr>
        <td width="100">粒子签收人/发票签收人:</td>
        <td>
            <%
                if(er.getSignFor()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getSignFor()) %>');">查看</a>
            <%
                }else{
                    out.print("无文件!");
                }
            %>

        </td>
    </tr>
    <%if(er.getEmpower()>0){%>
    <tr>
        <td>上传已盖章授权书:</td>
        <td>

            <%
                if(er.getCertificate()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getCertificate()) %>');">查看</a>
            <input name="certificate" class="certificate" type="file" alt="已盖章授权书不能为空!">
            <input name="certificate.attch" type="hidden" />
            <button class="btn btn-primary" type="button" onclick="myact('saveCer','2')">重新上传</button>
            <%
                }else{
            %>
            <input name="certificate" class="certificate" type="file" alt="已盖章授权书不能为空!">
            <input name="certificate.attch" type="hidden" value="<%= MT.f(er.getCertificate()) %>" />
            <button class="btn btn-primary" type="button" onclick="myact('saveCer','2')">保存</button>
            <%
                }
            %>
        </td>
    </tr>
    <tr>
        <td width="100">邮寄授权书:</td>
        <td>
            <%
                if(er.getNumber_mail()!=null){
                    out.print("已邮寄!");
            %>
            <a href='javascript:void(0);' onclick="chakan('<%=er.getEid()%>');">查看</a>
            <%
                }else{
                    out.print("未邮寄!");
                }
            %>

        </td>
    </tr>
    <tr>
        <td width="100">购销合同:</td>
        <td>
            <%
                if(er.getContract()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getContract()) %>');">查看</a>
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
        <td><%=MT.f(er.getEmpowerTime())%></td>
    </tr>
    <tr>
        <td width="100">状态:</td>
        <td><%=(er.getPerfect()==0?arr[er.getState()]:arr2[er.getPerfect()])%></td>
    </tr>
    <%if(er.getState()!=0){%>
    <tr>
        <td>审核时间:</td>
        <td><%=MT.f(er.getExamineTime())%></td>
    </tr>
    <%if(er.getState()==2){%>
    <tr>
        <td>失败原因:</td>
        <td><%=MT.f(er.getDescribe())%></td>
    </tr>
    <%}}%>

    <%if(er.getPerfect()==3){%>
    <tr>
        <td>失败原因：</td>
        <td><%=MT.f(er.getDescribe())%></td>
    </tr>
    <%}%>
</table>
<%if(er.getPerfect() != 0){
    List<SignFor> list = SignFor.find(" and eid=" + eid, 0, Integer.MAX_VALUE);
    if(list.size()>0){
%>
    
    <style>
        .newTable th{
            text-align: center;}
    </style>
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
    <%
        }
    %>
    </table>
<%}}%>


</form>

<div class="mt15">
    <%if(er.getState()==0){%>
    <button class="btn btn-primary" type="button" onclick="myact('examine','1')">审核通过</button>&nbsp;&nbsp;
    <button class="btn btn-primary" type="button" onclick="myact('examine','2')">审核不通过</button>&nbsp;&nbsp;
    <%}%>
    <%if(er.getPerfect()==1){%>
    <button class="btn btn-primary" type="button" onclick="myact('allow','2')">允许订货</button>&nbsp;&nbsp;
    <button class="btn btn-primary" type="button" onclick="myact('allow','3')">不允许订货</button>&nbsp;&nbsp;
    <%}%>
    <button class="btn btn-default" type="button" onclick="history.back(-1)">返回</button>

</div>
<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
</form>
<script>

    form2.nexturl.value=location.pathname+location.search;
    //var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    function myact(a,id) {

        if(a=="editTime"){

            fn.ajax("/EmpowerRecords.do?act=editTime",$("#form2").serialize(),function(data){
                if(data.type==0){
                    mtDiag.show("操作执行成功!","alert",null,form2.nexturl.value);
                }else{
                    mtDiag.show("系统异常，请重试!","msg");
                }
            })

        }else if(a=="examine"){
            if(id==2){
                layer.prompt({title: '拒绝原因', formType: 2}, function (pass, index) {
                    if(pass==""){
                        mtDiag.show('拒绝原因不能为空!','msg');
                    }else{
                        fn.ajax("/EmpowerRecords.do?act=examine&eid=<%=eid%>&state=" + id, "desc=" + pass, function (data) {
                            if (data.type == 0) {
                                layer.msg('操作执行成功', {time: 1000}, function () {
                                    location.reload();
                                });
                            } else {
                                layer.alert("系统异常，请重试!");
                            }

                        });
                        layer.close(index);
                    }
                });
            }else{

                fn.ajax("/EmpowerRecords.do?act=examine&eid=<%=eid%>","state="+id, function (data) {
                    if (data.type == 0) {
                        layer.msg('操作执行成功', {time: 1000}, function () {
                            location.reload();
                        });
                    } else {
                        layer.alert("系统异常，请重试!");
                    }
                });


            }

        }else if(a=="allow"){
            if(id==3){
                layer.prompt({title: '拒绝原因', formType: 2}, function (pass, index) {

                    form2.act.value="allow";
                    form2.eid.value="<%=eid%>";
                    form2.perfect.value=id;
                    form2.desc.value=pass;
                    form2.submit();
                    /*fn.ajax("/EmpowerRecords.do?act=allow&eid=<%=eid%>&perfect=" + id, "desc=" + pass, function (data) {
                        if (data.type == 0) {
                            layer.msg('操作执行成功', {time: 1000}, function () {
                                location.reload();
                            });
                        } else {
                            layer.alert("系统异常，请重试!");
                        }

                    });
                    layer.close(index);*/
                });
            }else if(id==2){

                form2.act.value="allow";
                form2.eid.value="<%=eid%>";
                form2.perfect.value=id;
                form2.submit();

                    /*fn.ajax("/EmpowerRecords.do?act=allow&eid=<%=eid%>","perfect="+id, function (data) {
                        if (data.type == 0) {
                            layer.msg('操作执行成功', {time: 1000}, function () {
                            location.reload();
                        });
                        } else {
                            layer.alert("系统异常，请重试!");
                        }
                    });*/


            }

        }else if(a=="saveCer"){

            if($(".certificate").next().attr('value') == undefined || $(".certificate").next().attr('value') == 0){
                if($(".certificate").get(0).files[0] == undefined){
                    mtDiag.show($(".certificate").attr("alt"),'msg');
                    return false;
                }else{
                    form2.act.value="saveCer";
                    form2.submit();
                }
            }
        }

    }


    function downatt(num){
        form9.attch.value = num;
        form9.submit();
    }

    function chakan(id) {
        layer.open({
            type: 2,
            title: '邮寄授权书',
            shadeClose: true,
            area: ['400px', '300px'],
            closeBtn:1,
            content: '/jsp/yl/shopweb/AmilShouQuan.jsp?onlyread=1&eid='+id
        });
    }
</script>

</body>
</html>
