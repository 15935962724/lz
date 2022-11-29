<%@page contentType="text/html;charset=UTF-8" %><%


String community=request.getParameter("community");
%>



<script type="text/javascript">
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
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>

<form name="form1" method="post" action="/servlet/EditBargaining" onsubmit="return submitText(this.account,'无效-帐号')&&submitText(this.datetime,'无效-日期')&&submitFloat(this.adopt,'无效-支出')&&submitFloat(this.memory,'无效-存入')&&submitFloat(this.balance,'无效-余额')&&submitText(this.explain,'无效-说明');">
  <TABLE border="0" cellPadding="0" cellSpacing="0"  id="tablecenter">
    <tr>
      <td>帐号</td>
      <td><input type="text" name="account"></td>
      <td>日期</td>
      <td><input type="text" name="datetime"  ><a href="#" onClick="td_calendar('form1.datetime')"><img src="/tea/image/public/Calendar2.gif" ></a></td>
    </tr>
    <tr>
      <td>支出</td>
      <td><input type="text" name="adopt"></td>
      <td>存入</td>
      <td><input type="text" name="memory"></td>
    </tr>
    <tr>
      <td>余额</td>
      <td><input type="text" name="balance"></td>
      <td>说明</td>
      <td><input type="text" name="explain"></td>
    </tr>
    <tr align="right">
      <td colspan="4"><input name="submit" type="submit" value="提交"></td>
    </tr>
  </table>
</form>

