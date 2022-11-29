<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.Resource" %>
<%
//response.setHeader("Cache-Control", "no-cache");
//response.setHeader("Pragma", "no-cache");
TeaSession teasession = new TeaSession(request);
String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl="/jsp/admin/?Node=2180731&Language=1";
}
Resource r = new Resource();
tea.entity.site.Community community=tea.entity.site.Community.find(teasession._strCommunity);
%><!doctype html>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body id="bodynone_02">
<div id="jspbefore" style="display:none">
<script>if(top.location==self.location)jspbefore.style.display='';</script>
<%=community.getJspBefore(teasession._nLanguage)%>
</div>
<div id="head6"><img SRC="/tea/" height="6" alt="" /></div>
  <form target="_parent" name="foLogin" METHOD="POST" action="/servlet/LoginNew" onSubmit="return (this.LoginType.value=='0'&&submitText(this.LoginId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>'))||(this.LoginType.value=='1'&&submitText(this.LoginId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>'))||(this.LoginType.value=='2'&&submitEmail(this.LoginId,'<%=r.getString(teasession._nLanguage, "InvalidEmail")%>'));">
    <input type='hidden' name="nexturl" VALUE="<%=nexturl%>"/>
    <input type='hidden' name="community" VALUE="<%=teasession._strCommunity%>"/>
    <input type='hidden' name="Node" VALUE="<%=teasession._nNode%>"/>
    <input type='hidden' name="LoginType" value="0"/>
<div id="tablecenter_glydenglu">
    <%//0用会员ID登陆,1用手机号登陆%>
    <table border="0" cellpadding="0" cellspacing="0">
    <tr>
       <td>身份:</td>
       <td><select name="role" id="member2">
	   <option value="3">普通会员</option>
	   <option value="2">酒店管理员</option>
        </select></td>
    </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "MemberId")%>:</td>
        <td><input type="TEXT" class="edit_input"  name="LoginId"></td>
      </tr>
      <tr>
        <td><%=r.getString(teasession._nLanguage, "Password")%>:</td>
        <td><input type="password" class="edit_input" name="Password"></td>
      </tr>
      <tr>
        <td></td>
        <td><input type="SUBMIT" name="Enter"  class="edit_button" id="edit_submit" VALUE="<%=r.getString(teasession._nLanguage, "登陆")%>" onClick="if(this.form.SaveLogin.checked){setCookie('SaveLoginMemberId',this.form.LoginId.value);setCookie('SaveLoginPassword',this.form.Password.value);}else{removeCookie('SaveLoginMemberId');removeCookie('SaveLoginPassword');}">
          <input name="Submit" type="button" class="edit_button" id="regbutton" onClick="window.open('/jsp/registration/newcaller.jsp?role=4')" value="<%=r.getString(teasession._nLanguage, "话务员注册")%>">
        </td>
      </tr>

    </table></div>
  </FORM>

  <SCRIPT type="">document.foLogin.LoginId.focus();document.foLogin.LoginId.value=getCookie('SaveLoginMemberId','');document.foLogin.Password.value=getCookie('SaveLoginPassword','');if(document.foLogin.LoginId.value.length!=0)document.foLogin.SaveLogin.checked=true;document.foLogin.LoginId.focus();</SCRIPT>
  <div id="language">
    <%=new tea.htmlx.Languages(teasession._nLanguage,request)%>
  </div>
<div id="head6"><img SRC="/tea/" height="6" alt=""></div>
<div id="jspafter" style="display:none">
<script>if(top.location==self.location)jspafter.style.display='';</script>
<%=community.getJspAfter(teasession._nLanguage)%>
</div>
<script>
if(top.location==self.location)
{
  jspbefore.style.display='';
  jspafter.style.display='';
}
</script>
</body>
</html>

