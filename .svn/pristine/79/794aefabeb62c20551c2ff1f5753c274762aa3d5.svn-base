<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.lms.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}

StringBuilder par=new StringBuilder();


String key=h.get("lmspay");
int lmspay=Integer.parseInt(MT.dec(key));
par.append("?lmspay="+key);
par.append("&pos=");

LmsPay t=LmsPay.find(lmspay);


%><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css"/>
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<h1>查看缴费</h1>
<div id="head6"><img height="6" src="about:blank"></div>

<form name="form1" action="/LmsPays.do?repository=pay" method="post" enctype="multipart/form-data" target="_ajax" onsubmit="return mt.check(this)">
<input type="hidden" name="community" value="<%=h.community%>"/>
<input type="hidden" name="lmspay" value="<%=lmspay%>"/>
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
    <th>支付方式：</th>
    <td><%=LmsPay.PAYMENT_TYPE[t.payment]%></td>
  </tr>
  <tr>
    <th>汇款凭证：</th>
    <td><img src="<%=t.voucher<1?"/tea/image/public/blank_png.gif":Attch.find(t.voucher).path%>"/></td>
  </tr>
</table>

<h2>缴费明细</h2>
<table id="tablecenter" cellspacing="0">
<tr id="tableonetr">
  <td width="8"></td>
  <td>学号</td>
  <td>姓名</td>
  <td>学习服务中心</td>
  <td>证书方向</td>
  <td>实践科次(已报考)</td>
  <td>机考科次(已报考)</td>
  <td>报考费用</td>
  <td>操作</td>
</tr>
<%
int pos=h.getInt("pos");
Iterator it=LmsMemberCourse.find(" AND lmc.lmspay="+t.lmspay,0,20).iterator();
for(int i=1+pos;it.hasNext();i++)
{
  LmsMemberCourse lmc=(LmsMemberCourse)it.next();
  Profile p=Profile.find(lmc.member);
  LmsOrg lo=LmsOrg.find(p.getAgent());
  %>
  <tr>
    <td><%=i%></td>
    <td><%=p.getMember()%></td>
    <td><%=Lms.getAnchor(p)%></td>
    <td><%=MT.f(lo.orgname)%></td>
    <td><%=p.getLeveltype()<1?"--":LmsCert.f(p.getLeveltype())%></td>
    <%
    out.print("<td>"+Math.max(0,lmc.lmscourse0.split("[|]").length-1));
    out.print("<td>"+Math.max(0,lmc.lmscourse1.split("[|]").length-1));
    %>
    <td onmouseover="mt.tip(this,'<table><%=lmc.getPrice()%></table>');"><%=MT.f(lmc.price)%></td>
    <td><%
    out.println("<a href='/jsp/lms/LmsMemberCourseView.jsp?member="+MT.enc(lmc.member)+"'>查看</a>");
    %></td>
  </tr>
  <%
}
out.print("<tr><td colspan='9' align='right'>共"+t.quantity+"条！"+new tea.htmlx.FPNL(h.language,par.toString(),pos,t.quantity,20));
%>
</table>
<br/>
<input type="button" value="返回" onclick="history.back();"/>
</form>

</body>
</html>
