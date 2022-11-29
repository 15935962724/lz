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
制卡成功
</title>
</head>
<body bgcolor="#ffffff">

<table id="tablecenter">
<tr><td>您好：</td>
</tr>
<tr>
  <td> 此卡已经制作成功，请制作下一张卡！
    </td>
</tr>
<tr> <td><input type="button" value="确认" onclick="window.open('/jsp/ocean/OceanRollList1.jsp','_self');" /></td>
</tr>
</table>
</body>
</html>
