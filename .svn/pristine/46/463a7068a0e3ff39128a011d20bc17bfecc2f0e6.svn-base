<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;


%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>
<body id='treebody'>
<!-- 上下班登记 -->
<table border="0" cellspacing="0" width="100%" id="tablecenter" class="landitable" bgcolor="#ffffff" cellpadding="0" align="center">
  <tr id="tableonetr">
    <td>　
      今日上下班登记      <br>
    </td>
  </tr>
  <tr id="tableonetr">
    <td nowrap>
      <input type="button"   value="进入" onClick="window.open('/jsp/admin/manage/duty.jsp','function_fun');">
    </td>
  </tr>
</table>

<!----  今日外出 ---->
<br>

<table border="0" cellspacing="0" id="tablecenter" width="100%" class="landitable" bgcolor="#ffffff" cellpadding="0" align="center">
  <tr id="tableonetr">
    <td>　
      今日外出登记      <br>
    </td>
  </tr>
  <tr id="tableonetr">
    <td nowrap>
      <input type="button" value="进入" class="BigButton" onClick="window.open('/jsp/admin/manage/out.jsp','function_fun');" >
    </td>
  </tr>
</table>

<!----  请假 ---->
<br>

<table border="0" cellspacing="0" id="tablecenter" width="100%" class="landitable" bgcolor="#ffffff" cellpadding="0" align="center">
  <tr id="tableonetr">
    <td nowrap>　 
      请假登记      <br>
    </td>
  </tr>
  <tr id="tableonetr">
    <td nowrap>
      <input type="button"  value="进入" class="BigButton" onClick="window.open('/jsp/admin/manage/leave.jsp','function_fun');">
    </td>
  </tr>
</table>

<!---- 出差 ---->
<br>

<table border="0" cellspacing="0" id="tablecenter" width="100%" class="landitable" bgcolor="#ffffff" cellpadding="0" align="center">
  <tr id="tableonetr">
    <td  nowrap> 
      出差登记      <br>
    </td>
  </tr>
  <tr id="tableonetr">
    <td nowrap>
      <input type="button"  value="进入" class="BigButton" onClick="window.open('/jsp/admin/manage/evection.jsp','function_fun');">
    </td>
  </tr>
</table>

<!----  上下班记录查询 ---->
<br>

<table border="0" cellspacing="0" id="tablecenter" width="100%" class="landitable" bgcolor="#ffffff" cellpadding="0" align="center">
  <tr id="tableonetr">
    <td>　
      上下班记录查询      <br>
    </td>
  </tr>
  <tr id="tableonetr">
    <td nowrap >
      <input type="button"  value="进入" class="BigButton" onClick="window.open('/jsp/admin/manage/report.jsp','function_fun');">
    </td>
  </tr>
</table>
</body>
</html>



