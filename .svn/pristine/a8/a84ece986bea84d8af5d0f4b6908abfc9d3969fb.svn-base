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
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script>
function td_calendar(fieldname)
{
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/tea/inc/calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
        </script>
<style type="text/css">
<!--
body{margin:0;padding:10px;border:1px solid #ccc;}
img {border:0;}
-->
</style>

</head>
<body>
<form name="form1" method="post" action="/servlet/EditAccount" onsubmit="return submitText(this.account,'无效-账号')&&submitFloat(this.balance,'无效-余额')&&submitFloat(this.yearbenefit,'无效-年利率')&&submitInteger(this.term,'无效-存期')&&submitText(this.maturity,'无效-到期日');">
  <TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
    <tr>
      <td>账号：</td>
    <td><input name="account" type="text" size="15"></td>
    <td>类型：</td>
    <td><select name="type">
      <option value="0">活期</option>
      <option value="1">死期</option>
    </select></td>
    </tr>
  <tr>
      <td>币种：</td>
      <td>
        <select name="currency">
        <option value="0">人民币</option>
        <option value="1">美元</option>
        </select>
    </td>
    <td>余额：</td>
    <td><input name="balance" type="text" size="15"></td>
  </tr>
  <tr>
      <td>年利率：</td>
    <td><input name="yearbenefit" type="text" size="15"></td>
    <td>存期：</td>
    <td><input name="term" type="text" size="15">
      <!--<a href="#" onclick="td_calendar('form1.term')"><img src="/tea/image/public/Calendar2.gif" ></a>--></td>
  </tr>
  <tr>
      <td>到期日：</td>
    <td><input name="maturity" type="text" size="15" >
        <a href="#" onclick="td_calendar('form1.maturity')"><img src="/tea/image/public/Calendar2.gif" ></a>
    </td>
    <td>状态：</td>
    <td><select name="states">
      <option value="0">活动</option>
      <option value="1">锁定</option>
    </select></td>
  </tr>
  <tr align="right">
      <td colspan="4">    <input type="submit" name="Submit" value="提交"></td>
    </tr>
</table>

</form>
</body>
</html>

