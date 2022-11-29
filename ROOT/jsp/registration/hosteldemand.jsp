<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.site.*" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<html>
<head>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
Community community = Community.find(teasession._strCommunity);
%>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<title>hosteldemand</title>
</head>
<body bgcolor="#ffffff" id="bodynone">
<div id="jspbefore" style="display:none"><%=community.getJspBefore(teasession._nLanguage)%> </div>
<div id="tablebgnone" class="register">
<h1>国内酒店查询</h1>
<div>
<img alt="" src="about:blank" height="6"/>
</div>
<form action="/servlet/Node?node=14860" name="form1">
<input  type="hidden" name="community" value="<%=teasession._strCommunity%>"/>
<input type="hidden"  name="Node" value="<%=teasession._nNode%>"/>
<input type="hidden" name="Language" value="<%=teasession._nLanguage%>" />
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<td><img alt="" src="/res/huangjin/u/0712/071246384.gif" />&nbsp;&nbsp;所在城市：</td>
<td><input type="text"  name="city"/></td>
</tr>
<tr>
<td><img alt="" src="/res/huangjin/u/0712/071246384.gif" />&nbsp;&nbsp;酒店星级</td>
<td><select name="hostelstar">
<option value="5" selected="selected">☆☆☆☆☆</option>
<option value="4">☆☆☆☆</option>
<option value="3">☆☆☆</option>
<option value="2">☆☆</option>
<option value="1">☆</option>
</select></td>
</tr>
<tr>
<td><img alt="" src="/res/huangjin/u/0712/071246384.gif" />&nbsp;&nbsp;酒店名称</td>
<td><input type="text" name="hostelname"/></td>
</tr>
<tr>
<td><img alt="" src="/res/huangjin/u/0712/071246384.gif" />&nbsp;&nbsp;排序方式
  </td>
<td><select name="type">
<option value="City" >所在城市</option>
<option value="StarClass" selected="selected">酒店星级</option>
<option value="node" >酒店名称</option>
</select>
  <select name="order">
  <option value="1">升序</option>
  <option value="2" selected="selected">降序</option>
  </select>
</td>
</tr>
<tr>
<td colspan="2" align="right">
<input type="image" src="/res/huangjin/u/0712/071246385.gif"/>
</td>
</tr>
</table>
</div>
<div id="jspafter" style="display:none"><%=community.getJspAfter(teasession._nLanguage) %></div>
</form>
</body>
</html>
