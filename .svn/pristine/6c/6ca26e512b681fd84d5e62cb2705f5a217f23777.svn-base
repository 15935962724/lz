<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
r.add("/tea/ui/member/order/SaleOrders").add("/tea/ui/member/order/PurchaseOrders").add("/tea/ui/member/order/TradeServlet");

String s2 =  request.getParameter("pos");
int pos = s2 == null ? 0 : Integer.parseInt(s2);
String community=teasession.getParameter("community");
if(community==null)
community=node.getCommunity();
String vcustomer=teasession.getParameter("vcustomer");
String vvendor=teasession.getParameter("vvendor");
String status=teasession.getParameter("tstatus");
String to=teasession.getParameter("to");
String from=teasession.getParameter("from");
String trade_id=teasession.getParameter("trade");
String order;
if(teasession.getParameter("order")==null)
{
  order=" ORDER BY t.time DESC";
}else
{
    order=" ORDER BY "+teasession.getParameter("order")+" "+teasession.getParameter("ordertype");
}
StringBuffer where=new StringBuffer();
StringBuffer param=new StringBuffer("?community="+community+"&node="+teasession._nNode);
if(trade_id!=null&&trade_id.length()>0)
{
  where.append(" AND t.trade = "+(trade_id));
  param.append("&trade="+trade_id);
}else
{
  if(vcustomer!=null&&vcustomer.length()>0)
  {
    where.append(" AND t.vcustomer LIKE "+tea.db.DbAdapter.cite("%"+vcustomer+"%"));
    param.append("&vcustomer="+vcustomer);
  }
  if(vvendor!=null&&vvendor.length()>0)
  {
    where.append(" AND t.vvendor LIKE "+tea.db.DbAdapter.cite("%"+vvendor+"%"));
    param.append("&vvendor="+vvendor);
  }
  if(status!=null&&status.length()>0)
  {
    where.append(" AND t.status = "+status);
    param.append("&tstatus="+status);
  }
  if(to!=null&&to.length()>0)
  {
    where.append(" AND t.time < "+tea.db.DbAdapter.cite(to));
    param.append("&to="+to);
  }
  if(from!=null&&from.length()>0)
  {
    where.append(" AND t.time >= "+tea.db.DbAdapter.cite(from));
    param.append("&from="+from);
  }
}

String menu_id=teasession.getParameter("id");
if(menu_id!=null&&menu_id.length()>0)
{
  param.append("&id="+menu_id);
}
java.util.Enumeration enumer=tea.entity.member.Trade.findAll(where.toString()+order,pos,25);
int sum=tea.entity.member.Trade.countAll(where.toString());
%>
<html>
<head>
<link href="/res/<%=community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js">
</SCRIPT>
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
<h1><%=r.getString(teasession._nLanguage, "Trade")%>(<%=sum%>)</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<form name="form1" action="" method="POST">
<input type="hidden" name="order" value="time">
<input type="hidden" name="ordertype" value="DESC">
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
   <tr>
   <td>
   订单号<input type="text" name="trade" >
 <td>时间
      <input name="from" type="text" readonly="readonly" value="<%%>" size="10"><input type="button" onClick="ShowCalendar('form1.from')" value="...">
    --
    <input name="to" type="text" readonly="readonly" value="<%%>" size="10"><input type="button"  onclick="ShowCalendar('form1.to')"  value="..."></td>
    <td>
   状态<select name="tstatus" >
   <option value="">-----------
   <%
   for(int index=0;index<tea.entity.member.Trade.TRADE_STATUS.length;index++)
   {
     out.println("<option value="+index+">"+r.getString(teasession._nLanguage,tea.entity.member.Trade.TRADE_STATUS[index]));
   }
   %>
   </select>
   购买者<input type="text" name="vcustomer" >
   销售者<input type="text" name="vvendor" >
   <input type=submit value="GO">
   </td>
   </tr>
   </table>
   </form>
   <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<form name="form2" action="" method="POST" onSubmit="alert('abc');">
<input type="hidden" name="order" value="time">
<input type="hidden" name="ordertype" value="DESC">
  <tr>
  <td><A href="#" onClick="form2.order.value='trade';form2.submit();" >订单号</A></td>
  <td><A href="#" onClick="form2.order.value='status';form2.submit();" >状态</A></td>
  <td><A href="#" onClick="form2.order.value='time';form2.submit();" >时间</A></td>
  <td><A href="#" onClick="form2.order.value='vcustomer';form2.submit();" >购买者</A></td>
  <td><A href="#" onClick="form2.order.value='vvendor';form2.submit();" >销售者</A></td>
  </tr>
   </form>
   <%
while(enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  tea.entity.member.Trade trade=  tea.entity.member.Trade.find(id);
  %>
  <tr><td><A href="/jsp/order/FinishedTrade.jsp?Trade=<%=id%>" >#<%=id%></A></td>
  <td><%=r.getString(teasession._nLanguage,tea.entity.member.Trade.TRADE_STATUS[trade.getStatus()])%></td>
    <td><%=trade.getTimeToString()%></td>
        <td><%=trade.getCustomer()%></td>
        <td><%=trade.getVendor()%></td>
  </tr>
  <%
}
   %>
   </table>
   <%=new tea.htmlx.FPNL(teasession._nLanguage,request.getRequestURI()+param.toString()+"&pos=",pos,sum)%>
  <div id="head6"><img height="6" src="about:blank"></div>
  <div id="language"><%=new Languages(teasession._nLanguage, request)%></div>
</body>
</html>

