<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.stat.*"%><%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.weixin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String tmp=h.get("wxuser");
WxUser t=WxUser.find(h.community,Long.parseLong(tmp));
WxGroup wg=WxGroup.find(h.community,t.wxgroup);

%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<link href="/tea/image/weixin/emoji.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看用户信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>用户标示</td>
    <td><%=MT.f(t.openid)%></td>
  </tr>
<%--
  <tr>
    <td>头像</td>
    <td><img src="/res/<%=h.community%>/wxuser/<%=t.wxuser%>.jpg" width="50" /></td>
  </tr>
  <tr>
    <td>性别</td>
    <td><%=WxUser.GENDER_TYPE[t.gender]%></td>
  </tr>
--%>
  <tr>
    <td>名称</td>
    <td><%=t.getAnchor()%></td>
  </tr>
  <tr>
    <td>所属组</td>
    <td><%=MT.f(wg.name)%></td>
  </tr>
  <tr>
    <td>备注名</td>
    <td><%=MT.f(t.remarkname)%></td>
  </tr>
  <tr>
    <td>地区</td>
    <td><%=MT.f(t.location)%></td>
  </tr>
  <tr>
    <td>IP</td>
    <td><%
    String ip=MT.f(t.xff,t.ip);
    if(ip!=null)out.print(ip+"==>"+Card.find(Ip.find(ip).card).address);
    %></td>
  </tr>
  <tr>
    <td>时间</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
</table>

<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script>
</script>
</body>
</html>
