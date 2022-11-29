<%@page import="tea.entity.yl.shop.ShopCategory"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.axis.encoding.Base64"%>
<!DOCTYPE html>
<html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css">
<title>登录</title>

</head>
<%

Http h=new Http(request);
Resource r=new Resource("/tea/ui/member/community/dpxReg");

String nexturl = h.get("nexturl");

%>
<body>
<style>
.seachr li{padding:14px 5px;}
</style>


<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<header class="header"><!-- <a href="javascript:history.go(-1)"></a> -->登录</header>

<div class="radiusBox bg">
	<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" name="form2" method="post">
		<input type="hidden" value="yllogin" name="act" />
		<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<ul class="seachr">
			<li><span class="sp1">账　户：</span><input placeholder="邮箱、用户名、手机号" name="username1" class="texts lo1" type="text" /></li>
			<li><span class="sp1">密　码：</span><input placeholder="请输入密码" name="password" type="password" class="texts lo2" /></li>
			<li><span class="sp1"><%=r.getString(h.language, "verificationcode")%>：</span><input placeholder="请输入验证码" style="text-transform: uppercase; width:122px;" class="texts" alt="<%=r.getString(h.language, "verificationcode")%>" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off" />
				<a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: hidden;position:relative;top:7px;left:3px;"></a>
			</li>
			<li><button type="submit" value="登　陆" />登　录</button>
				&nbsp;&nbsp;&nbsp;<a href="/mobjsp/yl/user/register_wx.jsp">注册</a>
			</li>
		</ul>
	</form>
</div>
<div class="tip login"><strong>新用户申订粒子：</strong>因特殊药品限制，新开展业务医院需要与我公司办理转入转出手续后方可申订。请网站或微信注册成功后，联系公司业务专员，办理相关手续。电话：<a href='tel:010-68513123'>010-68533123</a></div>

<div class="tip login"><strong>老用户绑定说明：</strong>老用户第一次登陆微信号，请先注册网站会员并与业务管理员联系，进行您专有的身份绑定，以便于您的粒子申订业务。电话：<a href="tel:010-68513123">010-68533123</a></div>

<script>
	if(<%=nexturl==null%>){
		var referrer = '/';
		var r = parent.document.referrer;
		if(r!=''&&r.indexOf('14102033')==-1){
			var url = location.href.substring(0,location.href.indexOf('/mobjsp'));
			referrer = r.replace(url,'');
			//alert(referrer);
		}	
		form2.nexturl.value=referrer;
	}
	
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
	//alert(openid);
	if(openid!=undefined && openid!=""){
		mt.send("/jsp/admin/edn_ajax.jsp?act=byopenidlogin&openid=" + openid, function(data) {
			if(data.replace(/(^\s*)|(\s*$)/g, "")=="succ"){
				parent.location = '<%= h.get("nexturl") %>';
			}
		}); 
	}else{
		location = '/PhoneProjectReport.do?act=openid&nexturl='+location.pathname+location.search;
	}
}else{
	location = "/jsp/info/error/error.html";
}

</script>


</body>
</html>