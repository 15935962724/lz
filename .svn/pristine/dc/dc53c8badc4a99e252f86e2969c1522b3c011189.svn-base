<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.member.*" %>
<%@page import="tea.ui.*"%>
<%@ page import="tea.entity.node.*" %>
<%@page import="tea.*"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
String node = teasession.getParameter("node");
String roomc = teasession.getParameter("roomc");
String roomp = teasession.getParameter("roomp");
String sdate = teasession.getParameter("sdate");
String edate = teasession.getParameter("edate");
java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyy-MM-dd");
     java.util.Date date1=formatter.parse(sdate);
     java.util.Date date2=formatter.parse(edate);
     long l = date2.getTime() - date1.getTime();
     long d = l/(24*60*60*1000);

Hostel hostel = Hostel.find(Integer.parseInt(node), 1);
RoomPrice roomPrice = RoomPrice.find(Integer.parseInt(roomp));
%>
<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
    <script src="/tea/tea.js" type="text/javascript"></script>
    <script language="javascript" src="/tea/CssJs/AreaCityData_zh_CN.js" type=""></script>
    <script language="javascript" src="/tea/CssJs/AreaCityData<%=Common.CHATSET[teasession._nLanguage]%>.js" type=""></script>

<title>
SelResult
</title>
</head>
<body bgcolor="#ffffff" id="bodynone" class="register">
<h1>查询结果</h1>
<table id="tablecenter">

<tr>

  <td align="center">房间类型：<%if(roomp.equals("0")){out.print(hostel.getHousexing());}else{out.print(roomPrice.getRoomtype(teasession._nLanguage));}%>
    <br />住店日期:&nbsp;<%=sdate%>&nbsp;&nbsp;离开日期:&nbsp;<%=edate%>　　　共&nbsp;<b><%=d%></b>&nbsp;晚
    <br />预定&nbsp;<b><%=roomc%></b>&nbsp;间
    <br />单价：<%if(roomp.equals("0")){out.print(hostel.getPrice());}else{out.print(roomPrice.getProscenium());}%>&nbsp;元
    <br />合计：<%if(roomp.equals("0")){out.print(Integer.parseInt(hostel.getPrice())*Integer.parseInt(roomc)*d);}else{out.print(roomPrice.getProscenium()*Integer.parseInt(roomc)*d);}%>&nbsp;元</td>
</tr>
</table>
<center>
<input align="middle" type="button" value="关闭" onclick="javascript:window.close();" />
</center>
</body>
</html>
