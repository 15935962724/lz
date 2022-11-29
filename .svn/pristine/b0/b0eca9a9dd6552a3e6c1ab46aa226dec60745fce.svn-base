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
%>
 <SCRIPT type="">
//  document.foLogin.LoginId.focus();
//  document.foLogin.LoginId.value=<%=saveLoginId%>;
//  document.foLogin.Password.value=<%=saveLoginPassword%>;
//  if(document.foLogin.LoginId.value.length!=0)
//  document.foLogin.SaveLogin.checked=true;
//  document.foLogin.LoginId.focus();
//
//  function f_autoLogin()
//  {
//    document.foLogin.LoginId.value=<%=autoLoginId%>;
//    document.foLogin.Password.value=<%=autoLoginPassword%>;
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
