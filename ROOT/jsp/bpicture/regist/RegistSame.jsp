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

    if (act.equals("member")) {
      out.print(!tea.entity.member.Profile.isExisted(value));//&&!Profile.isLExisted(value,teasession._nLanguage));
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
  if(submitText(form.member,'无效-Email')
  &&submitEmail(form.member,'无效-Email')
  &&submitText(form.name,'无效-姓名')
  &&submitText(form.ename,'无效-英文名')
  &&submitText(form.mobile,'无效-手机')
  &&submitInteger(form.mobile,'无效-手机')
  &&submitLength(11,12,form.mobile,'无效-手机')
  &&submitInteger(form.phone,'无效-联系电话')
  &&submitterms(form.terms,'无效-协议')){
    return true;
  }
  return false;
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
function submitterms(text,alerttext)
{
  if(!text.checked){
    alert(alerttext);
    text.focus();
    return false;
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
    var str = reg.member.value;
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


</script>
<style>

.t{margin:12px 0;height:20px;line-height:20px;width:100%;font-size:14px;font-weight:bold;background:url(/res/bigpic/u/0812/081243709.gif) no-repeat 25 2;padding-left:45px;}
#tablecenter002{background:#F6F6F6;border-top:10px solid #eeeeee;font-size:12px;line-height:150%;}
#lzj_an{width:45px;height:23px;background:url(/res/bigpic/u/0812/081243710.jpg) no-repeat;border:0;margin:0 10px;}
#txtfirstName,#txtPwd1,#txtPwd2,#selJobTitle,#selCompanyType,#txtzip,#txtMobilePhone{width:200px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}
#txtEmail,#txtJobTitleOther,#txtCompanyTypeOther,#txtCompany,#txtCompanyWebsite,#txtaddr1,#txtstate,#txtzip,#txtContactPhone{width:300px;height:22px;border:1px solid #809EBA;background:#fff;line-height:22px;font-size:12px;}

</style>
</HEAD>
<body style="margin:0;padding:0;">

<div class="t">注册</div>

  <form name="reg" action="/servlet/EditBPperson" method="get" onSubmit="return (check(this));">
  <input type="hidden" name="checkID" value="<%=!tea.entity.member.Profile.isExisted(request.getParameter("value"))%>"/>
<input type="hidden" name="act" value="reg"/>
  <table cellSpacing="0" cellPadding="2" width="700" align="center" border="0" id="tablecenter002">
    <tr>
      <td height="40" width="100">　<strong>注册信息</strong><td align="center" width="10"><span style="color:#0265CB;"><b>*</b></span></td>
          <td>表示必须填写</td>
    </tr>
    <tr>
      <td align="right">会员ID</td>
      <td align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="member" type="text" maxlength="50" id="txtEmail" onBlur="f_ajax(this)" size="35" /><span id="span_member" style="padding:2px 0 2px 0;font-size:12px;color:#7F7F7F;">&nbsp;请输入您的Email</span></td>
    </tr>
    <tr>
      <td align="right">姓名</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="name" type="text" maxlength="50" id="txtfirstName" size="35" /></td>
    </tr>
    <tr>
      <td align="right">英文名&nbsp;<b>|</b>&nbsp;全拼</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="ename" type="text" maxlength="50" id="txtEmail" size="35" /></td>
    </tr>
    <tr>
      <td  align="right">性别</td>
     <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><select name="sex" id="DrpTitle">
        <option selected="selected" value="1">男</option>
        <option value="0">女</option>
</select></td>
    </tr>
    <tr>
      <td align="right"><span id="lblMobile">手机</span></td><!--Mobile / Cell-->
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><input name="mobile" type="text" maxlength="50" id="txtMobilePhone" size="35" /></td>
    </tr>

    <tr>
      <td align="right"><span id="lblTelephone">联系电话</span></td><!--Telephone-->
      <td>&nbsp;</td>
      <td><input name="phone" type="text" maxlength="50" id="txtContactPhone" size="35"/></td>
    </tr>
    <tr>
      <td align="right">MSN</td>
      <td class="red" align="center"></td>
      <td><input name="MSN" type="text" maxlength="50" id="txtEmail" size="35" /></td>
    </tr>
    <tr vAlign="top">
      <td></td><td colspan="3">　&nbsp;<input type="checkbox" checked="checked" name="mailto" value="1"/>是否接受来自B-p的邮件</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td class="red" align="center"><span style="color:#0265CB;"><b>*</b></span></td>
      <td><span style="width:16px;"><input id="chkTerms" type="checkbox" checked="checked" name="terms" value="1" /><label for="terms"> </label></span>
        我接受并同意B-p网站 <A href="#" onclick="window.open('/servlet/Node?node=2199908&language=1','_blank');">
          用户服务条款</A></td>
    </tr>
<tr vAlign="top">
<td height="40" colspan="3" align="center" valign="middle"> <input type="submit" value="注册" id="lzj_an"/><input type="reset" value="重置" id="lzj_an"/></td></tr>
  </table>
  </form>

</body>

</HTML>

