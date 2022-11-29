<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.resource.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.admin.earth.*" %>
<%

request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Resource r=new Resource();

String nexturl=request.getParameter("nexturl");
String earthcdn=request.getParameter("earthcdn");
if("POST".equals(request.getMethod()))
{
  String pwd=request.getParameter("pwd");
  EarthCdn.create(earthcdn,pwd);
  response.sendRedirect(nexturl);
  return;
}

String pwd = String.valueOf(System.currentTimeMillis()).substring(7);
if(earthcdn.length()>0)
{
  EarthCdn ec=EarthCdn.find(earthcdn);
  pwd=ec.getPwd();
}

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="/tea/tea.js" type="text/javascript"></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body onload="form1.earthcdn.focus();">
<h1><%=r.getString(teasession._nLanguage, "提示")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post">
<input type="hidden" name="nexturl" value="<%=nexturl%>" />

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>编号</td>
    <td><input type="text" name="earthcdn" value="<%=earthcdn%>" maxlength="4"/>必须是4位.</td>
  </tr>
  <tr>
    <td>密码</td>
    <td><input type="text" name="pwd" value="<%=pwd%>" /></td>
  </tr>
</table>

<input type="submit" value="提交" onclick="if(form1.earthcdn.value.length!=4){ alert('编号-必须是4位.'); form1.earthcdn.focus(); return false;}">
<input type="button" value="返回" onclick="history.back();">

</form>

<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
