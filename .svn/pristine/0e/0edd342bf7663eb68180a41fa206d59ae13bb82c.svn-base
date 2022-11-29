<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.resource.Resource" %>
<%
TeaSession teasession = new TeaSession(request);
String nexturl=request.getParameter("nexturl");
if(nexturl==null)
{
  nexturl="/servlet/Node?node="+teasession._nNode+"&Language="+teasession._nLanguage;
}
Resource r = new Resource();
String member = teasession._rv._strR;
Profile p = Profile.find(member);
String password = p.getPassword();
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
  <SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type=""></SCRIPT>
</head>
<body>
<div id="wai">
<h1>
自动登录设置
</h1>
<form name="form1">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td align="center"><input type="CHECKBOX" name="aotuLogin" onclick="f_click()">&nbsp;<b><%=r.getString(teasession._nLanguage, "自动登录")%></b></td>
</tr>
<tr>
<td align="center"><b>说明</b>：选中时保存该帐号、密码自动登录本系统平台 / &nbsp;不选时通过注册页面输入帐号、密码进行登录</td>
</tr>
</table>
</form>
</div>
<script type="">
  if(getCookie('aotuLoginMemberId','')=='<%=member%>')
  {
    document.form1.aotuLogin.checked = true;
  }
  function f_click()
  {
    if(document.form1.aotuLogin.checked)
    {
      setCookie('aotuLoginMemberId','<%=member%>');
      setCookie('aotuLoginPassword','<%=password%>');
    }else
    {
      removeCookie('aotuLoginMemberId');
      removeCookie('aotuLoginPassword');
    }
  }
  </script>
</body>
</html>
