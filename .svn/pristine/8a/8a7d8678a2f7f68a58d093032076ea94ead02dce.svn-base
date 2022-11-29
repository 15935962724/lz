<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.ocean.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*" %><%@page import="java.util.Date" %>
<%
TeaSession teasession = new TeaSession(request);
String oceanorder=teasession.getParameter("oceanorder");

Date date = new Date();
Calendar cal = Calendar.getInstance();
int day = cal.get(Calendar.DAY_OF_MONTH);
cal.set(Calendar.DATE,day+2);


%>
<html>
<head>
<link href="http://www.bj-sea.com/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<title>
发卡信息提示
</title>
</head>
<body bgcolor="#ffffff">

<table id="tablecenter">
<tr><td>您好：</td>
</tr>
<tr>
  <td> 此卡已发放给用户，请注意保管！
    </td>
</tr>
<tr> <td><input type="button" value="继续发卡" onclick="window.open('/jsp/ocean/OceanRollList2.jsp','_self');" /></td>
</tr>
</table>
</body>
</html>
