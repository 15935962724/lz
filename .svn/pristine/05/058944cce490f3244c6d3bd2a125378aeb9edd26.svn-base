<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="java.io.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.women.*"%><%@page import="tea.entity.util.*"%><%

Http h=new Http(request,response);

int donation=h.getInt("donation");
Donation t=Donation.find(donation);


%>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/Calendar.js" type="text/javascript"></script>
</head>
<body>
<h1>落实信息 添加/编辑</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/Donations.do" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="donation" value="<%=donation%>"/>
<input type="hidden" name="act" value="edit"/>
<input type="hidden" name="nexturl" value="<%=h.get("nexturl")%>"/>

<table id="tablecenter" cellspacing="0">
  <tr>
    <td>发票编号</td>
    <td><input name="invoice" value="<%=MT.f(t.invoice)%>" alt="发票编号"/></td>
  </tr>

  <tr>
    <td>捐赠时间</td>
    <td><input name="dtime" value="<%=MT.f(t.dtime)%>" size="12" onclick="new Calendar().show('form1.dtime');" alt="捐赠时间"/><img onclick="previousSibling.onclick()" src="/tea/image/public/Calendar2.gif" align="top"></td>
  </tr>
  <tr>
    <td>捐赠者</td>
    <td><input name="donors" value="<%=MT.f(t.donors)%>" alt="捐赠者"/></td>
  </tr>
  <tr>
    <td>捐赠金额</td>
    <td><input name="money" value="<%=MT.f(t.money)%>" mask="float" alt="捐赠金额"/></td>
  </tr>
</table>

<h2>选项信息</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>地址</td>
    <td><input name="address" value="<%=MT.f(t.address)%>"/></td>
  </tr>
  <tr>
    <td>邮编</td>
    <td><input name="zip" value="<%=MT.f(t.zip)%>"/></td>
  </tr>
  <tr>
    <td>电话</td>
    <td><input name="tel" value="<%=MT.f(t.tel)%>"/></td>
  </tr>
  <tr>
    <td>指定地点</td>
    <td><input name="location" value="<%=MT.f(t.location)%>"/></td>
  </tr>
  <tr>
    <td>指定冠名</td>
    <td><input name="named" value="<%=MT.f(t.named)%>"/></td>
  </tr>
  <tr>
    <td>备注</td>
    <td><textarea name="remark" cols="50" rows="5"><%=MT.f(t.remark)%></textarea></td>
  </tr>
</table>

<h2>落实信息</h2>
<table id="tablecenter" cellspacing="0">
  <tr>
    <td>落实省(区)</td>
    <td><select name="province"><option value="">---请选择---</option>
<%
Enumeration e=Card.find(" AND card<100",0,100);
while(e.hasMoreElements())
{
  Card c=(Card)e.nextElement();
  String str=c.getAddress().replaceAll("[省市]","");
  out.print("<option value='"+str+"'");
  if(str.equals(t.province))out.print(" selected");
  out.print(">"+str);
}
%></select></td>
  </tr>
  <tr>
    <td>市(县)</td>
    <td><input name="city" value="<%=MT.f(t.city)%>"/></td>
  </tr>
  <tr>
    <td>乡(镇)</td>
    <td><input name="town" value="<%=MT.f(t.town)%>"/></td>
  </tr>
  <tr>
    <td>村</td>
    <td><input name="village" value="<%=MT.f(t.village)%>"/></td>
  </tr>
  <tr>
    <td>落实照片</td>
    <td><input type="file" name="photo">
      <%if(MT.f(t.photo).length()>0)out.print("<a href='###' onclick=mt.img('"+t.photo+"')>查看</a>");%>
    </td>
  </tr>
</table>

<br/>
<input type="submit" value="提交"/> <input type="button" value="返回" onclick="history.back();"/>
</form>

<script>mt.focus();</script>
</body>
</html>
