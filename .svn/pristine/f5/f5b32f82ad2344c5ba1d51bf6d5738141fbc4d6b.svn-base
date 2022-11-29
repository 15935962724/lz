<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.entity.node.*"%><%

Http h=new Http(request,response);


Node n=Node.find(h.node);
n=Node.find(n.getFather());
%>


<table id="tablecenter" cellspacing="0">
  <tr>
    <td>内容</td>
    <td><%=n.getText(h.language)%></td>
  </tr>
</table>
