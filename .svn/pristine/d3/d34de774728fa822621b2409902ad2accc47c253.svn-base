<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.db.DbAdapter" %><%@ page import="java.util.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.bbs.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.TeaSession" %><%


Http h=new Http(request);

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  out.print("<script>location.replace('/servlet/StartLogin?node="+h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString())+"')</script>");
  return;
}
//h.member=teasession._rv.toString();
Profile p = Profile.find(teasession._rv.toString());
String type = h.get("type");
boolean mflag = (type.equals("mobile")?true:false);
%>

<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src='/tea/jquery-1.3.1.min.js'></script>
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<style>
    .con {padding:15px 20px 0px;}
    .con table{/*margin:0 auto;*/}
    .con table td{padding:5px 0px;font-size:14px;color:#333333;line-height:20px;}
    .con table td input.getyzm{
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;cursor: pointer;border:1px solid #044694;height:32px;color:#044694;background:#f1f6fb;padding:0 8px}
    .con table td .tijiao{width:148px;height:30px;line-height:30px;background:#00A2E8;font-size:14px;font-weight:bold;color:#fff;margin-top:15px;border:0px;cursor:pointer;}

    .righttexts p{padding-top:5px ;line-height:160%}
    .con table td .form-control{
        float:left;
    }
</style>
<div class="con">
<form method="post" name="form2" action="/Members.do" target="_ajax" onSubmit="return mt.check(this)&&mt.show(null,0);">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input name="act" type="hidden" value="replacemob" />
<table border="0" cellpadding="0" class="right-tab4" style="display: <%= (mflag?"":"none")%>">
  <tr>
    <td align="right">手机：</td><td align="left"><input name="mob" alt="手机" class="form-control" /></td>
  </tr>
  <tr>
	<td align="right">手机验证码：</td><td align="left"><input style="width:200px;" name="verid" id="verid" alt="手机验证码" class="form-control" />&nbsp;&nbsp;<input value="获取短信验证码" type="button" class="getyzm" id="verbut" onclick="fsong()" /></td>
    </tr>
    <tr>
    <td align="right">验证码：</td><td align="left"><input style="text-transform: uppercase; width:93px;" alt="验证码" onfocus="mt.verifys()" onchange="value=value.toUpperCase()" maxlength="4" name="verify" autocomplete="off" class="form-control">&nbsp;&nbsp;<a href="javascript:mt.verifys()"><img id="img_verifys" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="margin-top:7px;visibility: visible;"></a>
			</td>
		</tr>
		<tr>
  	        <td colspan="2" align="center" style="padding-top:20px;">
                <input type="submit" value="提交" class="btn btn-default btn-blue">&nbsp;&nbsp;
                <input type="button" onclick="closetc();" value="取消" class="btn btn-default">
            </td>
		</tr>
</table>
</form>
<form method="post" action="/Members.do" target="_ajax" onSubmit="return mt.check(this)&&mt.show(null,0);" >
<input name="act" type="hidden" value="successcheckeamil" />
<input name="profile" type="hidden" value="<%= p.profile %>" />
<table border="0" cellpadding="0" class="right-tab4" style="display: <%= (mflag?"none":"")%>">
  <tr>
    <td align="right">我的邮箱：</td><td align="left"><input name="email" alt="email" class="form-control" style="width:200px;"/></td>
  </tr>
  <tr>
	<td style="padding-top:10px;" align="right" class="td01" nowrap="nowrap">验证码：</td><td><input class="form-control" style="text-transform: uppercase; width:93px;" alt="验证码" onfocus="mt.verifys1()" onchange="value=value.toUpperCase()" maxlength="4" name="verify1" autocomplete="off" class="input" style='width:100px'>&nbsp;&nbsp;<a href="javascript:mt.verifys1()"><img id="img_verifys1" src="/Imgs.do?act=verify&amp;t=0.8841180045674784" alt="" style="margin-top:5px;visibility: visible;"></a>
			</td>
		</tr>
    <tr>
  	<td colspan="2" align="center" style="padding-top:20px;">
        <input type="submit" value="提交" class="btn btn-default btn-blue">&nbsp;&nbsp;
        <input type="button" onclick="closetc();" value="取消" class="btn btn-default">
    </td>
  </tr>
</table>

</form></div>
<script type="text/javascript">
var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
function closetc(){
    parent.layer.close(index);
}
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
