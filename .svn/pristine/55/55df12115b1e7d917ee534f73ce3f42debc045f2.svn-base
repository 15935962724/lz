<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.Res"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <link href="/mobjsp/yl/shopStyle.css" rel="stylesheet" type="text/css"> -->
<link rel="stylesheet" href="/tea/mobhtml/m-style.css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery-1.11.1.min.js'></script>

<title>注册</title>

<style type="text/css">
	/* .seachr li{position:relative;}
	.seachr li span.absolutesp{position:absolute;right:0;text-align:left;width:75px;color:red;margin-right:0;}
	#verbut{border:1px solid #eee;padding: 0px 5px; background-color: rgb(1, 162, 232);border-radius:3px;color: #fff;} */
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
</head>
<body>
<%
Http h=new Http(request);
String act = h.get("act");
String access_token =  h.get("access_token");
String openid = h.get("openid");
String community=h.community;
if(community==null){
	Cookie co = new Cookie("community","Home");
    co.setPath("/");
    response.addCookie(co);
}
String nexturl = h.get("nexturl","/mobjsp/yl/user/login_mob.html");
Resource r=new Resource("/tea/ui/member/community/dpxReg");
%>
<!-- <header class="header">用户注册</header> -->
<div class="lo-head">
	
	<div class="xy-bg"></div>
	<div class="xy-con">
		<p class="yhxy ft16">用户协议<img src="/tea/mobhtml/img/icon13.png" class="yhxy-clo" alt=""></p>
		<div class="xy-text">
			<p class="ft14">欢迎您使用近距治疗“一站式”解决方案平台的服务（以下简称本服务），您在使用本服务前请认真阅读以下协议（以下简称本协议）。</p>
			<p class="ft14">
				<em>一、近距治疗“一站式”解决方案平台用户协议的接受</em>
			</p>
			<p class="ft14">
				当您在注册程序过程中在“阅读并接受《用户协议》”处打勾“✓”并按照注册程序成功注册为近距治疗“一站式”解决方案用户，或您以其他近距治疗“一站式”解决方案允许的方式实际使用平台服务时，即表示您已充分阅读、理解并接受本协议的全部内容，并与近距治疗“一站式”解决方案达成协议。请您务必审慎阅读、充分理解各条款内容，特别是免除或者限制责任的条款，<em>请您重点阅读并理解加粗提示条款。</em>如您对本协议项下任何条款有异议，请停止使用近距治疗“一站式”解决方案的服务。
			</p>
			<p class="ft14">
				<em>二、本协议的变更和修改</em>
			</p>
			<p class="ft14">
				<em>近距治疗“一站式”解决方案平台有权随时对本协议进行修改，并且一旦发生协议条款的变动，近距治疗“一站式”解决方案将在相关页面上提示修改的内容；用户如果不同意本协议的修改，可以放弃使用或访问本网站或取消已经获得的服务；如果用户选择在本协议变更后继续访问或使用本网站，则视为用户已经接受本协议的修改。</em>
			</p>
			<p class="ft14">
				<em>三、服务说明</em>
			</p>
			<p class="ft14">
				1、近距治疗“一站式”解决方案是一个向广大用户提供近距离治疗“一站式”解决方案的平台。
			</p>
			<p class="ft14">
				2、近距治疗“一站式”解决方案运用自己的系统通过互联网向用户提供服务，除非另有明确规定，增强或强化目前服务的任何新功能，包括新产品以及新增加的服务，均无条件地适用本协议。
			</p>
			<p class="ft14">
				<em>四、用户行为</em>
			</p>
			<p class="ft14">
				1、用户需要完成账号注册，才能正常使用网站提供的服务。任何机构或个人注册和使用的互联网用户账号名称，必须符合《互联网用户账号名称管理规定》，用户必须承诺遵守法律法规、社会主义制度、国家利益、公民合法权益、公共秩序、社会道德风尚和信息真实性等七条底线。
			</p>
			<p class="ft14">
				2、用户一旦注册平台账号，用户名和手机号码将不能修改，如需要修改用户名，请联系线下客服人员进行后台修改。
			</p>
			<p class="ft14">
				<em>1、用户帐号、密码和安全</em>
			</p>
			<p class="ft14">
				<em>（1）您应采取合理措施维护其密码和帐号的安全。用户对利用该密码和帐号所进行的一切活动负全部责任；由该等活动所导致的任何损失或损害由用户承担，近距治疗“一站式”解决方案平台不承担任何责任。</em>
			</p>
			<p class="ft14">
				（4）用户的密码和帐号遭到未授权的使用或发生其他任何安全问题，用户可以立即通知近距治疗“一站式”解决方案平台，并且用户在每次连线结束，应结束帐号使用，否则用户可能得不到近距治疗“一站式”解决方案平台的安全保护。
			</p>
			<p class="ft14">
				（5）对于用户长时间未使用的帐号，近距治疗“一站式”解决方案平台有权予以关闭。
			</p>
			<p class="ft14">
				<em>2、禁止用户从事以下行为：</em>
			</p>

			 <p class="ft14">(1)违反国家法律法规禁止性规定的;</p>
			
			 <p class="ft14">(2)政治宣传、封建迷信、淫秽、色情、赌博、暴力、恐怖或者教唆犯罪的;</p>
			
			 <p class="ft14">(3)欺诈、虚假、不准确或存在误导性的;</p>
			
			 <p class="ft14">(4)侵犯他人知识产权或涉及第三方商业秘密及其他专有权利的;</p>
			
			 <p class="ft14">(5)侮辱、诽谤、恐吓、涉及他人隐私等侵害他人合法权益的;</p>
			
			 <p class="ft14">(6)存在可能破坏、篡改、删除、影响小米商城平台任何系统正常运行或未经授权秘密获 取近距治疗“一站式”解决方案平台及其他用户的数据、个人资料的病毒、木马、爬虫等恶意软件、程序代码的;</p>
			
			 <p class="ft14">(7)其他违背社会公共利益或公共道德或依据相关近距治疗“一站式”解决方案平台协议的。 </p>
			
			 <p class="ft14">如果您上传、发布或传输的内容含有以上违反法律法规的信息或内容，或者侵犯任何第三方的合法权益，您将直接承担以上导致的一切不利后果。</p>
			
			<p class="ft14"><em>3、对用户发布信息的存储和披露</em></p>
			
			<p class="ft14">近距治疗“一站式”解决方案平台有权判断用户的行为是否符合本协议规定，如果近距治疗“一站式”解决方案平台认为用户违背了协议条款规定，有终止向其提供网站服务的权利。</p>
			
			<p class="ft14"><em>6、用户同意遵守近距治疗“一站式”解决方案平台规则、常见问题解答等管理规定。</em></p>
			
			<p class="ft14"><em>五、关于个人信息保护</em></p>
			
			<p class="ft14"><em>我们不会与近距治疗“一站式”解决方案平台(及相关关联公司或者相关服务提供的主体)以外的任何公司、组织和个人共享您的个人信息，但以下情况除外:</em></p>
						
			<p class="ft14"><em>(1)事先获得您明确的同意或授权;</em></p>                                                
			<p class="ft14"><em>(2)根据适用的法律法规、法律程序的要求、强制性的行政或司法要求所必须的情况下进 行提供，包括但不限于有关主管部门按照法律要求近距治疗“一站式”解决方案平台提供有关电子数据信息(其中包含部分个人信息)的。</em></p>
						
			<p class="ft14"><em>六、免责声明</em></p>
						
			<p class="ft14"><em>（1）在法律规定的保护期限内您免费授予近距治疗“一站式”解决方案平台及其关联公司获得全球排他的许可使用权利及再授权给其他第三方使用并可以自身名义对第三方侵权行为取证及提起诉讼的权利。您同意近距治疗“一站式”解决方案平台及其关联公司存储、使用、复制、修订、编辑、发布、展示、翻译、分发您的非个人信息，并以已知或日后开发的形式、媒体或技术将上述信息纳入其它作品内。</em></p> 

			<p class="ft14"><em>为方便您使用近距治疗“一站式”解决方案平台等其他相关服务，您授权近距治疗“一站式”解决方案平台将您在账户注册和使用近距治疗“一站式”解决方案平台服务过程中提供、形成的信息传递给其他相关服务提供者，或从其他相关服务提供者获取您在注册、使用相关服务期间提供、形成的信息。 </em></p>

			<p class="ft14"><em>（2）【信息发送】您同意，近距治疗“一站式”解决方案平台拥有通过邮件、短信、电话等形式，向您及您指定的收货人发送订单信息、促销活动、广告或广告链接等告知信息的权利。</em> </p>

			<p class="ft14"><em>七、变更 </em></p>
						
			<p class="ft14">近距治疗“一站式”解决方案平台可根据国家法律法规变化及维护交易秩序、保护消费者权益需要，不时修改本协议、 </p>

			补充协议，变更后的协议、补充协议(下称“变更事项”)将通过法定程序并以合理方式通 知您。如您对已生效的变更事项仍不同意的，您应当于变更事项确定的生效之日起停止使用近距治疗“一站式”解决方案平台服务，变更事项对您不产生效力;如您在变更事项生效后仍继续使用近距治疗“一站式”解决方案平台服务，则视为您同意已生效的变更事项。 </p>

			<p class="ft14"><em>七、终止</em></p>

			<p class="ft14">当您发生以下任一情况时，近距治疗“一站式”解决方案平台有权限制您的全部或部分权限(包括但不限于下单、参加促销活动等)，取消相关未履行完毕的订单、解除合同，或者注销您的近距治疗“一站式”解决方案帐号:</p>
						
			<p class="ft14">(1)通过网络攻击、大量发布广告等行为影响网站正常经营或影响网站为其他用户提供服务;</p>
						
			<p class="ft14">(2)多次在评论区或咨询区发布与所售商品或服务无关的信息，或违反平台信用评价制度的;</p>
						
			<p class="ft14">(3)通过不正当手段(如外挂工具、网络攻击、盗刷银行卡等方式)或其他违法、侵犯第三人利益的方式谋取利益;</p>
						
			<p class="ft14">(4)利用销售方过错或失误进行恶意索赔、投诉达两次或以上，或者无故对销售商或客服人员进行辱骂、人身攻击;</p>

			<p class="ft14">(5)非因商品/服务质量原因，短期内多次拒收商品或拒绝接受服务;</p>

			<p class="ft14">(6)通过账户购物从事索赔或转售业务的;</p>

			<p class="ft14">(7)您提供的订单信息(包括但不限于姓名、电话、身份证号、电子邮箱等)不真实、不准确或不完整;</p>

			<p class="ft14">(8)您有其他影响平台正常经营秩序或违法行为。 </p>

			<p class="ft14">账户终止后处理----如您在近距治疗“一站式”解决方案的账户被终止，对于您在账户有效期间产生的交易订单，近距治疗“一站式”解决方案平台可通知交易相对方并根据交易相对方的意愿决定是否关闭该等交易订单;</p>

			<p class="ft14">交易相对方要求继续履行的，则您应当就该等交易订单继续履行本协议及交易订单的约定， 并承担因此产生的任何损失或增加的任何费用。</p>

			<p class="ft14">账户终止权利终止----一旦您在近距治疗“一站式”解决方案平台的账户被终止，您使用近距治疗“一站式”解决方案平台服务的权利即告终止。近距治疗“一站式”解决方案不因终止本协议对您承担任何责任，包括终止您的用户账户和删除您的用户内容; 近距治疗“一站式”解决方案也没有义务向您或第三方提供您使用近距治疗“一站式”解决方案平台服务所形成的信息资料。 </p>

			<p class="ft14"><em>八、知识产权</em></p>

			<p class="ft14">除非经过近距治疗“一站式”解决方案的在先书面同意，您未获得权利使用近距治疗“一站式”解决方案的任何知识产权。您保证、陈述并承诺您尊重近距治疗“一站式”解决方案的知识产权。您不会以自己名义或促使第三方，也不会 同意或放任任何第三方，为了其任何营销、广告、促销或其他目的，在任何法域、以任何方式申请与近距治疗“一站式”解决方案或近距治疗“一站式”解决方案关联公司商标相似的商标、域名、无线网站、互联网搜索词或任何商号、 服务标志。如出现上述情况，您须将所有相关权利转让给近距治疗“一站式”解决方案，费用由您承担。 </p>
		</div>
	</div>
	<div class="re-box">
		<p class="re-tit ft16">
			账号注册
		</p>
		<div class="lo-con">
			<form action="/Members.do" target="_ajax"  onSubmit="return checksub()&&mt.check(this)&&mt.show(null,0)" name="form2" method="post">
				<input type="hidden" name="act" value="ylreg" />
				<input type="hidden" name="myact" value="<%= act %>" />
				<input type="hidden" name="openid" value="<%= openid %>" />
				<input type="hidden" name="checktype" value="1" />
				<input type="hidden" name="nexturl" value="<%= nexturl%>" />
				<input type="hidden" name="type" value="0" />
			<input placeholder="用户名" name='username' id="username" alt='<%=r.getString(h.language, "username")%>' min='3' class="lo-inp ft14">
			<input name="mob" placeholder="手机号" id="mob" alt="手机" class='lo-inp ft14' />
			<p style="position:relative;">
				<input name="verid" id="verid" placeholder="手机验证码" alt="手机验证码" class='lo-inp ft14'  />
				<input value="获取验证码" class="re-lob ft14" type="button" id="verbut" onclick="fsong()" />
			</p>
			<input class='lo-inp ft14' id="p1" placeholder="密码" alt="<%=r.getString(h.language, "password")%>" type="password" min="6" name="password" class='texts lo2'  />
			<input class='lo-inp ft14' id="p2"  placeholder="确认密码" alt="<%=r.getString(h.language, "confirmpassword")%>" type="password" name="password2" />
			<div class="checkbox lo-che">
				<label><input id="read" type="checkbox">我已阅读并接受</label><a style="color:#044694" class="yhxy-a">《用户协议》</a>
			</div>
			<button type="submit"  class="lo-btn ft14"  onclick="checksub()" >立即注册</button>
			<p class="lo-p">
				<span class="fl-right">已有账号？<a onclick="a_cli()" class="lo-re">点击登录</a></span>
			</p>
			</form>
		</div>
	</div>
	<div class="lo-foot ft14">
		®Copyright 中国同辐股份有限公司   京ICP备14058279号
	</div>
</div>

<div class="radiusBox bg">
</div>
<script>
	function a_cli(){
		parent.location='/mobjsp/yl/user/login_mob.jsp?nexturl=<%= nexturl%>';
	}
	jQuery(function(){
		jQuery('.yhxy-a').click(function(){
			jQuery('.xy-bg').show();
			jQuery('.xy-con').show();
		});
		jQuery('.yhxy-clo').click(function(){
			jQuery('.xy-bg').hide();
			jQuery('.xy-con').hide();
		});
	});
</script>
<script type="text/javascript">
	lang=<%= h.language%>;
	mt.verifys=function()
	{
	  var vcode=document.getElementById('img_verifys');
	  vcode.setAttribute('src',vcode.src.replace(/t=[\d.]+/,'t='+Math.random()));
	}; 
	
	var time =60; //倒计时的秒数
	function Load(){    
	  
		for(var i=time;i>=0;i--)    
		{    
		window.setTimeout("doUpdate("+ i +")", (time-i) * 1000);    
		}    
	}    
	function doUpdate(num){    
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
		//var reg=/^(((13[0-9]{1})|(18[0-9]{1})|147|150|151|152|153|154|155|156|157|158|159|170|176|177|178)+\d{8})$/;
		var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
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

		var p1=document.getElementById("p1");
		var p2=document.getElementById("p2");

		if(p1.value!=p2.value){
			mt.show("两次密码输入的不一致！");

			return false;
		}
		if($("#read").is(":checked")==false){
			mt.show("请阅读用户协议并勾选！");
			return false;
		}

		return true;
	}
</script>
<script>
mt.fit();
</script>
</body>
</html>