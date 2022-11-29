<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
int waiter=0;
if(request.getParameter("waiter")!=null)
waiter=Integer.parseInt(request.getParameter("waiter"));
String from=getNull(request.getParameter("from"));
String to=getNull(request.getParameter("to"));
%>
<script type="">
function ShowCalendar(fieldname)
{
  eval(fieldname).value='';
  myleft=document.body.scrollLeft+event.clientX-event.offsetX-80;
  mytop=document.body.scrollTop+event.clientY-event.offsetY+140;
  window.showModalDialog("/jsp/include/Calendar.jsp?FIELDNAME="+fieldname,self,"edge:raised;scroll:0;status:0;help:0;resizable:1;dialogWidth:280px;dialogHeight:205px;dialogTop:"+mytop+"px;dialogLeft:"+myleft+"px");
}
</script>
</head><body>
<table border="1"><form name="form1" method="get" action="">
  <tr>
    <td>作业员</td>
    <td>
      <select name="waiter"><option value="0">-------请选择------</option>
        <%
java.util.Enumeration enumer=tea.entity.node.Waiter.find(node.getCommunity());
while(enumer.hasMoreElements())
{
  tea.entity.node.Waiter waiter_obj=  tea.entity.node.Waiter.find(((Integer)enumer.nextElement()).intValue(),teasession._nLanguage);
  out.print("<option value="+waiter_obj.getNode());
  if(waiter==waiter_obj.getNode())
  out.print(" SELECTED ");
  out.print(">"+waiter_obj.getCode());
}
        %>
    </select></td>
    <td>FROM</td>
    <td>
      <input name="from" type="text" readonly="readonly" value="<%=from%>" size="10"><input type="button" onclick="ShowCalendar('form1.from')" value="...">
</td>
    <td>TO</td>
    <td><input name="to" type="text" readonly="readonly" value="<%=to%>" size="10"><input type="button"  onclick="ShowCalendar('form1.to')"  value="..."></td>
    <td><input type="submit" name="Submit" value="GO"></td>
  </tr></form>
  <tr><td>作业员</td>
    <td>订单</td>
    <td>合计</td>
</tr>
  <%
  tea.db.DbAdapter dbadapter = new tea.db.DbAdapter();
           try
           {
               StringBuffer sql=new StringBuffer();
               if(waiter!=0)
                   sql.append(" AND waiter="+waiter);
               if(from.length()>0)
                   sql.append(" AND come>="+dbadapter.cite(from));
               if(to.length()>0)
                   sql.append(" AND come<"+dbadapter.cite(to));
                   java.math.BigDecimal sum=new java.math.BigDecimal(0d);
               dbadapter.executeQuery("SELECT waiter,Trade.trade,gathering FROM Salesmanship,Trade WHERE Salesmanship.trade=Trade.trade AND status=7" +sql.toString());
               while (dbadapter.next())
               {
tea.entity.node.Waiter obj=tea.entity.node.Waiter.find(dbadapter.getInt(1),teasession._nLanguage);
int trade=dbadapter.getInt(2);
 java.math.BigDecimal sum_sub=   dbadapter.getBigDecimal(3,4);
 if(sum_sub!=null)
 sum=sum.add(sum_sub);
                 %>
  <tr>
    <td><%=obj.getCode()%></td>
    <td><A href="/jsp/order/FinishedTrade.jsp?Trade=<%=trade%>">#<%=trade%></A></td>
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

