<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
  return;
}
tea.entity.site.Communityjob obj=tea.entity.site.Communityjob.find(teasession._strCommunity);


%>

<%-- <input class="in" id=manageaccess type="button" value="问题反馈" onclick="window.open('/servlet/Talkbacks?node=<%//=obj.getTalkbacksNode()%>','_self')" /> --%>

<%
//tea.entity.node.Node node=tea.entity.node.Node.find(teasession._nNode);
tea.entity.node.Purview purview=tea.entity.node.Purview.find(teasession._rv.toString(),teasession._strCommunity);
if(purview.isJob()||purview.isResume()||purview.isApply()||purview.isCompany()||tea.entity.site.License.getInstance().getWebMaster().equals(teasession._rv.toString()))
{
    %><style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px; 
}
-->
</style>
   <input class="in" id=manageaccess type="button" value="管理入口" onclick="window.open('/servlet/Node?node=<%=teasession._nNode%>','_self')" />
<%
}
%>

