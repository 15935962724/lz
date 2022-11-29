<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="tea.ui.*" %><%
request.setCharacterEncoding("UTF-8");

RV rv=new TeaSession(request)._rv;
if(rv!=null)
{
  String url=request.getServerName();
  String urls[]= url.split("\\.");
  url=rv._strV;
  for(int index=1;index<urls.length;index++)
  {
    url+="."+urls[index];
  }
  if(request.getServerPort()!=80)
  {
    url+=":"+request.getServerPort();
  }

  response.sendRedirect("http://"+url);
}
%>

