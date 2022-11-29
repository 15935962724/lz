<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.weibo.*"%><%

Http h=new Http(request,response);
TeaSession ts = new TeaSession(request);
if (ts._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + h.node);
  return;
}

WConfig t=WConfig.find(h.community);

String nexturl=h.get("nexturl");
if(nexturl==null)nexturl=request.getRequestURI()+"?"+request.getQueryString();


%><html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>微博管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/WConfigs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=nexturl%>"/>


<table id="tablecenter" cellspacing="0">
  <tr>
    <td colspan="2"><h2>新浪</h2></td>
  </tr>
  <tr>
    <td>账号</td>
    <td><input name="sinaid" value="<%=MT.f(t.sinaid)%>" size="30"/></td>
  </tr>
  <tr>
    <td>App key</td>
    <td><input name="sinakey" value="<%=MT.f(t.sinakey)%>" size="30"/></td>
  </tr>
  <tr>
    <td>App Secret</td>
    <td><input name="sinasecret" value="<%=MT.f(t.sinasecret)%>" size="40"/></td>
  </tr>
  <tr>
    <td>令牌</td>
    <td><input name="sinatoken" value="<%=MT.f(t.sinatoken)%>" size="40"/> <input type="button" value="授权" onclick="mt.act('auth')"/></td>
  </tr>
  <tr>
    <td colspan="2"><h2>腾讯</h2></td>
  </tr>
  <tr>
    <td>账号</td>
    <td><input name="qqid" value="<%=MT.f(t.qqid)%>" size="30"/></td>
  </tr>
  <tr>
    <td>App key</td>
    <td><input name="qqkey" value="<%=MT.f(t.qqkey)%>" size="30"/></td>
  </tr>
  <tr>
    <td>App Secret</td>
    <td><input name="qqsecret" value="<%=MT.f(t.qqsecret)%>" size="40"/></td>
  </tr>
  <tr>
    <td>令牌</td>
    <td><input name="qqtoken" value="<%=MT.f(t.qqtoken)%>" size="40"/> <input type="button" value="授权" onclick="mt.act('auth2')"/></td>
  </tr>
</table>

<table id="tablecenter" cellspacing="0">
  <tbody class="weibo_write">
  <tr>
    <td>话题</td>
    <td><input name="topic" value="<%=MT.f(t.topic)%>" size="40"/></td>
  </tr>
  <tr>
    <td>网址</td>
    <td><input name="url" value="<%=MT.f(t.url)%>" size="40"/></td>
  </tr>
  <tr>
    <td>图片</td>
    <td><script>mt.file('picture','<%=MT.f(t.picture)%>','','jpg;gif;png;bmp;');</script></td>
  </tr>
  </tbody>
  <tr>
    <td>是否允许登录/注册</td>
    <td><input name="login" type="radio" value="1" id="login_1" checked="checked"/><label for="login_1">是</label>　<input name="login" type="radio" value="0" id="login_0" <%if(!t.login)out.print(" checked='checked' ");%>/><label for="login_0">否</label></td>
  </tr>
</table>

<div class="weibo_tudou">
<h2>土豆</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>用户</td>
    <td><input name="tudouuser" value="<%=MT.f(t.tudouuser)%>" size="40"/></td>
  </tr>
  <tr>
    <td>密码</td>
    <td><input name="tudoupassword" type="password" value="<%=MT.f(t.tudoupassword)%>" size="40"/></td>
  </tr>
  <tr>
    <td>App Key</td>
    <td><input name="tudoukey" value="<%=MT.f(t.tudoukey)%>" size="40"/></td>
  </tr>
</table>
</div>

<br/>
<input type="submit" value="提交" onclick="mt.act('edit');"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
mt.focus();
mt.act=function(a)
{
  form1.act.value=a;
  if(a=='auth2')
  {
    location="/OAuths.do?community=" + form1.community.value + "&type=2&op=auth";
    return;
  }
  if(a=='edit')return;
  form1.submit();
};
mt.receive=function(a)
{
  form1.sinatoken.value=a;
};
</script>
</body>
</html>
