<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int money=h.getInt("money");

Site s=Site.find(1);


%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>客户充值</h1>


<form name="form1" action="/Moneys.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="money" value="<%=money%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>用户</td>
    <td>　<input name="member" value="" alt="用户"/></td>
  </tr>
  <tr>
    <td>充值</td>
    <td>￥<input name="value" value="" mask="int" alt="充值"/></td>
  </tr>
  <tr>
    <td>说明</td>
    <td>　<input name="content" value="" size="50" alt="说明"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>


</body>
</html>
