<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);

Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
String member = request.getParameter("member");
if(member == null){
  member = teasession._rv._strR;
}
Profile p = Profile.find(member);
ProfileZh pz = ProfileZh.find(member);

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<script type="">
function check(form)
{
  if( submitText(form.password,'无效-旧密码')
  &&submitText(form.newpwd,'无效-新密码')
  &&submitText(form.compwd,'无效-确认新密码')
  &&submitEqual(form.newpwd,form.compwd,'两次密码输入不一致')
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
    if(document.uper.password.value.length<6)
    {
      sv.innerHTML="<img src=/tea/image/public/check_error.gif>密码长度小于6位";
    }else
    {
      if(document.getElementById('password').value!=document.getElementById('oldpassword').value)
      {
        sv.innerHTML="<img src=/tea/image/public/check_error.gif>密码错误，请重新输入";
      }else{
        sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
      }
    }
  }

  if(act=="newpwd")
  {

    if(document.uper.newpwd.value.length<6)
    {
      sv.innerHTML="<img src=/tea/image/public/check_error.gif>新密码长度小于6位";
    }else
    {
      sv.innerHTML="<img src=/tea/image/public/check_right.gif>";
    }
  }

  if(act=="compwd")
  {
    if(document.uper.compwd.value.length<6)
    {
      sv.innerHTML="<img src=/tea/image/public/check_error.gif>确认密码长度小于6位";
    }else
    {
      if(document.uper.compwd.value!=document.uper.newpwd.value)
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

</head>
<body >


<div id="jspbefore" style="display:none">
  <%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="friendship"><img src="/res/china-corea/u/0811/081127512.gif"/></div>
<div id="friendship_02"><img src="/res/china-corea/u/0811/081127515.gif"/></div>
<div id="friendship_03"><img src="/res/china-corea/u/0811/081127519.gif"/></div>



<form name="uper" action="/servlet/EditProfileZh" method="post" onsubmit="return check(this);">
<input type="hidden" name="member" value="<%=member%>"/>
<input type="hidden" name="type" value="uppwd"/>
<input type="hidden" value="<%=p.getPassword()%>" name="oldpassword"  id="oldpassword"/>
<div id="members_Resume">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" ID="members">
    <tr>
      <td id="td_01" width="150">会员名称</td>
      <td id="td_02"><input type="TEXT" disabled="disabled" name="member" value="<%=p.getMember()%>"/></td>
        <td id="td_001"><span id="span_member">【会员名称&nbsp;由英文字母数字和下划线组成】</span></td>
    </tr>
    <tr>
      <td id="td_01" nowrap="nowrap">
      现有的密码
      </td>
      <td id="td_02">
        <input id="password" type="password" name="password" maxlength="12" onblur="f_jax(this)"/>
      </td>
      <td id="td_001">
        <span id="span_password">【密　　码&nbsp;长度为6-12位】</span></td>
    </tr>
    <tr>
      <td id="td_01" nowrap="nowrap">
      输入新密码
      </td>
      <td id="td_02">
        <input type="password" name="newpwd" maxlength="12" onblur="f_jax(this)"/>
      </td>
      <td id="td_001"><span id="span_newpwd">&nbsp;</span></td>
    </tr>
    <tr>
      <td id="td_01" nowrap="nowrap">
      确认新密码
      </td>
      <td id="td_02">
        <input type="password" name="compwd" maxlength="12" onblur="f_jax(this)"/>
      </td>
      <td id="td_001"><span id="span_compwd">&nbsp;</span></td>
    </tr>
</table>
</div>
<table  border="0" cellspacing="0" cellpadding="0" ID="members_bottom">
  <tr><td align="center"><input type="submit" value="修改"/>　<input type="button" value="返回" onclick="history.go(-1)"/></td></tr>
</table>

</form>
<div id="jspafter" style="display:none">
  <%=community.getJspAfter(teasession._nLanguage)%>
</div>
<script type="">
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}


</script>
</body>
</html>


