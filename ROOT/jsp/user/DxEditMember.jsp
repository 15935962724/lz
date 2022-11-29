<%@page import="tea.entity.RV"%>
<%@page import="tea.entity.Http"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.admin.mov.*"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="tea.entity.site.*" %>
<%@ page import = "tea.resource.Resource" %>

<%
TeaSession teasession =new TeaSession(request);
Http h=new Http(request);
Resource r = new Resource("/tea/resource/Photography");

if("POST".equals(request.getMethod()))
{

  if(!h.get("verify").equalsIgnoreCase((String)session.getAttribute("sms.vertify")))
  {
    out.print("<script>parent.window.f_verify();</script>");
    return;
  }

  String member=h.get("MemberId");
  if(Profile.isExisted(member))
  {
    out.print("<script>parent.window.alert('该会员名已被使用。')</script>");
    return;
  }

  Profile.create(member,h.get("EnterPassword"),h.community,h.get("email"),request.getServerName());
  Profile p=Profile.find(member);
  p.setMembertype(0);
  p.setFirstName(h.get("firstname"),h.language);
  boolean sex = false;
  if(h.getInt("sex")==2)
  {
	  sex = true;
  }
  p.setSex(sex);
  java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
  Date birthyear =null;
	 if(h.get("BirthYear")!=null && h.get("BirthYear").length()>0)
	 {
	      birthyear = sdf.parse(h.get("BirthYear") + "-" +h.get("BirthMonth") + "-" + h.get("BirthDay"));
	 }
	p.setBirth(birthyear);
	p.setTelephone(h.get("telephone "),h.language);
	p.setMobile(h.get("mobile"));
	p.setAddress(h.get("address"),h.language);
	p.setPinyin(h.get("pinyin"));

	String wv [] = teasession.getParameterValues("woid");
	StringBuffer sp = new StringBuffer();
	if(wv!=null)
	{
		for(int i=0;i<wv.length;i++)
		{
			sp.append(wv[i]).append("/");
		}
		p.setWoid("/"+sp.toString());
	}



  session.setAttribute("tea.RV",new RV(member));
  out.print("<script>window.alert('会员注册成功！');window.open('"+h.get("nexturl")+"','_parent')</script>");
  return;

}

tea.entity.site.Community community = tea.entity.site.Community.find(teasession._strCommunity);
%>

<html>
<head>
<title><%=r.getString(teasession._nLanguage,"9203379366") %></title><!-- 用户注册 -->
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/card.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/mt.js" type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>

<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>

<script>

function f_ajax()
{
  var value = frmsrch.MemberId.value;

  if(value=='')
  {
      document.getElementById("show").innerHTML='<font color=red>道号/昵称不能为空</font>';
      return false;

    }

    var name ="MemberId";
    //currentPos = "show";
  //  send_request("/jsp/mov/member_ajax.jsp?value="+encodeURIComponent(value)+"&name="+name);

    sendx("/jsp/mov/member_ajax.jsp?value="+encodeURIComponent(value)+"&name="+name,
   		 function(data)
   		 {
   		   if(data!=''&&data.length>1)//如果有这个用户  则写入Cookie .trim()
   		   {

   			    document.getElementById("show").innerHTML=data;
   			 if(data.indexOf('color=red')!=-1)
   			 {
	   			 document.getElementById("submitid").disabled=true;
	   			 document.getElementById("submitid").value='信息有误...';
	   			 document.getElementById("resetid").style.display='none';
   			 }else
   		     {
   				 document.getElementById("submitid").disabled=false;
	   			 document.getElementById("submitid").value='注册';
	   			 document.getElementById("resetid").style.display='';
   		     }
   		   }
   		 }
   		 );




}



function f_edit()
{
	f_ajax();

	if(frmsrch.EnterPassword.value.length<6 || frmsrch.EnterPassword.value.length>16)
    {
        document.getElementById("passwordshow").innerHTML='<font color=red>密码必须为6到16位之间.</font>';
        frmsrch.EnterPassword.focus();
        return false;
    }
     document.getElementById("passwordshow").innerHTML='';

    if(frmsrch.ConfirmPassword.value!=frmsrch.EnterPassword.value)
    {
       document.getElementById("confirmpasswordshow").innerHTML='<font color=red>两次密码输入不一致.</font>';
       frmsrch.ConfirmPassword.focus();
       return false;
   }
    document.getElementById("confirmpasswordshow").innerHTML='';
    if(frmsrch.firstname.value=='')
    {
       document.getElementById("firstname_show").innerHTML='<font color=red>请填写您真实姓名.</font>';
       frmsrch.firstname.focus();
       return false;
   }
    document.getElementById("firstname_show").innerHTML='';


    var str = document.frmsrch.mobile.value;
    if(str=='')
    {
    	document.getElementById("mobile_show").innerHTML='<font color=red>请填写您的手机号.</font>';
        frmsrch.mobile.focus();
        return false;
    }else{
	    var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
	    if(!reg.test(str)){
	    	document.getElementById("mobile_show").innerHTML='<font color=red>手机号格式不正确.</font>';
	        frmsrch.mobile.focus();
	        return false;
	    }
    }
    document.getElementById("mobile_show").innerHTML='';
    var str = frmsrch.email.value;
    if(str=='')
    {
    	document.getElementById("email_show").innerHTML='<font color=red>请填写您的E-mail.</font>';
        frmsrch.email.focus();
        return false;
    }else
    {
	    var  strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
	    var r=str.search(strReg);
	    if(r==-1){
	         document.getElementById("email_show").innerHTML='<font color=red>E-mail的格式不正确</font>';
	         frmsrch.email.focus();
	         return false;
	    }
    }
    document.getElementById("email_show").innerHTML='';

    if(frmsrch.address.value=='')
    {
       document.getElementById("address_show").innerHTML='<font color=red>请填写所在地.</font>';
       frmsrch.address.focus();
       return false;
   }
    document.getElementById("address_show").innerHTML='';


    if(frmsrch.verify.value=='')
    {
       document.getElementById("verify_show").innerHTML='<font color=red>请填写验证码.</font>';
       frmsrch.verify.focus();
       return false;
   }
    document.getElementById("verify_show").innerHTML='';

    frmsrch.submit();


}
function f_verify()
{
	 document.getElementById("verify_show").innerHTML='<font color=red>输入的验证码不正确.</font>';
     frmsrch.verify.focus();
     mt.verify();
     return false;
}
</script>


<form name="frmsrch" method="POST" action="?"  target="_ajax" >
 <input type="hidden" name="nexturl" value="/html/folder/2345900-1.htm" >
  <input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden" name="act" value="DxEditMember"/>


<table  border="0" cellpadding="0" cellspacing="0" id="tablecenter">

<tr>
	<td  align="right"><font color=red>*</font>&nbsp;道号/昵称：<td><input type=text name=MemberId value= ""  onkeyup="f_ajax();">&nbsp;
	<!-- <a href ="###" onclick="f_ajax();">检测昵称</a> -->&nbsp;<span id="show">&nbsp;</span></td>

</tr>
<tr>
  <td nowrap align="right"><font color=red>*</font>&nbsp;密码：</td>
  <td><input type="password" name="EnterPassword" value=""/>&nbsp;<span id="passwordshow">&nbsp;&nbsp;6-16个字符以内，不能使用纯数字。</span>&nbsp;<span style="line-height:22px;font-size:12px;"></span>
  </td>

</tr>


<tr>
  <td nowrap  align="right"><font color=red>*</font>&nbsp;确认密码：</td>
  <td><input type="password" name="ConfirmPassword" value=""/>&nbsp;&nbsp;<span id="confirmpasswordshow">&nbsp;</span></td>

</tr>
<tr>
	<td align="right"><font color=red>*</font>&nbsp;<span id=firstnameid>姓名</span>：</td>
	<td><input type="text" id="firstname" name="firstname" >&nbsp;<span id="firstname_show">&nbsp;&nbsp;请填写您真实姓名。</span></td>
	</td>
</tr>

<tr>
	<td align="right"><font color=red>*</font>&nbsp;性别：</td>
		<td><input type="radio" name="sex" value="1"  checked  > 先生<input type="radio" name="sex" value="0"  /> 女士</td>
</tr>

<tr>
		<td align="right"><font color=red>*</font>&nbsp;出生日期：</td>
		<td>
			<%
			java.util.Calendar c= java.util.Calendar.getInstance();
			c.set(java.util.Calendar.YEAR,c.get(java.util.Calendar.YEAR)-30);
			Date birth = c.getTime();
			out.print(new tea.htmlx.TimeSelection("Birth", birth));
			%>

		</td>
</tr>
<tr>
	<td nowrap align="right"><span id=telephoneid>电话</span>：</td>
	<td> <input type=text  name=telephone value="" maxlength="12"></td>
</tr>
<tr>
		<td align="right"><font color=red>*</font>&nbsp;手机：</td>
		<td> <input type=text  name="mobile" value="" maxlength="11"> <span id=mobile_show></span></td>
</tr>
<tr>
		<td align="right"><font color=red>*</font>&nbsp;E-mail：</td>
		<td> <input type=text  name="email" value="" maxlength="30"> <span id=email_show></span></td>
</tr>
 <tr>
 			<td nowrap align="right"><font color=red>*</font>&nbsp;<span id=addressid>所在地</span>：</td>
 			<td> <input type=text size=50 name="address" value="" >&nbsp;&nbsp;<span id=address_show>&nbsp;</span></td>
 </tr>
  <tr>
 			<td nowrap align="right">&nbsp;<span id=pinyinid>行业</span>：</td>
 			<td> <input type=text  name="pinyin" size=50  value="" >&nbsp;&nbsp;</td>
 </tr>
  <tr>
 			<td nowrap align="right">&nbsp;<span id=woidid>关注</span>：</td>
 			<td>
 				<%

                        for (int i=0;i<Profile.WOID_TYPE.length;i++)
                        {
                           if(i%4==0)
                           {
                            out.print("<br>");
                           }
                            out.print("<input type=\"checkbox\" name=\"woid\" value="+i+">");
                            out.print("&nbsp;"+Profile.WOID_TYPE[i]+"&nbsp;");

                        }
                    %>
 			</td>
 </tr>
    <tr>
 			<td nowrap align="right">&nbsp;<span id=yanzhengid>验证码</span>：</td>
 			<td>
	 			<input name="verify"  size="5" alt="验证码">
	 			<img id="t_verify" src="/NFasts.do?community=<%=teasession._strCommunity%>&act=verify"><a href="javascript:mt.verify()">看不清,换一张</a>
	 			<span id="verify_show"></span>
 			</td>
 </tr>

</table>

<script>
mt.verify=function()
{
  $('t_verify').src+='&t='+new Date().getTime();
}
var sel=frmsrch.BirthYear,op=sel.options;
for(var i=parseInt(op[0].value);i>=1890;i--)
{
  var aa=new Option(i,i);
  aa.innerHTML=i;
  sel.insertBefore(aa, op[0]);
}
</script>
&nbsp;&nbsp;&nbsp;&nbsp;
<div style="text-align:center;"><input type="button" id="submitid" value="注册" style="width:80px;height:20px;margin:10px 0;" onClick="f_edit();">&nbsp;&nbsp;
<input type="reset" id="resetid" value="<%=r.getString(teasession._nLanguage,"重设") %>" style="width:80px;height:20px;margin:10px 0;""/></div>
</form>
 <SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>

</html>

