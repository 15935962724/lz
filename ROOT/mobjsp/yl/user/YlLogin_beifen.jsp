<%@page import="tea.entity.yl.shop.ShopCategory"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.axis.encoding.Base64"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

</head>
<%

Http h=new Http(request);
Resource r=new Resource("/tea/ui/member/community/dpxReg");

String nexturl = h.get("nexturl","/xhtml/folder/14102033-1.htm");

String gonexturl = h.get("gonexturl","/xhtml/folder/14110001-1.htm");


%>
<body>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<div class="denglu">

<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" name="form2" method="post">
<input type="hidden" value="yllogin" name="act" />
<input type="hidden" name="nexturl" value="<%=gonexturl%>"/>
<ul>
<li><span class="sp1">账　户</span><input placeholder="邮箱、用户名、已验证手机" name="username1" class="texts lo1" type="text" /></li>
<li><span class="sp1">密　码</span><input placeholder="请输入密码" name="password" type="password" class="texts lo2" /></li>
<li><span class="sp1"><%=r.getString(h.language, "verificationcode")%></span><input placeholder="请输入验证码" style="text-transform: uppercase; width:122px;" class="texts" alt="<%=r.getString(h.language, "verificationcode")%>" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off" /><a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: hidden;position:relative;top:7px;left:3px;"></a></li>

<li style="border:none;" class="li_log"><input type="submit" class="log" value="登　陆" /></li>
<li style="border:None;"><p class="p1"><!--<input type='checkbox' class='checkbox' name="aotulogin" id='checkbox'>
<label form='checkbox'>自动登录</label>--><a href="/xhtml/folder/14102034-1.htm" style="float:left;color:#00A2E8;" target="_parent">注册</a>
<a href='javascript:void();' onclick=parent.location='/xhtml/folder/14129620-1.htm' style="color:#aaaaaa;float:right;">忘记密码？</a></p>
</li>
<p class="p2"  style="display:none;">使用合作网站账号登录：<a href='javascript:void(0);' onclick="mylogin();"><img src="/res/Home/structure/14102366.jpg"/></a><a class="a1" href='#'><img src="/res/Home/structure/14102367.jpg" onclick="wxlogin();" /></a></p>

</ul></form>

</div>

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
	function mylogin(){
		parent.window.location = "https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=101144312&redirect_uri=www.fashiongolf.com/jsp/pcadmin/qqlogin.jsp&state=0";
			}


	function wblogin(){
		parent.window.location = "https://api.weibo.com/oauth2/authorize?client_id=1110361746&redirect_uri=http://www.fashiongolf.com/jsp/pcadmin/wblogin.jsp&response_type=code";
			}

	function wxlogin(){
		parent.window.location = "https://open.weixin.qq.com/connect/qrconnect?appid=wxc2dcc4a09edaa5eb&redirect_uri=http://www.fashiongolf.com/mobjsp/admin/wxlogin.jsp&response_type=code&scope=snsapi_login";
			}
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
	alert("微信中暂不支持此功能！");
	location = location.pathname+location.search;
	/*
	if(openid!=undefined && openid!=""){
		mt.send("/jsp/admin/edn_ajax.jsp?act=byopenidlogin&openid=" + openid, function(data) {
			if(data.replace(/(^\s*)|(\s*$)/g, "")=="succ"){
				parent.location = '<%= h.get("gonexturl","/xhtml/folder/14110001-1.htm") %>';
			}
		}); 
	}else{
		location = '/PhoneProjectReport.do?act=openid&nexturl=<%= Http.enc(nexturl+"?gonexturl="+Http.enc(gonexturl)) %>';
	}
	*/
}

</script>

<script>
mt.fit();
</script>

</body>
</html>