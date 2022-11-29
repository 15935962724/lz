<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession  teasession=new tea.ui.TeaSession(request);
if(teasession._rv!=null)
{
  tea.entity.site.Communitybbs community=  tea.entity.site.Communitybbs.find(teasession._strCommunity);
  boolean _bCommunityManage=teasession._rv._strR.equals(community.getSuperhost());
  tea.entity.admin.AdminUsrRole obj=tea.entity.admin.AdminUsrRole.find(teasession._rv._strR,teasession._strCommunity);
// 如果( 后台会员||网站管理员||后台有个"会员默认角色"|| 选定角色)
  if(obj.getBbsHost().length()>1||tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv._strR)|| _bCommunityManage)
  {%>
    <input id="accessbutton" type="button" value="" onclick="window.location='/jsp/admin/Frame.jsp?node=<%=teasession._nNode%>'">
  <%}
}
%>

