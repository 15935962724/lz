<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.Http" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.EmpowerRecord" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%@ page import="tea.entity.yl.shop.SignFor" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="java.util.List" %>
<%

    Http h = new Http(request, response);
    if(h.member<1)
    {
        String param = request.getQueryString();
        String url = request.getRequestURI();
        if(param != null)
            url = url + "?" + param;
        response.sendRedirect("/mobjsp/yl/user/login_mob.html?nexturl="+Http.enc(url));
        //response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }
    /*if (h.member < 1) {
        //response.sendRedirect("/servlet/StartLogin?community="+h.community);
        out.print("<script>parent.location='" + "/servlet/StartLogin?community=" + h.community + "';</script>");
        return;
    }*/

    StringBuffer sql = new StringBuffer(), par = new StringBuffer();
    int member = h.member;
    Profile p = Profile.find(member);
    String[] stateArr = {"<font color=blue>申请中</font>", "<font color=green>申请成功</font>", "<font color=red>申请失败</font>"};
    String[] uptypeArr = {"服务商", "vip"};
    List<UpProfile> list = UpProfile.find("AND isdele=0 and profile=" + member, 0, Integer.MAX_VALUE);
    UpProfile up = null;
    EmpowerRecord er = null;
    ShopHospital hos = null;
    if (list.size() > 0) {
        up = list.get(0);
        List<EmpowerRecord> erList = EmpowerRecord.find(" and upid=" + up.getUpid(), 0, 1);
        er = erList.get(0);
        hos = ShopHospital.find(er.getHospital());
    } else {
        up = new UpProfile();
        er = new EmpowerRecord();
        hos = new ShopHospital(0);
    }

    int state = up.getState();
    String[] statearr = {"申请中", "审核通过", "审核未通过"};
    String[] arr = {"粒子签收", "发票签收", "粒子&发票签收"};
    int type1 = h.getInt("type");
    if(state==1){//通过
        response.sendRedirect("/mobjsp/yl/shopweb/SPapply2.jsp");
    }

%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>申请医生</title>
    <link rel="stylesheet" href="../css/date.css">
    <link rel="stylesheet" href="../css/m-style.css">
    <link rel="stylesheet" href="../css/xj-style.css">
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src="/tea/yl/jquery-1.7.js"></script>
    <script src="/tea/yl/top.js"></script>
    <script src="/tea/yl/mtDiag.js"></script>
    <script src="/jsp/yl/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<%--    <link rel="stylesheet" href="/tea/new/css/bootstrap.css">--%>
<%--    <link rel="stylesheet" href="/tea/new/css/animate.css">--%>
<%--    <link rel="stylesheet" href="/tea/new/css/common.css">--%>
    <script src="/tea/jquery-1.11.1.min.js"></script>
</head>
    <style>
        #datePage{height:200px;}
    select{
        height: 32px;
        border-radius: 2px;
        border: 1px solid #cccccc;
        background: #fff;
        width: 172px;
    }
    .file {
    position: relative;
    display: inline-block;
    border: none;
    overflow: hidden;
    color: #044694;
    text-decoration: none;
    text-indent: 0;
    width:100%;
    line-height: 20px;
    }
    .file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
    }
    .file:hover {
    color: #044694;
    text-decoration: none;
    }
    .showFileName{margin-left:10px;display:inline-block;width:70%;overflow:hidden;text-overflow:ellipsis;}
    @media screen and (max-width: 320px) {
    .file{width:200px;}
    .showFileName{width:70%;}
    }
    </style>
<body>
<div class="body">
<%--    <div class="Header">--%>
<%--        <p class="header-tit ft18">--%>
<%--            <img src="../img/icon1.png" alt="" class="fl-left m-head-logo">--%>
<%--            <span>申请VIP</span>--%>
<%--            <img src="../img/icon2.png" alt="" class="head-list fl-right">--%>
<%--        </p>--%>
<%--    </div>--%>
<%--    <!-- 下拉 -->--%>
<%--    <div class="head-dh-list">--%>
<%--        <h3 class="bor-b ft16">首页</h3>--%>
<%--        <h3 class="bor-b ft16 head-dh-y">--%>
<%--            解决方案--%>
<%--            <img src="../img/icon12.png" class="fl-right" alt="">--%>
<%--        </h3>--%>
<%--        <ul>--%>
<%--            <li class="ft16">近距离治疗药物</li>--%>
<%--            <li class="ft16 head-ys-li">碘[<sup>125</sup>I]</li>--%>
<%--            <li class="ft16 head-ys-li">钯[<sup>103</sup>Pd]</li>--%>
<%--            <li class="ft16 head-ys-li">铱[<sup>90</sup>Y]</li>--%>
<%--            <li class="ft16 head-ys-li">铯[<sup>131</sup>Cs]</li>--%>

<%--            <li class="ft16">治疗计划系统TPS</li>--%>
<%--            <li class="ft16">植入设备/器械</li>--%>
<%--            <li class="ft16 head-ys-li">粒子植入设备与器械</li>--%>
<%--            <li class="ft16 head-ys-li">计划导航系统</li>--%>
<%--            <li class="ft16 head-ys-li">辐射检测与防护</li>--%>
<%--            <li class="ft16">手术支持服务</li>--%>
<%--            <li class="ft16 head-ys-li"> 前列腺设备支持服务</li>--%>
<%--            <li class="ft16 head-ys-li">远程计划系统服务</li>--%>
<%--        </ul>--%>
<%--        <h3 class="bor-b ft16">--%>
<%--            产品--%>
<%--        </h3>--%>
<%--        <h3 class="bor-b ft16 head-dh-y">--%>
<%--            患者--%>
<%--            <img src="../img/icon12.png" class="fl-right" alt="">--%>
<%--        </h3>--%>
<%--        <ul>--%>
<%--            <li class="ft16">粒子治疗简介</li>--%>
<%--            <li class="ft16 head-ys-li">治疗部位</li>--%>
<%--            <li class="ft16 head-ys-li">适应症</li>--%>
<%--            <li class="ft16 head-ys-li">禁忌症</li>--%>
<%--            <li class="ft16">患者指南</li>--%>
<%--            <li class="ft16 head-ys-li">专业术语</li>--%>
<%--            <li class="ft16 head-ys-li">常见问题</li>--%>
<%--            <li class="ft16 head-ys-li">病患防护</li>--%>
<%--            <li class="ft16">招募计划</li>--%>
<%--        </ul>--%>
<%--        <h3 class="bor-b ft16 head-dh-y">--%>
<%--            医生--%>
<%--            <img src="../img/icon12.png" class="fl-right" alt="">--%>
<%--        </h3>--%>
<%--        <ul>--%>
<%--            <li class="ft16">政策法规</li>--%>
<%--            <li class="ft16">医院资质</li>--%>
<%--            <li class="ft16">临床资料</li>--%>
<%--            <li class="ft16 head-ys-li">PPT</li>--%>
<%--            <li class="ft16 head-ys-li">文献</li>--%>
<%--            <li class="ft16 head-ys-li">视频</li>--%>
<%--            <li class="ft16">放射性同位素手册</li>--%>
<%--            <li class="ft16">病患防护</li>--%>
<%--        </ul>--%>
<%--        <h3 class="bor-b ft16 head-dh-y">--%>
<%--            活动资讯--%>
<%--            <img src="../img/icon12.png" class="fl-right" alt="">--%>
<%--        </h3>--%>
<%--        <ul>--%>
<%--            <li class="ft16">行业新闻</li>--%>
<%--            <li class="ft16">会议活动</li>--%>
<%--        </ul>--%>
<%--        <h3 class="bor-b ft16 head-dh-y">--%>
<%--            关于--%>
<%--            <img src="../img/icon12.png" class="fl-right" alt="">--%>
<%--        </h3>--%>
<%--        <ul>--%>
<%--            <li class="ft16">公司介绍</li>--%>
<%--            <li class="ft16">联系我们</li>--%>
<%--        </ul>--%>
<%--    </div>--%>
    <div class="Content">
        <p class="Header_tit2 ft16">申请医生</p>
        <!-- 进度条 -->
        <div class="sop">
            <p class="sop_tit">
                <span class="fl-left sop_tit_co">填写资质信息</span>
                <span class="fl-right">资质审核</span>
            </p>
            <div class="sop_jdt">
                <p></p>
                <span></span>
            </div>
        </div>
        <%if (up.getUpid() == 0||type1==1) {//新增  或修改 %>
        <div class="SPexplain">
            <p>1.请严格按照相关证件信息进行正确填写</p>
            <p>2.请上传最新版的证件原件的彩色扫描或彩色照片，复印件需加盖公司红章</p>
            <p>3.请确保上传图片信息清晰可辨，支持格式: JPG BMP JPEG PNG大小不超过2M</p>
        </div>
        <!-- 资质信息 -->
        <form class="form-horizontal" name="form2" action="/EmpowerRecords.do" id="form2" method="post"
              enctype="multipart/form-data" target="_ajax">
            <input type="hidden" name="nexturl" value="/mobjsp/yl/shopweb/VIPapply.jsp">
            <input type="hidden" name="act" value="upVip">
            <input type="hidden" name="upid" value="<%=up.getUpid() %>">
            <input type="hidden" name="eid" value="<%=er.getEid() %>">
            <input type="hidden" name="ismobile" value="1">

            <p class="sans_tit">资质信息</p>
            <div class="quali ft14">
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">用户名</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%--<input type="text" placeholder="请输入姓名" class="quali_input">--%>
                        <%=p.getMember()%>
                    </div>
                </div>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">手机</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%-- <input type="number" placeholder="请输入手机号" class="quali_input">--%>
                        <%=p.getMobile()%>
                    </div>
                </div>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">医院名称</label>
                    </div>
                    <div class="quali_cell_bd">
                        <!-- <input type="text" placeholder="选择医院" class="quali_input"> -->
                        <%-- <select name="" class="quali_select">
                             <option value="">选择医院</option>
                         </select>--%>
                        <input name="hospital" id="hospital" type="hidden" value="<%=er.getHospital()%>"
                               class="form-control"/>
                        <input name="hospitals" class="quali_input" alt="医院不能为空!" id="hospitals" type="text"
                               value="<%=MT.f(hos.getName())%>" readonly class="form-control" style="width:58%"/>

                        <a href="javascript:;" class="btn btn-default btn-blue" style="margin-left:10px;float:right"
                           onclick="showhospitalsearch()">选择医院</a>

                    </div>
                </div>
                <%--<div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">地址</label>
                    </div>
                    <div class="quali_cell_bd">
                        <input type="text" placeholder="选择地址" class="quali_input">
                    </div>
                </div>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">详细地址</label>
                    </div>
                    <div class="quali_cell_bd">
                        <input type="text" placeholder="填写详细地址" class="quali_input">
                    </div>
                </div>--%>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label">转入/转出审批表</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%--<label for="kaihu" class="quali_input_label">上传</label>
                        <input type="file" class="quali_input2" id="kaihu">--%>

                        <%if(er.getTurnApproval()==0||type1==1){%>

                            <a href="javascript:;" class="file">
                                <span class='showFileName'></span>
                                <span style='float:right'>上传</span>
                                <input type="file" class=' a-upload' name="turnApproval" id="" alt="转入/转出审批表不能为空!">
                            </a>
<%--                            <input name="turnApproval" type="file" alt="转入/转出审批表不能为空!">--%>
                            <input name="turnApproval.attch" type="hidden" value="<%= MT.f(er.getTurnApproval()) %>"/>
                        <%}
                            if (er.getTurnApproval() > 0) {
                        %>
                        <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(er.getTurnApproval()) %>');">查看</a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label">辐射安全许可证</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%--<label for="qita" class="quali_input_label">上传</label>
                        <input type="file" class="quali_input2" id="qita">--%>
                        <%if(er.getRadiationCard()==0||type1==1){%>
                        <a href="javascript:;" class="file">
                            <span class='showFileName'></span>
                            <span style='float:right'>上传</span>
                            <input type="file" class=' a-upload' name="radiationCard" id="" alt="辐射安全许可证不能为空!" title="<%= MT.f(er.getRadiationCard()) %>">
                        </a>
<%--                            <input name="radiationCard" type="file" alt="辐射安全许可证不能为空!"  title="<%= MT.f(er.getRadiationCard()) %>">--%>
                            <input name="radiationCard.attch" id="clientID" type="hidden"
                                   value="<%= MT.f(er.getRadiationCard()) %>"/>
                        <%}
                            if (er.getRadiationCard() > 0) {
                        %>
                        <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(er.getRadiationCard()) %>');">查看</a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="quali_cell" style="display: block;">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label">辐射安全许可证有效期</label>
                    </div>
                    <div class="quali_cell_bd">
                        <div id="datePlugin"></div>
                        <input value="<%=MT.f(er.getRaditaionStart())%>" name="raditaionStart" alt="辐射安全许可证有效期开始不能为空!"
                               type="text" id="dateinput"
                               style="width:45%;height:32px;line-height:32px;font-size:1rem;text-align:center;border: 1px solid #ccc;border-radius: 4px;"/>至
                        <input value="<%=MT.f(er.getRadiation())%>" name="radiation" alt="辐射安全许可证有效期结束不能为空!" type="text"
                               id="dateinput2"
                               style="width:45%;height:32px;line-height:32px;font-size:1rem;text-align:center;border: 1px solid #ccc;border-radius: 4px;"/>
                        <%-- <div id="datePlugin"></div>
                         <input type="text" id="dateinput" style="width:45%;height:40px;line-height:40px;font-size:1rem;text-align:center;border: 1px solid #ccc;border-radius: 4px;" />至
                         <input type="text" id="dateinput2" style="width:45%;height:40px;line-height:40px;font-size:1rem;text-align:center;border: 1px solid #ccc;border-radius: 4px;" />--%>
                    </div>
                </div>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label">放射诊疗许可证</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%--<label for="qita" class="quali_input_label">上传</label>
                        <input type="file" class="quali_input2" id="qita">--%>
                        <%if(er.getRadiate()==0||type1==1){%>
                        <a href="javascript:;" class="file">
                            <span class='showFileName'></span>
                            <span style='float:right'>上传</span>
                            <input type="file" class=' a-upload' name="radiate" id="" alt="放射诊疗许可证不能为空!" title="<%= MT.f(er.getRadiate()) %>">
                        </a>
<%--                            <input name="radiate" type="file" alt="放射诊疗许可证不能为空!" title="<%= MT.f(er.getRadiate()) %>">--%>
                            <input name="radiate.attch" type="hidden" value="<%= MT.f(er.getRadiate()) %>"/>
                            <%}
                            if (er.getRadiate() > 0) {
                        %>
                        <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(er.getRadiate()) %>');">查看</a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label">放射性药品使用许可证</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%--<label for="qita" class="quali_input_label">上传</label>
                        <input type="file" class="quali_input2" id="qita">--%>
                        <%if(er.getRadiateCard()==0||type1==1){%>
                        <a href="javascript:;" class="file">
                            <span class='showFileName'></span>
                            <span style='float:right'>上传</span>
                            <input type="file" class=' a-upload' name="radiateCard" id="" alt="放射性药品使用许可证不能为空!" title="<%= MT.f(er.getRadiateCard()) %>">
                        </a>
<%--                            <input name="radiateCard" type="file" alt="放射性药品使用许可证不能为空!" title="<%= MT.f(er.getRadiateCard()) %>">--%>
                            <input name="radiateCard.attch" type="hidden" value="<%= MT.f(er.getRadiateCard()) %>"/>
                            <%}
                            if (er.getRadiateCard() > 0) {
                        %>
                        <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(er.getRadiateCard()) %>');">查看</a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="quali_cell" style='border:none'>
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label">粒子签收人/发票签收人</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%-- <label for="qita" class="quali_input_label">上传</label>
                         <input type="file" class="quali_input2" id="qita">--%>
                        <%if(er.getSignFor()==0||type1==1){%>
                        <a href="javascript:;" class="file">
                            <span class='showFileName'></span>
                            <span style='float:right'>上传</span>
                            <input type="file" class=' a-upload' name="signFor" id="" alt="粒子签收人/发票签收人!">
                        </a>
<%--                            <input name="signFor" type="file" alt="粒子签收人/发票签收人!">--%>
                            <input name="signFor.attch" type="hidden" value="<%= MT.f(er.getSignFor()) %>"/>

                            <%}
                            if (er.getSignFor() > 0) {
                        %>
                        <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(er.getSignFor()) %>');">查看</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
            <% List<SignFor> list3 = SignFor.find(" and eid=" + er.getEid(), 0, Integer.MAX_VALUE);
                SignFor s1=null;
                SignFor s2=null;
            if(list3.size()>0) {
                s1 = list3.get(0);
                 s2 = list3.get(1);
            }else {
                s1=SignFor.find(0);
                s2=SignFor.find(0);
            }
            %>

            <p class="sans_tit">粒子签收人信息</p>
            <div class="quali ft14">
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">姓名</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%--<input type="text" placeholder="请输入姓名" class="quali_input">--%>
                        <input value="<%=MT.f(s1.getSignatory())%>" type="text" name="signatory" alt="签收人姓名不能为空!" placeholder="请输入姓名" class="quali_input">
                    </div>
                </div>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">电话</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%--<input type="num" placeholder="请输入手机号" class="quali_input">--%>
                        <input value="<%=MT.f(s1.getMobile())%>" type="text" name="mobile" alt="签收人手机号不能为空!" placeholder="请输入手机号" class="quali_input">
                    </div>
                </div>
                <%--<div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">邮箱</label>
                    </div>
                    <div class="quali_cell_bd">
                        <input type="text" placeholder="填写邮箱" class="quali_input">
                    </div>
                </div>--%>
                <%-- <div class="quali_cell">
                     <div class="quali_cell_hd">
                         <label class="quali_label quali_label70">地址</label>
                     </div>
                     <div class="quali_cell_bd">
                         <input type="text" placeholder="选择地址" class="quali_input">
                     </div>
                 </div>--%>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">科室</label>
                    </div>
                    <select style="width:100%" name="department" alt="请选择签收人科室!" class="form-control">
                        <option value="">请选择</option>
                        <%
                            for (int j = 1; j < SignFor.DEPARTMENT_ARR.length; j++) {
                                if(s1.getDepartment()==j){
                                    out.print("<option value='" + j + "' 'selected:selected' >" + SignFor.DEPARTMENT_ARR[j] + "</option>");
                                }else {
                                    out.print("<option value='" + j + "' >" + SignFor.DEPARTMENT_ARR[j] + "</option>");
                                }
                            }

                        %>
                    </select>
                </div>
                <div class="quali_cell" style='border:none'>
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">详细地址</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%--<input type="text" placeholder="填写详细地址" class="quali_input">--%>
                        <input value="<%=MT.f(s1.getAddress())%>" type="text" name="address" style="width:100%" placeholder="填写详细地址" alt="签收人详细地址不能为空"
                               class="quali_input">

                    </div>
                </div>
            </div>
            <p class="sans_tit">发票签收人信息</p>
            <div class="quali ft14">
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">姓名</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%--<input type="text" placeholder="请输入姓名" class="quali_input">--%>
                        <input value="<%=MT.f(s2.getSignatory())%>" type="text" name="signatory_fp" alt="签收人姓名不能为空!" placeholder="请输入姓名" class="quali_input">
                    </div>
                </div>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">电话</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%--<input type="num" placeholder="请输入手机号" class="quali_input">--%>
                        <input value="<%=MT.f(s2.getMobile())%>" type="text" name="mobile_fp" alt="签收人手机号不能为空!" placeholder="请输入手机号" class="quali_input">
                    </div>
                </div>
                <%--<div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">邮箱</label>
                    </div>
                    <div class="quali_cell_bd">
                        <input type="text" placeholder="填写邮箱" class="quali_input">
                    </div>
                </div>--%>
                <%-- <div class="quali_cell">
                     <div class="quali_cell_hd">
                         <label class="quali_label quali_label70">地址</label>
                     </div>
                     <div class="quali_cell_bd">
                         <input type="text" placeholder="选择地址" class="quali_input">
                     </div>
                 </div>--%>
                <div class="quali_cell">
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">科室</label>
                    </div>
                    <select style="width:100%" name="department_fp" alt="请选择签收人科室!" class="form-control">
                        <option value="">请选择</option>
                        <%
                            for (int j = 1; j < SignFor.DEPARTMENT_ARR.length; j++) {
                                if(s2.getDepartment()==j){
                                    out.print("<option value='" + j + "' 'selected:selected' >" + SignFor.DEPARTMENT_ARR[j] + "</option>");
                                }else {
                                    out.print("<option value='" + j + "' >" + SignFor.DEPARTMENT_ARR[j] + "</option>");
                                }
                            }

                        %>
                    </select>
                </div>
                <div class="quali_cell" style='border:none;'>
                    <div class="quali_cell_hd">
                        <span>*</span><label class="quali_label quali_label70">详细地址</label>
                    </div>
                    <div class="quali_cell_bd">
                        <%-- <input type="text" placeholder="填写详细地址" class="quali_input">--%>
                        <input value="<%=MT.f(s2.getAddress())%>" type="text" name="address_fp" style="width:100%" placeholder="填写详细地址" alt="签收人详细地址不能为空"
                               class="quali_input">

                    </div>
                </div>
            </div>
        </form>
        <div class="vipbut" style='padding:15px 20px;'>
            <button onclick="upVip()" class="submitted ft16">提交审核</button>
        </div>
        <%} else {%>
        <div class="SPexplain">
            <p style="color: red"><%=statearr[state] %>
            </p>
        </div>


        <p class="sans_tit">资质信息</p>
        <div class="quali">
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <span>*</span><label class="quali_label quali_label70">用户名</label>
                </div>
                <div class="quali_cell_bd">
                    <%--<input type="text" placeholder="请输入姓名" class="quali_input">--%>
                    <%=p.getMember()%>
                </div>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <span>*</span><label class="quali_label quali_label70">手机</label>
                </div>
                <div class="quali_cell_bd">
                    <%-- <input type="number" placeholder="请输入手机号" class="quali_input">--%>
                    <%=p.getMobile()%>
                </div>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <span>*</span><label class="quali_label quali_label70">医院名称</label>
                </div>
                <div class="quali_cell_bd">
                    <%=MT.f(hos.getName())%>

                </div>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label">转入/转出审批表</label>
                </div>
                <div class="quali_cell_bd">
                    <%
                        if (er.getTurnApproval() > 0) {
                    %>
                    <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(er.getTurnApproval()) %>');">查看</a>
                    <%
                    } else {%>
                    无文件
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label">辐射安全许可证</label>
                </div>
                <div class="quali_cell_bd">
                    <%
                        if (er.getRadiationCard() > 0) {
                    %>
                    <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(er.getRadiationCard()) %>');">查看</a>
                    <%
                    } else {%>
                    无文件
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="quali_cell" style="display: block;">
                <div class="quali_cell_hd">
                    <label class="quali_label">辐射安全许可证有效期</label>
                </div>
                <div class="quali_cell_bd">
                    <div id="datePlugin"></div>
                    <%=MT.f(er.getRaditaionStart())%>至<%=MT.f(er.getRadiation())%>
                </div>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label">放射诊疗许可证</label>
                </div>
                <div class="quali_cell_bd">
                    <%
                        if (er.getRadiate() > 0) {
                    %>
                    <a href='javascript:void(0);'  style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(er.getRadiate()) %>');">查看</a>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label">放射性药品使用许可证</label>
                </div>
                <div class="quali_cell_bd">
                    <%
                        if (er.getRadiateCard() > 0) {
                    %>
                    <a href='javascript:void(0);'  style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(er.getRadiateCard()) %>');">查看</a>
                    <%
                        }
                    %>
                </div>
            </div>
            <div class="quali_cell"  style='border:none'>
                <div class="quali_cell_hd">
                    <span>*</span><label class="quali_label">粒子签收人/发票签收人</label>
                </div>
                <div class="quali_cell_bd">
                    <%-- <label for="qita" class="quali_input_label">上传</label>
                     <input type="file" class="quali_input2" id="qita">--%>
                    <%if(er.getSignFor()==0||type1==1){%>
                        <input name="signFor" type="file" alt="粒子签收人/发票签收人!">
                        <input name="signFor.attch" type="hidden" value="<%= MT.f(er.getSignFor()) %>"/>

                        <%}
                        if (er.getSignFor() > 0) {
                    %>
                    <a href='javascript:void(0);'  style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(er.getSignFor()) %>');">查看</a>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
        <% List<SignFor> list3 = SignFor.find(" and eid=" + er.getEid(), 0, Integer.MAX_VALUE);
            SignFor s1 = list3.get(0);
            SignFor s2 = list3.get(1);
        %>

        <p class="sans_tit">粒子签收人信息</p>
        <div class="quali">
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label quali_label70">姓名</label>
                </div>
                <div class="quali_cell_bd">
                    <%=s1.getSignatory()%>
                </div>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <span>*</span><label class="quali_label quali_label70">电话</label>
                </div>
                <div class="quali_cell_bd">
                    <%=s1.getMobile()%>
                </div>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label quali_label70">科室</label>
                </div>
                <%=SignFor.DEPARTMENT_ARR[s1.getDepartment()]%>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label quali_label70">详细地址</label>
                </div>
                <div class="quali_cell_bd">
                    <%=s1.getAddress()%>
                </div>
            </div>
        </div>
        <p class="sans_tit">发票签收人信息</p>
        <div class="quali">
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label quali_label70">姓名</label>
                </div>
                <div class="quali_cell_bd">
                    <%=s2.getSignatory()%>
                </div>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label quali_label70">电话</label>
                </div>
                <div class="quali_cell_bd">
                   <%=s2.getMobile()%>
                    </div>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label quali_label70">科室</label>
                </div>
                <%=SignFor.DEPARTMENT_ARR[s2.getDepartment()]%>
            </div>
            <div class="quali_cell">
                <div class="quali_cell_hd">
                    <label class="quali_label quali_label70">详细地址</label>
                </div>
                <div class="quali_cell_bd">
                    <%=s2.getAddress()%>
                </div>
            </div>
        </div>



    <div class="quali">
            <%if(state==2){//修改%>
        <button class="submitted ft16" onclick="update('<%=up.getUpid()%>')">修改</button>
        <button class="submitted ft16" onclick="dele_up('<%=up.getUpid()%>')">取消申请</button>
        <%} }%>
    </div>
        <form action="/Attchs.do" id="form9" name="form9" method="post" target="_ajax">
            <input name="act" type="hidden" value="down"/>
            <input name="attch" type="hidden"/>
        </form>
        <form action="/UpProfiles.do" name="form4" method="post" target="_ajax">
            <input name="act" type="hidden" value="dele_up" />
            <input name="upid" type="hidden"/>
            <input name="vip" type="hidden" value="1">
            <input name="nexturl" type="hidden" />
        </form>
    </div>
</div>

<script src="../js/jquery.min.js"></script>
<script src="../js/m-home.js"></script>
<script type="text/javascript" src="../js/date.js"></script>
<script type="text/javascript" src="../js/iscroll_date.js"></script>
<script>
    $(function () {
        //初始化日期插件
        $('#dateinput').date();
        $('#dateinput2').date();
    });

    function showhospitalsearch() {
        layer.open({
            type: 2,
            title: '查询医院',
            shadeClose: true,
            area: ['350px', '400px'],
            closeBtn: 1,
            content: '/jsp/yl/shop/choseHospital.jsp?upid=<%=up.getUpid() %>'
        });
    }

    function upVip() {
        if (mtDiag.check1($("#form2"))) {
            if (form2.hospitals.value == null || form2.hospitals.value == "") {
                mt.show("必选项医院");
                form2.hospitals.focus();
                return false;
            }
            form2.submit();
        } 
    }

    mt.receive = function (h, n) {
        $("#hospital").val(h);
        $("#hospitals").val(n);
    }

    function downatt(num) {
        form9.attch.value = num;
        form9.submit();
    }
    function update(id) {
        location.href="/mobjsp/yl/shopweb/VIPapply.jsp?type=1";
    }
    function dele_up(id) {
        form4.nexturl.value="/mobjsp/yl/shopweb/PersonalCenter.jsp";
        form4.upid.value=id;
        mt.show('你确定要取消申请么？', 2, 'form4.submit()');
    }
    $(function(){
    $('.a-upload').change(function() {
    var filePath=$(this).val();
    var arr=filePath.split('\\');
    var fileName=arr[arr.length-1];
    console.log(arr[1]);
    console.log(fileName);
    $(this).parent().find('.showFileName').html(fileName);
    });
    });
</script>
</body>
</html>