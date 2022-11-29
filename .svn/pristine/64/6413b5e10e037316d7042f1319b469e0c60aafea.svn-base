<%@page contentType="text/html;charset=UTF-8"  %>
<%@include file="/jsp/Header.jsp"%>

<%
 if (!teasession._rv.toString().equalsIgnoreCase(tea.entity.site.Communityjob.find(teasession._strCommunity).getJobmember()) && !License.getInstance().getWebMaster().equals(teasession._rv._strR)) {
    ts.outText(response, 1, "你没有权限,访问本页.");
    return;
  }
DbAdapter dbadapter=new DbAdapter();
dbadapter.executeUpdate("delete FROM Purview WHERE username="+dbadapter.cite(request.getParameter("member")));
dbadapter.executeUpdate("delete FROM Profile WHERE member="+dbadapter.cite(request.getParameter("member")));
dbadapter.executeUpdate("DELETE FROM ProfileLayer  WHERE member="+dbadapter.cite(request.getParameter("member")));
dbadapter.close();
response.sendRedirect("/jsp/community/yjobsubscribers.jsp?Community=cnoocjob&Pos=0");
%>


