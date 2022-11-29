<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.Res"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>

</head>

<!-- <script src="/tea/jquery-1.3.1.min.js" type="text/javascript"></script> -->
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>

<body class="dpxreg">
<%
Http h=new Http(request);

String act = h.get("act");
String access_token =  h.get("access_token");
String openid = h.get("openid");


Resource r=new Resource("/tea/ui/member/community/dpxReg");
%>
<style>
    .head{display:none;}
    html,body{height:100%;}
    body{background:url(/res/Home/structure/19061774.jpg) center no-repeat;background-size:cover;}

</style>

<div class="container con-login">
    <div class="row clearfix">
        <div class="col-md-12 column addo-heading animate-box" data-animate-effect="fadeInLeft"><img src="/res/Home/structure/19061776.png" /></div>
        <div class="col-md-12 column addo-heading animate-box" data-animate-effect="fadeInLeft">

            <form class="form-horizontal" role="form">
                <h1 class="addo-heading animate-box" data-animate-effect="fadeInLeft">注册</h1>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <span class="icon iconfont icon-yonghuming"></span>
                        <input type="text" class="form-control" id="" placeholder="用户名" />
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <span class="icon iconfont icon-shouji"></span>
                        <input type="number" class="form-control" id="" placeholder="手机号" />
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
                        <span class="icon iconfont icon-suo"></span>
                        <input type="password" class="form-control" id="" placeholder="密码" />
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <span class="icon iconfont icon-suo"></span>
                        <input type="password" class="form-control" id="" placeholder="确认密码" />
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <div class="checkbox">
                            <label><input type="checkbox" />我已阅读并接受《同福协议》</label>
                        </div>
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" data-animate-effect="fadeInLeft">
                    <div class="col-sm-12">
                        <button type="submit" class="btn btn-primary btn-block btn-lg active">立即注册</button>
                    </div>
                </div>
                <div class="form-group addo-heading animate-box" style="padding:0px;margin:0px;">
                    <div class="col-sm-12 go">
                        已有账号?<a href="/html/folder/19061184-1.htm">去登录</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>

lang=<%= h.language%>;
mt.verifys=function()
{
  var vcode=document.getElementById('img_verifys');
  vcode.setAttribute('src',vcode.src.replace(/t=[\d.]+/,'t='+Math.random()));
}; 


function showme(num){
	if(num==0){//邮箱
		document.getElementById("tab2").style.display = "";
		document.getElementById("tab3").style.display = "none";
		document.getElementById("mob").value = "";
	}else if(num==1){//手机
		document.getElementById("tab2").style.display = "none";
		document.getElementById("tab3").style.display = "";
		document.getElementById("email").value = "";
		mt.fit();
	}
	form2.checktype.value = num;
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
function fsong(){
	var reg=/^(((13[0-9]{1})|(18[0-9]{1})|147|150|151|152|153|154|155|156|157|158|159|170|177|178)+\d{8})$/;
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
function checksub(){
	var username = document.getElementById("username");
	if(username.value!=""&&!isNaN(username.value)){
		mt.show("用户名不能全为数字！");
		mt.lamp(username);
		return false;
	}
	return true;
}
</script>

</div>
<script>
mt.fit();
</script>
</body>

</html>