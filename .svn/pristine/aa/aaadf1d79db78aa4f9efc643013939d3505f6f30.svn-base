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
    String type = h.get("type");//update？修改
    Boolean flag=true;
    if(er.getNumber_mail()!=null){//有值了
        flag=false;
        if("update".equals(type)){
            flag=true;
        }
    }



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

<div class="qualification con">

    <form id='form2' name="form1" action="/EmpowerRecords.do" target="_ajax" id="form2" method="post" enctype="multipart/form-data">
        <input type="hidden" name="nexturl">
        <input type="hidden" name="act">
        <input type="hidden" name="eid" value="<%=eid%>">
        <input type="hidden" name="uptype" value="<%=uptype%>">
        <input type="hidden" name="upid" value="<%=upid%>">

        <table id="tablecenter" cellspacing="0" class="right-tab4" style="background:none;">
            <tr>
                <td class="text-r" style="width:40%"><%=flag?"<em>*</em>":""%>医院名称：</td>
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
                <td class="text-r"><%=flag?"<em>*</em>":""%>服务商授权书：</td>
                <td>
                    <%
                        if(er.getCertificate()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getSignFor()) %>');">查看</a>
                    <%
                    }else {%>
                    <span>未上传电子版服务商授权书</span>

                    <%}
                    %>
                </td>
            </tr>
            <tr>

                <%if(flag){%>
                <td class="text-r"><em>*</em>邮寄公司：</td>
                <td>
                    <input name="company_mail" alt="邮寄公司不能为空！" value="<%=MT.f(er.getCompany_mail())%>">
                </td>
                <%}else {%>
                <td class="text-r">邮寄公司：</td>
                <td>
                    <span class="text-r"><%=er.getCompany_mail()%></span>
                </td>
                <%}%>

            </tr>
            <tr>
                <%if(flag){%>
                    <td class="text-r"><em>*</em>快递单号：</td>
                <td>
                    <input name="number_mail" alt="快递单号不能为空！"  value="<%=MT.f(er.getNumber_mail())%>">
                </td>
                <%}else {%>
                <td class="text-r">快递单号：</td>
                <td>
                    <span class="text-r"><%=er.getNumber_mail()%></span>
                </td>
                <%}%>

            </tr>
            <tr>
                <td>

                </td>
                <td></td>
            </tr>

        </table>



        <style>
            .right-tab4 td{padding:5px !important;}
            .right-zhgl{
                border-top:1px #ddd solid;
                padding-top:10px;
            }
            select{padding:5px 0px !important;}
        </style>
        <%
            if(1!=h.getInt("onlyread")){
            if(er.getNumber_mail()!=null&&type==null){//修改%>
        <div class="center text-c" style="padding-top:0px;padding-bottom:30px;">
            &nbsp;<a href="javascript:;" class="btn btn-primary btn-blue" style="color:#fff;" onclick="xiugai('<%=er.getEid()%>')">修改邮寄信息</a>&nbsp;
        </div>
        <%}else if(er.getNumber_mail()==null||type!=null){%>
        <div class="center text-c" style="padding-top:0px;padding-bottom:30px;">
            &nbsp;<a href="javascript:;" class="btn btn-primary btn-blue" style="color:#fff;" onclick="subEmpower()">确认邮寄</a>&nbsp;
        </div>
        <%}}%>


    </form>
    <form action="/Attchs.do" name="form9" method="post" target="_ajax">
        <input name="act" type="hidden" value="down" />
        <input name="attch" type="hidden" />
    </form>
</div>


</body>
</html>
<script>
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    form2.nexturl.value=location.pathname+location.search;
    function showhospitalsearch(){
        mt.show("/jsp/yl/shop/choseHospital.jsp",2,"查询医院",900,500);
    }
    function subEmpower(){
        if(mtDiag.check($("#form2"))) {
            form2.act.value = 'mail_ShouQuan';
            form2.submit();
        }
    }
    function xiugai(id) {
        location.href="/jsp/yl/shopweb/AmilShouQuan.jsp?type=update&eid="+id;
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