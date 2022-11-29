<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%


Http h=new Http(request);

if("POST".equals(request.getMethod()))
{
  out.print("<script>var mt=parent.mt;</script>");
  
  String member=h.get("member");
  if(Profile.isExisted(member))
  {
    out.print("<script>alert('该会员名已被使用。')</script>");
    return;
  }
  Profile.create(member,h.get("password"),h.community,h.get("email"),request.getServerName());
  Profile p=Profile.find(member);
  p.setMobile(h.get("mobile"));
  p.setMembertype(0);
  session.setAttribute("member",p.getProfile());
  out.print("<script>mt.show('会员注册成功！',1,'"+h.get("nexturl")+"');</script>");
  return;
}




%>
<style type="text/css">
.tip{background:url(/tea/mt/msg.gif) no-repeat; padding-left:20px;
border:1px solid #40B3FF;
background-position:0 -150px;
background-color:#E5F5FF;}
.err{background:url(/tea/mt/msg.gif) no-repeat; padding-left:20px;border:1px solid #FF8080;background-color:#FFF2F2;}
.ok{background:url(/tea/mt/msg.gif) no-repeat; padding-left:20px;background-position:0 -250px;}

</style>
<script src="/tea/city.js"></script>
<script src="/tea/mt.js"></script>
<script src="/tea/jquery.js"></script>
<form method="post" action="<%=request.getRequestURI()%>" target="_ajax" name="form1">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="/xhtml/flight737sim/folder/14040057-1.htm"/>
<table border="0" cellpadding="0" cellspacing="0" class="regtable">

  <tr>
    <td align="right" class="td01"><span>*</span>用户名：</td>
    <td><input class="in text1" name="member" value="请输入您的用户名" onfocus="if(this.value=='请输入您的用户名') this.value=''" onblur="this.value=this.value==''?'请输入您的用户名':this.value" min='4' maxlength="20" alt="用户名"><span id="member_info"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01"><span>*</span>手机号码：</td>
    <td><input class="in text2" name="mobile" value="请输入您的手机号码" onfocus="if(this.value=='请输入您的手机号码') this.value=''" onblur="this.value=this.value==''?'请输入您的手机号码':this.value" min='4' maxlength="20" alt="手机号码"></td>
  </tr>
  <tr>
    <td align="right" class="td01"><span>*</span>姓名：</td>
    <td><input class="in text2" name="name"  value="请输入您的姓名" onfocus="if(this.value=='请输入您的姓名') this.value=''" onblur="this.value=this.value==''?'请输入您的姓名':this.value" min='4' maxlength="20" alt="姓名"></td>
  </tr>
  <tr>
    <td align="right" class="td01"><span>*</span>电子邮箱：</td>
    <td><input class="in text2" name="email"  alt="电子邮箱" value="请输入您的邮箱" onfocus="if(this.value=='请输入您的邮箱') this.value=''" onblur="this.value=this.value==''?'请输入您的邮箱':this.value"></td>
  </tr>
  <tr>
    <td align="right" class="td01"><span>*</span>请设置密码：</td>
    <td><input class="in text3" type="text" id="passwordmsg" name="passwordmsg" value="请输入6-16位密码" onfocus="if(this.value=='请输入6-16位密码') this.value=''" onblur="this.value=this.value==''?'请输入6-16位密码':this.value"  min='6' maxlength="20" alt="密码">
    <input class="in text3" type="password" id="password" value="" style="display:none" name="password"   min='6' maxlength="20" alt="密码">
    </td>
  </tr>
  
</table>
<p class="butt"><input type="button" class="button" value="提交注册" onclick="verify()"></p>

</form>
<script type="text/javascript">

$('#passwordmsg').focus(function(){
	$(this).hide(); 
	$('#password').show();
	$('#password').focus();
})
$('#password').blur(function(){
	if(form1.password.value==''){
	$(this).hide(); 
	$('#passwordmsg').show();
	}
})
function verify(){
	var mobile=form1.mobile.value=="请输入您的手机号码"?"":form1.mobile.value;
	var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
	if(form1.member.value==""||form1.member.value=="请输入您的用户名"){
		alert("用户名不能为空");
	}else if(mobile.length==0)
	  {
	    alert("手机号码不能为空。");
	  }else if(!reg.test(mobile))
	  {
		  alert("手机号码格式不正确。");
	  }else
	  {
		  if(form1.name.value==""||form1.name.value=="请输入您的姓名"){
		    	alert("姓名不能为空");
		   }else if(form1.email.value==""||form1.email.value=="请输入您的邮箱"){
		    	alert("电子邮箱不能为空");
		    }else if(form1.password.value==""||form1.password.value=="请输入6-16位密码"){
		    	alert("密码不能为空");
		    }else if(form1.password.value.length<6){
		    	alert("密码不能小于6位");			
		    }else{
		    	form1.submit();
		   }
		    
	  } 
	
}
</script>
