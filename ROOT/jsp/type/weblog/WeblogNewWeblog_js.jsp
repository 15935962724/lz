<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String member=node.getCreator()._strV;
tea.entity.node.Blog blog = tea.entity.node.Blog.find(node.getCommunity(), member);

tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
try
{
dbadapter.executeQuery("SELECT TOP 10 node FROM Node WHERE type=82 AND community="+dbadapter.cite(node.getCommunity())+" AND path LIKE "+dbadapter.cite("%/"+blog.getHome()+"/%")+" ORDER BY time DESC");
while(dbadapter.next())
{
   node=tea.entity.node.Node.find(dbadapter.getInt(1));
   String subject=node.getSubject(teasession._nLanguage);
   if(subject.length()>10)
   {
     subject=subject.substring(0,10)+"...";
   }
%>
document.write("<li id=blogbiaoti>·<Span ID=WeblogIDgetSubject><A HREF=/servlet/Weblog?node=<%=node._nNode%>><%=subject%></A></span></li>");
<%}
}catch(Exception e)
{}finally
{dbadapter.close();}%>

