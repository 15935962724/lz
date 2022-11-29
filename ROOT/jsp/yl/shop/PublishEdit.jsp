<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.yl.shop.*"%><%

Http h=new Http(request,response);

int type=h.getInt("type");



%><!DOCTYPE html><html><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>

<form name="form1" action="/Publishs.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)&&mt.show(null,0)">
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>
<input type="hidden" name="type" value="<%=type%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>发行数量</td>
    <td><input name="quantity" alt="发行数量" mask="int">张</td>
  </tr>
  <tr>
    <td>有效期</td>
    <td><%=h.selects("vtime",MT.add(new Date(),180))%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus(form1);</script>
</body>
</html>
