<%@page contentType="text/html;charset=UTF-8"  %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.site.*" %><%@ page  import="tea.resource.Resource" %><%@ page import="java.util.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


String community=request.getParameter("community");
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>

<body>

<form action="/servlet/EditTransfer" method="post">
<style type="text/css">
<!--
body{margin:0;padding:10px;border:0;}
img {border:0;}
-->
</style>

  <TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
  <tr>
    <td>付款账户：</td>
    <td>
      <input type="text" name="account">
    </td>
    <td>帐款方户名：</td>
    <td><input type="text" name="chamberlain"></td>
  </tr>
  <tr>
    <td>收款方地址：</td>
    <td><input name="acceptaddress" value="北京">
    </td>
    <td>收款方开户行：</td>
    <td><input type="text" name="acceptbank"></td>
  </tr>
  <tr>
    <td>转入收款方账号：</td>
    <td>
      <input type="text" name="acceptaccount">
    </td>
    <td>转账金额：</td>
    <td><input type="text" name="money"></td>
  </tr>
  <tr>
    <td>大写：</td>
    <td>
      <input type="text" name="capital">
    </td>
    <td>手续费：</td>
    <td><input type="text" name="poundage"></td>
  </tr>
      <tr>
    <td>状态：</td>
    <td>
      <input type="text" name="state">
    </td>
    <td>交易类别：</td>
    <td><input type="text" name="type"></td>
    </tr>     <tr>
    <td>用途：</td>
    <td>
      <input type="text" name="purpose">
    </td>
    <td>备注：</td>
    <td><input type="text" name="remark"></td>
     </tr>
  <tr>
    <td>取款密码：</td>
    <td>
      <input type="text" name="password">
    </td>
    <td>日期:</td>
    <td><input type="text" name="datetime" value="<%=(new java.text.SimpleDateFormat("yyyy-MM-dd")).format(new java.util.Date())%>"></td>
  </tr>
  <tr align="right">
    <td colspan="4"><input name="" type="submit" value="提交"></td>
    </tr>
</table>
</form>

