<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.ocean.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%@page import="java.util.*" %><%@page import="java.util.Date" %>
<%
TeaSession teasession = new TeaSession(request);
String oceanorder=teasession.getParameter("oceanorder");

Date date = new Date();
Calendar cal = Calendar.getInstance();
int day = cal.get(Calendar.DAY_OF_MONTH);
cal.set(Calendar.DATE,day+5);

int ids = 0;
if(teasession.getParameter("ids")!=null && teasession.getParameter("ids").length()>0)
{
  ids = Integer.parseInt(teasession.getParameter("ids"));
}



%>
<html>
<head>
<link href="http://www.bj-sea.com/tea/CssJs/bj-sea.css" rel="stylesheet" type="text/css">
<title>
交易成功
</title>
</head>
<body class="OceanPassport">
<div class="body">
  <table class="Flow1">
    <tr>
      <td class="td01"></td><td class="td02">服务条款</td><td class="td03">填写登记表</td><td class="td04">确认订单</td><td class="td05">支付费用</td>
    </tr></table>
    <div class="Ocean">
      <div class="Ocean_top"></div><div class="Ocean_con"><div class="Ocean_bottom">
<div class="Success">
<form  name="form1" action="/servlet/EditOcean" method="get" enctype="multipart/form-data">
<input   type="hidden"  name="act"  value="OceanSuccess">
<input   type="hidden"  name="ids"  value="<%=ids%>">
<table>
<tr><td class="td01">交易成功！</td>
</tr>
<tr><td class="td02">您好：</td>
</tr>
<tr>
  <td class="td03"> 您的资金已提交成功，请于<%out.print(Ocean.sdf.format(cal.getTime()));%>来海洋馆领取您的海洋护照。<br>
    请牢记您的订单编号<%=oceanorder%>，相关信息已经发送到您的邮箱suiyuan423@163.com，请注意查收。</td>
</tr>

</table>
<div class="chaxunhuzxx"><a href="/jsp/ocean/OceanSearch.jsp"><img src="/res/bj-sea/u/0902/090264986.jpg"/></a></div>
<div class="Success_bottom"><input type="submit" value=""/></div>
</form>
</div>
</div>
</div>
</div>
<div class="footer">Copyright(c)2001-2010 北京海洋馆·版权所有 地址：北京海淀区高粱桥斜街乙18号（北京动物园北门内）<br/>
定票热线：（010）62123910 网址：www.BJ-sea.com</div>
</div>
</body>
</html>
