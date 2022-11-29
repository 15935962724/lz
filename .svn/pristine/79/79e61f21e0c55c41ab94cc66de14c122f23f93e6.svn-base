<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%@page import="tea.ui.*" %>
<%@page import="tea.entity.node.*" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv.toString()==null)
{
 response.sendRedirect("/jsp/admin/logg.jsp?nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return ;
}
int node = Integer.parseInt(teasession.getParameter("node"));
int id=Integer.parseInt(teasession.getParameter("destine"));
int roomPriceId=Integer.parseInt(teasession.getParameter("roomprice"));
RoomPrice roomPrice=RoomPrice.find(roomPriceId);
Destine destine =Destine.find(id);

Node obj = Node.find(teasession._nNode);
Hostel hostel = Hostel.find(obj._nNode,teasession._nLanguage);
java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyy-MM-dd");
     java.util.Date date1=formatter.parse(destine.getKipdateToString());
     java.util.Date date2=formatter.parse(destine.getLeavedateToString());
     long l = date2.getTime() - date1.getTime();
     long d = l/(24*60*60*1000);

%>
<html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>
<link href="/res/<%=obj.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<h1>订单资料</h1>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <TD>订 单 号：</TD>
    <td><font color="#DF451C"><strong><%=id%></strong></font></td>
  </tr>
  <tr>
    <TD>入住客人：</TD>
    <td><%=destine.getHumanname(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <TD>住宿日期：</TD>
    <td><%=(destine.getKipdateToString())%> 至 <%=(destine.getLeavedateToString())%>  　共&nbsp;<%=d%>&nbsp;晚</td>
  </tr>
  <tr>
    <TD>酒店名称：</TD>
    <td><%=obj.getSubject(teasession._nLanguage)%></td>
  </tr>
  <tr>
    <TD>房间类型：</TD>
   <td><%if(roomPriceId == -1){out.print("无");}else{if(roomPrice.getRoomtype(teasession._nLanguage)!=null){out.print(roomPrice.getRoomtype(teasession._nLanguage));}else{out.print(hostel.getHousexing());}}%></td>
  </tr>
  <tr>
    <TD>房间数量：</TD>
    <td><%=destine.getRoomcount()%>&nbsp;间 </td>
  </tr>
 <tr>
    <TD>付款方式：</TD>
    <td><%=RoomPrice.PAYMENT[destine.getPaymenttype()]%> </td>
  </tr>
  <tr>
    <TD>抵店时间：</TD>
    <td><%=destine.getEveningarrive()%></td>
  </tr>
  <tr>
    <TD>单 &nbsp; &nbsp;价：</TD>
    <td>
      <%if(roomPrice.getRoomtype(teasession._nLanguage)!=null){out.print(roomPrice.getPrice(destine.getPaymenttype()));}else{out.print(hostel.getPrice());}%>&nbsp;元</td>

  </tr>
  <tr>
    <TD>总 &nbsp; &nbsp;价：</TD>
    <td>
      <%=roomPrice.getPrice(destine.getPaymenttype())*destine.getRoomcount()*d%>&nbsp;元</td>

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

<center>
<input type=button value="返回" onClick="javascript:history.back()">
</center>
<div id="head6"><img height="6" src="about:blank" alt=""></div>
</body>
</html>
