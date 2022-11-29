<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%><%@page import="tea.entity.custom.papc.*"%><%

Http h=new Http(request,response);



%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
img1{width:200px}
</style>
</head>
<body>
<h1>生成二维码</h1>
<div id="head6"></div>


<form name="form2" onsubmit="">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="papcapp"/>
<input type="hidden" name="nexturl"/>
<input type="hidden" name="act"/>
<table id="tablecenter" cellspacing="0">
<tr>
  <td>内容：</td>
  <td><textarea name="content" cols="50" rows="4"></textarea></td>
</tr>
</table>
<input type="submit" value="生成"/>
</form>

<table id="tablecenter" cellspacing="0">
<tr>
  <td>未加密</td>
  <td>已加密</td>
</tr>
<tr>
  <td><img id="img0" src="/tea/mt/blank.gif"/></td>
  <td><img id="img1" src="/tea/mt/blank.gif"/></td>
</tr>
</table>

<script>
form2.onsubmit=function()
{
  var v='/QRCodes.do?content='+encodeURIComponent(this.content.value)+'&size=200&t='+Math.random();
  $('img0').src=v;
  $('img1').src=v+'&mode=A&xor=58607710&enc=16';
  return false;
};
</script>
</body>
</html>
