
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
    int upid = h.getInt("upid");
    Profile p = Profile.find(h.member);
    int eid = h.getInt("eid");
    int sid = h.getInt("sid");
    EmpowerRecord er = EmpowerRecord.find(eid);
    ShopHospital sh = ShopHospital.find(er.getHospital());
    String[] arr = {"粒子签收","发票签收","粒子&发票签收"};

%>
<html>
<head>
    <title>授权申请</title>

    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src='/tea/jquery-1.11.1.min.js'></script>
    <script src='/tea/yl/top.js'></script>
    <link rel="stylesheet" href="/tea/new/css/style.css">
    <script src='/tea/laydate-master/laydate.dev.js'></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <link rel="stylesheet" href="/tea/new/css/bootstrap.css">
    <link rel="stylesheet" href="/tea/new/css/animate.css">
    <link rel="stylesheet" href="/tea/new/css/style1.css">
    <link rel="stylesheet" href="/tea/new/css/common.css">
    <script src="/tea/new/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1 class="head-tit animate-box" data-animate-effect="fadeInLeft">申请VIP流程</h1>
            <div class="rate animate-box" data-animate-effect="fadeInLeft">
                <span class="active animate-box" data-animate-effect="fadeInLeft"><em>1</em><br>填写资质信息</span>
                <span class="animate-box last" data-animate-effect="fadeInLeft"><em>2</em><br>资质审核</span>
            </div>
            <div class="rate-fot animate-box">
                <p>1. 请严格按照相关证件信息进行正确填写</p>
                <p>2. 请上传最新版的证件原件的彩色扫描或彩色照片，复印件需加盖公司红章</p>
                <p>3. 请确保上传图片信息清晰可辨，支持格式：JPG BMP JPEG PNG大小不超过2M</p>
            </div>
            <h2 class="head-hd animate-box" data-animate-effect="fadeInLeft">资质信息</h2>
            <form class="form-horizontal" name="form2" action="/EmpowerRecords.do" id="form2" method="post" enctype="multipart/form-data" target="_ajax">
                <input type="hidden" name="nexturl">
                <input type="hidden" name="act" value="upVip">
                <input type="hidden" name="upid" value="<%=upid%>">
                <input type="hidden" name="eid" value="<%=eid%>">
                <div class="natural upVip animate-box" data-animate-effect="fadeInLeft">

                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>姓名</label>
                        <div class="col-sm-9">
                            <p><%=MT.f(p.getMember())%></p>
                            <%--<input type="text" class="form-control" id="" placeholder="请输入姓名">--%>
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>手机</label>
                        <div class="col-sm-9">
                            <p><%=p.getMobile()%></p>
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label  class="col-sm-3 control-label"><em>*</em>医院名称</label>
                        <div class="col-sm-9">
                            <input name="hospital" id="hospital" type="hidden" value="<%=er.getHospital()%>" class="form-control" />
                            <input name="hospitals" class="form-control fl" alt="医院不能为空!" id="hospitals" type="text" value="<%=MT.f(sh.getName())%>" readonly class="form-control" style="width:200px" />
                            <a href="javascript:;" class="btn btn-default btn-blue" style="margin-left:10px" onclick="showhospitalsearch()">选择医院</a>
                        </div>
                    </div>

                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>转出/转入审批表</label>
                        <div class="col-sm-9">
                            <input name="turnApproval" type="file" alt="转入/转出审批表不能为空!">
                            <input name="turnApproval.attch" type="hidden" value="<%= MT.f(er.getTurnApproval()) %>" />
                            <%
                                if(er.getTurnApproval()>0){
                            %>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getTurnApproval()) %>');">查看</a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>辐射安全许可证</label>
                        <div class="col-sm-9">
                            <input name="radiationCard" type="file" alt="辐射安全许可证不能为空!" title="<%= MT.f(er.getRadiationCard()) %>">
                            <input name="radiationCard.attch" id="clientID" type="hidden" value="<%= MT.f(er.getRadiationCard()) %>" />
                            <%
                                if(er.getRadiationCard()>0){
                            %>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiationCard()) %>');">查看</a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-offset-3 col-sm-9 ts">
                            注:上传图片格式gif\jpg\png\bmp,大小不超过2M
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>辐射安全许可证有效期</label>
                        <div class="col-sm-9">
                            <input name="raditaionStart" alt="辐射安全许可证有效期开始不能为空!" class="Wdate form-control fl" value="<%=MT.f(er.getRaditaionStart())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate" type="text" style="width:129px;height:auto;" />
                            <span class="fl" style="padding:7px 10px">至</span>
                            <input name="radiation" alt="辐射安全许可证有效期结束不能为空!" class="Wdate form-control fl" value="<%=MT.f(er.getRadiation())%>" onfocus="WdatePicker({minDate:'%y-%M-%d'})" id="makeoutdate1" type="text" style="width:129px;height:auto;" />
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>放射诊疗许可证</label>
                        <div class="col-sm-9">
                            <input name="radiate" type="file" alt="放射诊疗许可证不能为空!" title="<%= MT.f(er.getRadiate()) %>">
                            <input name="radiate.attch" type="hidden" value="<%= MT.f(er.getRadiate()) %>" />
                            <%
                                if(er.getRadiate()>0){
                            %>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiate()) %>');">查看</a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>放射性药品使用许可证</label>
                        <div class="col-sm-9">
                            <input name="radiateCard" type="file"  alt="放射性药品使用许可证不能为空!" title="<%= MT.f(er.getRadiateCard()) %>">
                            <input name="radiateCard.attch" type="hidden" value="<%= MT.f(er.getRadiateCard()) %>" />
                            <%
                                if(er.getRadiateCard()>0){
                            %>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getRadiateCard()) %>');">查看</a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                        <label class="col-sm-3 control-label"><em>*</em>粒子签收人/发票签收人</label>
                        <div class="col-sm-9">
                            <input name="signFor" type="file" alt="粒子签收人/发票签收人!">
                            <input name="signFor.attch" type="hidden" value="<%= MT.f(er.getSignFor()) %>" />
                            <%
                                if(er.getSignFor()>0){
                            %>
                            <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(er.getSignFor()) %>');">查看</a>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>

                <p class="right-zhgl animate-box" data-animate-effect="fadeInLeft"><b style="font-size:14px;">签收人</b></p>
                <style>
                    .right-tab4 td{padding:5px !important;}
                    .right-zhgl{
                        border-top:1px #ddd solid;
                        padding-top:10px;
                    }
                    select{padding:5px 0px !important;}
                </style>
                <input type="hidden" name="sid" value="<%=sid%>">
                <table class="right-tab4 tbody animate-box" data-animate-effect="fadeInLeft" border="0" cellpadding="0" cellspacing="0">
                    <tbody>
                    <%
                        List<SignFor> list = SignFor.find(" and eid=" + eid, 0, Integer.MAX_VALUE);
                        if(list.size()<1){
                    %>
                    <tr>
                        <td class="text-r"><em>*</em>姓名</td>
                        <td><input type="text" name="signatory" alt="签收人姓名不能为空!" style="width:100%" class="form-control"></td>
                        <td class="text-r"><em>*</em>科室</td>
                        <td>
                            <select style="width:100%" name="department" alt="请选择签收人科室!"  class="form-control">
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
                        <td><input type="text" name="mobile" alt="签收人手机号不能为空!" style="width:100%" class="form-control"></td>
                        <td class="text-r"><em>*</em>签收类型</td>
                        <td>
                            <select style="width:100%" name="signType" alt="请选择签收人签收类型" class="form-control">
                                <option value="">请选择</option>
                                <option value="0">粒子签收</option>
                                <option value="1">发票签收</option>
                                <option value="2">粒子+发票签收</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-r"><em>*</em>详细地址</td>
                        <td colspan="2"><input type="text" name="address" style="width:100%" alt="签收人详细地址不能为空" class="form-control"></td>
                        <td><a href="javascript:;" class="btn btn-default btn-danger" style="padding:4px 12px !important;" onclick="del(this)">删除</a></td>
                    </tr>
                    <tr><td colspan="4">&nbsp;</td> </tr>
                    <%}else{
                        for (int i = 0; i < list.size(); i++) {
                            SignFor sf = list.get(i);

                    %>
                    <tr>
                        <td class="text-r"><em>*</em>姓名</td>
                        <td><input type="text" name="signatory" alt="签收人姓名不能为空!" style="width:100%" value="<%=MT.f(sf.getSignatory())%>" class="form-control"></td>
                        <td class="text-r"><em>*</em>科室</td>
                        <td>
                            <select style="width:100%" name="department" alt="请选择签收人科室!"  class="form-control">
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
                        <td><input type="text" name="mobile" alt="签收人手机号不能为空!" style="width:100%" class="form-control" value="<%=MT.f(sf.getMobile())%> "></td>
                        <td class="text-r"><em>*</em>签收类型</td>
                        <td>
                            <select style="width:100%" name="signType" alt="请选择签收人签收类型!" class="form-control">
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
                        <td colspan="2"><input type="text" name="address" style="width:100%" alt="签收人详细地址不能为空!" class="form-control"  value="<%=MT.f(sf.getAddress())%>"></td>
                        <td><a href="javascript:;" class="btn btn-default btn-danger" style="padding:4px 12px !important;" onclick="del(this)">删除</a></td>
                    </tr>
                    <tr><td colspan="4">&nbsp;</td> </tr>
                    <%}}%>
                    </tbody>

                </table>

                <div class="center text-c animate-box" data-animate-effect="fadeInLeft" style="padding-top:0px;padding-bottom:30px;">
                    <a href="javascript:;" class="btn btn-default" onclick="addSign()">添加收货人</a>&nbsp;
                    <a href="javascript:;" onclick="upVip()" class="btn btn-primary btn-blue">提交申请</a>
                </div>
            </form>
        </div>
    </div>
</div>

<table class="tr animate-box" data-animate-effect="fadeInLeft" style="display: none;">
    <tr>
        <td class="text-r"><em>*</em>姓名</td>
        <td><input type="text" name="signatory" alt="签收人手机号不能为空" style="width:100%" class="form-control"></td>
        <td class="text-r"><em>*</em>科室</td>
        <td>
            <select style="width:100%" name="department" alt="请选择签收人科室"  class="form-control">
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
        <td><input type="text" name="mobile" alt="签收人手机号不能为空" style="width:100%" class="form-control"></td>
        <td class="text-r"><em>*</em>签收类型</td>
        <td>
            <select style="width:100%" name="signType" alt="请选择签收人签收类型" class="form-control">
                <option value="">请选择</option>
                <option value="0">粒子签收</option>
                <option value="1">发票签收</option>
                <option value="2">粒子+发票签收</option>
            </select>
        </td>
    </tr>
    <tr>
        <td class="text-r"><em>*</em>详细地址</td>
        <td colspan="2"><input type="text" name="address" style="width:100%" alt="签收人详细地址不能为空" class="form-control"></td>
        <td><a href="javascript:;" class="btn btn-default btn-danger" style="padding:4px 12px !important;" onclick="del(this)">删除</a></td>
    </tr>
    <tr><td colspan="4">&nbsp;</td> </tr>
</table>


<%--<script src="/tea/new/js/jquery.waypoints.min.js"></script>--%>
<%--<script src="/tea/new/js/main.js"></script>--%>

<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
</form>
</body>
</html>
<script>

    form2.nexturl.value=location.pathname+location.search;
    function showhospitalsearch(){
        layer.open({
            type: 2,
            title: '查询医院',
            shadeClose: true,
            area: ['700px', '550px'],
            closeBtn:1,
            content: '/jsp/yl/shop/choseHospital.jsp?upid=<%=upid%>'
        });
    }

    mt.receive=function(h,n){
        $("#hospital").val(h);
        $("#hospitals").val(n);
    }

    function upVip(){
        if(mtDiag.check($("#form2"))) {
            form2.submit();
        }
    }
    function addSign(){
        var tlist = $(".tbody");
        var td = $(".tr").html();
        tlist.append(td);
        mt.fit();
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

    function downatt(num){
        form9.attch.value = num;
        form9.submit();
    }
    mt.fit();
</script>
