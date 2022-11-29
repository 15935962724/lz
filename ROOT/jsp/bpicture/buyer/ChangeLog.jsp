<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);

TeaSession teasession =new TeaSession(request);
Community community=Community.find(teasession._strCommunity);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");

String member = request.getParameter("member");

if(teasession._rv==null){
  RV rv = new RV(member);
  teasession.getSession().setAttribute("tea.RV",rv);
  teasession.getSession().setAttribute("LoginId",member);
}else{
  if(member == null)
  {

    member = teasession._rv._strR;

  }
}

int bpid = Bperson.findId(member);
Bperson bp = Bperson.find(bpid);

Profile p = Profile.find(member);

%>
<html>
<!-- Stock photography -->
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>更改登录资料</title>
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function check(form)
{
  return submitText(form.name,'无效-姓名')&&submitText(form.email,'无效-Email')&&submitEmail(form.email,'无效-Email');
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
function checkpwd(form)
{
  if( submitText(form.password,'无效-旧密码')
  &&submitText(form.newpwd,'无效-新密码')
  &&submitText(form.conpwd,'无效-确认新密码')
  &&submitEqual(form.newpwd,form.conpwd,'两次密码输入不一致')
  )
  {
    if(document.getElementById('password').value!=document.getElementById('oldpassword').value)
    {
      alert("旧密码输入错误，请重新输入!");
      return false;
    }
  }else
  {
    return false;
  }

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
//    if(document.uper.password.value.length<6)
//    {
//      sv.innerHTML="<img src=/tea/image/public/check_error.gif>密码长度小于6位";
//    }else
//    {
      if(document.getElementById('password').value!=document.getElementById('oldpassword').value)
      {
        sv.innerHTML="<img src=/tea/image/public/check_error.gif>密码错误，请重新输入";
      }else{
        sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
      }
//    }
  }

  if(act=="newpwd")
  {

//    if(document.uper.newpwd.value.length<6)
//    {
//      sv.innerHTML="<img src=/tea/image/public/check_error.gif>新密码长度小于6位";
//    }else
//    {

      sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
//    }
  }

  if(act=="conpwd")
  {
//    if(document.uper.compwd.value.length<6)
//    {
//      sv.innerHTML="<img src=/tea/image/public/check_error.gif>确认密码长度小于6位";
//    }else
//    {
      if(document.mypwd.conpwd.value!=document.mypwd.newpwd.value)
      {
        sv.innerHTML="<img src=/tea/image/public/check_error.gif>两次密码输入不一致";
      }else
      {
        sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
      }
//    }

  }
}

</script>
<style>
.big{text-align:left;font-size:14px;margin:10 30px;}
#table001{background:#F6F6F6;border-bottom:5px solid #eee;border-top:5px solid #eee;padding:6px;}
#table001 td{padding:5px;}
#member,#firstname,#email,#oldpwd,#newpwd,#confirmpwd{height:22px;font-size:12px;line-height:22px;*line-height:15px;border:1px solid #7F9DB9;}
#submit,.Button{width:70px;height:22px;font-size:12px;line-height:15px;border:1px solid #7F9DB9;background:#fff;padding-bottom:5px;*padding-bottom:0;}
</style>

</head>

<body style="margin:0;">
<%if(teasession.getParameter("back")!=null){%>
<div id="jspbefore">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>
<%}%>
<div id="wai">

<div id="li_biao"><a href="http://bp.redcome.com" target="_top">首页</a>&nbsp;>&nbsp;管理中心&nbsp;>&nbsp;更改登陆信息</div>
<h1>更改登陆信息</h1>


  <!--FormType><FormType-->
    <!--Path>Getting Details<Path-->
      <!--User>{4D76E8B2-FE16-4C19-A4EF-7803226D70E8}<User-->

        <div class=big><strong>1. 个人信息</strong></div>

        <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="bg8" id="table001">
          <FORM METHOD=post ACTION="/servlet/EditBPperson"  id="my-account" name="myaccount" onSubmit="return check(this);">
            <input type="hidden" name="act" value="uplog"/>
            <input type="hidden" name="member" value="<%=p.getMember()%>"/>
            <input type="hidden" name="url" value="<%=request.getRequestURI()%>"/>
            <tr>
              <td colspan="4"><strong>如有必要，请修改您的个人信息</strong><br>
                星号 (<span class="red">*</span>) 表示必填字段</td>
            </tr>
            <tr>
              <td width="200" align="right" nowrap>会员ID</td>
              <td class="red"><b>*</b></td>
              <td>
                <input type="text" name="member" id="member" disabled="disabled" style="width:250px;" value="<%=p.getMember()%>" maxlength="80"></td>
            </tr>
            <tr>
              <td width="200" align="right">性别</td>
              <td width="5" class="red"><b>*</b></td>
              <td>
                <SELECT id=selTitle name=sex ><OPTION selected value="1" <%if(p.isSex())out.print("Selected");%>>男</OPTION><OPTION value="0" <%if(!p.isSex())out.print("Selected");%>>女</OPTION></SELECT></td>
            </tr>
            <tr>
              <td width="200" align="right">姓名</td>
              <td class="red"><b>*</b></td>
              <td>
                <input type="text" name="name" id="firstname" maxlength="50" value="<%=p.getFirstName(teasession._nLanguage)%>"></td>
            </tr>
            <tr>
              <td width="200" align="right">英文名(全拼)</td>
              <td class="red"><b>*</b></td>
              <td>
                <input type="text" name="ename" id="lastname" maxlength="50" value="<%=p.getLastName(teasession._nLanguage)%>"></td>
            </tr>
            <!--<tr>
              <td width="40%" align="right">Email</td>
              <td width="1%" class="red"><b>*</b></td>
              <td>
                <input type="text" name="email" id="email" maxlength="50" size=27 value="<%=bp.getEmail()%>" style="width:345"></td>
            </tr>-->


           <!-- <tr>
              <td width="40%" align="right" nowrap>从B-picture发送电子邮件给我</td>
              <td width="1%"></td>
              <td width="59%">
                <input type="checkbox" name="chkMailShot" id="chkMailShot" ></td>
            </tr>-->
            <tr valign="bottom">
              <td colspan="2"></td><td>
                <input type="submit" name="submit" id="submit" value="保存" class="button"></td>
            </tr>
          </FORM>
        </table>

        <div class=big><strong>2. 密码</strong> </div>

        <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="bg8" id="table001">
          <FORM METHOD=post ACTION="/servlet/EditBPperson"  id="mypwd" name="mypwd"  onSubmit="return checkpwd(this)">
            <input type="hidden" name="act" value="uppwd"/>
            <input type="hidden" name="url" value="<%=request.getRequestURI()%>"/>
            <input type="hidden" value="<%=p.getPassword()%>" name="oldpassword"  id="oldpassword"/>
            <input type="hidden" name="member" value="<%=p.getMember()%>"/>
            <tr>
              <td colspan="3" nowrap="nowrap"><strong>如有必要，请修改您的密码</strong></td></tr> <tr>

                <td width="200" align="right" nowrap>输入您现有的密码</td>
                <td width="5" class="red"><b>*</b></td> <td>
                  <input type="password" name="password" id="oldpwd" MAXLENGTH="12" value="" onBlur="f_jax(this)"></td>
            </tr>
            <tr>
            <td colspan="2"></td>
            <td><span id="span_password">&nbsp;</span></td>
            </tr>
            <tr>
              <td width="200" align="right" nowrap>输入新的密码</td>
              <td class="red"><b>*</b></td> <td>
                <input type="password" name="newpwd" id="newpwd" MAXLENGTH="12" value="" onBlur="f_jax(this)"></td>

            </tr>
            <tr>
            <td colspan="2"></td>
            <td><span id="span_newpwd">&nbsp;</span></td>
            </tr>
            <tr>
              <td width="200" align="right" nowrap>确认新的密码</td>
              <td class="red"><b>*</b></td> <td>
                <input type="password" name="conpwd" id="confirmpwd" MAXLENGTH="12" value="" onBlur="f_jax(this)"></td>
            </tr>
            <tr>
            <td colspan="2"></td>
            <td><span id="span_conpwd">&nbsp;</span></td>
            </tr>

            <tr><td colspan="2"></td><td>
              <input type="submit" name="submit" value="保存" class="Button"></td>
            </tr>
          </FORM>
        </table>


</div>
<%if(teasession.getParameter("back")!=null){%>
<div id="jspafter">
  <%=community.getJspAfter(teasession._nLanguage)%>
</div>
<%}%>
<script type="">

var sucInfo = '<%=request.getParameter("sucinfo")%>';
if(sucInfo.length>0&&sucInfo.length!=4){
alert(sucInfo);
}
</script>
</body>

<!-- Stock photography -->
</html>
