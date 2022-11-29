<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.*" %><%@page import="java.text.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %><%@page import="tea.entity.site.*" %>
<%@page import="tea.resource.Resource" %>
<%
Http h=new Http(request,response);
if("POST".equals(request.getMethod()))
{
  out.println("<script src='/tea/tea.js'></script><script>var mt=parent.mt,doc=parent.document;</script>");
  String verify=h.get("verify","");
  if(!verify.equalsIgnoreCase((String)session.getAttribute("sms.vertify")))
  {
    out.print("<script>mt.show('“验证码”不正确！');</script>");
    return;
  }
  session.removeAttribute("sms.vertify");

  String nexturl=h.get("nexturl");
  String email=h.get("email");
  String password=h.get("password");
  if(Profile.count(" AND email="+DbAdapter.cite(email))>0)
  {
    out.print("<script>mt.show('该邮箱已被注册！');</script>");
    return;
  }
  String member=String.valueOf(Seq.get());
  Profile p=Profile.create(member,password,h.community,email,request.getServerName());
 
  p.setMembertype(4);//直接到未审核的高级会员 
  p.setCode(member);

  h.setCook("member",MT.enc(p.toString()),h.getInt("expiry",-1));
  session.setAttribute("tea.RV",new RV(member));
  out.print("<script>mt.show('会员注册成功！',1,'"+nexturl+"');</script>");
  return;
}

TeaSession teasession=new TeaSession(request);
Resource r = new Resource();
r.add("/tea/resource/fashiongolf");



%>
<script>
function f_sub1()
{
  if(form1.mobile.value=='')
  {
    document.getElementById("mobileshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "请填写注册的手机号")%></font>';
    form1.mobile.focus();
    return false;
  }else
  {
    var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
    if(!reg.test(form1.mobile.value))
    {
      document.getElementById("mobileshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Fillregisteredmobilephonenumberincorrect")%></font>';
      form1.mobile.focus();
      return false;
    }
  }
  document.getElementById("mobileshow1").innerHTML='';
  if(form1.checkcode.value=='')
  {
    document.getElementById("checkcodeshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "请填写手机校验码")%></font>';
    form1.checkcode.focus();
    return false;
  }
  document.getElementById("checkcodeshow1").innerHTML='';
  if(form1.membername.value=='')
  {
    document.getElementById("membernameShow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "请输入您的姓名")%></font>';
    form1.membername.focus();
    return false;
  }

  document.getElementById("membernameShow1").innerHTML='';
  if(form1.membertitle.value=='')
  {
    document.getElementById("membertitleshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Pleasefillinyournickname")%></font>';
    form1.membertitle.focus();
    return false;
  }
  document.getElementById("membertitleshow1").innerHTML='';
  if(form1.password.value =='' )
  {
    document.getElementById("passwordshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Pleasefillinpassword")%></font>';
    form1.password.focus();
    return false;
  }

  document.getElementById("passwordshow1").innerHTML='';
  if( form1.password.value.length<6 || form1.password.value.length>18)
  {
    document.getElementById("passwordshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Thepasswordmustbebetween")%></font>';
    form1.password.focus();
    return false;
  }

	 document.getElementById("passwordshow1").innerHTML='';
	    if(form1.password2.value!=form1.password.value)
	    {
	    	 document.getElementById("password2show1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Twicepasswordinputinconsistent")%></font>';
	       form1.password2.focus();
	       return false;
	   }
	    document.getElementById("password2show1").innerHTML='';

	    if(form1.verify.value=='')
	    {

	    	 document.getElementById("verifyshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Pleasefillouttheverificationcode")%></font>';
	    	form1.verify.focus();
	    	return false;
	    }

	    var f = false;
		if(form1.agreement.checked){
			f = true;
		}
	    for (var i=0; i< form1.agreement.length; i++)
	    {
	      if (form1.agreement[i].checked)
	    	  f = true;
	    }

	    if(!f)
	    {

	    	 document.getElementById("agreementshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "PleaseselecttheTermsofService")%></font>';
	    	form1.agreement.focus();
			return false;
	    }


	    sendx("/jsp/admin/edn_ajax.jsp?act=WestracEventlogin&mobile="+ form1.mobile.value+"&membertitle="+encodeURIComponent(form1.membertitle.value),
				 function(data)
				 {
					data = data.trim();


					if(data.split("/")[1]=='t')
					{

						 document.getElementById("mobileshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Youusethephonenumberhasbeenoccupied")%></font>';
						form1.mobile.focus();
						return false;
					}else if(data.split("/")[2]=='t')
					{

						document.getElementById("membertitleshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Yournicknameisalreadyoccupied")%></font>';
						form1.membertitle.focus();
						return false;
					}
					else
					{

						document.getElementById("mobileshow1").innerHTML='';
						document.getElementById("membertitleshow1").innerHTML='';


					    sendx("/jsp/admin/edn_ajax.jsp?act=WestracEventloginverify&verify="+ form1.verify.value+"&checkcode="+form1.checkcode.value+"&mobile="+form1.mobile.value,
								 function(data)
								 {
									data = data.trim();
									if(data.split("/")[1]=='t')
									{

										document.getElementById("verifyshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "verificationcodeerrorPleaseagain")%></font>';

										reloadVcode();
										form1.verify.focus();
										return false;
									}else if(data.split("/")[2]=='t')
									{

										document.getElementById("checkcodeshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "phonechecksumisincorrectorhasexpiredplease")%></font>';

										form1.checkcode.focus();
										return false;
									}
									else
									{
										document.getElementById("verifyshow1").innerHTML='';
										document.getElementById("checkcodeshow1").innerHTML='';

										var a =document.getElementsByName("sex");
										var sex=0;
										for(var i=0;i<a.length;i++){
											if(a[i].checked == true){sex=a[i].value;}
										}

											 sendx("/jsp/admin/edn_ajax.jsp?act=WestracEvent_reg&membertype=4&verify="+ form1.verify.value+"&mobile="+form1.mobile.value+"&membername="+form1.membername.value+"&sex="+sex+"&password="+form1.password.value+"&membertitle="+encodeURIComponent(form1.membertitle.value),
												 function(data)
												 {
													  data = data.trim();
													//	alert(data);

														window.location.href='/jsp/info/Succeed.jsp';



												 }
										 	);

									}

								 }
							 );



					}

				 }
			 );
}
function f_sub2()
{
	getCheckBoxValue();
  if(form2.mobile.value=='')
  {
    document.getElementById("mobileshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "请填写注册的手机号 ")%></font>';
    form2.mobile.focus();
    return false;
  }else
  {
    var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
    if(!reg.test(form2.mobile.value))
    {
      document.getElementById("mobileshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Fillregisteredmobilephonenumberincorrect")%></font>';
      form2.mobile.focus();
      return false;
    }
  }
  document.getElementById("mobileshow").innerHTML='';
  if(form2.checkcode.value=='')
  {
    document.getElementById("checkcodeshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "请填写手机校验码")%></font>';
    form2.checkcode.focus();
    return false;
  }

  document.getElementById("checkcodeshow").innerHTML='';
  if(form2.membername.value=='')
  {
    document.getElementById("membernameShow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "请输入您的姓名")%></font>';
    form2.membername.focus();
    return false;
  }

  document.getElementById("membernameShow").innerHTML='';
  if(form2.membertitle.value=='')
  {
    document.getElementById("membertitleshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "请输入商户名称")%></font>';
    form2.membertitle.focus();
    return false;
  }
  document.getElementById("membertitleshow").innerHTML='';
  if(form2.password.value =='' )
  {
    document.getElementById("passwordshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Pleasefillinpassword")%></font>';
    form2.password.focus();
    return false;
  }

  document.getElementById("passwordshow").innerHTML='';
  if( form2.password.value.length<6 || form2.password.value.length>18)
  {
    document.getElementById("passwordshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Thepasswordmustbebetween")%></font>';
    form2.password.focus();
    return false;
  }

	 document.getElementById("passwordshow").innerHTML='';
	    if(form2.password2.value!=form2.password.value)
	    {
	    	 document.getElementById("password2show").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Twicepasswordinputinconsistent")%></font>';
	       form2.password2.focus();
	       return false;
	   }
	    document.getElementById("password2show").innerHTML='';

	    if(form2.verify.value=='')
	    {

	    	 document.getElementById("verifyshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Pleasefillouttheverificationcode")%></font>';
	    	form2.verify.focus();
	    	return false;
	    }

	    var f = false;
		if(form2.agreement.checked){
			f = true;
		}
	    for (var i=0; i< form2.agreement.length; i++)
	    {
	      if (form2.agreement[i].checked)
	    	  f = true;
	    }

	    if(!f)
	    {

	    	 document.getElementById("agreementshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "PleaseselecttheTermsofService")%></font>';
	    	form2.agreement.focus();
			return false;
	    }


	    sendx("/jsp/admin/edn_ajax.jsp?act=WestracEventlogin&mobile="+ form2.mobile.value+"&membertitle="+encodeURIComponent(form2.membertitle.value),
				 function(data)
				 {
					data = data.trim();


					if(data.split("/")[1]=='t')
					{

						 document.getElementById("mobileshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Youusethephonenumberhasbeenoccupied")%></font>';
						form2.mobile.focus();
						return false;
					}else if(data.split("/")[2]=='t')
					{

						document.getElementById("membertitleshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Yournicknameisalreadyoccupied")%></font>';
						form2.membertitle.focus();
						return false;
					}
					else
					{

						document.getElementById("mobileshow").innerHTML='';
						document.getElementById("membertitleshow").innerHTML='';


					    sendx("/jsp/admin/edn_ajax.jsp?act=WestracEventloginverify&verify="+ form2.verify.value+"&checkcode="+form2.checkcode.value+"&mobile="+form2.mobile.value,
								 function(data)
								 {
									data = data.trim();
									if(data.split("/")[1]=='t')
									{

										document.getElementById("verifyshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "verificationcodeerrorPleaseagain")%></font>';

										reloadVcode2();
										form2.verify.focus();
										return false;
									}else if(data.split("/")[2]=='t')
									{

										document.getElementById("checkcodeshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "phonechecksumisincorrectorhasexpiredplease")%></font>';

										form2.checkcode.focus();
										return false;
									}
									else
									{
										document.getElementById("verifyshow").innerHTML='';
										document.getElementById("checkcodeshow").innerHTML='';

										var a =document.getElementsByName("sex2");
										var sex2=0;
										for(var i=0;i<a.length;i++){
											if(a[i].checked == true){sex2=a[i].value;}
										}
											 sendx("/jsp/admin/edn_ajax.jsp?act=WestracEvent_reg&membertype=1&verify="+ form2.verify.value+"&mobile="+form2.mobile.value+"&sex="+sex2+"&membername="+form2.membername.value+"&merchanttype="+form2.mmtype.value+"&merchantcontent="+form2.merchantcontent.value+"&password="+form2.password.value+"&membertitle="+encodeURIComponent(form2.membertitle.value),
												 function(data)
												 {
													  data = data.trim();
													//	alert(data);

														window.location.href='/jsp/info/Succeed.jsp';



												 }
										 	);

									}

								 }
							 );



					}

				 }
			 );
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
   document.getElementById("url_id").innerHTML = num;
	 if(num == 0)
	 {
		 document.getElementById("verid").disabled='';
		 document.getElementById("verid").value='获取短信效验码';
		 document.getElementById("mobileshow_div").innerHTML='';
	 }
}
function Load1()
{

	for(var i=time;i>=0;i--)
	{
	window.setTimeout("doUpdate1("+ i +")", (time-i) * 1000);
	}
}
function doUpdate1(num)
{
   document.getElementById("url_id1").innerHTML = num;
	 if(num == 0)
	 {
		 document.getElementById("verid1").disabled='';
		 document.getElementById("verid1").value='获取短信效验码';
		 document.getElementById("mobileshow_div1").innerHTML='';
	 }
}
function f_ver()
{

	if(form1.mobile.value=='')
	{

		document.getElementById("mobileshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "请填写注册的手机号 ")%></font>';
		form1.mobile.focus();
		return false;
	}else
	{
		 var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
		 if(!reg.test(form1.mobile.value))
		{
			 document.getElementById("mobileshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Fillregisteredmobilephonenumberincorrect")%></font>';
				form1.mobile.focus();
				return false;
		}
	}

	 document.getElementById("mobileshow1").innerHTML='';

	 sendx("/jsp/admin/edn_ajax.jsp?act=WestracEventloginVer&mobile="+ form1.mobile.value,
			 function(data)
			 {
				data = data.trim();


				if(data=='t')
				{

					document.getElementById("mobileshow1").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "usingthephonenumberhasbeenregisterednotvalidationcode")%></font>';
					form1.mobile.focus();
					return false;

				}else
				{
					document.getElementById("mobileshow1").innerHTML='';
					//alert('校验码已发出，请注意查收短信，如果没有收到，您可以在50秒后要求系统重新发送');
					 document.getElementById("mobileshow1").innerHTML='';
					document.getElementById("verid1").disabled='disabled';
					document.getElementById("verid1").value='<%=r.getString(teasession._nLanguage, "校验码发送中，请稍后")%>...';
					document.getElementById("checkcodeid1").disabled='';
					document.getElementById("checkcodeid1").style.backgroundColor='';
					var divr = '<%=r.getString(teasession._nLanguage, "校验码已发出，请注意查收短信，如果没有收到，您可以在")%>&nbsp;<span id="url_id1" style="font-size:20px; color:#FF0000;"></span>&nbsp;<%=r.getString(teasession._nLanguage, "秒后要求系统重新发送。")%> ';
					document.getElementById("mobileshow_div1").innerHTML=divr;
					Load1();

					form1.mobile.focus();
				}


			 }
		 );


}
function f_ver2()
{

	if(form2.mobile.value=='')
	{

		document.getElementById("mobileshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "请填写注册的手机号 ")%></font>';
		form2.mobile.focus();
		return false;
	}else
	{
		 var reg=/^(((13[0-9]{1})|(18[0-9]{1})|150|151|152|153|154|155|156|157|158|159)+\d{8})$/;
		 if(!reg.test(form2.mobile.value))
		{
			 document.getElementById("mobileshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "Fillregisteredmobilephonenumberincorrect")%></font>';
				form2.mobile.focus();
				return false;
		}
	}

	 document.getElementById("mobileshow").innerHTML='';
	 sendx("/jsp/admin/edn_ajax.jsp?act=WestracEventloginVer&mobile="+ form2.mobile.value,
			 function(data)
			 {
				data = data.trim();


				if(data=='t')
				{

					document.getElementById("mobileshow").innerHTML='<br><font color=red><%=r.getString(teasession._nLanguage, "usingthephonenumberhasbeenregisterednotvalidationcode")%></font>';
					form2.mobile.focus();
					return false;

				}else
				{
					document.getElementById("mobileshow").innerHTML='';
					//alert('校验码已发出，请注意查收短信，如果没有收到，您可以在50秒后要求系统重新发送');
					 document.getElementById("mobileshow").innerHTML='';
					document.getElementById("verid").disabled='disabled';
					document.getElementById("verid").value='<%=r.getString(teasession._nLanguage, "校验码发送中，请稍后")%>...';
					document.getElementById("checkcodeid").disabled='';
					document.getElementById("checkcodeid").style.backgroundColor='';
					var divr = '<%=r.getString(teasession._nLanguage, "校验码已发出，请注意查收短信，如果没有收到，您可以在")%>&nbsp;<span id="url_id" style="font-size:20px; color:#FF0000;"></span>&nbsp;<%=r.getString(teasession._nLanguage, "秒后要求系统重新发送。")%> ';
					document.getElementById("mobileshow_div").innerHTML=divr;
					Load();

					form2.mobile.focus();
				}


			 }
		 );


}
function reloadVcode()
{
	var vcode = document.getElementById('vcodeImg');
	vcode.setAttribute('src','/NFasts.do?community=<%=teasession._strCommunity %>&act=verify&r='+Math.random());
	//这里必须加入随机数不然地址相同我发重新加载
}
function reloadVcode2()
{
	var vcode = document.getElementById('vcodeImg2');
	vcode.setAttribute('src','/NFasts.do?community=<%=teasession._strCommunity %>&act=verify&r='+Math.random());
	//这里必须加入随机数不然地址相同我发重新加载
}

</script>
<script src='/tea/mt.js'></script>

<div class="con">
<div class="RegSelect">
<a href='###' onclick='mt.tab(this)' id='way1'>普通会员</a>
<a href='###' onclick='mt.tab(this)' id='way2'>商户会员</a>
<%
Community c=Community.find(h.community);
/* String[] arr=c.regway.split("[|]");
if(arr.length>2)
{
  for(int i=1;i<arr.length;i++)
  {
    out.print("<a href='###' onclick='mt.tab(this)' id='way"+i+"'>"+Community.REG_WAY[i]+"</a>");
  }
} */

String nexturl=request.getHeader("referer");
if(nexturl==null)nexturl="/";


%></div>
<span id="text">我已是中华服务网会员，请<a href="/html/Home/folder/14050063-1.htm" onclick="sea.login();">登录</a></span>
<form id="fway1" name="form1" method="post" action="?" target="_ajax" style="display:none">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="act" value="putong"/>
<table border="0" cellpadding="0" cellspacing="0" class="regtable">

  <tr>
    <td align="right" valign="top" class="td01"><span id="iphone">*手机号码：</span></td>
    <td valign="top"><input name="mobile" id="mobileid" value="" ><span id="mobileshow1"></span>
    <br><span id="tishi">*请填写您真实的手机号码，否则无法接收验证短信。</span>
    <input type="button" value="获取短信校验码" onClick="f_ver();" id="verid1">
      <div id="mobileshow_div1"> </div>
    </td>
  </tr>

  <tr>
    <td align="right" class="td01">*请填写手机校验码：</td>
    <td>
    <input name="checkcode" id="checkcodeid1" value="" disabled  style="background-color:#CCCCCC;"><span id="checkcodeshow1"></span>

    </td>
  </tr>


    <tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "姓名")%>：</td>
    <td><input name="membername" id="membertitleid" value="" ><span id="membernameShow1"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "性别")%>：</td>
    <td><input name="sex" id="sexid" type="radio" value="0" checked="checked">先生<input name="sex" type="radio" id="sexid" value="1" >女士</td>
  </tr>
  
  <tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "密码")%>：</td>
    <td><input id="password" type="password" name="password"  min='6' maxlength="20" alt="<%=r.getString(teasession._nLanguage, "Password")%>"><span id="passwordshow1"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01">*确认密码：</td>
    <td><input id="password2" type="password" name="password2"  alt="<%=r.getString(teasession._nLanguage, "Confirmpassword")%>"><span id="password2show1"></span></td>
  </tr>
  <!--<tr>
    <td align="right" class="td01">E-mail：</td>
    <td><input name="email" value=""><span class="tixing"></span>
  </tr>-->
  <tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "验证码")%>：</td>
    <td><table border="0" cellpadding="0" cellspacing="0"><tr><td><input name="verify" size="5" alt="<%=r.getString(teasession._nLanguage, "验证码")%>"></td><td>&nbsp;<img id="vcodeImg" src="/NFasts.do?community=westrac&act=verify"></td><td style="vertical-align:middle;">&nbsp;<a href="###" onClick="reloadVcode();"><%=r.getString(teasession._nLanguage, "看不清")%></a>

    </td></tr></table> <span id="verifyshow1"></span><div id="verify_info"></div></td>
  </tr>
</table>
<input type="checkbox" name="agreement" value="1" alt="<%=r.getString(teasession._nLanguage, "MembershipAgreement")%>">
<%=r.getString(teasession._nLanguage, "我同意")%><a class="Agreement" href="/html/Home/folder/14050187-1.htm" target="_blank">《中华服务网服务条款》</a><span id="agreementshow1"></span>
<br><br><input id="button" type="button" value="<%=r.getString(teasession._nLanguage, "Submittedforregistration")%>" onClick="f_sub1();">
</form>
<%-- <form id="fway1" name="form1" action="/jsp/mov/GolfRegistra.jsp" method="post" target="_ajax" style="display:none" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="reg1"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<table class="regtable">
  <tr>
    <td align="right">Email地址：</td>
    <td><script>document.write("<in"+"put name='em"+"ail' alt='Em"+"ail地址' />");</script></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">密码：</td>
    <td><input name="password" type="password" alt="密码"/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">确认密码：</td>
    <td><input name="password2" type="password" alt="确认密码"/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right"><%=r.getString(teasession._nLanguage, "验证码")%>：</td>
    <td>
      <input name="verify" size="5" alt="<%=r.getString(teasession._nLanguage, "验证码")%>">
      <img id="vcode1" src="/NFasts.do?community=westrac&act=verify"/>
      <a href="###" onClick="$$('vcode1').src+='&';"><%=r.getString(teasession._nLanguage, "Notsee")%></a>
    </td>
  </tr>
</table>
<input type="checkbox" name="agreement" value="1" alt="<%=r.getString(teasession._nLanguage, "MembershipAgreement")%>"><%=r.getString(teasession._nLanguage, "myagree")%><a class="Agreement" href="/html/folder/49-1.htm" target="_blank">《FashionGOLF<%=r.getString(teasession._nLanguage, "TermsofService")%>》</a><span id="agreementshow"></span>
<br><br>
<input id="button" type="submit" value="<%=r.getString(teasession._nLanguage, "Submittedforregistration")%>" >
</form> --%>

<form id="fway2" name="form2" method="post" action="?" target="_ajax" style="display:none">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>
<input type="hidden" name="mmtype" value=""/>
<table border="0" cellpadding="0" cellspacing="0" class="regtable">

  <tr>
    <td align="right" valign="top" class="td01"><span id="iphone">*手机号码：</span></td>
    <td valign="top"><input name="mobile" id="mobileid" value="" ><span id="mobileshow"></span>
    <br><span id="tishi">*<%=r.getString(teasession._nLanguage, "请填写您真实的手机号码，否则无法接收验证短信")%>。</span>
    <input type="button" value="<%=r.getString(teasession._nLanguage, "获取短信校验码")%>" onClick="f_ver2();" id="verid">

      <div id="mobileshow_div"> </div>

    </td>
  </tr>

  <tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "请填写手机校验码")%>：</td>
    <td>
    <input name="checkcode" id="checkcodeid" value="" disabled  style="background-color:#CCCCCC;"><span id="checkcodeshow"></span>

    </td>
  </tr>
  <tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "姓名")%>：</td>
    <td><input name="membername" id="membertitleid" value="" ><span id="membernameShow"></span></td>
  </tr>
    <tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "商户名称")%>：</td>
    <td><input name="membertitle" id="membertitleid" value="" ><span id="membertitleshow"></span></td>
  </tr>
<tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "性别")%>：</td>
    <td><input name="sex2" id="sexid" type="radio" value="0" checked="checked">先生<input name="sex2" type="radio" id="sexid" value="1" >女士</td>
  </tr>
  
  <tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "密码")%>：</td>
    <td><input id="password" type="password" name="password"  min='6' maxlength="20" alt="<%=r.getString(teasession._nLanguage, "Password")%>"><span id="passwordshow"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "确认密码")%>：</td>
    <td><input id="password2" type="password" name="password2"  alt="<%=r.getString(teasession._nLanguage, "确认密码")%>"><span id="password2show"></span></td>
  </tr>
  <!--<tr>
    <td align="right" class="td01">E-mail：</td>
    <td><input name="email" value=""><span class="tixing"></span>
  </tr>-->
  <tr>
<%
String roles=h.get("roles");
  out.print("<td align='right' class='td01'>*请选择商户类型：</td><td>");
  for(int i =1;i<roles.split("[|]").length;i++)
  {
    out.print("<input type=\"checkbox\" name=\"merchanttype\" value=\""+roles.split("[|]")[i]+"\"");
    
    out.print(">"+AdminRole.find(Integer.parseInt(roles.split("[|]")[i])).getName()+"　");
  }
%>
   <span id="merchanttypeshow"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01">*请填写所选类型说明：</td>
    <td><textarea rows="3" cols="40" name="merchantcontent"></textarea><span id="merchantcontentshow"></span></td>
  </tr>
  <tr>
    <td align="right" class="td01">*<%=r.getString(teasession._nLanguage, "验证码")%>：</td>
    <td><table border="0" cellpadding="0" cellspacing="0"><tr><td><input name="verify"  size="5" alt="<%=r.getString(teasession._nLanguage, "验证码")%>"></td><td>&nbsp;<img id="vcodeImg2" src="/NFasts.do?community=westrac&act=verify"></td><td style="vertical-align:middle;">&nbsp;<a href="###" onClick="reloadVcode2();"><%=r.getString(teasession._nLanguage, "看不清")%></a>

    </td></tr></table> <span id="verifyshow"></span><div id="verify_info"></div></td>
  </tr>
</table>
<input type="checkbox" name="agreement" value="1" alt="<%=r.getString(teasession._nLanguage, "MembershipAgreement")%>">
<%=r.getString(teasession._nLanguage, "我同意")%><a class="Agreement" href="/html/Home/folder/14050187-1.htm" target="_blank">《中华服务网服务条款》</a><span id="agreementshow"></span>
<br><br><input id="button" type="button" value="<%=r.getString(teasession._nLanguage, "")%>" onClick="f_sub2()">
</form>

</div>
<script>


function getCheckBoxValue(){
	var arr=[];
    var r=document.getElementsByName("merchanttype");
    var j=0;
    for(var i=0;i<r.length;i++){
         if(r[i].checked){
                 arr[j] = r[i].value;
                 j=Number(j)+1;
         }    
    }
    form2.mmtype.value="|"+arr+"|";
}
var way1=null,way2=null;
mt.tab=function(a)
{
  if(way1)way1.className='';
  (way1=a).className='current';

  if(way2)way2.style.display='none';
  (way2=$$('f'+a.id)).style.display='';
};
$$('way1').onclick();
</script>
