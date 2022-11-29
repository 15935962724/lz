<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

Http h=new Http(request);

int flow=h.getInt("flow");
int flowbusiness=h.getInt("flowbusiness");

Flow f=Flow.find(flow);
if(flowbusiness<1)
{
  flowbusiness=Flowbusiness.create(teasession._strCommunity,flow,teasession._rv._strR);
}

response.sendRedirect("/jsp/admin/cec/Flowbusiness_"+f.getDynamic()+".jsp?flowbusiness="+flowbusiness+"&"+request.getQueryString());

%>
