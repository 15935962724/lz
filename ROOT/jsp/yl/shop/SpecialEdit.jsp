<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
int special=h.getInt("special");
Special t=Special.find(special);



%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>特价商品 添加/编辑</h1>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="special" value="<%=special%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>类型</td>
    <td><%=h.radios(Special.SPECIAL_TYPE,"type",t.type)%></td>
  </tr>
  <tr>
    <td> 特价商品</td>
    <td><input name="product" value="<%=MT.f(t.product)%>"/></td>
  </tr>
  <tr>
    <td>顺序</td>
    <td><input name="sequence" value="<%=MT.f(t.sequence)%>"/></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
