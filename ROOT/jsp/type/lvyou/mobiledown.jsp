<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<script type="text/javascript" language="javascript" src="/tea/tea.js"></script>
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/load.js" type="text/javascript"></SCRIPT>
<script>
function sendverify()
{
   
    currentPos = 'pos';
    var url = "/jsp/type/lvyou/verify.jsp?act=send&mobile="+document.getElementById("mobile").value;
    url = encodeURI(url);
    send_request(url);
  
}
function down()
{
   
    currentPos = 'pos';
    var url = "/jsp/type/lvyou/verify.jsp?act=verify&mobile="+document.getElementById("mobile").value+"&verify="+document.getElementById("verify").value;
    url = encodeURI(url);
    send_request(url);
  
}
</script>

<h1>通过手机号获取客户端</h1>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr>
    <td>输入手机号：</td>
    <td><input name="mobile" value="" size="12" class="text"/> 
    <input type="button" name="send" value="发送验证码" onClick="sendverify();"></td>
   <tr>
   <tr>
    <td>输入验证码：</td>
    <td><input name="verify" value="" size="5" class="text2"/> 
    <input type="button" name="ok" value="发送下载链接" onClick="down();"></td>
   <tr>
 
 </table>
  <span id="pos"></span>
