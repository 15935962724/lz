
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="tea.entity.*"%>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.entity.yl.shop.EmpowerRecord" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }
    int again = h.getInt("again");//是否是重新申请    1是

    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    int upid = h.getInt("upid");
    String[] stateArr = {"<font color=blue>申请中</font>","<font color=green>申请成功</font>","<font color=red>申请失败</font>"};
    Profile p = Profile.find(h.member);
    int eid = h.getInt("eid");
    EmpowerRecord er = EmpowerRecord.find(eid);
    ShopHospital sh = ShopHospital.find(er.getHospital());


%>
<html>
<head>
    <title>授权申请</title>

    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.3.1.min.js'></script>
    <script src='/tea/yl/top.js'></script>
    <link rel="stylesheet" href="/tea/new/css/style.css">
    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <style>
        td{text-align:left !important;}
        td input{padding:0px 4px;}
        td input[type='file']{
            padding:0px;
        }
        .con {padding:15px 20px 0px;}
        .con table{/*margin:0 auto;*/}
        .con table td{padding:6px 0px;font-size:14px;color:#333333;line-height:20px;}
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
    <form name="form2" action="/EmpowerRecords.do" id="form2" method="post" enctype="multipart/form-data">
        <input type="hidden" name="nexturl">
        <input type="hidden" name="act">
        <input type="hidden" name="upid" value="<%=upid%>">
        <input type="hidden" name="eid" value="<%=eid%>">

        <table id="tablecenter" cellspacing="0" class="right-tab4" style="background:none;">
            <tr>
                <td class="text-r"><em>*</em>服务商：</td>
                <td><%=MT.f(p.getMember())%></td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>医院名称：</td>
                <td>
                    <%if(eid!=0&&again==0){//不是新增%>
                    <input name="hospitals" alt="医院不能为空!" disabled="disabled" id="hospitals" type="text" value="<%=MT.f(sh.getName())%>" readonly class="form-control" style="width:200px" />

                    <%}else {%>
                    <input name="hospital" id="hospital" type="hidden" value="<%=er.getHospital()%>" class="form-control" />
                    <input name="hospitals" alt="医院不能为空!" id="hospitals" type="text" value="<%=MT.f(sh.getName())%>" readonly class="form-control" style="width:200px" />
                    <a href="javascript:;" class="btn btn-default btn-blue" style="margin-left:10px" onclick="showhospitalsearch()">选择医院</a>
                    <%}%>
                    </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>授权有效期：</td>
                <td>
                    <input <%=eid==0||again==1?"":"disabled=\"disabled\""%> name="stateTime" alt="授权有效期开始不能为空!" class="Wdate form-control" value="<%=MT.f(er.getStateTime())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate" type="text" style="width:129px;height:auto;" />
                    <span class="fl" style="padding:7px 10px">至</span>
                    <input <%=eid==0||again==1?"":"disabled=\"disabled\""%> name="endTime" alt="授权有效期结束不能为空!" class="Wdate form-control" value="<%=MT.f(er.getEndTime())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate1" type="text" style="width:129px;height:auto;" />
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>受委托人：</td>
                <td>
                    <input <%=eid==0||again==1?"":"disabled=\"disabled\""%> name="client" id="client" alt="受委托人不能为空!" class="form-control" style="width:292px" type="text" value="<%=MT.f(er.getClient())%>" />
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>受委托人身份证复印件：</td>
                <td>
                     <%
                        if(er.getClientID()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getClientID()) %>');">查看</a>
                    <%
                        }else {
                    %>
                    <input name="clientID" type="file" alt="受委托人身份证复印件不能为空!" title="<%= MT.f(er.getClientID()) %>">
                    <input name="clientID.attch" id="clientID" type="hidden" value="<%= MT.f(er.getClientID()) %>" />
                    <%}

                    if(again==1){%>
                    <input name="clientID" type="file" alt="受委托人身份证复印件不能为空!" title="<%= MT.f(er.getClientID()) %>">
                    <input name="clientID.attch" id="clientID" type="hidden" value="<%= MT.f(er.getClientID()) %>" />
                    <%}%>


                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>辐射安全许可证：</td>
                <td>
                     <%
                        if(er.getRadiationCard()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiationCard()) %>');">查看</a>
                    <%
                        }else {
                       %>
                    <input name="radiationCard" type="file" alt="辐射安全许可证不能为空!" title="<%= MT.f(er.getRadiationCard()) %>">
                    <input name="radiationCard.attch" id="clientID" type="hidden" value="<%= MT.f(er.getRadiationCard()) %>" />
                    <%
                        }
                        if(again==1){%>
                    <input name="radiationCard" type="file" alt="辐射安全许可证不能为空!" title="<%= MT.f(er.getRadiationCard()) %>">
                    <input name="radiationCard.attch" id="clientID" type="hidden" value="<%= MT.f(er.getRadiationCard()) %>" />
                        <%}
                    %>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>辐射安全许可证有效期：</td>
                <td>
                    <input <%=eid==0||again==1?"":"disabled=\"disabled\""%> name="raditaionStart" alt="辐射安全许可证有效期开始不能为空!" class="Wdate form-control" value="<%=MT.f(er.getRaditaionStart())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate" type="text" style="width:129px;height:auto;" />
                    <span class="fl" style="padding:7px 10px">至</span>
                    <input <%=eid==0||again==1?"":"disabled=\"disabled\""%> name="radiation" alt="辐射安全许可证有效期结束不能为空!" class="Wdate form-control" value="<%=MT.f(er.getRadiation())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate1" type="text" style="width:129px;height:auto;" />
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>放射诊疗许可证：</td>
                <td>
                    <%
                        if(er.getRadiate()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiate()) %>');">查看</a>
                    <%
                        }else {%>
                    <input name="radiate" type="file" alt="放射诊疗许可证不能为空!" title="<%= MT.f(er.getRadiate()) %>">
                    <input name="radiate.attch" type="hidden" value="<%= MT.f(er.getRadiate()) %>" />
                    <%}
                    if(again==1){
                    %>
                    <input name="radiate" type="file" alt="放射诊疗许可证不能为空!" title="<%= MT.f(er.getRadiate()) %>">
                    <input name="radiate.attch" type="hidden" value="<%= MT.f(er.getRadiate()) %>" />
                    <%}%>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>放射性药品使用许可证：</td>
                <td>
                       <%
                        if(er.getRadiateCard()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiateCard()) %>');">查看</a>
                    <%
                        }else {%>
                    <input name="radiateCard" type="file"  alt="放射性药品使用许可证不能为空!" title="<%= MT.f(er.getRadiateCard()) %>">
                    <input name="radiateCard.attch" type="hidden" value="<%= MT.f(er.getRadiateCard()) %>" />

                    <%}
                    if(again==1){%>
                    <input name="radiateCard" type="file"  alt="放射性药品使用许可证不能为空!" title="<%= MT.f(er.getRadiateCard()) %>">
                    <input name="radiateCard.attch" type="hidden" value="<%= MT.f(er.getRadiateCard()) %>" />
                    <%}
                    %>
                </td>
            </tr>
            <tr>
                <td class="text-r"><em>*</em>授权申请：</td>
                <td>
                      <%
                        if(er.getEmpower()>0){
                    %>
                    <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getEmpower()) %>');">查看</a>
                    <%
                        }else {%>
                    <input name="empower" type="file" alt="授权申请不能为空!" title="<%=MT.f(er.getEmpower()) %>">
                    <input name="empower.attch" type="hidden" value="<%= MT.f(er.getEmpower()) %>" />

                    <% }
                    if(again==1){%>
                    <input name="empower" type="file" alt="授权申请不能为空!" title="<%=MT.f(er.getEmpower()) %>">
                    <input name="empower.attch" type="hidden" value="<%= MT.f(er.getEmpower()) %>" />
                    <%}
                    %>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><a href="/tea/EmpowerRecord.doc" style="color:#044694;text-decoration: underline" download="/tea/EmpowerRecord.doc" class="btn-link">下载授权申请模板</a></td>
            </tr>
        </table>
    </form>

</div>
<div class="center text-c pd20">
    <%if(eid==0||again==1){%>
            <a href="javascript:;" onclick="subEmpower()" class="btn btn-primary btn-blue">提交审核</a>&nbsp;&nbsp;

    <%}%>
    <button class="btn btn-default" type="button" onclick="closetc()">关闭</button>
</div>
<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
</form>
</body>
</html>
<script>
    var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    function closetc() {
        parent.layer.close(index);
    }
    function downatt(num){
        form9.attch.value = num;
        form9.submit();
    }
    form2.nexturl.value=location.pathname+location.search;
    function showhospitalsearch(){
        //mt.show("/jsp/yl/shop/choseHospital.jsp",2,"查询医院",900,500);
        parent.layer.open({
            type: 2,
            title: '查询医院',
            shadeClose: true,
            area: ['700px', '550px'],
            closeBtn:1,
            content: '/jsp/yl/shop/choseHospital.jsp?upid=<%=upid%>'
        });

    }
    // mt.receive=function(h,n){
    //     document.getElementById("hospital").value=h;
    //     document.getElementById("hospitals").value=n;
    // };
    function subEmpower(){
        if(mtDiag.check1($("#form2"))){
            form2.act.value = 'empower';
            form2.submit();

        }

    }
</script>