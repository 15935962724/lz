<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.Resource" %>
<%@page import="java.net.URLEncoder"%>
<%
//response.setHeader("Cache-Control", "no-cache");
//response.setHeader("Pragma", "no-cache");


if(!"1-1-1-222-3-3-3".equals(request.getParameter("edn"))){
	String nexturl=request.getParameter("nexturl");
	response.sendRedirect("/html/jskxcbs/folder/14010780-1.htm");
	//response.sendRedirect("/jsp/info/Alert.jsp?info="+URLEncoder.encode("请您设置后台节点","UTF-8"));
	return;

}


TeaSession teasession = new TeaSession(request);
String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl="/servlet/Node?node="+teasession._nNode+"&Language="+teasession._nLanguage;
}
Resource r = new Resource();
String lastLoginId="",saveLoginId = "",saveLoginPassword="",autoLoginId="",autoLoginPassword="";
Cookie[] cookies = request.getCookies();
if(cookies != null)
{
  for(int i = 0; i < cookies.length; i++)
  {
    //查找用户名
    if(cookies[i].getName().equals("aotuLoginMemberId"))
    {
      autoLoginId = cookies[i].getValue();
    }
    if(cookies[i].getName().equals("aotuLoginPassword"))
    {
      autoLoginPassword = cookies[i].getValue();
    }
     if(cookies[i].getName().equals("SaveLoginMemberId"))
    {
      saveLoginId = cookies[i].getValue();
    }
     if(cookies[i].getName().equals("SaveLoginPassword"))
    {
      saveLoginPassword = cookies[i].getValue();
    }
     if(cookies[i].getName().equals("lastLoginId"))
    {
      lastLoginId = cookies[i].getValue();
    }
  }
}

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
        <td><input type="SUBMIT" name="Enter"  class="edit_button" id="edit_submit" VALUE="<%=r.getString(teasession._nLanguage, "Enter")%>">
        <input name="Submit" type="button" class="edit_button" id="regbutton" onClick="window.open('/jsp/user/SignUp.jsp?node=<%=teasession._nNode%>&Language=<%=teasession._nLanguage%>')" value="<%=r.getString(teasession._nLanguage, "LogSignUp")%>">
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <A href="/servlet/RetrieveMemberId?node=<%=teasession._nNode%>&language=<%=teasession._nLanguage%>"><%=r.getString(teasession._nLanguage, "RetrieveMemberId")%></A> <A href="/servlet/RetrievePassword?node=<%=teasession._nNode%>&language=<%=teasession._nLanguage%>"><%=r.getString(teasession._nLanguage, "RetrievePassword")%></A>
          <input id="CHECKBOX" type="CHECKBOX" name=SaveLogin value="1" ><%=r.getString(teasession._nLanguage, "InfSaveLogin")%>　　
          <input id="CHECKBOX" type="CHECKBOX" name="aotuLogin" value="1"><%=r.getString(teasession._nLanguage, "自动登录")%>
        </td>
      </tr>
    </table>
  </FORM>
  <SCRIPT type="">
//  document.foLogin.LoginId.focus();
//  document.foLogin.LoginId.value='<%=saveLoginId%>';
//  document.foLogin.Password.value='<%=saveLoginPassword%>';
//  if(document.foLogin.LoginId.value.length!=0)
//  document.foLogin.SaveLogin.checked=true;
//  document.foLogin.LoginId.focus();
//
//  function f_autoLogin()
//  {
//    document.foLogin.LoginId.value='<%=autoLoginId%>';
//    document.foLogin.Password.value='<%=autoLoginPassword%>';
//    if(document.foLogin.LoginId.value.length!=0)
//    {
//      document.foLogin.aotuLogin.checked = true;
//     document.foLogin.submit();
//    }
//    document.foLogin.LoginId.focus();
//  }
//  f_autoLogin();
var lastid = '<%=lastLoginId%>';
var saveLoginId = '<%=saveLoginId%>';
var saveLoginPassword = '<%=saveLoginPassword%>';
var autoLoginId = '<%=autoLoginId%>';
var autoLoginPassword = '<%=autoLoginPassword%>';

if(lastid.length>0)
  {
  document.foLogin.LoginId.value=lastid;
  }

  if(saveLoginId.length>0)
 {
   document.foLogin.LoginId.focus();
   document.foLogin.LoginId.value=saveLoginId;
   document.foLogin.Password.value=saveLoginPassword;
   if(document.foLogin.LoginId.value.length!=0)
   document.foLogin.SaveLogin.checked=true;
   document.foLogin.LoginId.focus();
 }

 if(autoLoginId.length>0)
 {
    document.foLogin.LoginId.value=autoLoginId;
    document.foLogin.Password.value=autoLoginPassword;
    if(document.foLogin.LoginId.value.length!=0)
    {
      document.foLogin.aotuLogin.checked = true;
      document.foLogin.submit();
    }
    document.foLogin.LoginId.focus();
 }

  </SCRIPT>
</fieldset>
<!--<div id="language">
  <%=new tea.htmlx.Languages(teasession._nLanguage,request)%>
</div>-->
<div id="head6"><img SRC="/tea/" height="6" alt=""></div>
</body>
</html>

