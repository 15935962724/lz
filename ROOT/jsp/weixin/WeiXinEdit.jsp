<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

WeiXin t=WeiXin.find(h.community);

int menuid=h.getInt("id");

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<style>
.D{display:none}
</style>
</head>
<body>
<h1><%=AdminFunction.find(menuid).getName(h.language)%></h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form2" action="/WeiXins.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="index"/>
<input type="hidden" name="verify"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl","")%>"/>

<h2>订阅号</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>微信用户：</td>
    <td><input name="user0" value="<%=MT.f(t.user[0])%>"/></td>
  </tr>
  <tr>
    <td>微信密码：</td>
    <td><input name="password0" value="<%=MT.f(t.password[0])%>"/> <input type="button" value="测试" onclick="mt.act('login',0)"/></td>
  </tr>
  <tr class="D">
    <td>微信Cookie：</td>
    <td><input name="cookie0" value="<%=MT.f(t.cookie[0])%>"/></td>
  </tr>
  <tr>
    <td>App Id</td>
    <td><input name="appid0" value="<%=MT.f(t.appid[0])%>" size="30"/></td>
  </tr>
  <tr>
    <td>App Secret</td>
    <td><input name="appsecret0" value="<%=MT.f(t.appsecret[0])%>" size="40"/></td>
  </tr>
</table>

<h2>服务号</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>微信用户：</td>
    <td><input name="user1" value="<%=MT.f(t.user[1])%>"/></td>
  </tr>
  <tr>
    <td>微信密码：</td>
    <td><input name="password1" value="<%=MT.f(t.password[1])%>"/> <input type="button" value="测试" onclick="mt.act('login',1)"/></td>
  </tr>
  <tr class="D">
    <td>微信Cookie：</td>
    <td><input name="cookie1" value="<%=MT.f(t.cookie[1])%>"/></td>
  </tr>
  <tr>
    <td>App Id</td>
    <td><input name="appid1" value="<%=MT.f(t.appid[1])%>" size="30"/></td>
  </tr>
  <tr>
    <td>App Secret</td>
    <td><input name="appsecret1" value="<%=MT.f(t.appsecret[1])%>" size="40"/></td>
  </tr>
  <tr>
    <td>商户号：</td>
    <td><input name="partnerid" value="<%=MT.f(t.partnerid)%>"/> 10位，纯数字！</td>
  </tr>
  <tr>
    <td>商户密钥：</td>
    <td><input name="partnerkey" value="<%=MT.f(t.partnerkey)%>"/> 32位，数字字母组合！　商户平台->账户设置->安全设置->API密钥</td>
  </tr>
  <tr>
    <td>支付专用签名：</td>
    <td><input name="paysignkey" value="<%=MT.f(t.paysignkey)%>"/> 128位，数字字母大小写组合！</td>
  </tr>
</table>

<h2>企业号</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>微信用户：</td>
    <td><input name="user2" value="<%=MT.f(t.user[2])%>"/></td>
  </tr>
  <tr>
    <td>微信密码：</td>
    <td><input name="password2" value="<%=MT.f(t.password[2])%>"/> <input type="button" value="测试" onclick="mt.act('login',0)"/></td>
  </tr>
  <tr class="D">
    <td>微信Cookie：</td>
    <td><input name="cookie2" value="<%=MT.f(t.cookie[2])%>"/></td>
  </tr>
  <tr>
    <td>App Id</td>
    <td><input name="appid2" value="<%=MT.f(t.appid[2])%>" size="30"/></td>
  </tr>
  <tr>
    <td>App Secret</td>
    <td><input name="appsecret2" value="<%=MT.f(t.appsecret[2])%>" size="40"/></td>
  </tr>
</table>
<br/>
<input type="button" onclick="mt.act('edit')" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();
mt.act=function(a,i)
{
  form2.act.value=a;
  form2.index.value=i;
  var t=$$('_verify');
  if(t)form2.verify.value=t.value;
  if(form2.onsubmit()!=false)form2.submit();
};
</script>
</body>
</html>
