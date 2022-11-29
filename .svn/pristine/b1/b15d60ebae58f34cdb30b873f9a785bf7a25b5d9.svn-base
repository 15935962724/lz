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



<div class="container con-login">
	<div class="row clearfix">
		<div class="col-md-12 column addo-heading animate-box" data-animate-effect="fadeInLeft"><img src="/res/Home/structure/19061776.png" /></div>
		<div class="col-md-12 column addo-heading animate-box " data-animate-effect="fadeInLeft" style="position: relative;">
			<div class="card border-0 shadow card--login is-show" id="login">
				<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" name="form2" method="post">
					<!-- <input type="hidden" value="yllogin" name="act" /> -->
					<input type="hidden" value="ylloginmobile" name="act" />
					<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
					<input type="hidden" name="pincode" id="pincode"/>

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
					<div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
						<div class="col-sm-12">
							<p><a class="fl btn-register js-btn" data-target="register">手机号验证码登录</a><a href="" class="fr">忘记密码?</a></p>
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
			</div>

			<div class="card border-0 shadow card--register" id="register">
				<div class="col-md-12 column addo-heading animate-box" data-animate-effect="fadeInLeft">
					<form class="form-horizontal" role="form">
						<h1 class="addo-heading animate-box" data-animate-effect="fadeInLeft">登录</h1>
						<div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
							<div class="col-sm-12">
								<span class="icon iconfont icon-shouji"></span>
								<input type="text" class="form-control" id="" placeholder="手机号" />
							</div>
						</div>
						<div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
							<div class="col-sm-12" style="position: relative;">
								<span class="icon iconfont icon-anquanbaozhang"></span>
								<input type="text" class="form-control" id="" placeholder="验证码" />
								<a href="" style="color: #044694;position: absolute;right: 20px;z-index: 1;top: 12px;font-size: 16px;">获取验证码</a>
							</div>
						</div>
						<div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
							<div class="col-sm-12">
								<p><a class="fl btn-login js-btn" data-target="login">用户名密码登录</a><a href="" class="fr">忘记密码?</a></p>
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
				</div>
			</div>
		</div>


	</div>



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
<script>
    const cards = document.querySelectorAll('.card');


    const btns = document.querySelectorAll('.js-btn');
    btns.forEach(btn => {
        btn.addEventListener('click', on_btn_click, true);
    btn.addEventListener('touch', on_btn_click, true);
    });

    function on_btn_click(e) {
        const nextID = e.currentTarget.getAttribute('data-target');
        const next = document.getElementById(nextID);
        if (!next) return;
        bg_change(nextID);
        view_change(next);
        return false;
    }

    /* Add class to the body */
    function bg_change(next) {
        document.body.className = '';
        document.body.classList.add('is-' + next);
    }

    /* Add class to a card */
    function view_change(next) {
        cards.forEach(card => {card.classList.remove('is-show');});
        next.classList.add('is-show');
    }
</script>
</body>
</html>