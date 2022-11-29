<%@page import="tea.entity.yl.shop.ShopCategory"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.axis.encoding.Base64"%>
<%@ page import="tea.entity.Filex" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
	<meta name="viewport" content="width=device-width,user-scalable=0">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
	<title>登录</title>
</head>
<%
Http h=new Http(request,response);
String community = h.get("community","");
if(community.equals("")){
	community = h.getCook("community", "Home");
}
h.setCook("community", community, -1);
Resource r=new Resource("/tea/ui/member/community/dpxReg");
String openid=h.getCook("openid",null);
String nexturl = h.get("nexturl","/xhtml/folder/19053380-1.htm");

%>
<body>
<style>
.seachr li{padding:14px 5px;}
html,body,.lo-head{
	width: 100%;
	height:100%;
}
.lo-head{
	background:url(/tea/mobhtml/img/lo-bg.jpg) center no-repeat;
	background-size:cover;
	position: relative;
}
</style>


<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery-1.7.js'></script>
<script src='/tea/yl/mtDiag.js' type="text/javascript"></script>
<script src='/tea/yl/common.js' type="text/javascript"></script>
<div class="lo-head">
	<div class="lo-box">
		<p class="lo-tit">
			<span class="on ft16">账号登录</span>
			<span class="ft16">短信登录</span>
		</p>
		<div class="lo-con lo-show lo-con2">
			<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" id="form2" name="form2" method="post">
				<input type="hidden" value="ylloginmobile" name="act" />
				<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
				<input type="hidden" name="pincode" id="pincode"/>

				<input placeholder="用户名" name="username1" id="username1" class="lo-inp ft14" type="text" />
				<input placeholder="密码" name="password" id="password1" type="password" class="lo-inp ft14" />
				<p style="position: relative;">
					<input placeholder="手机验证码" name="verid" id="verid"  type="text" class="lo-inp ft14" />
					<input type="button" onclick="fsong2()" class="ft14" id="verbut2" value="获取验证码" style="background: none;border:none;color: #044694;position: absolute;right:10px;top:10px;">
				</p>
				<button type="button" class="lo-btn ft14" onclick="login1()" value="登录" />登录</button>
				<p class="lo-p">
					<a href="#" class="fl-left" onclick="repwd()">忘记密码</a>
				</p>
			</form>
		</div>
		<div class="lo-con lo-con2">
            <form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" id="form3" name="form3" method="post">
                <!-- <input type="hidden" value="yllogin" name="act" /> -->
                <input type="hidden" value="ylloginmobile" name="act" />
                <input type="hidden" name="nexturl" value="<%=nexturl%>"/>
                <input type="hidden" name="pincode" id="pincode"/>

				<input placeholder="手机号" name="mob" id="mob" class="lo-inp ft14" type="text" />
				<p style="position: relative;">
					<input placeholder="手机验证码" name="verid" id="verid"  type="text" class="lo-inp ft14" />
					<input type="button" onclick="fsong()" class="ft14" id="verbut" value="获取验证码" style="background: none;border:none;color: #044694;position: absolute;right:10px;top:10px;">
				</p>
                <button style='margin-top:30px;' type="button" class="lo-btn ft14" onclick="login2()" value="登录" />登录</button>
                <p class="lo-p" style='margin-top:27px;'>
                    <a href="#" class="fl-left" onclick="repwd()">忘记密码</a>
                </p>
            </form>
		</div>
	</div>

	<div class="lo-foot ft14">
		®Copyright 中国同辐股份有限公司   京ICP备14058279号
	</div>
</div>

<script>
	function repwd(){
       mtDiag.show("请给管理员联系找回或修改密码　电话：010-68533123");
   	}
	mt.receive=function(v,n,h){
	  document.getElementById("hname").value=v;
	};

	mt.verifys=function()
	{
	  var imgs=document.getElementById('img_verifys');
          imgs.style.visibility = "visible";
	  imgs.src=imgs.src.replace(/=[.\d]+/,'='+Math.random());
	  foLogin.verify.value='';
	  foLogin.verify.focus();
	};
</script>

<script type="text/javascript">
 function isWeiXin(){
	var ua = window.navigator.userAgent.toLowerCase();
	if(ua.match(/MicroMessenger/i) == 'micromessenger'){
		return true;
	}else{
		return false;
	}
}
if(isWeiXin()){
	var openid = cookie.get("openid");
	if(openid!=undefined && openid!=""){
		mt.send("/jsp/admin/edn_ajax.jsp?act=byopenidlogin&openid=" + openid, function(data) {
			if(data.replace(/(^\s*)|(\s*$)/g, "")=="succ"){
				parent.location = '<%= h.get("nexturl","/") %>';
			}
		});
	}else{
		location = '/PhoneProjectReport.do?act=openid&nexturl='+location.pathname+location.search;
	}
}
var seed=60;
var t1=null;
function fnclick(){
	var hname=$("#hname").val();

	var username1=$("#username1").val();
	if(username1==''){
		mt.show("请输入用户名！");
		return false;
	}
	var password1=$("#password1").val();
	if(password1==''){
		mt.show("请输入密码！");
		return false;
	}

	mt.send("/Members.do?act=findusername&username="+username1+"&password="+password1+"&hname="+hname,function(d)
			{
					if(d=='1'){
						  mt.show("密码输入错误，请重新输入！");

					  }else if(d!='0')
				        {
				        	mt.show("验证码已发送到您的手机，请查看！");
				        	$("#pincode").val(d);
				        	t1 = setInterval(tip, 1000);
				        }else if(d=='0'){
				        	mt.show("该用户名不存在，请与管理员联系！");
				        }
				    });

}

function login1(){
    fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=yl_login_new",$("#form2").serialize(),function(data){
		if(data.type > 0) {
			mt.show(data.mes);
			mt.verifys();
		} else {
			location = form2.nexturl.value;
		}
	});
}


function tip() {

    seed--;
    if(seed<60){
    	enableBtn();
    	$("#button").val(seed+"秒后可重发");
    }
    if(seed<1){
    	ableBtn();
    	$("#button").val("获取验证码");
    	clearInterval(t1);
    }

}
function enableBtn(){

    $("#button").attr("disabled","disabled");

}
function ableBtn(){

    $("#button").attr("disabled","");

}
mt.sethid = function(id,name){
	//$("#hid").val(id);
	//$("#hid1").val(name);
	 document.getElementById("hname").value=name;
};

function a_cli(){
    parent.location='/mobjsp/yl/user/register_wx.jsp?nexturl=<%= nexturl%>';
}
$('.lo-tit span').click(function(){
	$(this).addClass('on').siblings().removeClass('on');
	$('.lo-show').removeClass('lo-show').siblings('div').addClass('lo-show');

})


////短信登陆，发送验证码
function fsong(){
	var mobile = form3.mob.value;
    if(mobile == ""){
        mt.show("手机号码不能为空");
    } else if(mobile.length != 11){
        mt.show("手机号码格式不正确");
    } else {
		if(mobile == '18810037469') {
			alert("验证成功，准备发验证码");
		}
		$.post("/LzLogins.do",{"act" : "sendmobile","mob" : mobile},function (result) {
			if(mobile == '18810037469') {
				alert("请求成功。" + result);
			}
			var obj = eval("(" + result + ")");
			if(obj.code == '0'){
				time = 60;
				Load();
			}else {
				mt.show(obj.message);
			}
		});
    }
}

var time =60; //倒计时的秒数
function Load()
{

    for(var i=time;i>=0;i--)
    {
        window.setTimeout("doUpdate("+ i +")", (time-i) * 1000);
    }
}
 function Load2()
 {

     for(var i=time;i>=0;i--)
     {
         window.setTimeout("doUpdat("+ i +")", (time-i) * 1000);
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
 function doUpdat(num)
 {
     document.getElementById("verbut2").value = "还有"+num+"秒";
     if(num == 0)
     {
         jiechu2();
     }
 }
function jiechu(){
    document.getElementById("verbut").disabled='';
    document.getElementById("verbut").value = "重发";
}
 function jiechu2(){
     document.getElementById("verbut2").disabled='';
     document.getElementById("verbut2").value = "重发";
 }

function login2(){
    fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=ylloginmobile2",$("#form3").serialize(),function(data){

        if(data.type>0){
            mt.show(data.mes);
            mt.verifys();
            //form3.verify.value = "";

        }else{
            location = form2.nexturl.value;
        }

    });
}
 function fsong2(){
     var username1=$("#username1").val();

     $.post("/LzLogins.do",{"act" : "send_username","user_name" : username1},function (result) {
         var obj = eval("(" + result + ")");
         if(obj.code == '0'){
             time = 60;
             document.getElementById("verbut2").disabled='disabled';
             Load2();
         }else {
             mt.show(obj.message);
         }
     });

 }

</script>


</body>
</html>