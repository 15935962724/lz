var messageflag = true;//用户名登陆验证码
var mobmessageflag =true;//手机号登陆验证码
var nexturl = YKRJ.getParam("nexturl");
$(function(){
	//切换登陆Tab标签
	 $('.lo-tit span').click(function(){
		 $(this).addClass('on').siblings().removeClass('on');
		 $('.lo-show').removeClass('lo-show').siblings('div').addClass('lo-show');
	 });
    //判断登陆浏览器是否是微信浏览器
    if(isWeiXin()) {
        var openid = getCookie("openid");
        //openid存在
        if(openid != undefined && openid != ""){
            $.post("/LzLogins.do", {"act": "byopenidlogin", "openid": openid}, function (result) {
                var obj = eval("(" + result + ")");
                if (obj.code == '0') {
                    if(nexturl != null && nexturl != ""){
                        parent.location = nexturl;
                    } else {
                        parent.location = "/xhtml/folder/19053380-1.htm";
                    }
                }
            });
        } else {//openid不存在
            location.href = '/PhoneProjectReport.do?act=openid&nexturl='+nexturl;
        }
    }
	//验证登陆
   // checklogin();
});
//验证登陆状态
function checklogin() {
    var  data= localStorage.getItem("wuser");
    var wuserstr = eval("(" + data + ")");
    if(wuserstr) {	//已登录
        if(nexturl != null && nexturl != ""){
            location.href = nexturl;
        }else{
            location.href = "/xhtml/folder/19053380-1.htm";
        }
    }
}
//账号登陆
function accountlogin(){
    var myDate = new Date();
    var username = $("#username").val();
    var password = $("#password").val();
    var verid = $("#acccountVerid").val();
    
    if(username == '') {
    	YKRJ.show("提示","请输入用户名",1);
    } else if(password == '') {
    	YKRJ.show("提示","请输入密码",1);
    } else if(verid == ''){
    	YKRJ.show("提示","请输入验证码",1);
    } else {
    	$.post("/LzLogins.do",{"act" : "accountLogin","username" : username,"password":password,"verid":verid,"iswechat":isWeiXin()},function (result) {
            var data = eval("(" + result + ")");
            if(data.code > 0) {
                YKRJ.show("提示",data.message,1);
            } else {
                var wuser = {};
                wuser.profile = data.data.profile;
                wuser.username = data.data.username;
                wuser.mobile = data.data.mobile;
                wuser.hours = myDate.getHours();
                localStorage.setItem("wuser",JSON.stringify(wuser));
                
                if(nexturl != null && nexturl != ""){
                    location.href = nexturl;
                } else {
                    location.href = "/xhtml/folder/19053380-1.htm";
                }
            }
        });
    }
}
//短信登陆
function messagelogin(){
    var myDate = new Date();
    var mobile = $("#mob").val();
    var verid = $("#messageVerid").val();
    if(mobile == '') {
    	YKRJ.show("提示","请输入手机号",1);
    } else if(verid == ''){
    	YKRJ.show("提示","请输入验证码",1);
    } else {
    	$.post("/LzLogins.do",{"act" : "moblieLogin","mobile" : mobile,"verid":verid,"iswechat":isWeiXin()},function (result) {
            var data = eval("(" + result + ")");
            if(data.code > 0) {
                YKRJ.show("提示",data.message,1);
            } else {
                var wuser = {};
                wuser.profile = data.data.profile;
                wuser.username = data.data.username;
                wuser.mobile = data.data.mobile;
                wuser.hours = myDate.getHours();
                localStorage.setItem("wuser",JSON.stringify(wuser));

                //跳转到首页
                if(nexturl != null && nexturl != ""){
                    location.href = nexturl;
                } else {
                    location.href = "/xhtml/folder/19053380-1.htm";
                }
            }
        });
    }
}

//账号登陆 获取验证码
function accountVertify(){
    var password = $("#password").val();
    //防止多次请求
    if (!messageflag) {
        YKRJ.show("提示","验证码已发送",1);
    } else if (messageflag) {
        messageflag = false;
        $.post("/LzLogins.do", {"act": "accountVertify", "username": $("#username").val(),"password":password}, function (result) {
            var obj = eval("(" + result + ")");
            if (obj.code == '0') {
                accountMinutimer(60);
            } else {
                YKRJ.show("提示", obj.message, 1);
                messageflag = true;
            }
        });
    }
}

////短信登陆，发送验证码
function messageVertify(){
    var mobile = $("#mob").val();
    if(mobile == ""){
        YKRJ.show("提示","手机号码不能为空",1);
    } else if(mobile.length != 11){
        YKRJ.show("提示","手机号码格式不正确",1);
    } else {
        //防止多次请求
        if (!mobmessageflag) {
            YKRJ.show("提示","验证码已发送",1);
        } else if (mobmessageflag) {
            mobmessageflag = false;
            $.post("/LzLogins.do", {"act": "messageVertify", "mobile": mobile}, function (result) {
                var obj = eval("(" + result + ")");
                if (obj.code == '0') {
                    messageMinutimer(60);
                } else {
                    YKRJ.show("提示", obj.message, 1);
                    mobmessageflag = true;
                }
            });
        }
    }
}

//账号登陆，60秒后使用
function accountMinutimer(timers) {
    if (timers > 0) {
        $("#acccountVerbut").val(timers + "秒后可重发");
        setTimeout("accountMinutimer(" + (parseInt(timers) - 1) + ")", 1000);
        $("#acccountVerbut").attr("onclick", "");
    } else {
        messageflag = true;
        $("#acccountVerbut").attr("onclick", "accountVertify()");
        $("#acccountVerbut").val("重发");
    }
}
//手机号登陆，60秒后使用
function messageMinutimer(timers) {
    if (timers > 0) {
        $("#messageVerbut").val(timers + "秒后可重发");
        setTimeout("messageMinutimer(" + (parseInt(timers) - 1) + ")", 1000);
        $("#messageVerbut").attr("onclick", "");
    } else {
        mobmessageflag = true;
        $("#messageVerbut").attr("onclick", "messageVertify()");
        $("#messageVerbut").val("重发");
    }
}
//判断是否是微信
function isWeiXin(){
    var ua = window.navigator.userAgent.toLowerCase();
    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
        return true;
    }else{
        return false;
    }
}
// 获取指定名称的cookie
function getCookie(name){
    var strcookie = document.cookie;//获取cookie字符串
    var arrcookie = strcookie.split("; ");//分割
    //遍历匹配
    for ( var i = 0; i < arrcookie.length; i++) {
        var arr = arrcookie[i].split("=");
        if (arr[0] == name){
            return arr[1];
        }
    }
    return "";
}