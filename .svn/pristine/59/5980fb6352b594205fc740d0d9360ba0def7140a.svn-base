<%@page contentType="text/html;charset=UTF-8"  %><%@page import="tea.entity.admin.ig.*" %><%@page import="tea.ui.*" %>
<%@page import="java.util.*"%><% request.setCharacterEncoding("UTF-8");

TeaSession teasession = new TeaSession(request);
teasession._rv=new tea.entity.RV("webmaster","Home");
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
  return;
}
System.out.println("-----------feeds.jsp");
Enumeration e=request.getParameterNames();
while(e.hasMoreElements())
{
	String name=(String)e.nextElement();
	String value=request.getParameter(name);
	System.out.println(name+":"+value);
}

/*
String at=request.getParameter("at");
String ct=request.getParameter("ct");
String dt=request.getParameter("dt");

if(at!=null)// 添加标签
{
  int igtab=Igtab.create(teasession._strCommunity,teasession._rv._strV,"为此标签命名");
  response.sendRedirect("/jsp/admin/DynamicDesktop.jsp?igtab="+igtab);
}else
if(ct!=null)// 切换标签
{
  response.sendRedirect("/jsp/admin/DynamicDesktop.jsp?igtab="+ct);
}else
if(dt!=null)// 删除标签
{
  Igtab obj=Igtab.find(Integer.parseInt(dt));
  obj.delete();
  response.sendRedirect("/jsp/admin/DynamicDesktop.jsp?igtab="+dt);
}
*/


%>



