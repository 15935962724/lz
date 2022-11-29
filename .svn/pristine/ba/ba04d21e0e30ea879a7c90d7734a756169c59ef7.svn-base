<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.db.DbAdapter" %>
<%@ page import="java.util.*" %>
<%@ page  import="tea.resource.Resource" %>
<%@ page import="tea.entity.bbs.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%


Http h=new Http(request);

String type = MT.f(h.get("type"),"");

TeaSession teasession=new TeaSession(request);
 if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}
if(!"1".equals(((String)session.getAttribute("emailflag")))){
	out.print("<script>location='/jsp/yl/shopweb/ShopCheckEmailMobile.jsp?type="+type+"';</script>");
} 
//h.member=teasession._rv.toString();
Profile p = Profile.find(teasession._rv.toString());
boolean mflag = ("mobile".equals(type)?true:false);
%>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
	  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}

</script>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>

<div class="con">
<form method="post" name="form2" action="/Members.do" target="_ajax" onSubmit="return mt.check(this)&&mt.show(null,0);">
  <input type="hidden" name="community" value="<%=h.community%>"/>
  <input name="act" type="hidden" value="replacemob" />
  <table border="0" cellpadding="0" cellspacing="0" style="display: <%= (mflag?"":"none")%>">
    <tr>
      <td align="right">手机：</td>
      <td align="left"><input name="mob" alt="手机" /></td>
    </tr>
    <tr>
      <td align="right">手机验证码：</td>
      <td align="left"><input name="verid" id="verid" alt="手机验证码"  />
        <input value="获取短信验证码" type="button" id="verbut" onclick="fsong()" /></td>
    </tr>
    <tr>
      <td align="right" class="td01" nowrap="nowrap">验证码：</td><td align="left"><input style="text-transform: uppercase; width:93px;" alt="验证码" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off" class="input" style='width:100px'>
        <a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><input type="submit" value="提交" class="tijiao"></td>
    </tr>
  </table>
</form>
<form method="post" action="/Members.do" target="_ajax" onSubmit="return mt.check(this)&&mt.show(null,0);" >
  <input name="act" type="hidden" value="successcheckeamil" />
  <input name="profile" type="hidden" value="<%= p.profile %>" />
  <table border="0" cellpadding="0" cellspacing="0" style="display: <%= (mflag?"none":"")%>">
    <tr>
      <td align="right">我的邮箱：</td><td align="left"><input name="email" alt="email" /></td>
    </tr>
    <tr>
      <td align="right" class="td01" nowrap="nowrap"> 验证码： </td>
      <td align="left"><input style="text-transform: uppercase; width:93px;" alt="验证码" onfocus="mt.verifys1()" onchange="value=value.toUpperCase()" maxlength="4" name="verify1" autocomplete="off" class="input" style='width:100px'>
        <a href="javascript:mt.verifys1()"><img id="img_verifys1" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="visibility: visible;"></a></td>
    </tr>
    <tr>
      <td colspan="2" align="center"><input type="submit" value="发送邮件" class="tijiao"></td>
    </tr>
  </table>
  </div>
</form>
<script type="text/javascript">
mt.verifys=function()
{
  var vcode=document.getElementById('img_verifys');
  vcode.setAttribute('src',vcode.src.replace(/t=[\d.]+/,'t='+Math.random()));
};
mt.verifys1=function()
{
  var vcode=document.getElementById('img_verifys1');
  vcode.setAttribute('src',vcode.src.replace(/t=[\d.]+/,'t='+Math.random()));
}; 
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
mt.fit();
</script> 
