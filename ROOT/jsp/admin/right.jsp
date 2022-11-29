<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*"%><%@page import="tea.entity.admin.*"%><%@page import="tea.entity.member.*"%><%

Http h=new Http(request);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?bg=1&node="+h.node);
  return;
}

AdminFunction af_node=AdminFunction.find(h.getInt("id"));
String acts=af_node.getAction(h);
if(acts==null)
{
  out.print("无效权限！<script src='/tea/mt.js' type='text/javascript'></script>");
  return;
}

String url=af_node.getUrl(h.language);
if(url==null||"".equals(url))
{
  out.print("<!doctype html><html><head><link href='/res/"+h.community+"/cssjs/community.css' rel='stylesheet' type='text/css'></head><body><h1>无效菜单</h1>");
  //url="/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("&#27492;&#21151;&#33021;&#24320;&#21457;&#24314;&#35774;&#20013;!","UTF-8");
}else if(url.startsWith("javascript:"))
{
  out.print("<script>"+url.substring(11)+"</script>");
}else
{
  url+=(url.indexOf('?')==-1?'?':'&')+"community="+h.community;
  if(url.indexOf("node=")==-1)url+="&node="+h.node;
  url+="&acts="+acts;
  String info=request.getParameter("info");
  if(info!=null)
  {
    url=url+"&info="+java.net.URLEncoder.encode(info,"UTF-8");
  }
  if(url.startsWith("http://"))//||h.debug
  {
    response.sendRedirect(url);
  }else
  {
    Logs.create(h.community,new RV(h.username),10,af_node.id,af_node.getName(h.language));
    application.getRequestDispatcher(url).forward(request,response);
  }
}


%>
