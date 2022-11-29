<%--
  Created by IntelliJ IDEA.
  User: zyj32
  Date: 2019/5/27
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="tea.entity.*"%>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.entity.yl.shop.EmpowerRecord" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.SignFor" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    //String[] stateArr = {"<font color=blue>申请中</font>","<font color=green>申请成功</font>","<font color=red>申请失败</font>"};
    Profile p = Profile.find(h.member);
    int eid = h.getInt("eid");
    EmpowerRecord er = EmpowerRecord.find(eid);
    ShopHospital sh = ShopHospital.find(er.getHospital());
    String[] arr = {"粒子签收","发票签收","粒子&发票签收"};
    int uptype = h.getInt("uptype");
    int upid = h.getInt("upid");
    int type = h.getInt("type");//判断是否是上传购销合同11
%>
<html>
<head>
    <title>提交医院资质</title>

    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.3.1.min.js'></script>
    <link rel="stylesheet" href="/tea/new/css/style.css">
    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <style>
        td{text-align:left !important;}
        td input{padding:0px 4px;}
        td label input{
            position: relative;
            top:7px;}
        .tab1{
            border:1px #ddd solid;
            border-collapse:collapse;
        }
        .tab1 th{
            background:#f5f5f5;
            font-size:14px;
            border-collapse:collapse;
            padding:5px;
        }
        .tab1 td{
            border-collapse:collapse;
            border:1px #ddd solid;
            padding:5px;
        }
        input{
            outline: none;
        }
        .con {padding:15px 20px 0px;}
        .con table{/*margin:0 auto;*/}
        .con table td{padding:5px 0px;font-size:14px;color:#333333;line-height:20px;}
        .con table td input.getyzm{
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;cursor: pointer;border:1px solid #044694;height:32px;color:#044694;background:#f1f6fb;padding:0 8px}
        .con table td .tijiao{width:148px;height:30px;line-height:30px;background:#00A2E8;font-size:14px;font-weight:bold;color:#fff;margin-top:15px;border:0px;cursor:pointer;}

        .righttexts p{padding-top:5px ;line-height:160%}
        .con table td .form-control{
            float:left;
        }
        .con table td em{
            font-style: normal;
            color:red;
            padding:0px 2px;
            font-size:18px;
        }
    </style>
</head>
<body>
<%if(type!=11){%>
<div class="qualification con">

    <form id='form2' name="form1" action="/EmpowerRecords.do" id="form2" method="post" enctype="multipart/form-data">
        <input type="hidden" name="nexturl">
        <input type="hidden" name="act">
        <input type="hidden" name="eid" value="<%=eid%>">
        <input type="hidden" name="uptype" value="<%=uptype%>">
        <input type="hidden" name="upid" value="<%=upid%>">

        <table id="tablecenter" cellspacing="0" class="right-tab4" style="background:none;">
            <tr>
                <td class="text-r" style="width:40%"><em>*</em>医院名称：</td>
                <td>
                    <%if(uptype==1){%>
                    <input name="hospital" type="hidden" value="<%=er.getHospital()%>" class="hospital" />
                    <input name="hospitals" type="text" value="<%=MT.f(sh.getName())%>" readonly class="hospitals form-control" />
                    <a href="javascript:;" onclick="showhospitalsearch()">选择医院</a>
                    <%}else{%>
                    <input name="hospital" type="hidden" value="<%=er.getHospital()%>" class="hospital" />
                    <%=MT.f(sh.getName())%>
                    <%}%>

                </td>
            </tr>

            <tr>
                <td class="text-r"><em>*</em>转入/转出审批表：</td>
                <td>
                    <%
                        if(er.getTurnApproval()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getTurnApproval()) %>');">查看</a>
                    <%
                    }else {%>
                    <input name="turnApproval" type="file" alt="转入/转出审批表不能为空!">
                    <input name="turnApproval.attch" type="hidden" value="<%= MT.f(er.getTurnApproval()) %>" />

                    <%}
                    %>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>粒子签收人/发票签收人：</td>
                <td>
                    <%
                        if(er.getSignFor()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getSignFor()) %>');">查看</a>
                    <%
                    }else {%>
                    <input name="signFor" type="file" alt="粒子签收人/发票签收人!">
                    <input name="signFor.attch" type="hidden" value="<%= MT.f(er.getSignFor()) %>" />

                    <%}
                    %>
                </td>
            </tr>

        </table>

        <div class="center text-c pd20">
            <%--
                if(uptype==1){
                    out.print("<a href=\"javascript:;\" onclick=\"upVip()\" class=\"btn btn-primary btn-blue\">提交申请</a>&nbsp;&nbsp;");
                }else{
                    out.print("<a href=\"javascript:;\" onclick=\"subEmpower()\" class=\"btn btn-primary btn-blue\">提交申请</a>&nbsp;&nbsp;");
                }
            --%>
            <button class="btn btn-default" type="button" onclick="history.back(-1)"  style="display: none">返回</button>
        </div>

        <p class="right-zhgl"><b style="font-size:14px;">签收人</b></p>
        <style>
            .right-tab4 td{padding:5px !important;}
            .right-zhgl{
                border-top:1px #ddd solid;
                padding-top:10px;
            }
            select{padding:5px 0px !important;}
        </style>
        <table class="right-tab4 tbody" border="0" cellpadding="0" cellspacing="0">
            <tbody>
            <%
                List<SignFor> list = SignFor.find(" and eid=" + eid, 0, Integer.MAX_VALUE);
                if(list.size()<1){
            %>
            <tr>
                <td class="text-r"><em>*</em>姓名</td>
                <td><input type="text" name="signatory" alt="姓名不能为空!" style="width:100%" class="form-control"></td>
                <td class="text-r"><em>*</em>科室</td>
                <td>
                    <select style="width:100%" name="department" alt="请选择科室!"  class="form-control">
                        <option value="0">请选择</option>
                        <%
                            for (int i = 1; i < SignFor.DEPARTMENT_ARR.length; i++) {
                                out.print("<option value='"+i+"'>"+SignFor.DEPARTMENT_ARR[i]+"</option>");
                            }

                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>手机号</td>
                <td><input type="text" name="mobile" alt="手机号不能为空!" style="width:100%" class="form-control"></td>
                <td class="text-r"><em>*</em>签收类型</td>
                <td>
                    <select style="width:100%" name="signType" alt="请选择签收类型" class="form-control">
                        <option value="">请选择</option>
                        <option value="0">粒子签收</option>
                        <option value="1">发票签收</option>
                        <option value="2">粒子+发票签收</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>详细地址</td>
                <td colspan="2"><input type="text" name="address" style="width:100%" alt="详细地址不能为空" class="form-control"></td>
                <td><a href="javascript:;" class="btn btn-default btn-danger" style="padding:4px 12px !important;" onclick="del(this)">删除</a></td>
            </tr>
            <tr><td colspan="4">&nbsp;</td> </tr>
            <%}else{
                for (int i = 0; i < list.size(); i++) {
                    SignFor sf = list.get(i);

            %>
            <tr>
                <td class="text-r"><em>*</em>姓名</td>
                <td><input disabled="disabled" type="text" name="signatory" alt="姓名不能为空!" style="width:100%" value="<%=MT.f(sf.getSignatory())%>" class="form-control"></td>
                <td class="text-r"><em>*</em>科室</td>
                <td>
                    <select disabled="disabled" style="width:100%" name="department" alt="请选择科室!"  class="form-control">
                        <option value="">请选择</option>
                        <%
                            for (int j = 1; j < SignFor.DEPARTMENT_ARR.length; j++) {
                                if(sf.getDepartment()==j){
                                    out.print("<option value='" + j + "' selected=selected>" + SignFor.DEPARTMENT_ARR[j] + "</option>");
                                }else {
                                    out.print("<option value='" + j + "'>" + SignFor.DEPARTMENT_ARR[j] + "</option>");
                                }
                            }

                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>手机号</td>
                <td><input disabled="disabled" type="text" name="mobile" alt="手机号不能为空!" style="width:100%" class="form-control" value="<%=MT.f(sf.getMobile())%> "></td>
                <td class="text-r"><em>*</em>签收类型</td>
                <td>
                    <select disabled="disabled" style="width:100%" name="signType" alt="请选择签收类型!" class="form-control">
                        <option value="">请选择</option>
                        <%
                            for (int i1 = 0; i1 < arr.length; i1++) {
                                if(sf.getSignType()==i1){
                                    out.print("<option value='"+i1+"' selected=selected>"+arr[i1]+"</option>");
                                }else{
                                    out.print("<option value='"+i1+"'>"+arr[i1]+"</option>");
                                }

                            }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>详细地址</td>
                <td colspan="2"><input disabled="disabled" type="text" name="address" style="width:100%" alt="详细地址不能为空!" class="form-control"  value="<%=MT.f(sf.getAddress())%>"></td>
                <td><a href="javascript:;" class="btn btn-default btn-danger" style="padding:4px 12px !important;" onclick="del(this)">删除</a></td>
            </tr>
            <tr><td colspan="4">&nbsp;</td> </tr>
            <%}}%>
            </tbody>

        </table>
        <div class="center text-c" style="padding-top:0px;padding-bottom:30px;">
            &nbsp;<a href="javascript:;" class="btn btn-primary btn-blue" style="color:#fff;" onclick="subEmpower()">提交申请</a>&nbsp;
            <a href="javascript:;" class="btn btn-default" onclick="addSign()">添加收货人</a>&nbsp;
        </div>

    </form>
    <form action="/Attchs.do" name="form9" method="post" target="_ajax">
        <input name="act" type="hidden" value="down" />
        <input name="attch" type="hidden" />
    </form>
</div>
<table class="tr" style="display: none;">
    <tr>
        <td class="text-r"><em>*</em>姓名</td>
        <td><input type="text" name="signatory" alt="手机号不能为空" style="width:100%" class="form-control"></td>
        <td class="text-r"><em>*</em>科室</td>
        <td>
            <select style="width:100%" name="department" alt="科室不能为空"  class="form-control">
                <option value="">请选择</option>
                <%
                    for (int i = 1; i < SignFor.DEPARTMENT_ARR.length; i++) {
                        out.print("<option value='"+i+"'>"+SignFor.DEPARTMENT_ARR[i]+"</option>");
                    }

                %>
            </select>
        </td>
    </tr>
    <tr>
        <td class="text-r"><em>*</em>手机号</td>
        <td><input type="text" name="mobile" alt="手机号不能为空" style="width:100%" class="form-control"></td>
        <td class="text-r"><em>*</em>签收类型</td>
        <td>
            <select style="width:100%" name="signType" alt="签收类型不能为空" class="form-control">
                <option value="">请选择</option>
                <option value="0">粒子签收</option>
                <option value="1">发票签收</option>
                <option value="2">粒子+发票签收</option>
            </select>
        </td>
    </tr>
    <tr>
        <td class="text-r"><em>*</em>详细地址</td>
        <td colspan="2"><input type="text" name="address" style="width:100%" alt="详细地址不能为空" class="form-control"></td>
        <td><a href="javascript:;" class="btn btn-default btn-danger" style="padding:4px 12px !important;" onclick="del(this)">删除</a></td>
    </tr>
    <tr><td colspan="4">&nbsp;</td> </tr>
</table>
<%}else {//上传购销合同%>
<div class="qualification con">
     <form id='form3' name="form3" action="/EmpowerRecords.do"  method="post" enctype="multipart/form-data">
        <input type="hidden" name="nexturl">
        <input type="hidden" name="act">
        <input type="hidden" name="eid" value="<%=eid%>">
<input type="hidden" name="uptype" value="<%=uptype%>">
<input type="hidden" name="upid" value="<%=upid%>">

<table id="tablecent" cellspacing="0" class="right-tab4" style="background:none;">
    <tr>
        <td class="text-r" style="width:40%"><em>*</em>医院名称：</td>
        <td>
            <%if(uptype==1){%>
            <input name="hospital" type="hidden" value="<%=er.getHospital()%>" class="hospital" />
            <input name="hospitals" type="text" value="<%=MT.f(sh.getName())%>" readonly class="hospitals form-control" />
            <a href="javascript:;" onclick="showhospitalsearch()">选择医院</a>
            <%}else{%>
            <input name="hospital" type="hidden" value="<%=er.getHospital()%>" class="hospital" />
            <%=MT.f(sh.getName())%>
            <%}%>

        </td>
    </tr>

    <tr>
        <td class="text-r"><em>*</em>购销合同：</td>
        <td>
            <%
                if(er.getContract()>0){
            %>
            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getContract()) %>');">查看</a>
            <%
            }else {%>
            <input name="contract" type="file" alt="购销合同不能为空!">
            <input name="contract.attch" type="hidden" value="<%= MT.f(er.getContract()) %>" />

            <%}
            %>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <div class="center text-c" style="padding-top:0px;padding-bottom:30px;">
                &nbsp;<a href="javascript:;" class="btn btn-primary btn-blue" style="color:#fff;" onclick="subContract()">提交申请</a>&nbsp;

            </div>
        </td>

    </tr>

</table>
     </form>
</div>
<%}%>


</body>
</html>
<script>
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    form2.nexturl.value=location.pathname+location.search;
    function showhospitalsearch(){
        mt.show("/jsp/yl/shop/choseHospital.jsp",2,"查询医院",900,500);
    }
    function subEmpower(){
        if(mtDiag.check1($("#form2"))) {
            form2.act.value = 'perfect';
            form2.submit();
        }
    }
    function upVip(){
        form2.act.value = 'upVip';
        form2.submit();
    }
    function downatt(num){
        form9.attch.value = num;
        form9.submit();
    }
    function signFor(){
        if(mtDiag.check1($("#form3"))){
            form3.submit();
            parent.layer.close(index);
        }

    }
    function addSign(){
        var tlist = $(".tbody");
        var td = $(".tr").html();
        tlist.append(td);
    }
    function del(obj){
        var l = $(obj).parents(".tbody").children("tbody").length;
        console.log(l);
        if(l>1){
            $(obj).parents("tbody").remove();
        }else{
            parent.mtDiag.show("这是最后一行了!");
        }
    }
    function subContract(){
        if(mtDiag.check1($("#form3"))) {
            form3.act.value = 'contract';
            form3.submit();
        }
    }
</script>