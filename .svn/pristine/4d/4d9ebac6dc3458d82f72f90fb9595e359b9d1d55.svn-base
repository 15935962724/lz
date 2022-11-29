<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/TradeServlet");
String from=getNull(request.getParameter("from"));
String to=getNull(request.getParameter("to"));
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
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
<h1><%=r.getString(teasession._nLanguage, "PurchaseTradeList")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <form name="form1" method="get" action="">
  <tr>
     <td>FROM</td>
    <td>
      <input name="from" type="text" readonly="readonly" value="<%=from%>" size="10"><input type="button" onclick="ShowCalendar('form1.from')" value="...">
</td>
    <td>TO</td>
    <td><input name="to" type="text" readonly="readonly" value="<%=to%>" size="10"><input type="button"  onclick="ShowCalendar('form1.to')"  value="..."></td>
    <td><input type="submit" name="Submit" value="GO"></td>
  </tr></form>
  <tr>
    <td>订单</td>
    <td>合计</td>
</tr>
  <%
  tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
           try
           {
               StringBuffer sql=new StringBuffer();
               sql.append(" AND rcustomer = "+dbadapter.cite(teasession._rv._strR));
               if(from.length()>0)
                   sql.append(" AND come>="+dbadapter.cite(from));
               if(to.length()>0)
                   sql.append(" AND come<"+dbadapter.cite(to));
//System.out.println("SELECT waiter,COUNT(waiter),SUM(gathering) FROM Salesmanship,Trade WHERE Salesmanship.trade=Trade.trade AND status=7" +sql.toString()+" GROUP BY waiter");
java.math.BigDecimal sum=new java.math.BigDecimal(0d);
               dbadapter.executeQuery("SELECT trade,gathering FROM Trade WHERE  rcustomer=vcustomer AND status=7" +sql.toString());
               while (dbadapter.next())
               {
                 int trade=dbadapter.getInt(1);
                 java.math.BigDecimal sum_sub=   dbadapter.getBigDecimal(2,4);
                 if(sum_sub!=null)
                 sum=sum.add(sum_sub);
                 %>
  <tr>
    <td><a href="/jsp/order/FinishedTrade.jsp?Trade=<%=trade%>">#<%=trade%></a></td>
    <td><%=sum_sub%></td>
  </tr>
<%             }%>
<tr><td>总计:<%=sum%></td></tr>
<%
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

