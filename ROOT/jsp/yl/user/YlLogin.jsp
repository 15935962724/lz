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

String nexturl = h.get("nexturl");
%>
<body>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/jquery-1.4.2.min.js" type="text/javascript"></script>
<div class="denglu">

<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" name="form2" method="post">
<!-- <input type="hidden" value="yllogin" name="act" /> -->
<input type="hidden" value="ylloginmobile" name="act" />
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="pincode" id="pincode"/>
<ul>
<li><span class="sp1">用户名</span><input name="username1" id="username1" alt="用户名" class="texts lo1"  /></li>
<li><span class="sp1">密码</span><input name="password" id="password1" type="password" alt="密码" class="texts lo2"/></li>
<li><span class="sp1"><%=r.getString(h.language, "verificationcode")%>：</span><input  style="text-transform: uppercase; width:122px;" class="texts" alt="<%=r.getString(h.language, "verificationcode")%>"  maxlength="4" name="verify" autocomplete="off"><input type="button"  id="button"   onclick="return fnclick(this)" value="获取验证码"></li>
<li><p class="p1">
<!-- <input type='checkbox' class='checkbox' name="autologin" value="1" id='checkbox'>
<label form='checkbox'>自动登录</label> -->
<a href='/html/folder/14110760-1.htm' target="_parent">忘记密码？</a></p>
</li>
<li><input type="submit" class="log" value="登陆" /></li>
<!-- p class="p2">使用合作网站账号登录：<a href='javascript:void(0);' onclick="mylogin();"><img src="/res/Home/structure/14102366.jpg"/></a><a class="a1" href='#'><img src="/res/Home/structure/14102367.jpg" onclick="wxlogin();" /></a></p-->

</ul></form>

</div>

	<script>
	if(<%=nexturl==null%>){
		var referrer = '/';
		var r = parent.document.referrer;
		if(r!=''&&r.indexOf('14102033')==-1){
			var url = location.href.substring(0,location.href.indexOf('/jsp'));
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
		parent.window.location = "https://graph.qq.com/oauth2.0/authorize?response_type=code&client_id=101144312&redirect_uri=www.fashiongolf.com/WebLogin.do?act=qqlogin&state=0";
			}


	function wblogin(){
		parent.window.location = "https://api.weibo.com/oauth2/authorize?client_id=1110361746&redirect_uri=http://www.fashiongolf.com/WebLogin.do&response_type=code";
			}

	function wxlogin(){
		parent.window.location = "https://open.weixin.qq.com/connect/qrconnect?appid=wxc2dcc4a09edaa5eb&redirect_uri=http://www.fashiongolf.com/WebLogin.do?act=wxlogin&response_type=code&scope=snsapi_login";
			}
	var seed=60;
	var t1=null;
	
	function fnclick(o){
		
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
		mt.send("/Members.do?act=findusername&username="+username1+"&password="+password1,function(d)
				{
		  //alert(d);
						  if(d=='1'){
							  mt.show("密码输入错误，请重新输入！");
							  
						  }else if(d!='0')
					        {
					        	mt.show("验证码已发送到您的手机，请查看！");
					        	$("#pincode").val(d);
					        	t1 = setInterval(tip, 1000);  
					        }else if(d=='0'){
					        	
					        	//alert(a);
					        	mt.show("该用户名不存在，请与管理员联系！");
					        	
					        	
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
        /* 
        if (seed < 1) {  
            enableBtn();  
            seed = 60;  
            $("#button").text('');  
            var t2 = clearInterval(t1);  
        } else {  
        	
            $("#button").val(seed);  
        }  */ 
    }  
	function enableBtn(){  
	      
        $("#button").attr("disabled","disabled");     
          
    } 
	function ableBtn(){  
	      
        $("#button").attr("disabled","");     
          
    } 
	
	function fnkeyup(a){
		
		var mobile=$(a).val();
		//alert(mobile.length);
		if(mobile.length==11){
			$("#button").attr("disabled","");
		}else{
			$("#button").attr("disabled","disabled");
		}
	}
	
	</script>
<script>
mt.fit();
</script>

</body>
</html>