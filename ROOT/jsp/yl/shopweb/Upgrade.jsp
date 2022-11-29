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
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }
    Profile p = Profile.find(h.member);
    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    int upid = h.getInt("upid");
    UpProfile up = UpProfile.find(upid);
    int uptype = 0;
    if(up==null){
        uptype = h.getInt("uptype");
    }else{
        uptype = up.getUptype();
    }


%>
<html>
<head>
    <title>升级申请</title>
    <script>
        var ls=parent.document.getElementsByTagName("HEAD")[0];
        document.write(ls.innerHTML);
        var arr=parent.document.getElementsByTagName("LINK");
        for(var i=0;i<arr.length;i++)
        {
            document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
        }
        var tsstr = Date.parse(new Date());
    </script>
    <script src='/tea/mt.js'></script>
    <script src='/tea/city.js'></script>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src="/tea/yl/jquery-1.7.js"></script>
    <script src="/tea/yl/top.js"></script>
    <link rel="stylesheet" href="/tea/new/css/bootstrap.css">
    <link rel="stylesheet" href="/tea/new/css/animate.css">
    <link rel="stylesheet" href="/tea/new/css/style1.css">
    <link rel="stylesheet" href="/tea/new/css/common.css">
    <script src="/tea/new/js/bootstrap.min.js"></script>
    <style>
        td{
            text-align: left !important;
        }
        .col-sm-10 input[type="file"]{
            float:left;
        }
    </style>
</head>
<body>
<%
if(up.getState() != 1 && p.membertype == 0){
%>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="head-tit animate-box" data-animate-effect="fadeInLeft">填写资质信息</h1>
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
                <div class="natural animate-box" data-animate-effect="fadeInLeft">
                    <form name="form2" class="form-horizontal" id="form2" action="/UpProfiles.do" method="post" enctype="multipart/form-data" target="_ajax" >
                        <input type="hidden" name="act" value="upProfile"/>
                        <input type="hidden" name="upid" value="<%=upid%>" />
                        <input type="hidden" name="mesg" value="操作执行成功,请等待管理员审核..." />
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-2 control-label"><em>*</em>用户名</label>
                            <div class="col-sm-10">
                                <p><%=MT.f(p.member)%></p>
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-2 control-label"><em>*</em>手机</label>
                            <div class="col-sm-10">
                                <p><%=MT.f(p.mobile)%></p>
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-2 control-label">邮箱</label>
                            <div class="col-sm-10">
                                <%=MT.f(p.email)%>
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label for="company" class="col-sm-2 control-label"><em>*</em>服务商公司名称</label>
                            <div class="col-sm-10">
                                <input type="text" name="company" alt="服务商公司名称不能为空!" value="<%=MT.f(up.getCompany())%>" class="form-control" id="company" placeholder="请输入服务商公司名称">
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-2 control-label"><em>*</em>营业执照</label>
                            <div class="col-sm-10">
                                <input name="business" alt="营业执照不能为空!" type="file">
                                <input name="business.attch" type="hidden" value="<%= MT.f(up.getBusiness()) %>" />
                                <%
                                    if(up.getBusiness()>0){
                                %>
                                <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getBusiness()) %>');">查看</a>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-2 control-label"><em>*</em>开户许可证</label>
                            <div class="col-sm-10">
                                <input name="license" alt="开户许可证不能为空!" type="file">
                                <input name="license.attch" type="hidden" value="<%= MT.f(up.getLicense()) %>" />
                                <%
                                    if(up.getLicense()>0){
                                %>
                                <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getLicense()) %>');">查看</a>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <label class="col-sm-2 control-label"><em>*</em>其他材料</label>
                            <div class="col-sm-10">
                                <input name="other" alt="其他材料不能为空!" type="file">
                                <input name="other.attch" type="hidden" value="<%= MT.f(up.getOther()) %>" />
                                <%
                                    if(up.getOther()>0){
                                %>
                                <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getOther()) %>');">查看</a>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-2 col-sm-10 ts">
                                注:上传图片格式gif\jpg\png\bmp,大小不超过2M
                            </div>
                        </div>
                        <div class="form-group animate-box" data-animate-effect="fadeInLeft">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="button" class="btn btn-default" onclick="mysupmit()">提交审核</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
<%}else{%>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="head-tit animate-box" data-animate-effect="fadeInLeft">审核已通过</h1>
                <div class="rate animate-box" data-animate-effect="fadeInLeft">
                    <span class="active animate-box" data-animate-effect="fadeInLeft"><em>1</em><br>填写资质信息</span>
                    <span class="active animate-box last" data-animate-effect="fadeInLeft"><em>2</em><br>资质审核</span>
                </div>

                <h2 class="head-hd animate-box" data-animate-effect="fadeInLeft">资质审核</h2>
                <div class="natural animate-box" data-animate-effect="fadeInLeft" style="min-height: 457px;">
                    <div class="addo-feature">
                        <p class="animate-box" data-animate-effect="fadeInLeft"><img src="/tea/new/img/list05.png" /></p>
                        <h3 class="animate-box" data-animate-effect="fadeInLeft">您的审核已通过</h3>
                        <p class="animate-box" data-animate-effect="fadeInLeft">请到<a href="">账号管理-基本信息</a>上传技术服务协议及保证金凭证</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
<%}%>
<form action="/Attchs.do" name="form9" method="post" target="_ajax">
    <input name="act" type="hidden" value="down" />
    <input name="attch" type="hidden" />
</form>
<%--<script src="/tea/new/js/jquery.waypoints.min.js"></script>--%>
<%--<script src="/tea/new/js/main.js"></script>--%>

</body>
</html>
<script>
    mt.fit();
    form2.nexturl.value=location.pathname+location.search;
    function mysupmit(){
        if(mtDiag.check1($("#form2"))) {
            form2.submit();
        }
    }
    function downatt(num){
        form9.attch.value = num;
        form9.submit();
    }
</script>