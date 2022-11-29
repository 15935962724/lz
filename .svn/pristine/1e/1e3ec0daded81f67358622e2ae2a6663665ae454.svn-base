<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
String member=getNull(request.getParameter("member"));
String from=getNull(request.getParameter("from"));
String to=getNull(request.getParameter("to"));
r.add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/TradeServlet");
%>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script type="">
function ShowCalendar(fieldname)
{
  eval(fieldname).value='';
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "PurchaseMemberList")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <form name="form1" method="get" action="">
  <tr>
    <td>会员</td>
    <td><input  name="member" value="<%=member%>"></td>
    <td>FROM</td>
    <td><input name="from" type="text" readonly="readonly" value="<%=from%>" size="10"><input type="button" onclick="ShowCalendar('form1.from')" value="...">
</td>
    <td>TO</td>
    <td><input name="to" type="text" readonly="readonly" value="<%=to%>" size="10"><input type="button"  onclick="ShowCalendar('form1.to')"  value="..."></td>
    <td><input type="submit" name="Submit" value="GO"></td>
  </tr></form>
  <tr><td>会员</td>
    <td>次数</td>
    <td>合计</td>
</tr>
  <%
  tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
           try
           {
               StringBuffer sql=new StringBuffer();
               if(member.length()>0)
                   sql.append(" AND rcustomer like "+dbadapter.cite("%"+member+"%"));
               if(from.length()>0)
                   sql.append(" AND come>="+dbadapter.cite(from));
               if(to.length()>0)
                   sql.append(" AND come<"+dbadapter.cite(to));
               dbadapter.executeQuery("SELECT rcustomer,COUNT(trade),SUM(gathering) FROM Trade WHERE status=7  AND rcustomer=vcustomer" +sql.toString()+" GROUP BY rcustomer");
               while (dbadapter.next())
               {
                 %>
  <tr>
    <td><%=dbadapter.getString(1)%></td>
    <td><A href="/jsp/order/BgPurchaseTradeList.jsp?member=<%=member%>&from=<%=from%>&to=<%=to%>"><%=dbadapter.getInt(2)%></A></td>
    <td><%=dbadapter.getBigDecimal(3,4)%></td>
  </tr>
<%             }
           } catch (Exception exception)
           {
               exception.printStackTrace();
           } finally
           {
               dbadapter.close();
           }
  %>
</table>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</html>

