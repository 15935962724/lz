<style>
.edit_input{width:285px;height:18px;border:1px solid #a6a6a6;}
</style>
<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.Resource" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %><% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

if(!teasession._rv.isReal())
{
  response.sendError(403);
  return;
}

Resource r=new Resource("/tea/ui/member/profile/ChangePassword");

%><html>
<head>
<title><%=r.getString(teasession._nLanguage, "ChangePassword")%></title>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body id="bodynoneVotes">
<div class="content">
<h1><%=r.getString(teasession._nLanguage, "ChangePassword")%></h1>
<FORM name=foChange METHOD=POST action="/servlet/ChangePassword" onSubmit="return((this.OldPassword.value.length==0||submitIdentifier(this.OldPassword,'<%=r.getString(teasession._nLanguage, "InvalidOldPassword")%>'))&&submitIdentifier(this.Password,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitEqual(this.Confirm,this.Password,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>'));">
<input type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <TD><%=r.getString(teasession._nLanguage, "MemberId")%></TD>
    <td>&nbsp;&nbsp;<%=(teasession._rv._strR)%></td></tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "OldPassword")%></TD>
      <td>&nbsp;&nbsp;<input type=PASSWORD class="edit_input" name=OldPassword></td>
    </tr>
    <tr>
      <TD><%=r.getString(teasession._nLanguage, "NewPassword")%></TD>
      <td>&nbsp;&nbsp;<input type="password" class="edit_input" name="Password"></td></tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "ConfirmNewPassword")%></TD>
        <td>&nbsp;&nbsp;<input type=PASSWORD class="edit_input" name=Confirm></td>
      </tr>
</table>
<input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
<SCRIPT>document.foChange.OldPassword.focus();</SCRIPT>
</div>
</body>
</html>

