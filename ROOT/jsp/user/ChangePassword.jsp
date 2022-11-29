<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.*" %><%@ page import="tea.entity.site.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

//if(!teasession._rv.isReal())
//{
//  response.sendError(403);
//  return;
//}

Resource r=new Resource("/tea/ui/member/profile/ChangePassword");
tea.entity.site.Community community = tea.entity.site.Community.find(h.community);

%><!DOCTYPE html>
<html>
<head>
<title><%=r.getString(h.language, "ChangePassword")%></title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspBeforePath(h.language)%>" type="text/javascript"></SCRIPT>
<h1><%=r.getString(h.language, "ChangePassword")%></h1>

<FORM name=foChange METHOD=POST action="/servlet/ChangePassword" target="_ajax" onSubmit="return mt.check(this);">
<input type="hidden" name="community" value="<%=h.community%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <TD class="teleft" align="right"><%=r.getString(h.language, "MemberId")%>：</TD>
    <td><%=(h.username)%></td></tr>
    <tr>
      <TD align="right"><%=r.getString(h.language, "OldPassword")%>：</TD>
      <td class="tdright"><input type="password"  autocomplete="off" class="edit_input" name="old" alt="<%=r.getString(h.language, "OldPassword")%>"></td>
    </tr>
    <tr>
      <TD align="right"><%=r.getString(h.language, "NewPassword")%>：</TD>
      <td class="tdright"><input type="password" autocomplete="off"  class="edit_input" name="password" min="6" alt="<%=r.getString(h.language, "NewPassword")%>">
<!--
<style>
.strength{text-align:center;width:180px;}
.strength td{background:#FFD099;height:15px;padding:0;line-height:15px}
.strength2{background:#FF6600 !important}
</style>
<table class="strength"><tr><td id="strength0" class="strength2">弱</td><td id="strength1">中</td><td id="strength2">强</td></tr></table>
//mt.strength=function(a)
//{
//  var i=0,v=a.value;
//  if(v.length>5&&v!='abc123')
//  {
//    if(/\d/.test(v))i++;
//    if(/[a-z]/.test(v))i++;
//    if(/[A-Z]/.test(v))i++;
//    if(/[`\-=~!@#$%^&*\(\)_+\[\]{}:;<>\?]/.test(v))i++;
//  }
//  a.strength=i;
//  for(var j=1;j<3;j++)$$('strength'+j).className=i>j?'strength2':'';
//};
-->
      </td></tr>
      <tr>
        <TD align="right"><%=r.getString(h.language, "ConfirmNewPassword")%>：</TD>
        <td class="tdright"><input type="password" class="edit_input" name="password2" alt="<%=r.getString(h.language, "ConfirmNewPassword")%>"></td>
      </tr>
</table>

<div style="text-align:center;margin-top:10px;">
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(h.language, "Submit")%>">
<input type="button" value="<%=r.getString(h.language,"Return") %>" onClick="window.open('<%=Community.find(h.community).getDesktop() %>','_self');">
</div>

</FORM>
<SCRIPT>document.foChange.old.focus();</SCRIPT>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=community.getJspAfterPath(h.language)%>" type="text/javascript"></SCRIPT>
</body>
</html>
