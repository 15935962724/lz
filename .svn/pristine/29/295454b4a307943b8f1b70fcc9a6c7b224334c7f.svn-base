<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String member=node.getCreator()._strV;
//tea.entity.node.Blog blog = tea.entity.node.Blog.find(node.getCommunity(), member);
tea.entity.member.BLOGProfile bp=tea.entity.member.BLOGProfile.find(member);
//node=tea.entity.node.Node.find(blog.getHome());

    String url=request.getServerName();
    String urls[]= url.split("\\.");
    url=member;
    for(int index=1;index<urls.length;index++)
    {
      url+="."+urls[index];
    }
    if(request.getServerPort()!=80)
    {
      url+=":"+request.getServerPort();
    }
%>
document.write('<A href="http://<%=url%>"><%=bp.getNickname(teasession._nLanguage)%>的博客</A>');

