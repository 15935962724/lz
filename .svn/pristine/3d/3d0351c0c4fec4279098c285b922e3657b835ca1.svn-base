<%@page contentType="text/html; charset=UTF-8" %>
    <%@page import="tea.entity.Http" %>
    <%@ page import="tea.entity.MT" %>
    <%@ page import="tea.entity.member.Profile" %>
    <%@ page import="tea.entity.yl.shop.UpProfile" %>
    <%@ page import="java.util.List" %>
        <%
    Http h=new Http(request,response);
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
    /*if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }*/
    int type = 10;
    Profile p = Profile.find(h.member);
    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    int member = h.member;
    List<UpProfile> list = UpProfile.find("AND isdele=0 and profile=" + member, 0, Integer.MAX_VALUE);
    UpProfile up=null;

    if(list.size()>0){
        up = list.get(0);

    }else{
        up=new UpProfile();

    }
    int state=up.getState();
    String[] statearr={"审核中","审核通过","审核未通过"};
    int type1 = h.getInt("type");//是否是修改   1是修改
    if(state==1){//通过
        response.sendRedirect("/mobjsp/yl/shopweb/SPapply2.jsp");
    }

%>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>服务商申请</title>
    <link rel="stylesheet" href="../css/m-style.css">
    <link rel="stylesheet" href="../css/xj-style.css">
    <script src='/tea/mt.js'></script>
    <script src="/tea/new/js/jquery.min.js"></script>
    <script src='/tea/yl/mtDiag.js' type="text/javascript"></script>
    <script src="../js/m-home.js"></script>
    </head>
    <style>
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
    <div class="body">
    <%--        <div class="Header">--%>
    <%--            <p class="header-tit ft18">--%>
    <%--                <img src="../img/icon1.png" alt="" class="fl-left m-head-logo">--%>
    <%--                <span>服务商申请</span>--%>
    <%--                <img src="../img/icon2.png" alt="" class="head-list fl-right">--%>
    <%--            </p>--%>
    <%--        </div>--%>
    <%--        <!-- 下拉 -->--%>
    <%--        <div class="head-dh-list">--%>
    <%--            <h3 class="bor-b ft16">首页</h3>--%>
    <%--            <h3 class="bor-b ft16 head-dh-y">--%>
    <%--                解决方案    --%>
    <%--                <img src="../img/icon12.png" class="fl-right" alt="">--%>
    <%--            </h3>--%>
    <%--            <ul>--%>
    <%--                <li class="ft16">近距离治疗药物</li>--%>
    <%--                <li class="ft16 head-ys-li">碘[<sup>125</sup>I]</li>--%>
    <%--                <li class="ft16 head-ys-li">钯[<sup>103</sup>Pd]</li>--%>
    <%--                <li class="ft16 head-ys-li">铱[<sup>90</sup>Y]</li>--%>
    <%--                <li class="ft16 head-ys-li">铯[<sup>131</sup>Cs]</li>--%>

    <%--                <li class="ft16">治疗计划系统TPS</li>--%>
    <%--                <li class="ft16">植入设备/器械</li>--%>
    <%--                <li class="ft16 head-ys-li">粒子植入设备与器械</li>--%>
    <%--                <li class="ft16 head-ys-li">计划导航系统</li>--%>
    <%--                <li class="ft16 head-ys-li">辐射检测与防护</li>--%>
    <%--                <li class="ft16">手术支持服务</li>--%>
    <%--                <li class="ft16 head-ys-li"> 前列腺设备支持服务</li>--%>
    <%--                <li class="ft16 head-ys-li">远程计划系统服务</li>--%>
    <%--            </ul>--%>
    <%--            <h3 class="bor-b ft16">--%>
    <%--                产品--%>
    <%--            </h3>--%>
    <%--            <h3 class="bor-b ft16 head-dh-y">--%>
    <%--                患者--%>
    <%--                <img src="../img/icon12.png" class="fl-right" alt="">--%>
    <%--            </h3>--%>
    <%--            <ul>--%>
    <%--                <li class="ft16">粒子治疗简介</li>--%>
    <%--                <li class="ft16 head-ys-li">治疗部位</li>--%>
    <%--                <li class="ft16 head-ys-li">适应症</li>--%>
    <%--                <li class="ft16 head-ys-li">禁忌症</li>--%>
    <%--                <li class="ft16">患者指南</li>--%>
    <%--                <li class="ft16 head-ys-li">专业术语</li>--%>
    <%--                <li class="ft16 head-ys-li">常见问题</li>--%>
    <%--                <li class="ft16 head-ys-li">病患防护</li>--%>
    <%--                <li class="ft16">招募计划</li>--%>
    <%--            </ul>--%>
    <%--            <h3 class="bor-b ft16 head-dh-y">--%>
    <%--                医生--%>
    <%--                <img src="../img/icon12.png" class="fl-right" alt="">--%>
    <%--            </h3>--%>
    <%--            <ul>--%>
    <%--                <li class="ft16">政策法规</li>--%>
    <%--                <li class="ft16">医院资质</li>--%>
    <%--                <li class="ft16">临床资料</li>--%>
    <%--                <li class="ft16 head-ys-li">PPT</li>--%>
    <%--                <li class="ft16 head-ys-li">文献</li>--%>
    <%--                <li class="ft16 head-ys-li">视频</li>--%>
    <%--                <li class="ft16">放射性同位素手册</li>--%>
    <%--                <li class="ft16">病患防护</li>--%>
    <%--            </ul>--%>
    <%--            <h3 class="bor-b ft16 head-dh-y">--%>
    <%--                活动资讯--%>
    <%--                <img src="../img/icon12.png" class="fl-right" alt="">--%>
    <%--            </h3>--%>
    <%--            <ul>--%>
    <%--                <li class="ft16">行业新闻</li>--%>
    <%--                <li class="ft16">会议活动</li>--%>
    <%--            </ul>--%>
    <%--            <h3 class="bor-b ft16 head-dh-y">--%>
    <%--                关于--%>
    <%--                <img src="../img/icon12.png" class="fl-right" alt="">--%>
    <%--            </h3>--%>
    <%--            <ul>--%>
    <%--                <li class="ft16">公司介绍</li>--%>
    <%--                <li class="ft16">联系我们</li>--%>
    <%--            </ul>--%>
    <%--        </div>--%>
    <div class="Content">
    <p class="Header_tit2 ft16">服务商申请</p>
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
        <%if(up.getUpid()==0||type1==1){%>
    <div class="SPexplain">
    <p>1.请严格按照相关证件信息进行正确填写</p>
    <p>2.请上传最新版的证件原件的彩色扫描或彩色照片，复印件需加盖公司红章</p>
    <p>3.请确保上传图片信息清晰可辨，支持格式: JPG BMP JPEG PNG大小不超过2M</p>
    </div>
    <!-- 资质信息 -->
    <p class="sans_tit">资质信息</p>
    <form name="form2" class="form-horizontal" id="form2" action="/UpProfiles.do" method="post"
    enctype="multipart/form-data" target="_ajax" >
    <input type="hidden" name="act" value="upProfile"/>
    <input type="hidden" name="upid" value="<%=up.getUpid() %>" />
    <input type="hidden" name="mesg" value="操作执行成功,请等待管理员审核..." />
    <input type="hidden" name="nexturl" value="/mobjsp/yl/shopweb/SPapply.jsp">

    <div class="quali ft14">
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <span>*</span><label class="quali_label quali_label70">用户名</label>
    </div>
    <div class="quali_cell_bd">
    <p><%=MT.f(p.member)%></p>
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <span>*</span><label class="quali_label quali_label70">手机</label>
    </div>
    <div class="quali_cell_bd">
    <p><%=MT.f(p.mobile)%></p>
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <label class="quali_label quali_label70">邮箱</label>
    </div>
    <div class="quali_cell_bd">
        <%=MT.f(p.email)%>
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <span>*</span><label class="quali_label quali_label120">服务商公司名称</label>
    </div>
    <div class="quali_cell_bd">
    <input name="company" id="company" type="text" alt="公司名称不能为空！" placeholder="请输入服务商公司名称" class="quali_input"
    value="<%=MT.f(up.getCompany())%>">
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <span>*</span><label class="quali_label">营业执照</label>
    </div>
    <div class="quali_cell_bd">
    <%--<div class="quali_cell_bd">
        <label for="zhizhao" class="quali_input_label">上传</label>
        <input type="file" class="quali_input2" id="zhizhao">
    </div>--%>
    <%--     <label for="zhizhao" class="quali_input_label">上传</label>
     <input name="business" alt="营业执照不能为空!" type="file" class="quali_input2" id="zhizhao">
     <input name="business.attch"  type="hidden" value="<%= MT.f(up.getBusiness()) %>" />--%>
        <%if(up.getBusiness()==0||type1==1){%>
            <a href="javascript:;" class="file">
                <span class='showFileName'></span>
                <span style='float:right'>上传</span>
                <input type="file" class=' a-upload' name="business" id="" alt="营业执照不能为空!">
            </a>
<%--    <input name="business" alt="营业执照不能为空!" type="file" class='inp-file' >--%>
    <input name="business.attch" type="hidden"  value="<%= MT.f(up.getBusiness()) %>" />
        <%}if(up.getBusiness()>0){
                            %>
    <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(up.getBusiness()) %>');">查看</a>
        <%
                                }
                            %>
    </div>

    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <span>*</span><label class="quali_label">开户许可证</label>
    </div>
    <div class="quali_cell_bd">
    <%-- <label for="kaihu" class="quali_input_label">上传</label>
     <input type="file" class="quali_input2" id="kaihu" alt="开户许可不能为空！">--%>
        <%if(up.getLicense()==0||type1==1){%>
    <%--                           <input   type="file">--%>
    <a href="javascript:;" class="file">
        <span class='showFileName'></span>
        <span style='float:right'>上传</span>
        <input type="file" class=' a-upload' name="license" id="" alt="开户许可证不能为空!">
    </a>
    <input name="license.attch" type="hidden" value="<%= MT.f(up.getLicense()) %>" />
        <%}
                        if(up.getLicense()>0){
                           %>
    <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(up.getLicense()) %>');">查看</a>
        <%
                               }
                           %>
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <label class="quali_label">其他材料</label>
    </div>
    <div class="quali_cell_bd">
    <%--<label for="qita" class="quali_input_label">上传</label>
    <input type="file" class="quali_input2" id="qita">--%>
        <%if(up.getOther()==0||type1==1){%>
    <a href="javascript:;" class="file">
        <span class='showFileName'></span>
        <span style='float:right'>上传</span>
        <input type="file" name='other' class=' a-upload' >
    </a>
<%--    <input name="other" type="file">--%>
    <input name="other.attch" type="hidden" value="<%= MT.f(up.getOther()) %>" />
        <%}
                                if(up.getOther()>0){
                            %>
    <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(up.getOther()) %>');">查看</a>
        <%
                                }%>


    </div>
    </div>
    <button class="submitted ft16" onclick=" mysupmit()">提交审核</button>
    </div>
    </form>
        <%}else {%>
    <div class="SPexplain">
    <p style="color: red"><%=statearr[state] %></p>
    </div>
    <p class="sans_tit">资质信息</p>
    <div class="quali">
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <span>*</span><label class="quali_label quali_label70">用户名</label>
    </div>
    <div class="quali_cell_bd">
    <p><%=MT.f(p.member)%></p>
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <span>*</span><label class="quali_label quali_label70">手机</label>
    </div>
    <div class="quali_cell_bd">
    <p><%=MT.f(p.mobile)%></p>
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <label class="quali_label quali_label70">邮箱</label>
    </div>
    <div class="quali_cell_bd">
        <%=MT.f(p.email)%>
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <span>*</span><label class="quali_label quali_label120">服务商公司名称</label>
    </div>
    <div class="quali_cell_bd">
    <input name="company" type="text" alt="公司名称不能为空！" placeholder="请输入服务商公司名称" class="quali_input"
    value="<%=MT.f(up.getCompany())%>">
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <span>*</span><label class="quali_label">营业执照</label>
    </div>
    <div class="quali_cell_bd">
        <%if(up.getBusiness()>0){
                        %>
    <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(up.getBusiness()) %>');">查看</a>
        <%
                            }else {%>
    无文件
        <%}
                        %>
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <span>*</span><label class="quali_label">开户许可证</label>
    </div>
    <div class="quali_cell_bd">
    <%-- <label for="kaihu" class="quali_input_label">上传</label>
     <input type="file" class="quali_input2" id="kaihu" alt="开户许可不能为空！">--%>

        <%
                            if(up.getLicense()>0){
                        %>
    <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(up.getLicense()) %>');">查看</a>
        <%
                            }else {%>
    无文件
        <%}
                        %>
    </div>
    </div>
    <div class="quali_cell">
    <div class="quali_cell_hd">
    <label class="quali_label">其他材料</label>
    </div>
    <div class="quali_cell_bd">
    <%--<label for="qita" class="quali_input_label">上传</label>
    <input type="file" class="quali_input2" id="qita">--%>
        <%
                            if(up.getOther()>0){
                        %>
    <a href='javascript:void(0);' style="color: #044694;float:right;" onclick="downatt('<%= MT.enc(up.getOther()) %>');">查看</a>
        <%
                            }else {%>
    无文件
        <%}%>


    </div>
    </div>


        <%if(state==2){//修改%>
    <button class="submitted ft16" onclick="update('<%=up.getUpid()%>')">修改</button>
    <button class="submitted ft16" onclick="dele_up('<%=up.getUpid()%>')">取消申请</button>
        <%} }%>
    </div>
    </div>
    </div>
    <form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
    </form>
    <form action="/UpProfiles.do" name="form4" method="post" target="_ajax">
    <input name="act" type="hidden" value="dele_up" />
    <input name="upid" type="hidden"/>
    <input name="nexturl" type="hidden" />
    </form>
    <script type="text/javascript">

    function mysupmit(){
    if(mtDiag.check1($("#form2"))) {
    form2.submit();
    }
    }
    function downatt(num){
    form9.attch.value = num;
    form9.submit();
    }

    function update(id) {
    location.href="/mobjsp/yl/shopweb/SPapply.jsp?type=1";
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





