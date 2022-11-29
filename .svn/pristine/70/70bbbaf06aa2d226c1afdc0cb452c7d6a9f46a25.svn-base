<%@page contentType="text/html;charset=UTF-8" %>
<%
tea.ui.TeaSession teasession=new tea.ui.TeaSession(request);
tea.entity.node.Download obj = tea.entity.node.Download.find(teasession._nNode,teasession._nLanguage);
String url=obj.getUrl(Integer.parseInt(request.getParameter("id")));
if(url==null)
{
  response.sendRedirect("/jsp/info/Alert.jsp?info=很抱歉！来这个页面的原因可能是因为非法访问."+teasession._nNode);
  return;
}
if(url.startsWith("/tea/download/"))
{
//  url=java.net.URLEncoder.encode(url,"GB2312").replaceAll("%2F","/");
  response.setContentType("application/octet-stream");
  response.setHeader("Content-disposition", "attachment; filename="+url);
  java.io.File file = new java.io.File(getServletContext().getRealPath(url));
  byte by[] = new byte[(int) file.length()];
  java.io.FileInputStream is = new java.io.FileInputStream(file);
  is.read(by);
  is.close();
  response.setContentLength(by.length);
  javax.servlet.ServletOutputStream out1=response.getOutputStream();
  out1.write(by);
  out1.close();
//url=java.net.URLEncoder .encode(url,"gb2312").replaceAll("%2F","/");
  //url=new String(url.getBytes("gb2312"),"ISO-8859-1");
//  out.print(new tea.html.Script("window.location='"+url+"';"));
 return;
}
//out.print(new tea.html.Script("window.location='"+obj.getUrl(Integer.parseInt(request.getParameter("id")))+"';"));
response.sendRedirect(url);
%>

