<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<link href="/res/Home/cssjs/19060001L1.css" rel="stylesheet" type="text/css">
<link href="/res/Home/cssjs/14102046L1.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/res/Home/cssjs/14102046L1.js"></script>
<link href="/res/Home/cssjs/14110279L1.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/res/Home/cssjs/14110279L1.js"></script>
<!-- <link href="/res/Home/cssjs/19070394L1.css" rel="stylesheet" type="text/css"> -->
<link href="/res/Home/cssjs/19070023L1.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/res/Home/cssjs/19070394L1.js"></script>
<link href="/res/Home/cssjs/19070400L1.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/res/Home/cssjs/19070400L1.js"></script>
<link href="/res/Home/cssjs/19070405L1.css" rel="stylesheet" type="text/css">
<script language="javascript" src="/res/Home/cssjs/19070405L1.js"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery-1.11.1.min.js'></script>
<script src='/tea/yl/mtDiag.js' type="text/javascript"></script>
<script src='/tea/yl/common.js' type="text/javascript"></script>
<body>
<style>
    .head{display:none;}
    html,body{height:100%;}
    body{background:url(/res/Home/structure/19061774.jpg) center no-repeat;background-size:cover;}

    .f-head{width: 100%;min-width: 1280px;height: 95px;position: relative;z-index: 3;}
        @media screen and (max-width: 1366px) {
        .f-head{width: 100%;min-width: 1200px;height: 30px;position: relative;z-index: 3;}
        .con-login .form-group{margin-bottom:5px;}
        }
        @media screen and (max-width: 1280px) {
        .f-head{width: 100%;min-width: 1200px;height: 60px;position: relative;z-index: 3;}
        .con-login .form-group{margin-bottom:5px;}
        }
        .logol{padding: 25px 50px;position: absolute;left: 0px;}
        .con-login .form-horizontal{margin:0}
        .is-show{display: block;opacity: 1;}
        .is-show2{display: none;opacity: 1 !important;}
</style>
<!-- <div class="f-head"></div> -->
<div class="col-md-12 column addo-heading animate-box logol" data-animate-effect="fadeInLeft"><a href="http://www.brachysolution.com"><img src="/res/Home/structure/19091409.png" /></a></div>
<div class="container con-login">
    <!-- <div class="row clearfix"> -->
        <!-- <div class="col-md-12 column addo-heading animate-box" data-animate-effect="fadeInLeft" style="position: relative;"> -->
            <div class="card border-0 shadow card--login is-show" id="login" style="position: absolute;top: 50%;left: 50%;margin-left: -211px;margin-top: -203px;">
                <form name="form1" id="form1" class="form-horizontal" role="form">
                    <input value="1" name="webtype" type="hidden" />
                    <h1 class="addo-heading animate-box" data-animate-effect="fadeInLeft">登录</h1>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <span class="icon iconfont icon-yonghuming"></span>
                            <input name="username1" id="username1" alt="用户名" class="texts lo1 form-control" placeholder="用户名" />
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <span class="icon iconfont icon-suo"></span>
                            <input name="password" id="password1" type="password" alt="密码" placeholder="密码" class="texts lo2 form-control"/>
                        </div>
                    </div>
                    <%--<div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12" style="position: relative;">
                            <span class="icon iconfont icon-anquanbaozhang"></span>
                            <input type="text" class="form-control" id=""  style="text-transform:uppercase;" name="verify" placeholder="验证码" />
                            <a style="position: absolute;right: 18px;top: 5px;" href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a>
                            &lt;%&ndash;<a href="" style="color: #044694;position: absolute;right: 20px;z-index: 1;top: 12px;font-size: 16px;">获取验证码</a>&ndash;%&gt;
                        </div>
                    </div>--%>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <span class="icon iconfont icon-suo"></span>
                            <input name="verid" id="verid" type="verid" alt="手机验证码" placeholder="手机验证码" class="texts lo2 form-control"/>
                            <input style="color: #044694;position: absolute;right: 20px;z-index: 1;top: 12px;font-size: 16px;border:none;background:none;" type="button" onclick="fsong()" id="verbut" value="获取验证码">
                            <%--<a href="javascript:void(0);" onclick="fsong()" style="color: #044694;position: absolute;right: 20px;z-index: 1;top: 12px;font-size: 16px;">获取验证码</a>--%>
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <p><a class="fl btn-register js-btn" id="mob-log" data-target="register">短信验证码登录</a><a onclick="repwd()" class="fr">忘记密码?</a></p>
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <button type="button" style="background:#044694;" onclick="login3()" class="btn btn-primary btn-block btn-lg active" id="Submit">登录</button>
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" style="padding:0px;margin:0px;">
                        <div class="col-sm-12 go">
                            <%--还没有账号?<a class="re" onclick="a_cli()" >立即注册</a>--%>
                        </div>
                    </div>
                </form>
            </div>
            <div class="card border-0 shadow card--login is-show2" id="login" style="position: absolute;top: 50%;left: 50%;margin-left: -211px;margin-top: -203px;">
                <form name="form2" id="form2" class="form-horizontal" role="form">
                    <input value="1" name="webtype" type="hidden" />
                    <h1 class="addo-heading animate-box" data-animate-effect="fadeInLeft">登录</h1>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <span class="icon iconfont icon-yonghuming"></span>
                            <input name="mob" id="mob" alt="手机号" class="texts lo1 form-control" placeholder="手机号" />
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <span class="icon iconfont icon-suo"></span>
                            <input name="verid" id="verid" type="verid" alt="手机验证码" placeholder="手机验证码" class="texts lo2 form-control"/>
                            <input style="color: #044694;position: absolute;right: 20px;z-index: 1;top: 12px;font-size: 16px;border:none;background:none;" type="button" onclick="fsong2()" id="verid1" value="获取验证码">
                            <%--<a href="javascript:void(0);" onclick="fsong()" style="color: #044694;position: absolute;right: 20px;z-index: 1;top: 12px;font-size: 16px;">获取验证码</a>--%>
                        </div>
                    </div>
                    <%--<div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12" style="position: relative;">
                            <span class="icon iconfont icon-anquanbaozhang"></span>
                            <input type="text" class="form-control" id=""  style="text-transform:uppercase;" name="verify" placeholder="验证码" />
                            <a style="position: absolute;right: 18px;top: 5px;" href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a>
                            &lt;%&ndash;<a href="" style="color: #044694;position: absolute;right: 20px;z-index: 1;top: 12px;font-size: 16px;">获取验证码</a>&ndash;%&gt;
                        </div>
                    </div>--%>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <p><a class="fl btn-register js-btn" id="mob-log2" data-target="register">用户名密码登录</a><a onclick="repwd()" class="fr">忘记密码?</a></p>
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <button type="button" onclick="login2()" style="background:#044694;" class="btn btn-primary btn-block btn-lg active">登录</button>
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" style="padding:0px;margin:0px;">
                        <div class="col-sm-12 go">
                           <%-- 还没有账号?<a onclick="a_cli()" href="/html/folder/19061185-1.htm">立即注册</a>--%>
                        </div>
                    </div>
                </form>
            </div>

            <!-- <div class="card border-0 shadow card--login is-show2" id="registerregister" style="position: absolute;top: 50%;left: 50%;margin-left: -211px;margin-top: -203px;">
                <form  name="form2"  id="form2" class="form-horizontal" role="form">
                    <h1 class="addo-heading animate-box" data-animate-effect="fadeInLeft">登录</h1>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <span class="icon iconfont icon-shouji"></span>
                            <input type="text" name="mobile" class="form-control" id="" placeholder="手机号" />
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12" style="position: relative;">
                            <span class="icon iconfont icon-anquanbaozhang"></span>
                            <input type="text" name="smsverify" class="form-control" id="" placeholder="验证码" />
                            <a href="" style="color: #044694;position: absolute;right: 20px;z-index: 1;top: 12px;font-size: 16px;">获取验证码</a>
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <p><a class="fl btn-login js-btn" id="mob-log2" data-target="login">用户名密码登录</a><a onclick="repwd()" class="fr">忘记密码?</a></p>
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                        <div class="col-sm-12">
                            <button type="submit" class="btn btn-primary btn-block btn-lg active">登录</button>
                        </div>
                    </div>
                    <div class="form-group addo-heading animate-box" style="padding:0px;margin:0px;">
                        <div class="col-sm-12 go">
                            还没有账号?<a href="/html/folder/19061185-1.htm">立即注册</a>
                        </div>
                    </div>
                </form>
            </div> -->
        <!-- </div> -->


    <!-- </div> -->



</div>
</body>
<script>
   function repwd(){
       var a="<p>请给管理员联系找回或修改密码</p><p>电话：010-68533123</p>";
        // mtDiag.show("请给管理员联系找回或修改密码\n\r电话：010-68533123");
        mtDiag.show(a);

   }
   /* const cards = document.querySelectorAll('.card');



    const btns = document.querySelectorAll('.js-btn');
    btns.forEach(btn => {
        btn.addEventListener('click', on_btn_click, true);
    btn.addEventListener('touch', on_btn_click, true);
    });*/

    /*function on_btn_click(e) {
        const nextID = e.currentTarget.getAttribute('data-target');
        const next = document.getElementById(nextID);
        if (!next) return;
        bg_change(nextID);
        view_change(next);
        return false;
    }*/

    /* Add class to the body */
    function bg_change(next) {
        document.body.className = '';
        document.body.classList.add('is-' + next);
    }

    /* Add class to a card */
    /*function view_change(next) {
        cards.forEach(card => {card.classList.remove('is-show');});
        next.classList.add('is-show');
    }*/
    // mt.fit();
    mt.verifys=function()
    {
        var vcode=document.getElementById('img_verifys');
        vcode.setAttribute('src',vcode.src.replace(/t=[\d.]+/,'t='+Math.random()));
    };


        function login1(){
            fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=ylloginmobile1",$("#form1").serialize(),function(data){

                if(data.type>0){
                    mt.show(data.mes);
                    mt.verifys();
                    form1.verify.value = "";

                }else{
                    location = '/html/folder/19053380-1.htm';
                 }

            });
        }
$('#mob-log').click(function(){
    $('.is-show').hide();
    $('.is-show2').show();
})
$('#mob-log2').click(function(){
    $('.is-show2').hide();
    $('.is-show').show();
})
$(document).keydown(function (event) {
    if (event.keyCode == 13) {
        $('#Submit').triggerHandler('click');
    }
    });

function a_cli(){
    parent.location='/html/folder/19070485-1.htm';
}
   function fsong2(){
       var reg=/^(((13[0-9]{1})|(18[0-9]{1})|147|150|151|152|153|154|155|156|157|158|159|170|177|176|178)+\d{8})$/;
       if(form2.mob.value==""){
           mt.show("手机号码不能为空");
           return;
       }
       if(!reg.test(form2.mob.value)){
           mt.show("手机号码格式不正确");
           return;
       }
       var mob = form2.mob.value;

       fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=getyzmlog&mob="+mob,"",function(data){
           if(data.type==0){
               time = 60;
               document.getElementById("verid1").disabled='disabled';
               Load1();
           }else{
               mt.show(data.mes);
           }
       });

   }
   function fsong(){
       /*var reg=/^(((13[0-9]{1})|(18[0-9]{1})|147|150|151|152|153|154|155|156|157|158|159|170|177|178)+\d{8})$/;
       if(form2.mob.value==""){
           mt.show("手机号码不能为空");
           return;
       }
       if(!reg.test(form2.mob.value)){
           mt.show("手机号码格式不正确");
           return;
       }*/
       var name = form1.username1.value;
       if(name==""){
           mt.show("用户名不能为空");
           return;
       }
       if(form1.password.value==""){
           mt.show("用户密码不能为空");
           return;
       }
       fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=send_yzm&user_name="+name,"",function(data){
                   if(data.type==0){
                       time = 60;
                       document.getElementById("verbut").disabled='disabled';
                       Load();
                   }else{
                       mt.show(data.mes);
                   }
               });

   }
   var time =60; //倒计时的秒数
   function Load1()
   {

       for(var i=time;i>=0;i--)
       {
           window.setTimeout("doUpdat("+ i +")", (time-i) * 1000);
       }
   }
   function doUpdat(num)
   {
       document.getElementById("verid1").value = "还有"+num+"秒";
       if(num == 0)
       {
           jiechu1();
       }
   }
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
   function jiechu1(){
       document.getElementById("verid1").disabled='';
       document.getElementById("verid1").value = "重发";
   }

   function login2(){
       fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=ylloginmobile2",$("#form2").serialize(),function(data){

           if(data.type>0){
               mt.show(data.mes);
               mt.verifys();
               //form2.verify.value = "";

           }else{
               location = '/html/folder/19053380-1.htm';
           }

       });
   }

   function login3() {
       fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=yl_login_new",$("#form1").serialize(),function(data){

           if(data.type>0){
               mt.show(data.mes);
               mt.verifys();
               //form2.verify.value = "";

           }else{
               location = '/html/folder/19053380-1.htm';
           }

       });

   }

   function a_cli(){
    parent.location='/html/folder/19061185-1.htm';
}
</script>
</html>
