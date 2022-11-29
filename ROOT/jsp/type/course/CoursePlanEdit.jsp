<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%>
<%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);

int courseplan=h.getInt("courseplan");
CoursePlan t=CoursePlan.find(courseplan);

if("POST".equals(request.getMethod()))
{
  String act=h.get("act");
  String nexturl=h.get("nexturl");
  if("del".equals(act))
  {
    t.delete();
  }else if("edit".equals(act))
  {
    t.node=h.getInt("node");
    t.member=h.getInt("member");
    t.price=h.getFloat("price");
    t.payment=h.getInt("payment");
    t.ispay=h.getInt("ispay");
    t.paynote=h.get("paynote");
    t.paymember=h.getInt("paymember");
    t.paytime=h.getDate("paytime");
    t.state=h.getInt("state");
    t.time=h.getDate("time");
    t.set();
  }
  out.print("<script>parent.mt.show('数据操作成功！',1,'"+nexturl+"');</script>");
  return;
}

%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="?" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="courseplan" value="<%=courseplan%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>课程</td>
    <td><input name="node" value="<%=MT.f(t.node)%>"/></td>
  </tr>
  <tr>
    <td>用户</td>
    <td><input name="member" value="<%=MT.f(t.member)%>"/></td>
  </tr>
  <tr>
    <td>付款金额</td>
    <td><input name="price" value="<%=MT.f(t.price)%>"/></td>
  </tr>
  <tr>
    <td>支付方式</td>
    <td><%=h.radios(CoursePlan.PAYMENT_TYPE,"payment",t.payment)%></td>
  </tr>
  <tr>
    <td>付款状态</td>
    <td><%=h.radios(CoursePlan.ISPAY_TYPE,"ispay",t.ispay)%></td>
  </tr>
  <tr>
    <td>付款备注</td>
    <td><input name="paynote" value="<%=MT.f(t.paynote)%>"/></td>
  </tr>
  <tr>
    <td>付款状态操作者</td>
    <td><input name="paymember" value="<%=MT.f(t.paymember)%>"/></td>
  </tr>
  <tr>
    <td>付款时间</td>
    <td><%=h.selects("paytime",t.paytime)%></td>
  </tr>
  <tr>
    <td>状态</td>
    <td><%=h.radios(CoursePlan.STATE_TYPE,"state",t.state)%></td>
  </tr>
  <tr>
    <td>报名时间</td>
    <td><%=h.selects("time",t.time)%></td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
