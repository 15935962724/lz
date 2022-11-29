<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.eon.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.text.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.erp.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户还款</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<body bgcolor="#ffffff" >


<div id="lzi_rkd">
  <h1>客户还款</h1>
  <form action="?" name="form1">

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
      <td >当前客户：</td>
      <td >北京怡康科技有限公司 </td>
    </tr>
    <tr>
      <td >还款日期：</td>
      <td ><input name="time_s" size="7"  value="">
        <A href="###"><img onclick="showCalendar('form1.time_s');" src="/tea/image/public/Calendar2.gif" align="top"/></a>  </td>
    </tr>
    <tr>
      <td >欠款金额：</td>
      <td >6000元 </td>
    </tr>
    <tr>
      <td >本次还款数量：</td>
      <td ><input type="text" name="" value=""> </td>
    </tr>
  </table>
  <br>
  <input type="submit" value="确认打款"/>&nbsp;
  <input type="button" value="关闭"  onClick="javascript:window.close();">
  </form>

</div>

</body>
</html>
