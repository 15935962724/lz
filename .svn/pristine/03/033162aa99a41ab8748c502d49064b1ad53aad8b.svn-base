<%@page contentType="text/html;charset=utf-8" %>
<%

tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

int id=Integer.parseInt(request.getParameter("travelshopping"));
tea.entity.node.TravelShopping travels=tea.entity.node.TravelShopping.find(id);
if(!session.getId().equals(travels.getSessionid()))
{
  response.sendError(403);
  return;
}


teasession._nNode=travels.getNode();
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.entity.node.Travel travel=tea.entity.node.Travel.find(teasession._nNode,teasession._nLanguage);
tea.resource.Resource r=new tea.resource.Resource();
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
<body>
<h1><%=r.getString(teasession._nLanguage, "SubmitTravelOrder")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
订单:<%=id%><!--//travels.getCode()-->
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr><td>名称</td><td>单价</td><td>数量</td><td>总价</td><td></td>
</tr>
<tr>
  <td>
<%=node.getSubject(teasession._nLanguage)%>
</td>
<td><%=travel.getPrice()%>
</td>
<td><%=travels.getCounts()%></td>
<td><%=travel.getPrice().multiply(new java.math.BigDecimal(travels.getCounts()))%></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<tr>
<TD>真实姓名</TD>
<td><%=travels.getName(teasession._nLanguage)%></td>
<TD>电话</TD>
<td><%=travels.getPhone()%></td>
</tr>
<tr>
<TD>电子邮件</TD>
<td><%=travels.getEmail()%></td>
<TD>支付方式</TD>
<td><%=travels.getPayment()%></td>
</tr>
</table>

<table cellspacing="0" class="section">
<tr>
<TD>汇款帐号</TD>
</tr>
<tr>
<td><%=travel.getAccount()%></td>
</tr>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new tea.htmlx.Languages(teasession._nLanguage,request)%></div>
</body>
</html>

