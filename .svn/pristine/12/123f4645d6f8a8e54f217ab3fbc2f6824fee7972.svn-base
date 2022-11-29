<%@page contentType="text/html;charset=UTF-8"  %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="java.util.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=request.getParameter("community");
%>

<style type="text/css">
<!--
body{margin:0;padding:10px;border:1px solid #ccc;}
img {border:0;}
-->
</style>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>

<body>

  <TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
    <form name="form1" method="post" action="/servlet/EditNetPay" onsubmit="return submitText(this.account,'无效-账号')&&submitText(this.password,'无效-密码')&&submitFloat(this.money,'无效-金额')&&submitFloat(this.date,'无效-日期');">
    <tr>
      <td>账号：</td>
      <td>
        <input type="text" name="account">
      </td>
      <td>密码：</td>
      <td><input type="password" name="password"></td>
    </tr>
    <tr>
      <td>金额:</td>
      <td>
        <input type="text" name="money">
      </td>
      <td>日期：</td>
      <td><input type="text" readonly="readonly" name="date" value="<%=(new java.text.SimpleDateFormat("yyyy-MM-dd")).format(new java.util.Date())%>" ><a href="#" onClick="showCalendar('form1.date')"><img src="/tea/image/public/Calendar2.gif" ></a></td>
    </tr>
    <tr align="right">
      <td colspan="4"><input name="Submit" type="Submit" value="提交"></td>
      </tr></form>
  </table>

</body>
</html>

