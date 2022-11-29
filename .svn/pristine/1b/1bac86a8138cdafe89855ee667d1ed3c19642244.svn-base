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
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
</head>
<%
Http h=new Http(request);
Resource r=new Resource("/tea/ui/member/community/dpxReg");

String nexturl = h.get("nexturl","/");
%>
<body>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<div class="denglu">

<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" name="form2" method="post">
<input type="hidden" value="yllogin" name="act" />
<input type="hidden" value="<%=nexturl%>" name="nexturl" />
<ul>
<li><span class="sp1">邮箱/用户名/已验证手机</span><input name="username1" alt="用户名" class="texts lo1" /></li>
<li><span class="sp1">密码</span><input name="password" type="password" alt="密码" class="texts lo2"/></li>
<li><span class="sp1"><%=r.getString(h.language, "verificationcode")%>：</span><input  style="text-transform: uppercase; width:122px;" class="texts" alt="<%=r.getString(h.language, "verificationcode")%>" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off"><a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: hidden;position:relative;top:7px;left:3px;"></a></li>
<li><p class="p1"><input type='checkbox' class='checkbox' name="autologin" value="1" id='checkbox'>
<label form='checkbox'>自动登录</label>
<a href='/html/folder/14110760-1.htm' target="_parent">忘记密码？</a></p>
</li>
<li><input type="submit" class="log" value="登陆" /></li>
<p class="p2">使用合作网站账号登录：<a href='javascript:void(0);' onclick="mylogin();"><img src="/res/Home/structure/14102366.jpg"/></a><a class="a1" href='#'><img src="/res/Home/structure/14102367.jpg" onclick="wxlogin();" /></a></p>

</ul></form>

</div>

	<script>
	mt.verifys=function()
	{
	  var imgs=document.getElementById('img_verifys');
          imgs.style.visibility = "visible";
	  imgs.src=imgs.src.replace(/=[.\d]+/,'='+Math.random());
	  foLogin.verify.value='';
	  foLogin.verify.focus();
	};
	function mylogin(){
		parent.window.location = "https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=101144312&redirect_uri=www.fashiongolf.com/WebLogin.do?act=qqlogin&state=0";
			}


	function wblogin(){
		parent.window.location = "https://api.weibo.com/oauth2/authorize?client_id=1110361746&redirect_uri=http://www.fashiongolf.com/WebLogin.do&response_type=code";
			}

	function wxlogin(){
		parent.window.location = "https://open.weixin.qq.com/connect/qrconnect?appid=wxc2dcc4a09edaa5eb&redirect_uri=http://www.fashiongolf.com/WebLogin.do?act=wxlogin&response_type=code&scope=snsapi_login";
			}
	
	</script>
<script>
mt.fit();
</script>

</body>
</html>