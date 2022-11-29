<%@page import="tea.ui.TeaSession"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.resource.Resource" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession tse=new TeaSession(request);
TeaSession teasession=new TeaSession(request);
Resource r = new Resource();
r.add("/tea/resource/fashiongolf");
%>

<style>
form,body{padding:0px;margin:0px;}
.MembersLog{color:#666;text-align:center;}
#loginid,#password{background:#F9F9F9;width:180px; height:29px;font-size:14px;color:#999;}
.MembersLog .con{height:230px;margin:0 auto;width:480px;}
.MembersLog .con .left{width:290px;float:left;text-align:center;}
.MembersLog .con .left .title{height:30px;*height:45px;padding-top:15px;font-size:13px;font-weight:bold;color:#000;}
.MembersLog .con .left table{margin:0 auto;width:200px;}
.MembersLog .con .left table td{padding:5px;font-size:14px;text-align:left;vertical-align:middle;}
.MembersLog .con .left table td.ForgotPW a{color:#BD1C20;font-size:12px;text-decoration:underline;}
.MembersLog .con .right{width:188px;float:right;text-align:center;font-size:12px;background:#f7f7f7;height:242px;}
.MembersLog .con .right .close{text-align:right;height:9px;*height:15px;padding:6px 6px 0px 0px;}
.MembersLog .con .right .top{height:34px;*height:82px;color:#BD1C20;padding-top:48px;}
.MembersLog .con .right .middle{margin-bottom:20px;}
img{border:0px; }
.MembersLog .con .left .LogBtn{text-align:center;}
.MembersLog .con .left .LogBtn input{width:87px;height:33px;background:url(/res/westrac/structure/logbutton.gif) no-repeat left top; border:0px;cursor:pointer;}
.MembersLog #logshowid{display:block;font-size:12px;font-weight:normal;}
</style>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/tea/ym/skin/dmm-green/ymPrompt.css" rel="stylesheet" type="text/css">
<script>
function f_ajax()
{

		if(formajax.LoginId.value=='')
		{

			document.getElementById("loginidshow").innerHTML="<font color=red><br/><%=r.getString(teasession._nLanguage, "Pleasephonenumberemail")%></font>";
			formajax.LoginId.focus();
			return false;
		}
		document.getElementById("loginidshow").innerHTML='';
		/**if(formajax.Password.value=='')
		{

			document.getElementById("passshowid").innerHTML="<font color=red><br/><%=r.getString(teasession._nLanguage, "Pleasefillinpassword")%></font>";
			formajax.Password.focus();
			return false;
		}**/
		document.getElementById("passshowid").innerHTML='';


		sendx("/jsp/admin/edn_ajax.jsp?act=WestracEvent_login&mobile="+ encodeURIComponent(formajax.LoginId.value)+"&paw="+formajax.Password.value,
				 function(data)
				 {
					data = data.trim();
					if(data==2)
					{

						document.getElementById("logshowid").innerHTML="<font color=red><%=r.getString(teasession._nLanguage, "Youenterphonemailpasswordenter")%></font>";

						return false;
					}else if(data==4)
	                {

	                    document.getElementById("logshowid").innerHTML="<font color=red><%=r.getString(teasession._nLanguage, "Youenterphonemaillockedpleasecontactadministrator")%></font>";
						return false;
	                }else
					{

	                	parent.ymPrompt.close();
	                	parent.window.location.reload();

					}

				 }
			 );


		///servlet/Login
}
</script>
<div class="MembersLog">
<div class="con">
<div class="left">
<div class="title"><%=r.getString(teasession._nLanguage, "Userlogin")%><span id="logshowid"></span></div>
<FORM  action="?" method="POST" name="formajax">
<input type="hidden" name="community" value="westrac" />
<input type="hidden" value="/html/folder/3-1.htm" name="nexturl" />
<table cellpadding="0" cellspacing="0">
<tr><td nowrap="nowrap" valign="middle"><%=r.getString(teasession._nLanguage, "Username")%>：</td><td><input name="LoginId" onFocus="if (value =='<%=r.getString(teasession._nLanguage, "Phonenumberemail")%>'){value =''};this.select(); " onBlur="if (value ==''){value='<%=r.getString(teasession._nLanguage, "Phonenumberemail")%>'}" onmouseover="this.focus()" value="<%=r.getString(teasession._nLanguage, "Phonenumberemail")%>"  id="loginid" /><span id="loginidshow"></span></td></tr>
         <tr><td nowrap="nowrap" valign="middle"><%=r.getString(teasession._nLanguage, "Password")%>：</td><td><input type="password" name="Password" id="password" onkeydown = "enterIn(event);" /> <span id ="passshowid"></span></td>
         </tr>
         <tr>
 <td class="ForgotPW" colspan="2"><a href="/jsp/util/RetrievePassword.jsp?" target="_blank"><%=r.getString(teasession._nLanguage, "Forgotyourpassword")%>？</a></td></tr>
         <tr><td class="LogBtn" colspan="2"><input type="button" name="" value="" onclick="f_ajax();"  herf="###"/></td></tr></table>
          </form></div>
<div class="right">
<div class="close"><a href="javascript:void(0);" onclick="parent.ymPrompt.close();"><img src="/res/westrac/structure/PopupClose.gif"/></a></div>
<div class="top"><%=r.getString(teasession._nLanguage, "Havenotyetregistered")%>FashionGolf</div>
<div class="middle"><a href="/html/folder/32.htm" target="_blank"><img src="/res/westrac/structure/MemberZhuce.gif"></a></div>
<div class="middle"><a href="/html/folder/17.htm" target="_blank"><img src="/res/westrac/structure/MemberZhuce2.gif"></a>
</div>
</div>
</div>
</div>
<script>
//回车
function enterIn(evt)
{
	var evt = evt?evt:(window.event?window.event:null);
	if(evt.keyCode==13)
	{
		var obj;
		f_ajax();
	}
}
</script>

