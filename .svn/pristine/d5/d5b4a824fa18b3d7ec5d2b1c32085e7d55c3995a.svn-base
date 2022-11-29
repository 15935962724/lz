<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.*,tea.resource.*" %>
<html>
<%
TeaSession teasession = new TeaSession(request);
Resource r = new Resource("/tea/ui/util/SignUp1").add("/tea/htmlx/HtmlX");
%>
<head>
<link  href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
<title>
hostelstyleinfor
</title>
</head>
<body bgcolor="#ffffff">
<div id="tablebgnone" class="register">
<h1> 增加或修改房型信息</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<form action="" name="form1" method="POST">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter" align="center">
<tr>
<td><label><%=r.getString(teasession._nLanguage,"房型:")%></label></td>
<td><input type="text" name=""/></td>
</tr>
<tr>
<td><label><%=r.getString(teasession._nLanguage,"门市价:")%></label></td>
<td><input type="text" name=""/></td>
</tr>
<tr>
<td><label><%=r.getString(teasession._nLanguage,"前台现付价:")%></label></td>
<td><input type="text" name=""/></td>
</tr>
<tr>
<td><label><%=r.getString(teasession._nLanguage,"网上支付价:")%></label></td>
<td><input type="text" name=""/></td>
</tr>
<tr>
<td><label><%=r.getString(teasession._nLanguage,"周末价:")%></label></td>
<td><input type="text" name=""/></td>
</tr>
<tr>
<td><label><%=r.getString(teasession._nLanguage,"早餐:")%></label></td>
<td><input type="text" name=""/></td>
</tr>
<tr>
<td><label><%=r.getString(teasession._nLanguage,"备注:")%></label></td>
<td><textarea cols="50" rows="5"></textarea></td>
</tr>
<tr>
<td colspan="2" align="center">
  <input type="submit" name="submit" value="提交"/></td>
</tr>
</table>
</form>
</div>
</body>
</html>
