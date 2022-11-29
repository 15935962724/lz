<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>
<%
tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String nexturl=request.getParameter("nexturl");
if(nexturl!=null)
{
  node.delete(1);
  response.sendRedirect(nexturl);
  return ;
}

%>
<table width="200" border="0">
  <tr>
    <td nowrap>标题</td>
    <td nowrap>媒体名称</td>
    <td nowrap>发生时间</td>
    <td nowrap>&nbsp;</td>
  </tr>
  <%
  tea.db.DbAdapter dbadapter=new  tea.db.DbAdapter();
  tea.db.DbAdapter dbadapter2=new  tea.db.DbAdapter();
  try
  {
    nexturl=request.getRequestURI()+"?"+request.getQueryString();
    dbadapter.executeQuery("SELECT NodeLayer.subject,Report.media_id,Node.node FROM Node,NodeLayer,Report WHERE NodeLayer.node=Node.node AND Node.type=39 AND Report.node=Node.node AND NodeLayer.language=1 AND Node.path like '%/"+teasession._nNode+"/%' ORDER BY NodeLayer.subject");
    while(dbadapter.next())
    {
      int media_id=dbadapter.getInt(2);
      if( dbadapter2.getInt("SELECT COUNT(NodeLayer.node) FROM Node,NodeLayer,Report WHERE NodeLayer.node=Node.node AND Report.node=NodeLayer.node AND NodeLayer.subject="+dbadapter.cite(dbadapter.getString(1))+" AND NodeLayer.language=1 AND Node.path like '%/"+teasession._nNode+"/%' AND Report.media_id="+media_id)>1)
      {
        int node_id=dbadapter.getInt(3);
        tea.entity.node.Node node_obj=tea.entity.node.Node.find(node_id);
        tea.entity.node.Report report_obj=tea.entity.node.Report.find(node_id);
        tea.entity.node.Media media_obj= tea.entity.node.Media.find(media_id);
        %>
        <tr>
          <td nowrap><a href="/servlet/Node?node=<%=node_id%>" target="_blank"><%=node_obj.getSubject(1)%></A></td>
          <td nowrap><%=media_obj.getName()%><%//=media_obj.getName(1)%></td>
          <td nowrap><%=report_obj.getIssueTime()%></td>
          <td nowrap><!--input type="submit" name="Submit" onClick="if(confirm('确认删除')){window.location='/servlet/DeleteNode?node=<%=node_id%>&nexturl=<%=nexturl%>';}" value="DELETE"--></td>
        </tr><%
        }
      }
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      dbadapter.close();dbadapter2.close();
    }
%>
</table>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</DIV>
</body>
</html>

