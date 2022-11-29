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

%>
<!doctype html><html><head>
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
<link rel="stylesheet" href="/tea/new/css/style.css">
<script src="/tea/new/js/jquery.min.js"></script>
<script src="/tea/new/js/superslide.2.1.js"></script>
<script src="/tea/yl/mtDiag.js"></script>
<script src='/tea/jquery-1.11.1.min.js'></script>
<script src='/tea/yl/common.js' type="text/javascript"></script>
<style>
    .con {padding:15px 20px 0px;}
    .con table{/*margin:0 auto;*/}
    .con table td{padding:5px 0px;font-size:14px;color:#333333;line-height:20px;}
    .con table td input.getyzm{
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        border-radius: 5px;cursor: pointer;border:1px solid #044694;height:32px;color:#044694;background:#f1f6fb;padding:0 5px}
    .con table td .tijiao{width:148px;height:30px;line-height:30px;background:#00A2E8;font-size:14px;font-weight:bold;color:#fff;margin-top:15px;border:0px;cursor:pointer;}

    .righttexts p{padding-top:5px ;line-height:160%}
    .con table td .form-control{
        float:left;
    }
</style>
<body>
<div class="con">
<form method="post" name="form2" action="/Members.do" target="_ajax" onSubmit="return mt.check(this)&&mt.show(null,0);">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="mob" value="<%= MT.f(p.mobile) %>"/>
<input type="hidden" name="act" value="mobcheck"/>


</form>
<form name="form4" method="post" action="/Members.do" target="_ajax" onSubmit="return mt.check(this)&&mt.show(null,0);" >
<input name="email" type="hidden" value="<%= MT.f(p.email) %>" />
<input name="act" type="hidden" value="bangding_mail" />
<input name="profile" type="hidden" value="<%= p.profile %>" />
<%--<input type="hidden" name="nexturl" value="/jsp/yl/shopweb/SecuritySetting.jsp">--%>

    <input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>">

<table border="0" cellpadding="0" class="right-tab4">
    <%if("editPW".equals(h.get("type"))){//修改密码%>
    <tr>
        <td  align="right">原密码：</td>
        <td align="left">
            <input  class="form-control" style=" width:200px;" placeholder="输入原始密码" type="password" name="old_pw" id="old_pw">
        </td>
    </tr>
    <tr>
        <td align="right" class="td01" nowrap="nowrap">新密码：</td>
        <td><input class="form-control" style=" width:200px;" type="password" placeholder="输入新密码" alt="输入新密码" id="new_pw"  name="new_pw" autocomplete="off">&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td align="right" class="td01" nowrap="nowrap">新密码：</td>
        <td><input class="form-control" style=" width:200px;" type="password" placeholder="输入新密码" alt="再次输入新密码" id="new_pw2"  name="new_pw2" autocomplete="off">&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center" style="padding-top:15px;">
            <%-- <input type="submit" value="发送邮件" class="btn btn-default btn-blue">&nbsp;&nbsp; --%>
            <input onclick="jiaoyan_submit()" value="提交" class="btn btn-default btn-blue">&nbsp;&nbsp;
            <input type="button" onclick="closetc();" value="取消" class="btn btn-default">
        </td>
    </tr>

    <%}else {%>
    <tr>
        <td  align="right">新邮箱地址：</td>
        <td align="left">
            <input  class="form-control" style=" width:200px;" type="text" name="new_mail">
            <%--<input type="button" onclick="fsongemail()" value="获取验证码" style="background: none;border:none;color: #044694;">--%>
            <input class="btn btn-default btn-blue" type="button" onclick="fsongemail()" id="asdfg_" value="获取验证码">
        </td>
    </tr>
    <tr>
        <td align="right" class="td01" nowrap="nowrap">邮箱验证码：</td>
        <td><input class="form-control" style=" width:93px;" alt="验证码"  name="verify1" autocomplete="off">&nbsp;&nbsp;
        </td>
    </tr>
    <tr>
        <td colspan="2" align="center" style="padding-top:15px;">
            <%-- <input type="submit" value="发送邮件" class="btn btn-default btn-blue">&nbsp;&nbsp; --%>
                <input type="submit" value="提交" class="btn btn-default btn-blue">&nbsp;&nbsp;
            <input type="button" onclick="closetc();" value="取消" class="btn btn-default">
        </td>
    </tr>
    <%}%>

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
   document.getElementById("asdfg_").value = "还有"+num+"秒";
	 if(num == 0)
	 {
		 jiechu();
	 }
} 
function jiechu(){
	document.getElementById("asdfg_").disabled='';
	document.getElementById("asdfg_").value = "重发";
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
	});

	
}
function fsongemail(){

    if(!isEmail(form4.new_mail.value)){
        mt.show("邮箱地址不正确！");
        form1.Email.select();
        return false;
    }else {//发送邮件

        var mail = form4.new_mail.value;
        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=send_email&mail="+mail,"",function(data){
            if(data.type==0){
                mt.show("该邮箱已被注册，请重新填写");
            }else if(data.type==2){
                mt.show("邮箱发送次数已达上限明天再试");
            }else{
                time = 60;
                document.getElementById("asdfg_").disabled='disabled';
                Load();
                mt.show("发送成功");
            }
        });
    }
}
function jiaoyan_submit() {
    var a = document.getElementById("old_pw").value;
    var b = document.getElementById("new_pw").value;
    var c = document.getElementById("new_pw2").value;
    if(a.length==0){
        mt.show("原始密码不能为空，请重新填写");
        return;
    }
    if(b.length==0){
        mt.show("新密码不能为空，请重新填写");
        return;
    }
    if(c.length==0){
        mt.show("新密码不能为空，请重新填写");
        return;
    }
    if(b.length<6){
        mt.show("新密码不能少于6位数，请重新填写");
        return;
    } else {
        var l = 0, k = 0, j = 0;
        if (b.match(/([a-z])+/))
            l++;
        if (b.match(/([0-9])+/))
            j++;
        if (b.match(/([A-Z])+/))
            k++;
        if (l > 0 && j > 0 && k > 0){

        }else {
            mt.show("密码必须为大小写字母以及数字组成！");
            return ;
        }

    }

    if(b!=c){
        mt.show("新密码不一致，请重新填写");
    }else {
        fn.ajax("/mobjsp/yl/shop/ajax.jsp?act=edit_PW&old_pw="+a+"&new_pw="+b,"",function(data){
            if(data.type==0){
                mt.show("原密码不正确，请重新填写！");
            }else{
               mt.show("修改成功");
                parent.layer.close(index);
            }
        });
    }
}

</script>
