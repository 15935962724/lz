<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

String key=h.get("lmspay");
int lmspay=Integer.parseInt(MT.dec(key));
LmsPay t=LmsPay.find(lmspay);


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>上传汇款凭证</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsPays.do?repository=pay" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmspay" value="<%=key%>"/>
<input type="hidden" name="act" value="voucher"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <th>缴费人：</th>
    <td><%=Profile.find(t.member).getMember()%></td>
  </tr>
  <tr>
    <th>缴费单号：</th>
    <td><%=MT.f(t.code)%></td>
  </tr>
  <tr>
    <th>缴费人数：</th>
    <td><%=MT.f(t.quantity)%>位</td>
  </tr>
  <tr>
    <th>缴费金额：</th>
    <td><%=MT.f(t.price)%>元</td>
  </tr>
  <tr>
    <th><em>*</em>汇款凭证：</th>
    <td>
      <input type="file" name="voucher" <%=t.voucher>0?"_alt":"alt"%>="汇款凭证"/>
      <%
      if(t.voucher>0)
      {
        out.print(Attch.find(t.voucher).getAnchor("查看"));
      }
      %>
    </td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
