<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%
String name=request.getParameter("index");
java.util.Enumeration enumeration = tea.entity.node.Node.findByType(45, Node.find(teasession._nNode).getCommunity());
int nodecode;
while (enumeration.hasMoreElements())
{
  nodecode = ((Integer) enumeration.nextElement()).intValue();
  Node node = Node.find(nodecode);
%>
<A href="#" onclick="fclick('<%=nodecode%>')" ><%=nodecode%> <%=node.getSubject(teasession._nLanguage)%></A><br>
<%}%>
<script>
var parent_window = window.dialogArguments;
function fclick(theDate)
{
   parent_window.<%=name%>.value=theDate;
   window.close();
}
</script>

