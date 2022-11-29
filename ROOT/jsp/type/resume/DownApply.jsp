<script>
<%
String node[]=request.getParameterValues("Node");
for(int index=0;index<node.length;index++)
{
int app=Integer.parseInt(request.getParameter("jobcheckbox"+node[index]));
JobApply apply=tea.entity.member.Apply.find(app,Integer.parseInt(node[index]));
if(new java.io.File(application.getRealPath("/tea/app/at"+apply.getApplyTable()+".doc")).exists())
{
  %>
  window.open('/tea/app/at<%=apply.getApplyTable()%>.doc');
  <%
}
}
%>
window.close();
</script>

