<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String nexturl=request.getParameter("nexturl");


Resource r=new Resource();

%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function defaultfocus()
{
  form1.money.focus();
}
</script>
</head>
<body onLoad="defaultfocus();">

<h1>用户缴费</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br/>
<form name="form1" action="/servlet/EditEonTeleset" method="post" onSubmit="return submitFloat(this.money, '<%=r.getString(teasession._nLanguage, "InvalidParameter")%>-金额')">
<input type=hidden name="community" value="<%=teasession._strCommunity%>"/>
<input type=hidden name=nexturl value="<%=nexturl%>">
<input type=hidden name="act" value="addconsume"/>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>用户名</td>
    <td><%=teasession._rv._strV%></td>
  </tr>
  <tr>
    <td>金额</td>
    <td><input name="money" type="text" onkeypress="inputFloat()"></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
      <input type="submit" value="提交">
      <input type="button" value="返回" onclick="history.back();">
    </td>
  </tr>
</table>
</form>

<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>
