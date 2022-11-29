<%--
  Created by IntelliJ IDEA.
  User: zyj32
  Date: 2019/5/27
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*"%>
<%@ page import="tea.entity.member.Profile" %>
<%@ page import="tea.entity.yl.shop.UpProfile" %>
<%@ page import="tea.entity.yl.shop.SignFor" %>
<%@ page import="java.util.List" %>
<%@ page import="tea.entity.yl.shop.EmpowerRecord" %>
<%@ page import="tea.entity.yl.shop.ShopHospital" %>
<%

    Http h=new Http(request,response);
    if(h.member<1)
    {
        //response.sendRedirect("/servlet/StartLogin?community="+h.community);
        out.print("<script>parent.location='"+"/servlet/StartLogin?community="+h.community+"';</script>");
        return;
    }
    Profile p = Profile.find(h.member);
    StringBuffer sql=new StringBuffer(),par=new StringBuffer();
    int member = h.member;
    List<UpProfile> list = UpProfile.find("AND isdele=0  and profile=" + member, 0, Integer.MAX_VALUE);
    UpProfile up=null;

    if(list.size()>0){
        up = list.get(0);

    }else{
        up=new UpProfile();

    }
    int state=up.getState();
    String[] statearr={"审核中","审核通过","审核未通过"};

%>
<html>
<head>
    <title>升级申请</title>
    <style>
        td{
            text-align: left !important;
        }
        .col-sm-10 input[type="file"]{
            float:left;
        }
        .form-group{
        width:100%;
        float:left;
    }
    .form-group .col-sm-10{padding-top:5px;}
    .form-group .col-sm-10 p{font-family:"微软雅黑 bold" !important;}
    </style>
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

</head>
<body style="min-height:700px;">
<%
//if(up.getState() != 1 && p.membertype == 0){
    if(up.getUpid()==0){
%>

    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1 class="head-tit ">填写资质信息</h1>
                <div class="rate ">
                    <span class="active "><em>1</em><br>填写资质信息</span>
                    <span class=" last"><em>2</em><br>资质审核</span>
                </div>
                <div class="rate-fot ">
                    <p>1. 请严格按照相关证件信息进行正确填写</p>
                    <p>2. 请上传最新版的证件原件的彩色扫描或彩色照片，复印件需加盖公司红章</p>
                    <p>3. 请确保上传图片信息清晰可辨，支持格式：JPG BMP JPEG PNG大小不超过2M</p>
                </div>

                <h2 class="head-hd ">资质信息</h2>
                <div class="natural ">
                    <form name="form2" class="form-horizontal" id="form2" action="/UpProfiles.do" method="post" enctype="multipart/form-data" target="_ajax" >
                        <input type="hidden" name="act" value="upProfile"/>
                        <input type="hidden" name="upid" value="<%=up.getUpid() %>" />
                        <input type="hidden" name="mesg" value="操作执行成功,请等待管理员审核..." />
                        <input type="hidden" name="nexturl">
                        <div class="form-group ">
                            <label class="col-sm-3 control-label"><em>*</em>用户名</label>
                            <div class="col-sm-9">
                                <p><%=MT.f(p.member)%></p>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="col-sm-3 control-label"><em>*</em>手机</label>
                            <div class="col-sm-9">
                                <p><%=MT.f(p.mobile)%></p>
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="col-sm-3 control-label">邮箱</label>
                            <div class="col-sm-9">
                                <input type="text" name="eamil" value="<%=MT.f(up.getEmail())%>" class="form-control" id="email" placeholder="请输入邮箱">
                            </div>
                        </div>
                        <div class="form-group ">
                            <label for="company" class="col-sm-3 control-label"><em>*</em>服务商公司名称</label>
                            <div class="col-sm-9">
                                <input type="text" name="company" alt="服务商公司名称不能为空!" value="<%=MT.f(up.getCompany())%>" class="form-control" id="company" placeholder="请输入服务商公司名称">
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="col-sm-3 control-label"><em>*</em>营业执照</label>
                            <div class="col-sm-9">
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
                        <div class="form-group ">
                            <label class="col-sm-3 control-label"><em>*</em>开户许可证</label>
                            <div class="col-sm-9">
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
                        <div class="form-group ">
                            <label class="col-sm-3 control-label">其他材料</label>
                            <div class="col-sm-9">
                                <input name="other" type="file">
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
                        <div class="form-group ">
                            <div class="col-sm-offset-2 col-sm-10 ts">
                                注:上传图片格式gif\jpg\png\bmp,大小不超过2M
                            </div>
                        </div>
                        <div class="form-group ">
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
<div class="form-horizontal">
    <div class="row">
        <div class="col-md-12">
            <h1 class="head-tit ">服务商申请</h1>
            <div class="rate ">
                <span class="active "><em>1</em><br>填写资质信息</span>
                <span class=" last"><em>2</em><br>资质审核</span>
            </div>
            <h2 class="head-hd  conduct  "><%=statearr[state] %></h2>
                <%
                    if(state==2){
                %>

            <div class="natural upVip gys-sh"  style="min-height: 327px;overflow:hidden;">
                
                <div class="form-group gys-ly">
                    <label class="col-sm-2 control-label">未通过原因</label>
                    <div class="col-sm-10">
                        <p><%=MT.f(up.getDescribe()) %></p>
                    </div>
                </div>
                <%
                    }
                %>
                
                <h4 style="margin-top:15px;margin-top:20px;padding:0 15px;">资质信息</h4>
                <div class="natural">
                <div class="form-group ">
                    <label class="col-sm-2 control-label">用户名</label>
                    <div class="col-sm-10">
                        <%=MT.f(p.member)%>
                    </div>
                </div>
                <div class="form-group ">
                    <label class="col-sm-2 control-label">手机</label>
                    <div class="col-sm-10">
                        <%=MT.f(p.mobile)%>
                    </div>
                </div>
                <div class="form-group ">
                    <label class="col-sm-2 control-label">邮箱</label>
                    <div class="col-sm-10">
                        <%=MT.f(up.getEmail())%>
                    </div>
                </div>
                <div class="form-group ">
                    <label for="company" class="col-sm-2 control-label">服务商公司名称</label>
                    <div class="col-sm-10">
                        <%=MT.f(up.getCompany())%>
                    </div>
                </div>
                <div class="form-group ">
                    <label class="col-sm-2 control-label">营业执照</label>
                    <div class="col-sm-10">
                        <%
                            if(up.getBusiness()>0){
                        %>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getBusiness()) %>');">查看</a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="form-group ">
                    <label class="col-sm-2 control-label">开户许可证</label>
                    <div class="col-sm-10">

                        <%
                            if(up.getLicense()>0){
                        %>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getLicense()) %>');">查看</a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="form-group ">
                    <label class="col-sm-2 control-label">其他材料</label>
                    <div class="col-sm-10">

                        <%
                            if(up.getOther()>0){
                        %>
                        <a href='javascript:void(0);' onclick="downatt('<%= MT.enc(up.getOther()) %>');">查看</a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <%
                    if(state==2){
                %>
                <div class="form-group ">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="button" class="btn btn-default" onclick="fnedit()">修改</button>
                    </div>
                </div>
                    <div class="form-group ">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" class="btn btn-default" onclick="dele_up('<%=up.getUpid()%>')">取消申请</button>
                        </div>
                    </div>
                <%
                    }
                %>
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
    <form action="/UpProfiles.do" name="form4" method="post" target="_ajax">
        <input name="act" type="hidden" value="dele_up" />
        <input name="upid" type="hidden"/>
        <input name="nexturl" type="hidden" />
    </form>


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
    function fnedit(){
        location.href="/jsp/yl/shopweb/Upgrade_shou_edit.jsp?nexturl="+location.pathname+location.search;
    }

    function dele_up(id) {
        form4.nexturl.value="/html/folder/19092170-1.htm";/*  正式/html/folder/19092170-1.htm**/
        form4.upid.value=id;
        mt.show('你确定要取消申请么？', 2, 'form4.submit()');
    }
</script>