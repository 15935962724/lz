<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.*" %>
<%@page import="java.text.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="java.util.*"%>
<%

request.setCharacterEncoding("UTF-8");

String referer=request.getHeader("referer");
if(referer==null)
{
  response.sendError(404,request.getRequestURI());
  return;
}

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  //response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  //return;
}
Resource r=new Resource();
String ip=request.getParameter("ip");
String host=request.getParameter("host");
String context=request.getParameter("context");

DecimalFormat df=new DecimalFormat("#,##0");
Date time=new Date();
int day=Integer.parseInt( new SimpleDateFormat("dd").format(time));


Enumeration e=Community.find("",0,Integer.MAX_VALUE); //Communityinfo.findByHost(host,0,Integer.MAX_VALUE);
while(e.hasMoreElements())
{
  String community=(String)e.nextElement();
  Community obj=Community.find(community);
  if(obj.getNode()>0)
  {

  }

%>



