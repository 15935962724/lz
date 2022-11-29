var time = 60; //倒计时的秒数
$(function(){
	$('.lo-tit span').click(function(){
		$(this).addClass('on').siblings().removeClass('on');
		$('.lo-show').removeClass('lo-show').siblings('div').addClass('lo-show');
	});
	/////判断是否微信浏览器
	if(isWeiXin()){
		var openid = cookie.get("openid");
		if(openid!=undefined && openid!=""){
			mt.send("/jsp/admin/edn_ajax.jsp?act=byopenidlogin&openid=" + openid, function(data) {
				if(data.replace(/(^\s*)|(\s*$)/g, "") == "succ") {
					parent.location = '<%= h.get("nexturl","/") %>';
				}
			});
		} else {
			location = '/PhoneProjectReport.do?act=openid&nexturl='+location.pathname+location.search;
		}
	}
});

///切换登陆选项
function tablogin(obj){
	
}


///加载秒数
function Load() {
    for(var i=time;i>=0;i--)
    {
        window.setTimeout("doUpdate("+ i +")", (time-i) * 1000);
    }
}

///是否微信登陆
function isWeiXin(){
	var ua = window.navigator.userAgent.toLowerCase();
	if(ua.match(/MicroMessenger/i) == 'micromessenger'){
		return true;
	}else{
		return false;
	}
}


function repwd(){
    mtDiag.show("请给管理员联系找回或修改密码　电话：010-68533123");
}

mt.receive=function(v,n,h){
	document.getElementById("hname").value=v;
}

mt.verifys=function() {
	var imgs=document.getElementById('img_verifys');
	imgs.style.visibility = "visible";
	imgs.src=imgs.src.replace(/=[.\d]+/,'='+Math.random());
	foLogin.verify.value='';
	foLogin.verify.focus();
}
