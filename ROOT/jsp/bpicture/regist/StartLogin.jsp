<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.Resource" %>
<%
TeaSession teasession = new TeaSession(request);
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl="/servlet/Node?node="+teasession._nNode+"&Language="+teasession._nLanguage;
}
Resource r = new Resource();
%><html>
<head>
  <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "登录/注册")%></h1>
<div id="head6"><img SRC="/tea/" height="6" alt="" /></div>
<fieldset id="startloginfieldset">
  <FORM target="_parent" name="foLogin" METHOD="POST" action="/servlet/Login" onSubmit="return (this.LoginType.value=='0'&&submitText(this.LoginId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>'))||(this.LoginType.value=='1'&&submitText(this.LoginId,'<%=r.getString(teasession._nLanguage, "InvalidMemberId")%>'))||(this.LoginType.value=='2'&&submitEmail(this.LoginId,'<%=r.getString(teasession._nLanguage, "InvalidEmail")%>'));">
    <input type='hidden' name="nexturl" VALUE="<%=nexturl%>"/>
    <input type='hidden' name="community" VALUE="<%=teasession._strCommunity%>"/>
    <input type='hidden' name="Node" VALUE="<%=teasession._nNode%>"/>
    <input type='hidden' name="LoginType" value="0"/>
    <%//0用会员ID登陆,1用手机号登陆%>
    <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "MemberId")%>:</TD>
        <td><input type="TEXT" class="edit_input"  name="LoginId"></td>
      </tr>
      <tr>
        <TD><%=r.getString(teasession._nLanguage, "Password")%>:</TD>
        <td><input type="password" class="edit_input" name="Password"></td>
      </tr>
      <tr>
        <TD></TD>
        <td><input type="SUBMIT" name="Enter"  class="edit_button" id="edit_submit" VALUE="<%=r.getString(teasession._nLanguage, "Enter")%>" onClick="if(this.form.SaveLogin.checked){setCookie('SaveLoginMemberId',this.form.LoginId.value);setCookie('SaveLoginPassword',this.form.Password.value);}else{removeCookie('SaveLoginMemberId');removeCookie('SaveLoginPassword');}
        if(this.form.aotuLogin.checked){setCookie('aotuLoginMemberId',this.form.LoginId.value);setCookie('aotuLoginPassword',this.form.Password.value);}else{removeCookie('aotuLoginMemberId');removeCookie('aotuLoginPassword');}">
        <%if(!teasession._strCommunity.equals("bigpic")){%>
        <input name="Submit" type="button" class="edit_button" id="regbutton" onClick="window.open('/jsp/user/SignUp.jsp?node=<%=teasession._nNode%>&Language=<%=teasession._nLanguage%>')" value="<%=r.getString(teasession._nLanguage, "LogSignUp")%>">
        <%}else{ %>
<input name="Submit" type="button" class="edit_button" id="regbutton" onClick="window.open('/jsp/bpicture/regist/register.jsp')" value="<%=r.getString(teasession._nLanguage, "LogSignUp")%>">
        <%} %>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <!--<A href="/servlet/RetrieveMemberId?node=<%=teasession._nNode%>&Language=<%=teasession._nLanguage%>"><%=r.getString(teasession._nLanguage, "RetrieveMemberId")%></A> <A href="/servlet/RetrievePassword?node=<%=teasession._nNode%>&Language=<%=teasession._nLanguage%>"><%=r.getString(teasession._nLanguage, "RetrievePassword")%></A>-->
          <input id="CHECKBOX" type="CHECKBOX" name=SaveLogin ><%=r.getString(teasession._nLanguage, "InfSaveLogin")%>　　
          <input id="CHECKBOX" type="CHECKBOX" name="aotuLogin" ><%=r.getString(teasession._nLanguage, "自动登录")%>
        </td>
      </tr>
    </table>
  </FORM>
  <SCRIPT type="">
  document.foLogin.LoginId.focus();
  document.foLogin.LoginId.value=getCookie('SaveLoginMemberId','');
  document.foLogin.Password.value=getCookie('SaveLoginPassword','');
  if(document.foLogin.LoginId.value.length!=0)
  document.foLogin.SaveLogin.checked=true;
  document.foLogin.LoginId.focus();

  function f_autoLogin()
  {
    document.foLogin.LoginId.value=getCookie('aotuLoginMemberId','');
    document.foLogin.Password.value=getCookie('aotuLoginPassword','');
    if(document.foLogin.LoginId.value.length!=0)
    {
      document.foLogin.aotuLogin.checked = true;
      document.foLogin.submit();
    }
    document.foLogin.LoginId.focus();
  }
  f_autoLogin();
  </SCRIPT>
</fieldset>
<!--<div id="language">
  <%=new tea.htmlx.Languages(teasession._nLanguage,request)%>
</div>-->
<div id="head6"><img SRC="/tea/" height="6" alt=""></div>
</body>
</html>

