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
<div class="zhuc"><div class="zhucetop"></div>
<div class="memberReg">
<div class="con">
<form action="/Members.do" target="_ajax"  onSubmit="return checksub()&&mt.check(this)&&mt.show(null,0)" name="form2" method="post">
    <input type="hidden" name="act" value="ylreg" />
    <input type="hidden" name="myact" value="<%= act %>" />
    <input type="hidden" name="openid" value="<%= openid %>" />
    <input type="hidden" name="checktype" value="0" />
    <input type="hidden" name="nexturl" value="/index.jsp" /><div style="padding:20px;">
    <input type="hidden" name="type" value="0" />
    <!-- <input id="_type0" checked="checked" type="radio" onclick="tabdiv(0)" name="type" value="0" />
    <label for="_type0">普通会员</label> -->
    <div class="tab">
    <table id="tab1">
            <tr>
                <td class="th" align='right'><em>*</em>&nbsp;<%=r.getString(h.language, "username")%>：</td>
                <td><input name='username' id="username" class='texts lo1' alt='<%=r.getString(h.language, "username")%>' min='3'></td>
            </tr>
            <tr>
                <td class="th"><em>*</em>&nbsp;<%=r.getString(h.language, "password")%>：</td>
                <td><input alt="<%=r.getString(h.language, "password")%>" type="password" min="6" name="password" class='texts lo2'  /></td>
            </tr> 
            <tr>
                <td class="th"><em>*</em>&nbsp;<%=r.getString(h.language, "confirmpassword")%>：</td>
                <td><input class='texts lo2' alt="<%=r.getString(h.language, "confirmpassword")%>" type="password" name="password2" /></td>
            </tr>
     </table>
     <table id="tab2">
            <tr>
            	<td class="th"><em>*</em>&nbsp;电子邮箱：</td>
            	<td>
            		 <input name="email" id="email" alt="电子邮箱" class='texts'  /> 或 <a href="javascript:void(0);" style='color:#005EA7' onclick="showme(1)">验证手机</a>
            	</td>
            </tr>
    </table>
    <table id="tab3" style="display: none;">
            <tr>
            	<td class="th"><em>*</em>&nbsp;手机：
            	</td>
            	<td><input name="mob" id="mob" alt="手机" class='texts phon'  /> 或 <a style='color:#005EA7' href="javascript:void(0);" onclick="showme(0)">验证邮箱</a>
            	</td>
            </tr>
            <tr>
            	<td class="th"><em>*</em>&nbsp;验证手机：
            	</td>
            	<td>
            		 <input name="verid" id="verid" alt="手机验证码" class='texts'  />
            		 <input value="获取短信验证码" type="button" id="verbut" onclick="fsong()" />
            	</td>	
            </tr>
    </table>
    <table>
    	<tr>
			<td align="right" class="td01 th" nowrap="nowrap"><em>*</em>&nbsp;<%=r.getString(h.language, "verificationcode")%>：
			</td>
			<td><input style="text-transform: uppercase; width:93px;" alt="<%=r.getString(h.language, "verificationcode")%>" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off" class="texts" style='width:100px'>
				<a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a>
			</td>
		</tr>
    </table></div>
  <div class='res'>  <input name="tiaokuan" alt="<%=r.getString(h.language, "tiaokuan")%>"  type="checkbox"  /><label for="agree"><%=r.getString(h.language, "read")%></label><input name="murl" id="murl" type="hidden" /><a id="tk" href="javascript:void(0);" onclick="gotk()">《<%=r.getString(h.language, "tiaokuan")%>》</a><div class="usersub">
	 		
    <input name="" type="submit" value="注册" onclick="checksub()" /></div></div>
</form>
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
	var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
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