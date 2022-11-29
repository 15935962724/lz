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
String oldpwd=Profile.find(h.member).password;
%>

<script src='/tea/mt.js'></script>
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
    width:200px;
  }
</style>
<form method="post" action="/servlet/ChangePassword" target="_ajax" name="form1" onSubmit="return mt.check(this);">
<input type="hidden" name="community" value="<%=h.community%>"/>
<div class="con">
<table border="0" cellpadding="0" class="right-tab4">
<%-- <%
Profile p=Profile.find(h.member);
if(p.getMembertype()==1)
{
%>
  <tr>
    <td align="right">会员编号：</td>
    <td align="left"><%=p.code%>　　　绑定账号：<%=h.username%></td>
  </tr>
<%
}
%> --%>
  <tr>
    <td align="right">旧密码：</td>
    <td align="left"><input type="password" name="old" id="old" alt="旧密码" class="form-control"></td>
  </tr>
  <tr>
    <td align="right">新密码：</td>
    <td align="left"><input type="password" name="password" id="password" alt="新密码" class="form-control"></td>
  </tr>
  <tr>
    <td align="right">确认新密码：</td>
    <td align="left"><input type="password" name="password2" id="password2" alt="确认新密码" class="form-control"></td>
  </tr>
  <tr>
  	<td colspan="2" align="center" class="submitTd" style="padding-top:10px;"><!-- <input type="submit" value="提交" class="tijiao"> -->
      <input type="button" value="提交" class="btn btn-default btn-blue" onclick="fnsubmit('<%=oldpwd %>')">&nbsp;&nbsp;
      <input type="button" onclick="closetc();" value="取消" class="btn btn-default">
  	</td>
  </tr>
</table>

</div>

</form>

<script>
var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
function closetc(){
    parent.layer.close(index);
}
function fnsubmit(oldpwd){
	
	var old=document.getElementsByName("old")[0].value;
	
	var str=document.getElementsByName("password")[0].value;//新密码
	var str2=document.getElementsByName("password2")[0].value;//确认密码
	if(old==''){
		//mt.show("请输入旧密码");
        layer.tips('请输入旧密码', '#old',{ tips:1});
		return;
	}
	if(str==''){
		//mt.show("请输入新密码");
        layer.tips('请输入新密码', '#password',{ tips:1});
		return;
	}
	if(str2==''){
		//mt.show("请输入确认密码");
        layer.tips('请输入确认密码', '#password2',{ tips:1});
		return;
	}
	if(old!=oldpwd){
		//mt.show("无效旧密码");
        layer.tips('无效旧密码','#old',{ tips:1});
		return;
	}
	if(str.length>=8&&(/\d/.test(str)&&/[a-z]/.test(str)&&/[A-Z]/.test(str))){
		if(str2==str){
			//提交
			form1.submit();
		}else{
			//mt.show("确认密码与新密码不相符！");
            layer.tips('确认密码与新密码不相符!','#password2',{ tips:1});
			return;
		}
	}else{
		//mt.show("请输入8-18位大小写字母和数字的组合！");
        layer.tips('请输入8-18位大小写字母和数字的组合!','#password',{tips:1});
		return;
	}

}

mt.fit();

</script>
