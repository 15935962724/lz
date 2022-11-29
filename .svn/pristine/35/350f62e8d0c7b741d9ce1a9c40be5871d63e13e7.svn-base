<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.node.*" %>
<%
TeaSession teasession = new TeaSession(request);
String  City = request.getParameter("city");
String Star = request.getParameter("hostelstar");
int starclass = Integer.parseInt(Star);
String hostelname = request.getParameter("hostelname");
String type = request.getParameter("type");
String order = request.getParameter("order");
String order_t="";
if(order.equals("1"))
{
  order_t="ASC";
}
else if(order.equals("2"))
{
  order_t="DESC";
}
Hostel hostel = new Hostel(teasession._nNode, teasession._nLanguage);
//这里有错误！不是固定传入一个 1 而是传入酒店的 id ，但是我调用错了。
java.util.Enumeration e = hostel.getallByTJ(type,order_t,City,starclass,1);
%>
<html>
 <head></head>
<body>
<form action="" name="form1" id="bodynone">
<table>
<tr>
<td></td>
<td></td>
<td></td>
</tr>
<%
while(e.hasMoreElements())
{
Hostel obj = (Hostel)e.nextElement();
Node node = new Node(teasession._nLanguage);
%>
<tr>
  <td><%=obj.getCity() %></td>
  <td><%=node.getSubject(teasession._nLanguage) %></td>
  <td><%=obj.getStarClass() %></td>
</tr>
<%
}
%>
</table>
</form>
</body>
</html>
