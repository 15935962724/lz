<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/resource/Hostel");


int id=Integer.parseInt(request.getParameter("destine"));
int roomPriceId=Integer.parseInt(request.getParameter("roomprice"));

RoomPrice roomPrice=RoomPrice.find(roomPriceId);
Destine destine =Destine.find(id);

java.text.DateFormat df = java.text.DateFormat.getDateInstance();
Hostel hostel=Hostel.find(teasession._nNode,teasession._nLanguage);


%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>

<h1><%=r.getString(teasession._nLanguage, "Submit")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <TD>订 单 号：</TD>
    <td><font color="#DF451C"><strong><%=destine.getDestineCode()%></strong></font></td>
  </tr>
  <tr>
    <TD>入住客人：</TD>
    <td><%=destine.getHumanname(teasession._nLanguage)%> </td>
  </tr>
  <tr>
    <TD>住宿日期：</TD>
    <td><%=(destine.getKipdateToString())%> 至 <%=( destine.getLeavedateToString())%> </td>
  </tr>
  <tr>
    <TD>酒店名称：</TD>
    <td><%=hostel.getName()%> </td>
  </tr>
  <tr>
    <TD>房间类型：</TD>
    <td><%=roomPrice.getRoomtype(teasession._nLanguage)%> </td>
  </tr>
  <tr>
    <TD>房间数量：</TD>
    <td><%=destine.getRoomcount()%> </td>
  </tr>
  <tr>
    <TD>付款方式：</TD>
    <td><%=r.getString(teasession._nLanguage,RoomPrice.PAYMENT[ destine.getPaymenttype()])%> </td>
  </tr>
  <tr>
    <TD>抵店时间：</TD>
    <td><%=destine.getEarlyarrive()%> 至 <%=destine.getEveningarrive()%></td>
  </tr>
  <tr>
    <TD>价 &nbsp; &nbsp;格：</TD>
    <td><%=roomPrice.getPrice(destine.getPaymenttype())%> </td>
  </tr>
  <tr>
    <TD>联 系 人：</TD>
    <td><%=destine.getLinkmanname(teasession._nLanguage)%> </td>
  </tr>
  <tr>
    <TD>联系电话：</TD>
    <td><%=destine.getLinkmanhandset()%> </td>
  </tr>
  <tr>
    <TD>E-mail：</TD>
    <td><%=destine.getLinkmanmail()%></td>
  </tr>
</table>
<br>
如果您的计划有变动，如：不能按时入住酒店、取消预订、延长入住、提前退房等情况，请与预订中心联系。

          谢谢您选择本系统，祝您旅途愉快！<br>
　
<center>
  <input type=button value=返回 onClick="window.open('/servlet/Node?node=<%=teasession._nNode%>','_self')">
</center>
<div id="head6"><img height="6" src="about:blank"></div>
</BODY>
</html>
