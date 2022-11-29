<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/7/26
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.Res"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script src="/tea/mt.js" type="text/javascript"></script>
    <link href="/res/Home/cssjs/19060001L1.css" rel="stylesheet" type="text/css">
    <script language="javascript" src="/res/Home/cssjs/14102046L1.js"></script>
    <link href="/res/Home/cssjs/19060004L1.css" rel="stylesheet" type="text/css">
    <script language="javascript" src="/res/Home/cssjs/14110279L1.js"></script>
    <link href="/res/Home/cssjs/19070023L1.css" rel="stylesheet" type="text/css">
    <script language="javascript" src="/res/Home/cssjs/19070394L1.js"></script>
    <link href="/res/Home/cssjs/19070026L1.css" rel="stylesheet" type="text/css">
    <script language="javascript" src="/res/Home/cssjs/19070400L1.js"></script>
    <script language="javascript" src="/res/Home/cssjs/19070405L1.js"></script>

    <script src='/tea/jquery-1.11.1.min.js'></script>
    <script src='/tea/yl/mtDiag.js' type="text/javascript"></script>
    <script src='/tea/yl/common.js' type="text/javascript"></script>
</head>
<style>
        .head{display:none !important;}
        html,body{height:100% !important;}
        body{background:url(/res/Home/structure/19061774.jpg) center no-repeat !important;background-size:cover !important;}
        .logol{padding: 25px 50px;position: absolute;left: 0px;}
        .con-login .form-horizontal{margin:0}
    </style>
<body>
<%
    Http h=new Http(request);

    String act = h.get("act");
    String access_token =  h.get("access_token");
    String openid = h.get("openid");
    String nexturl = h.get("nexturl","/html/folder/19061184-1.htm");

    Resource r=new Resource("/tea/ui/member/community/dpxReg");
%>
<div class="col-md-12 column addo-heading animate-box logol" data-animate-effect="fadeInLeft"><a href="http://www.brachysolution.com"><img src="/res/Home/structure/19091409.png" /></a></div>
<div class="container con-login"  style="position: absolute;top: 50%;left: 50%;margin-left: -211px;margin-top: -249px;">
    <!-- <div class="row clearfix">
        <div class="col-md-12 column addo-heading animate-box" data-animate-effect="fadeInLeft"> -->
                <form  class="form-horizontal" action="/Members.do" target="_ajax"  onSubmit="return checksub()&&mt.check(this)&&mt.show(null,0)" name="form2" method="post">
                    <input type="hidden" name="act" value="ylreg" />
                    <input type="hidden" name="myact" value="<%= act %>" />
                    <input type="hidden" name="openid" value="<%= openid %>" />
                    <input type="hidden" name="checktype" value="1" />
                    <input type="hidden" name="nexturl" value="<%= nexturl%>" />
                    <input type="hidden" name="type" value="0" />
                <h1 class="addo-heading animate-box" data-animate-effect="fadeInLeft">注册</h1>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <span class="icon iconfont icon-yonghuming"></span>
                        <input type="text" class="form-control" id="username" name="username" placeholder="用户名" />
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <span class="icon iconfont icon-shouji"></span>
                        <input type="number" class="form-control" id="mob" placeholder="手机号"  name="mob" />
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12" style="position: relative;">
                        <span class="icon iconfont icon-anquanbaozhang"></span>
                        <input type="text" class="form-control"  name="verid" id="verid" placeholder="短信验证码" />
                        <input style="color: #044694;position: absolute;right: 20px;z-index: 1;top: 12px;font-size: 16px;border:none;background:none;" type="button" id="verbut" value="获取验证码" onclick="fsong()"/>
                        <%--<a href="javascript:void(0)" onclick="fsong()" style='color: #044694;position: absolute;right: 20px;z-index: 1;top: 12px;font-size: 16px;'>获取验证码</a>--%>
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <span class="icon iconfont icon-suo"></span>
                        <input type="password" name="password" class="form-control" id="p1" placeholder="密码" />
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <span class="icon iconfont icon-suo"></span>
                        <input type="password" name="password2" class="form-control" id="p2" placeholder="确认密码" />
                    </div>
                </div>
                    <%--<div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12" style="position: relative;">
                            <span class="icon iconfont icon-anquanbaozhang"></span>
                            <input class="form-control" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off" placeholder="验证码">
                            <a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" style="position: absolute;right: 18px;top: 5px;"></a>
                        </div>
                    </div>--%>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <div class="checkbox">
                            <!-- <label><input type="checkbox" id="read" />我已阅读并接受<a href="/html/folder/19070563-1.htm" target="_blank" style="color:#044694">《用户协议》</a></label> -->
                            <label><input type="checkbox" id="read" />我已阅读并接受<a href="/html/folder/19082352-1.htm" target="_blank" style="color:#044694">《用户协议》</a></label>
                        </div>
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <%--<button type="submit" class="btn btn-primary btn-block btn-lg active">立即注册</button>--%>
                        <input type="submit" value="立即注册" style="background:#044694;"   class="btn btn-primary btn-block btn-lg active">
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" style="padding:0px;margin:0px;">
                    <div class="col-sm-12 go">
                        已有账号?<a onclick="a_cli()" >去登录</a>
                    </div>
                </div>
            </form>
        <!-- </div>
    </div> -->
</div>
<script>
    /*mt.verifys=function()
    {
        var vcode=document.getElementById('img_verifys');
        vcode.setAttribute('src',vcode.src.replace(/t=[\d.]+/,'t='+Math.random()));
    };*/
    function fsong(){
        //var reg=/^(((13[0-9]{1})|(18[0-9]{1})|147|150|151|152|153|154|155|156|157|158|159|170|176|177|178)+\d{8})$/;
        var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
        if(form2.mob.value==""){
            mt.show("手机号码不能为空");
            return;
        }
        if(!reg.test(form2.mob.value)){
            mt.show("手机号码格式不正确");
            return;
        }
        var mob = form2.mob.value;
        sendx("/servlet/Ajax?act=checkmob&mob="+mob,function(data){
            data = data.trim();
            if(data=='t')
            {
                mt.show("手机号码已被注册");
                return;
            }else{
                document.getElementById("verid").disabled='';
                var mob = form2.mob.value;
                sendx("/servlet/Ajax?act=getyzm&mob="+mob,function(data){
                    data = data.trim();
                    if(data=='t')
                    {
                        mt.show("发送失败请重新发送");
                    }else{
                        time = 60;
                        document.getElementById("verbut").disabled='disabled';
                        Load();
                    }
                });
            }
        });

    }
    var time =60; //倒计时的秒数
    function Load()
    {

        for(var i=time;i>=0;i--)
        {
            window.setTimeout("doUpdate("+ i +")", (time-i) * 1000);
        }
    }
    function doUpdate(num)
    {
        document.getElementById("verbut").value = "还有"+num+"秒";
        if(num == 0)
        {
            jiechu();
        }
    }
    function jiechu(){
        document.getElementById("verbut").disabled='';
        document.getElementById("verbut").value = "重发";
    }
    function checksub(){
        var username = document.getElementById("username");
        if(username.value!=""&&!isNaN(username.value)){
            mt.show("用户名不能全为数字！");
            mt.lamp(username);
            return false;
        }
        var p1=document.getElementById("p1");
        var p2=document.getElementById("p2");
        var a = document.getElementById('p1').value;
        if (a.length < 6){
            mt.show("密码不能少于6位数！");
            return false;
        }else {
            var b = 0, c = 0, d = 0;
            if (a.match(/([a-z])+/))
                b++;
            if (a.match(/([0-9])+/))
                c++;
            if (a.match(/([A-Z])+/))
                d++;
            if (b > 0 && c > 0 && d > 0){

            }else {
                mt.show("密码必须为大小写字母以及数字组成！");
                return false;
            }

        }

        if(p1.value!=p2.value){
            mt.show("两次密码输入的不一致！");

            return false;
        }
        if($("#read").is(":checked")==false){
            mt.show("请阅读用户协议并勾选！");
            return false;
        }

        return true;
    }
    var scrwidth=document.body.clientWidth;
    console.log(scrwidth);
    if(scrwidth<=1230){
        $(".f-head").addClass('f-headx');
        $('.con-login').addClass('con-loginx');
    }
    if(scrwidth<=1490){
        $(".f-head").addClass('f-headx2');
    }

    function a_cli(){
    parent.location='/html/folder/19061184-1.htm';
}
</script>
</body>
</html>
