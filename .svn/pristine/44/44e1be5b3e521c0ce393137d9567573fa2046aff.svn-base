<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int type=h.getInt("type");
String member=h.get("member");



%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<form name="form1" action="/Publishs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="act" value="member"/>
<input type="hidden" name="nexturl" value="location.reload()"/>
<input type="hidden" name="type" value="<%=type%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>代理商</td>
    <td><input name="member" value="<%=MT.f(member)%>" alt="代理商"/></td>
  </tr>
  <tr>
    <td>发放数量</td>
    <td><input name="quantity" alt="数量" size="10" mask="int">张 (剩余：<%=Coupon.count(" AND member IS NULL")%>)</td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="关闭" onclick="parent.mt.close();"/>
</form>

<script>mt.focus(form1);</script>
</body>
</html>
