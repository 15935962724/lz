<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String member=node.getCreator()._strV;
tea.entity.node.Blog blog = tea.entity.node.Blog.find(node.getCommunity(), member);
//tea.entity.member.BLOGProfile bp=tea.entity.member.BLOGProfile.find(member);

node=tea.entity.node.Node.find(blog.getHome());
%>
document.write('<%=node.getSubject(teasession._nLanguage)%>');

