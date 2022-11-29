<%@page contentType="text/html;charset=utf-8" %>
<%@ page import="tea.htmlx.Languages"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import = "tea.entity.member.Profile" import = "tea.entity.member.Profile" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" /><%
///webapps/ROOT/tea/image/section/bj-sea/photo
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
tea.resource.Resource r = new tea.resource.Resource("/tea/ui/util/SignUp1");


tea.entity.member.Profile profile=null;

if(request.getMethod().equals("POST"))
{



}

String vertify=sms.password();
session.setAttribute("sms.vertify" ,vertify);

tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String community=node.getCommunity();
tea.entity.site.Community commobj=tea.entity.site.Community.find(teasession._strCommunity);
	%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="text/javascript">/*
function isMmeberId(s) {
  s=s.replace(' ','').replace('	','');
	if (s.length < 1)
		return false;
	for (var i = 0; i < s.length; i++) {
		var c = s.charAt(i);
		if (('/' == c)||('<' == c)||('>' == c)||('\\' == c)||('|' == c))
		{
                  return false;
              }
	}
	return true;
}
function submitMemberId(text, alerttext) {
	if(!isMmeberId(text.value)) {
		alert(alerttext);
		text.focus();
		return false;
	}

	return true;
}*/

</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=commobj.getJspBeforePath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
<body>
<h1><%=r.getString(teasession._nLanguage, "SeaRegister")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<FORM name=foSignUp METHOD=POST ACTION="/servlet/EditProfileBBS?node=<%=teasession._nNode%>" onSubmit="return(submitMemberid(this.MemberId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>')&&submitIdentifier(this.EnterPassword,'<%=r.getString(teasession._nLanguage, "InvalidPassword")%>')&&submitEqual(this.EnterPassword,this.ConfirmPassword,'InvalidConfirm')&&submitEmail(this.Email,'<%=r.getString(teasession._nLanguage, "InvalidEmailAddress")%>')&&submitEqual(this.EnterPassword,this.ConfirmPassword,'<%=r.getString(teasession._nLanguage, "InvalidConfirmPassword")%>')&&submitText(this.mobile,'<%=r.getString(teasession._nLanguage, "InvalidMobile")%>')&&submitIdentifier(this.vertify,'<%=r.getString(teasession._nLanguage, "Validate")%>'));">
  <input type="hidden" name="community" value="<%=community%>"/>
  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <TD align="right">* <%=r.getString(teasession._nLanguage, "MemberId")%>:</TD>
      <td><input type="TEXT" class="edit_input"  name=MemberId  size=20 maxlength=40>3-20位</td>

    </tr>
    <tr>
      <TD align="right">* <%=r.getString(teasession._nLanguage, "EnterPassword")%>:</TD>
      <td><input type="password" class="edit_input"  name=EnterPassword value="" size=20 maxlength=16>3-20位</td>
        <TD align="right">* <%=r.getString(teasession._nLanguage, "ConfirmPassword")%>:</TD>
        <td><input type="password" class="edit_input"  name=ConfirmPassword value="" size=20 maxlength=16></td>
    </tr>
    <tr>
      <TD align="right"><%=r.getString(teasession._nLanguage, "姓名")%>:</TD>
      <td><input type="TEXT" class="edit_input"  name=firstname  size=40 maxlength=40></td>
        <TD align="right">*<%=r.getString(teasession._nLanguage, "EmailAddress")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name=Email  size=40 maxlength=40></td>
    </tr>
    <tr>
      <TD align="right">* <%=r.getString(teasession._nLanguage, "Gender")%>:</TD>
      <td><input id="gender_0" id="radio" type="radio" name="sex" value="1" checked="checked"/><label for="gender_0"><%=r.getString(teasession._nLanguage, "Man")%></label>
        <input id="gender_1" id="radio" type="radio" name="sex" value="0" /><label for="gender_1"><%=r.getString(teasession._nLanguage, "Woman")%></label></td>
        <%-- 四通阳光中要加的'手机' --%>
        <TD align="right"><%=r.getString(teasession._nLanguage, "手机")%>:</TD>
        <td><input type="text" name="mobile1" onKeyPress="if(event.keyCode<48||event.keyCode>57)event.returnValue=false;"/></td>
    </tr>
    <tr>
      <TD align="right">* <%=r.getString(teasession._nLanguage, "Validate")%>:</TD>
      <td><input type="TEXT" class="edit_input"  name=vertify value="" size=20 maxlength=20></td>
        <TD align="right"><%=r.getString(teasession._nLanguage, "VerificationCode")%>:</TD>
        <td><img src="validate.jsp" alt="Validate">        <%//=vertify%></td>
    </tr>
  </table>
  <input type="submit" class="edit_button" id="edit_submit" value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
<SCRIPT>document.foSignUp.MemberId.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="<%=commobj.getJspAfterPath(teasession._nLanguage)%>" type="text/javascript"></SCRIPT>
</body>
</html>

