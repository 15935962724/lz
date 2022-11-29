<%@page contentType="text/html;charset=UTF-8"  %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
if(teasession._rv!=null)
{
  String community=tea.entity.node.Node.find(teasession._nNode).getCommunity();
  if(teasession._rv.isOrganizer(community))
  {
    out.print("<input type=submit name=Submit value=管理会员 class=in onclick=window.open('/jsp/type/score/ScoreManages.jsp','_self')>");//new tea.html.Button("class=in","管理会员","window.open('/jsp/type/score/ScoreManages.jsp','_self')"));
  }
}
%>

