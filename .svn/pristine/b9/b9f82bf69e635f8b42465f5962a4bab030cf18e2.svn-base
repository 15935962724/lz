<%@page contentType="text/html; charset=UTF-8"%><%
response.setHeader("Expires", "0");
request.setCharacterEncoding("UTF-8");

if(request.getParameter("f")!=null)
{
  String url=request.getRequestURI()+"?"+request.getQueryString().replaceFirst("&f=","&");
  out.print("<script>window.opener=null; window.close(); window.open(\""+url+"\",'','width=0px,height=0px,top=90000px,left=90000px');</script>");
  return;
}
//if(request.getParameter("t")==null)
//{
//  response.sendRedirect(request.getRequestURI()+"?"+request.getQueryString()+"&t="+System.currentTimeMillis());
//  return;
//}

String uri=request.getParameter("uri");
if(!uri.startsWith("/res/")||uri.contains(".."))
{
  response.sendError(404,uri);
  return;
}
String name=request.getParameter("name");
if(name==null)name=uri.substring(uri.lastIndexOf('/')+1);
name=name.replace(':','：');

//java.net.URLEncoder.encode(name,"UTF-8")
//application/octet-stream
response.setHeader("Content-Disposition","attachment; filename="+new String(name.getBytes("GBK"),"ISO-8859-1"));

%><jsp:forward page="<%=uri%>"/>
