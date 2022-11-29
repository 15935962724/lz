<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.util.*"%>
<%@ page import="tea.resource.*"%>
<%
Resource r = new Resource();
TeaSession teasession = new TeaSession(request);
r.add("/tea/resource/Hostel");

%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><%=r.getString(teasession._nLanguage, "RoomType")%></td>
    <td><%=r.getString(teasession._nLanguage, "Retail")%></td>
    <td><%=r.getString(teasession._nLanguage, "Proscenium")%></td>
    <td><%=r.getString(teasession._nLanguage, "Net")%></td>
    <td><%=r.getString(teasession._nLanguage, "Weekend")%></td>
    <td><%=r.getString(teasession._nLanguage, "Breakfast")%></td>
    <td><%=r.getString(teasession._nLanguage, "Remark")%></td>
    <td></td>
  </tr>
<%

java.util.Enumeration enumer=RoomPrice.findByNode(teasession._nNode);
while (enumer.hasMoreElements())
{
  int id=((Integer)enumer.nextElement()).intValue();
  RoomPrice obj=  RoomPrice.find(id);
%>
  <tr>
    <td><%=obj.getRoomtype(teasession._nLanguage)%></td>
    <td><%=obj.getRetail()%></td>
    <td><%=obj.getProscenium()%></td>
    <td><%=obj.getNet()%></td>
    <td><%=obj.getWeekend()%></td>
    <td><%=obj.getBreakfast(teasession._nLanguage)%></td>
	<td><%=obj.getRemark(teasession._nLanguage)%></td>
<td><input  value="<%=r.getString(teasession._nLanguage, "Destine")%>" type="button" onClick="window.open('/jsp/type/hostel/EditDestine.jsp?node=<%=teasession._nNode%>&roomprice=<%=id%>')">
    </td>
  </tr>
<%
}

%>
</table>

