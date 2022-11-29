<%@page import="tea.entity.yl.shop.ShopCategory"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.axis.encoding.Base64"%>
<%@ page import="tea.entity.Filex" %>
<!DOCTYPE html>
<html><head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta name="viewport" content="width=device-width,user-scalable=0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css"> -->
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


    /*String openid=h.getCook("openid",null);
    //out.print("<script>alert('"+openid+"');</script>");
	if(openid==null){
		response.sendRedirect("/PhoneProjectReport.do?act=openid&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()+"&r="+Math.random()));
		return;
	}
    Filex.logs("openid.txt", openid);*/
    //Filex.logs("openid.txt", openid);

Resource r=new Resource("/tea/ui/member/community/dpxReg");

//String nexturl = h.get("nexturl","/mobjsp/yl/shopweb/ShopOrdersNew.jsp");
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
.lo-tit span{
	width:100%;
	text-align: center;
	display: inline-block;
	height:3rem;
	line-height: 3rem;
	float: left;
	color:#666;
}
</style>


<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery-1.11.1.min.js'></script>
<script src='/tea/yl/mtDiag.js' type="text/javascript"></script>
<script src='/tea/yl/common.js' type="text/javascript"></script>
<!-- <header class="header"><a href="javascript:history.go(-1)"></a>登录</header> -->
<div class="lo-head">
	<div class="lo-box">
		<p class="lo-tit" style="width: 100%">
			<span class="on ft16">账号登录</span>
		</p>
		<div class="lo-con lo-show lo-con2">
			<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" id="form2" name="form2" method="post">
				<!-- <input type="hidden" value="yllogin" name="act" /> -->
				<input type="hidden" value="ylloginmobile" name="act" />
				<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
				<input type="hidden" name="pincode" id="pincode"/>

				<input placeholder="用户名" name="username1" id="username1" class="lo-inp ft14" type="text" />
				<input placeholder="密码" name="password" id="password1" type="password" class="lo-inp ft14" />
				<%--<p style="position:relative;">
					<input type="text" class="lo-inp ft14" id=""  style="text-transform:uppercase;" name="verify" placeholder="验证码" />
					<a style="position: absolute;right: 12px;top: 9px;" href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a>
				</p>--%>
				<p style="position: relative;">
					<input placeholder="手机验证码" name="verid" id="verid"  type="password" class="lo-inp ft14" />
					<input type="button" onclick="fsong()" class=" ft14" id="verbut" value="获取验证码" style="background: none;border:none;color: #044694;position: absolute;right:10px;top:10px;">
				</p>
				<button type="button" class="lo-btn ft14" onclick="login3()" value="登录" />登录</button>
				<p class="lo-p">
					<a href="#" class="fl-left" onclick="repwd()">忘记密码</a>
					<span class="fl-right">还没有账号？<a href="#" class="lo-re" onclick="a_cli()">点击注册</a></span>
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

                <button style='margin-top:30px;' type="button" class="lo-btn ft14" onclick="login2()" value="登录" />登录</button>
                <p class="lo-p" style='margin-top:27px;'>
                    <a href="#" class="fl-left" onclick="repwd()">忘记密码</a>
                    <span class="fl-right">还没有账号？<a href="#" class="lo-re" onclick="a_cli()">点击注册</a></span>
                </p>
            </form>
		</div>
	</div>

	<div class="lo-foot ft14">
		®Copyright 中国同辐股份有限公司   京ICP备14058279号
	</div>
</div>


<!-- <div class="radiusBox bg">
	<form action="/Members.do" target="_ajax"  onSubmit="return mt.check(this)" name="form2" method="post">
		/<input type="hidden" value="yllogin" name="act" />
		<input type="hidden" value="ylloginmobile" name="act" />
		<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
		<input type="hidden" name="pincode" id="pincode"/>
		<ul class="seachr">
			<li>
				<span class="sp1">医　院：</span><input type="text" readonly name="hname" id="hname" value=""/>
				<input id="hospitalsel" onclick="mt.show('/mobjsp/yl/user/Selhospital_login.jsp',1,'选择医院',460,400)" type="button" value="请选择"/>
			</li>
			<li><span class="sp1">账　户：</span><input placeholder="用户名" name="username1" id="username1" class="texts lo1" type="text" />
			</li>
			<li><span class="sp1">密　码：</span><input placeholder="请输入密码" name="password" id="password1" type="password" class="texts lo2" /></li>
			<li><span class="sp1"><%=r.getString(h.language, "verificationcode")%>：</span>
			<input placeholder="请输入验证码" style="text-transform: uppercase; width:122px;" class="texts" alt="<%=r.getString(h.language, "verificationcode")%>"  maxlength="4" name="verify" autocomplete="off" />
			
				/<a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: hidden;position:relative;top:7px;left:3px;"></a>
			</li>
			<li style="width:100%;text-align:center;"><input type="button"  id="button"   onclick="return fnclick()" value="获取验证码"></li>
			<li><button type="submit" value="登　陆" />登　录</button>
				&nbsp;&nbsp;&nbsp;<a href="/mobjsp/yl/user/register_wx.jsp">注册</a>
			</li>
		</ul>
	</form>
</div> -->
<!-- <div class="tip login"><strong>新用户申订粒子：</strong>因特殊药品限制，新开展业务医院需要与我公司办理转入转出手续后方可申订。请网站或微信注册成功后，联系公司业务专员，办理相关手续。电话：<a href='tel:010-68513123'>010-68533123</a></div>

<div class="tip login"><strong>老用户绑定说明：</strong>老用户第一次登陆微信号，请先注册网站会员并与业务管理员联系，进行您专有的身份绑定，以便于您的粒子申订业务。电话：<a href="tel:010-68513123">010-68533123</a></div> -->

<script>
	function repwd(){
       mtDiag.show("请给管理员联系找回或修改密码　电话：010-68533123");
   }
mt.receive=function(v,n,h){
	  document.getElementById("hname").value=v;
	};
	/*if(<%=nexturl==null%>){
		var referrer = '/';
		var r = parent.document.referrer;
		if(r!=''&&r.indexOf('14102033')==-1){
			var url = location.href.substring(0,location.href.indexOf('/mobjsp'));
			referrer = r.replace(url,'');
			
		}
		
		form2.nexturl.value=referrer;
		//alert(form2.nexturl.value);
	}*/
	
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
				parent.location = '<%= h.get("nexturl","/") %>';
			}
		}); 
	}else{
		location = '/PhoneProjectReport.do?act=openid&nexturl='+location.pathname+location.search;
	}
}/*else{
	location = "/jsp/info/error/error.html";
}*/
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

function login3(){
    fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=yl_login_new",$("#form2").serialize(),function(data){

        if(data.type>0){
            mt.show(data.mes);
            mt.verifys();
            //form2.verify.value = "";

        }else{
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
/*$('.lo-tit span').click(function(){
	$(this).addClass('on').siblings().removeClass('on');
	$('.lo-show').removeClass('lo-show').siblings('div').addClass('lo-show');

})*/



function fsong(){
    var username1=$("#username1").val();
    fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=send_yzm&user_name="+username1,"",function(data){
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

</script>


</body>
</html>