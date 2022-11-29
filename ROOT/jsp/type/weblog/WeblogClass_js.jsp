<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String member=node.getCreator()._strV;
tea.entity.node.Blog blog = tea.entity.node.Blog.find(node.getCommunity(), member);

java.util.Enumeration enumer=tea.entity.node.Node.findAllSons(blog.getHome());

while(enumer.hasMoreElements())
{
   node=tea.entity.node.Node.find(((Integer)enumer.nextElement()).intValue());
%>
document.write("<li id=blogbiaoti>·<Span ID=NodeTitle><A HREF='/servlet/Category?node=<%=node._nNode%>'><%=node.getSubject(teasession._nLanguage)%></A></span></li>");
<%}%>

