<%@page contentType="text/html;charset=UTF-8"%>
<%
  tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
  tea.entity.node.Node node = tea.entity.node.Node.find(teasession._nNode);
  %>

  <table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr>
    <td>产品名称</td>
    <td>功能描述</td>
    <td>朋友链</td>
  </tr>
  <%
java.util.Enumeration enumer = tea.entity.node.Sale.find(node.getCommunity(), teasession._rv!=null?
teasession._rv._strR:null);
while (enumer.hasMoreElements())
{
    int node_code=((Integer) enumer.nextElement()).intValue();
    tea.entity.node.Sale sale_obj=tea.entity.node.Sale.find(node_code, teasession._nLanguage);
    tea.entity.node.Node node_obj=tea.entity.node.Node.find(node_code);
     %>
    <tr>
    <td><%=node_obj.getSubject(teasession._nLanguage)%></td>
    <td><%=sale_obj.getCapability()%></td>
    <td>
      <%
       if(teasession._rv!=null)
       {
         java.util.Enumeration
like_enumer=tea.entity.member.FriendList.getLink(teasession._rv._strR,node_obj.getCreator()._strR);
         while(like_enumer.hasMoreElements())
         {
           tea.entity.member.FriendList fl_obj=
tea.entity.member.FriendList.find(((Integer)like_enumer.nextElement()).intValue());
           %>
           <%=fl_obj.getMember()%>→<%=fl_obj.getMember2()%>→<%=node_obj.getCreator()._strR%>
           <%
         }
       }
    %></td></tr>
<%
}
%>
</table>

