<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}

int courseplan=h.getInt("courseplan");
CoursePlan t=CoursePlan.find(courseplan);
Node n=Node.find(t.node);
Profile m=Profile.find(t.member);

%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看——报名管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="courseplan" value="<%=courseplan%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>课程名称：</td>
    <td><%=n.getAnchor(h.language)%></td>
  </tr>
  <tr>
    <td>用户名：</td>
    <td><%=m.getMember()%></td>
  </tr>
  <tr>
    <td>付款金额：</td>
    <td><%=MT.f(t.price)%></td>
  </tr>
  <tr>
    <td>支付方式：</td>
    <td><%=CoursePlan.PAYMENT_TYPE[t.payment]%></td>
  </tr>
  <tr>
    <td>付款状态：</td>
    <td><%=CoursePlan.ISPAY_TYPE[t.ispay]%></td>
  </tr>
  <tr>
    <td>付款备注：</td>
    <td><%=MT.f(t.paynote)%></td>
  </tr>
<%
if(t.ispay==2)
{
%>
  <tr>
    <td>收款人：</td>
    <td><%=Profile.find(t.paymember).getMember()%></td>
  </tr>
  <tr>
    <td>收款时间：</td>
    <td><%=MT.f(t.paytime,1)%></td>
  </tr>
<%
}
%>
  <tr>
    <td>审核状态：</td>
    <td><%=CoursePlan.STATE_TYPE[t.state]%></td>
  </tr>
  <tr>
    <td>报名时间：</td>
    <td><%=MT.f(t.time,1)%></td>
  </tr>
</table>

<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
