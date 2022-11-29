<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.ui.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.member.*"%><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);

TeaSession ts=new TeaSession(request);
if(ts._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + h.node+"&nexturl="+Http.enc(request.getRequestURI()+"?"+request.getQueryString()));
  return;
}



int site=h.getInt("site");
Site t=Site.find(site);


%><html>
<head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>短信通道</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Sites.do" method="post" enctype="multipart/form-data" target="_ajax" onSubmit="return mt.check(this)">
<input type="hidden" name="site" value="<%=site%>"/>
<input type="hidden" name="act" value="sms"/>

<table id="tablecenter">
  <tr>
    <td class="th">通道类型：</td>
    <td><%=h.radios(Site.SMS_SERVICE,"smsserver",t.smsserver)%></td>
  </tr>
  <tr>
    <td class="th">用户名：</td>
    <td><input name="smsuser" value="<%=MT.f(t.smsuser)%>"/></td>
  </tr>
  <tr>
    <td class="th">密码：</td>
    <td><input name="smspassword" value="<%=MT.f(t.smspassword)%>"/></td>
  </tr>
  <tr>
    <td class="th">选项：</td>
    <td><input type="checkbox" name="smsremind" id="smsremind" <%=t.smsremind?" checked":""%>><label for="smsremind">发送提醒</label></td>
  </tr>
</table>



<br/>
<input class="but" type="submit" value="提交"/> <input class="but" type="button" value="返回" onClick="history.back();"/>
</form>



<h2>相关信息</h2>
<table id="tablecenter">
  <tr>
    <td class="th">短信剩余：</td>
    <td id="count"></td>
  </tr>
  <tr>
    <td class="th">发送短信：</td>
    <td><%=t.smscount%> 条</td>
  </tr>
</table>


<!--
http://60.28.200.132/chufaceshi/
-->

<script>
mt.send("/SMessages.do?act=count",function(d){$('count').innerHTML=d+' 条';});
</script>
</body>
</html>
