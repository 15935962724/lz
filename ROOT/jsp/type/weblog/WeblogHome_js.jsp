<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);

tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
String member=node.getCreator()._strV;
//tea.entity.node.Blog blog = tea.entity.node.Blog.find(node.getCommunity(), member);
//tea.entity.member.BLOGProfile bp=tea.entity.member.BLOGProfile.find(member);

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
document.write("<a href=http://<%=url%>>http://<%=url%></a>　﹥<a href=\"javascript:;\" onclick=\"clipboardData.setData('Text','<%=url%>');window.alert('　　已经把该BLOG网址复制到系统剪贴板，您可以使用（Ctrl+V或鼠标右键）粘贴功能，通过其他软件记录或发送给您的朋友。');\">复制</a>　﹥<a href=\"javascript:;\" onclick=\"window.external.addFavorite(document.location,window.document.title);return false;\">收藏本页</a>");

