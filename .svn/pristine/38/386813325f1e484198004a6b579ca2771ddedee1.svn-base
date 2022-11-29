<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%
TeaSession teasession =new TeaSession(request);
Community community=Community.find(teasession._strCommunity);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
String act = request.getParameter("act");
if (act != null)
  {
    String value = request.getParameter("value");

    if (act.equals("email")) {
      out.print(!Bperson.isExisted(value));//&&!Profile.isLExisted(value,teasession._nLanguage));
    }

    return;
  }
%>
<HTML>
  <HEAD>
    <title>B-picture会员-注册</title>

<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function check(form)
{
  return submitText(form.name,'无效-姓名')
  &&submitText(form.email,'无效-Email')
  &&submitEmail(form.email,'无效-Email')
  &&submitText(form.password,'无效-密码')
  &&submitText(form.conpwd,'无效-确认密码')
  &&submitEqual(form.password,form.conpwd,'两次密码输入不一致')
  &&submitjob(form.jobstyle,'请选择工作类型')
  &&submitjob(form.city,'请选择省')
  &&submitText(form.state,'无效-市/区')
  &&submitText(form.addr,'无效-地址')
  &&submitText(form.zip,'无效-邮编')
  &&submitInteger(form.zip,'无效-邮编')
  &&submitText(form.mobile,'无效-手机')
  &&submitInteger(form.mobile,'无效-手机')
  &&submitLength(11,12,form.mobile,'无效-手机')
  &&submitInteger(form.phone,'无效-联系电话')
  &&submitterms(form.terms,'无效-协议');
}
function submitInteger(text, alerttext)
{if(text.value.length>0){
	if (isNaN(parseInt(text.value)))
	{
		alert(alerttext);
		text.focus();
		return false;
	}
	text.value=parseInt(text.value);
	return true;
      }
        return true;
}
function submitjob(text,alerttext)
{
  if(text.value.length==0||text.value=='00')
  {
    alert(alerttext);
    text.focus();
    return false;
  }
  return true;
}

function submitterms(text,alerttext)
{
  if(!text.checked){
    alert(alerttext);
    text.focus();
    return false;
  }
  return true;
}
function submitEmail(text, alerttext)
{
	var   strReg="";
	var   r;
	var str = text.value;
        if(str.length>0){
          strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
          r=str.search(strReg);
          if(r==-1)
          {
            alert(alerttext);
            text.focus();
            return false;
          }

          return true;
        }
        return true;
}

function f_ajax(obj)
{
  var act=obj.name;
  var sv=document.getElementById('span_'+act);
  var checkid=document.getElementById('checkID');
  if(obj.value==""||obj.value==null)
  {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>不能为空";
    return;
  }
  sv.innerHTML="<img src=/tea/image/public/load.gif>";
sendx("?act="+act+"&value="+obj.value,function(v)
  {
    var   strReg="";
    var   r;
    var str = reg.email.value;
    strReg=/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/i;
    r=str.search(strReg);
    if(r==-1){
      sv.innerHTML="<img src=/tea/image/public/check_error.gif>Email格式不正确";
      checkid.value="true";
    }
    else{
      if(v.indexOf('true')!=-1)
      {

        sv.innerHTML="<img src=/tea/image/public/check_right.gif>用户名可用";
        checkid.value="false";

      }else
      {

        sv.innerHTML="<img src=/tea/image/public/check_error.gif>用户名已存在";
        checkid.value="true";

      }
    }
  }
  )
}

function f_jax(obj)
{
  var act=obj.name;
  var sv=document.getElementById('span_'+act);
  if(obj.value==""||obj.value==null)
  {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>不能为空";
    return;
  }
  sv.innerHTML="<img src=/tea/image/public/load.gif>";
  if(act=="password")
  {
    if(document.reg.password.value.length<6)
    {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>密码长度小于6位";
    }else
    {
    sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
    }
  }
  if(act=="conpwd")
  {
    if(document.reg.conpwd.value.length<6)
    {
    sv.innerHTML="<img src=/tea/image/public/check_error.gif>确认密码长度小于6位";
    }else
    {
      if(document.reg.conpwd.value!=document.reg.password.value)
      {
      sv.innerHTML="<img src=/tea/image/public/check_error.gif>两次密码输入不一致";
      }else
      {
      sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
      }
    }

  }
}
</script>
<style>
#dv1{width:100%;text-align:right;font-size:12px;height:55px;background:url(/res/bigpic/u/0812/081255616.jpg) no-repeat 10 5;color:#0000CC;}
.lzj_a{margin:0 10px;color:#0000CC; text-decoration:none;margin-top:8px;}
#tablecenter001{border-top:1px solid #67A7E4;background:#D6E6FF;font-size:12px;color:#000;height:28px;line-height:28px;padding-left:15px;}
#tablecenter001 a{color:#0000ff;}
.t{margin:12px 0;height:20px;line-height:20px;width:100%;font-size:14px;font-weight:bold;background:url(/res/bigpic/u/0812/081243709.gif) no-repeat 25 2;padding-left:45px;}
#tablecenter002{background:#F6F6F6;border-top:10px solid #eeeeee;font-size:12px;line-height:150%;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0812/081243710.jpg) no-repeat;border:0;margin:0 10px;}
#txtfirstName,#txtPwd1,#txtPwd2,#selJobTitle,#selCompanyType,#txtzip,#txtMobilePhone{width:200px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}
#txtEmail,#txtJobTitleOther,#txtCompanyTypeOther,#txtCompany,#txtCompanyWebsite,#txtaddr1,#txtstate,#txtzip,#txtContactPhone{width:300px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}
.top{border-top:1px solid #cccccc;margin-top:19px;}
.top td{font-size:12px;line-height:150%;}
.top td a{color:#0000CC;}
</style>
</HEAD>
<body style="margin:0;padding:0;">
 <div id="jspbefore">
    <%=community.getJspBefore(teasession._nLanguage)%>
  </div>
 <div style="text-align:left;" id="li_biao">　><a href="http://bp.redcome.com">首页</a>>注册</div>
<div class="t">注册</div>

  <form name="reg" action="/servlet/EditBPperson" method="post" onSubmit="return(check(this));">
  <input type="hidden" name="checkID" value="<%=!Bperson.isExisted(request.getParameter("value"))%>"/>
<input type="hidden" name="act" value="reg"/>
  <table cellSpacing="0" cellPadding="2" width="700" align="center" border="0" id="tablecenter002">
    <tr>
      <td width="8" rowSpan="11"><IMG height="1" src="Images/s.gif" width="4"></td>
        <td height="40" colSpan="2"><strong>基本信息</strong></td>
        <td align="right"><span class="red"><strong>*</strong></span>
          表示必填字段</td>
          <td width="8" rowSpan="11"><IMG height="1" src="Images/s.gif" width="4"></td>
    </tr>
    <tr>
      <td align="right">性别</td>
      <td class="red" align="center" width="8"><span style="color:#0265CB;"><b>*</b></span></td>
      <td width="431"><select name="sex" id="DrpTitle" tabindex="10">
        <option selected="selected" value="1">先生</option>
        <option value="0">女士</option>
</select></td>
    </tr>
    <tr>
      <td align="right">姓名</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="name" type="text" maxlength="50" id="txtfirstName" tabindex="15" size="35" /></td>
    </tr>
    <tr>
      <td height="40" colSpan="3"><strong>登陆信息</strong></td>
    </tr>
    <tr>
      <td align="right">Email</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="email" type="text" maxlength="50" id="txtEmail" onBlur="f_ajax(this)" tabindex="25" size="35" /><span id="span_email" style="padding:2px 0 2px 0;font-size:12px;color:#7F7F7F;"></span></td>
    </tr>
    <tr>
      <td align="right" valign="top">密码</td>
      <td align="center" valign="top" class="red"><span style="color:#0265CB;"><b>*</b></span></td>
      <td>

         <input name="password" type="password" maxlength="12" id="txtPwd1" tabindex="30"  onblur="f_jax(this)"/>
            &nbsp;
            <br><span id="span_password" style="padding:2px 0 2px 0;font-size:12px;color:#7F7F7F;">为了确保密码最大的安全性，我们建议您不要选择使用在其他网站上的密码</span>

      </td>
    </tr>
    <tr>
      <td align="right">确认密码</td>
      <td class="red" align="center"><span style="color:#0265CB;"><span style="color:#0265CB;"><b>*</b></span></span></td>
      <td><input name="conpwd" type="password" maxlength="12" id="txtPwd2" tabindex="35"  onblur="f_jax(this)"/>
      &nbsp;
      <br><span id="span_conpwd" style="padding:2px 0 2px 0;font-size:12px;color:#7F7F7F;">&nbsp;</span>
</td>
    </tr>
  </table>
  <table cellSpacing="0" cellPadding="2" width="700" align="center" border="0" id="tablecenter002" style="border:0;border-bottom:10px solid #eeeeee;">
    <tr>
      <td width="8" rowSpan="30"><IMG height="1" src="Images/s.gif" width="4"></td>
        <td height="40" colSpan="4">

             <strong>公司和联系信息</strong>      </td>
      <td width="8" rowSpan="30"><IMG height="1" src="Images/s.gif" width="4"></td>
    </tr>

    <tr>
      <td align="right" height="43">工作类型</td>
      <td class="red" align="center" height="43"><span style="color:#0265CB;"><b>*</b></span></td>
      <td height="43"><select name="jobstyle" id="selJobTitle" tabindex="61">
        <option value="">请选择 ...</option>
        <%
                for(int i=0;i<Common.JOBSTYLE.length;i++)
                {
                  out.print("<option value="+Common.JOBSTYLE[i][0]+" >"+Common.JOBSTYLE[i][1]);
                }
                %>
</select></td>
    </tr>
    <tr>
      <td align="right">(其他)</td>
      <td>&nbsp;</td>
      <td><input name="jobother" type="text" maxlength="80" id="txtJobTitleOther" tabindex="62" size="35" /></td>
    </tr>

    <tr>
      <td colSpan="3">&nbsp;</td>
    </tr>
    <tr>

      <td align="right">公司类型</td>
      <td>&nbsp;</td>
      <td><select name="comstyle" id="selCompanyType" tabindex="63">
        <option value="">请选择...</option>
  <%
                for(int i=0;i<Common.COMPANYSTYLE.length;i++)
                {
                  out.print("<option value="+Common.COMPANYSTYLE[i][0]+" >"+Common.COMPANYSTYLE[i][1]);
                }
                %>
</select></td>
    </tr>
    <tr>
      <td align="right">(其他)</td>
      <td>&nbsp;</td>
      <td><input name="comother" type="text" maxlength="50" id="txtCompanyTypeOther" tabindex="64" size="35" /></td>
    </tr>



    <tr>
      <td align="right">公司名称</td>
      <td class="red" align="center"><!--<span id="lblMandatory"><span style="color:#0265CB;"><b>*</b></span></span>--></td>
      <td><input name="comname" type="text" maxlength="100" id="txtCompany" tabindex="66" size="35"/></td>
    </tr>

    <tr>
      <td align="right">网站</td>
      <td>&nbsp;</td>
      <td><input name="web" type="text" maxlength="80" id="txtCompanyWebsite" tabindex="68" size="35" /></td>
    </tr>
    <tr>
      <td colSpan="3">&nbsp;</td>
    </tr>
    <tr>
      <td align="right">省</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td> <select id="city" name="city" tabindex="69">
            <%
                for(int i=0;i<Common.CSVCITYS.length;i++)
                {
                  out.print("<option value="+Common.CSVCITYS[i][0]+" >"+Common.CSVCITYS[i][1]);
                }
                %>
          </select></td>
    </tr>
    <tr>
      <td align="right" height="28">市 / 区</td>
      <td class="red" align="center" height="28"><span style="color:#0265CB;"><b>*</b></span></td>
      <td height="28"><input name="state" type="text" maxlength="35" id="txtstate" tabindex="70" size="35"/></td>
    </tr>
    <tr>
      <td align="right">地址</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="addr" type="text" maxlength="35" id="txtaddr1" tabindex="71" size="35" /></td>
    </tr>

    <tr>
      <td align="right">邮编</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="zip" type="text" maxlength="25" id="txtzip" tabindex="73" size="35"/></td>
    </tr>

    <tr>
      <td colSpan="3">&nbsp;</td>
    </tr>

    <tr>
      <td align="right"><span id="lblMobile">手机</span></td><!--Mobile / Cell-->
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="mobile" type="text" maxlength="50" id="txtMobilePhone" tabindex="76" size="35" /></td>
    </tr>

    <tr>
      <td align="right"><span id="lblTelephone">联系电话</span></td><!--Telephone-->
      <td>&nbsp;</td>
      <td><input name="phone" type="text" maxlength="50" id="txtContactPhone" tabindex="77" size="35"/></td>
    </tr>

    <tr>
      <td height="40" colSpan="3"><strong>请同意 B-picture的条款和条件:</strong></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><span style="width:16px;"><input id="chkTerms" type="checkbox" name="terms" value="1" tabindex="78" /><label for="terms"> </label></span>
        我同意 <A href="javascript:window.showModalDialog('/servlet/Node?node=2198280','_top','dialogWidth:450px;dialogHeight:600px;dialogLeft:750px;dialogTop:240px;');">
          条款和条件</A> 应用于B-picture的网站</td>
    </tr>
  <tr>
				<td height="40" colSpan="3"><strong>您想注册成为一名:</strong></td>
	</tr>
			<tr vAlign="top">
				<td>&nbsp;</td>
				<td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
				<td>
                                  <input id="buy" type="radio" name="regstyle" checked="checked" value="1" tabindex="79" /><label for="buy">买家</label><br>
                                  <input id="sale" type="radio" name="regstyle" value="0" tabindex="80" /><label for="sale">卖家</label><br>
			<!--<input id="RdBoth" type="radio" name="RdVisitorType" value="RdBoth" /><label for="RdBoth"> Both purchase and submit images to Alamy</label></td>-->			</tr>

    <tr vAlign="top">
      <td>&nbsp;</td><td colspan="3">　&nbsp;&nbsp;<input type="checkbox" name="mailto" value="1"/>是否发送注册资料至您所填写的邮箱中</td>
    </tr>
			<tr vAlign="top">
			  <td height="40" colspan="3" align="center" valign="middle"> <input type="submit" value="注册" id="lzj_an"/></td>

  </table>
  </form>
<div id="jspafter">
      <%=community.getJspAfter(teasession._nLanguage)%>
    </div>
</body>

</HTML>

