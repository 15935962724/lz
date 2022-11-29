<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"  %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.entity.site.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="java.util.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@page import="java.net.URLEncoder"%>

<%
request.setCharacterEncoding("UTF-8");
if(request.getProtocol().compareTo("HTTP/1.0")==0)
{
  response.setHeader("Pragma","no-cache");
}
if(request.getProtocol().compareTo("HTTP/1.1")==0)
{
  response.setHeader("Cache-Control","no-cache");
}
response.setDateHeader("Expires",0);

TeaSession teasession=new TeaSession(request);
StringBuffer numSb = new StringBuffer();
//StringBuffer cookieSb = new StringBuffer();
String nexturl = teasession.getParameter("nexturl");
String listes = teasession.getParameter("list");

int count = 0;

String kinds = teasession.getParameter("count");
if(kinds!=null)
{
  count =Integer.parseInt(kinds);
}

for(int i = 0; i < count; i++)
{
  String par = teasession.getParameter("id"+i);
  String[] para = par.split(",");
    int node =Integer.parseInt(para[0]);

    //查列举号。。。。    形成   1，1111，1112,/2，1111，3333,/
    numSb.append(node).append(",");
//    cookieSb.append(node).append("!");
    for(int j = 1; j < para.length; j++)
    {
    numSb.append(para[j]).append(",");
//    cookieSb.append(para[j]).append("!");
    }
    numSb.append("/");
//    cookieSb.append("/");
}
  if(teasession._rv == null)
  {
//    Cookie[] cookie = request.getCookies();
//
//    for (int i = 0; i < cookie.length; i++)
//    {
//      if (cookie[i].getName().equals("param"))
//      {
//        cookie[i].setMaxAge(0);
//        response.addCookie(cookie[i]);
//        System.out.println("清除" + cookie[i].getName() + "成功！");
//      }
//    }

//  Cookie scookie = new Cookie("param", cookieSb.toString());
//  scookie.setPath("/");
//  scookie.setMaxAge(60*60);

//  response.addCookie(scookie);

    //存COOKIE
  }else
  {
    String member = teasession._rv._strR;
    //判断是否存在 ？  更新 ： 增加
    boolean isEx = PreInfo.isExist(member);
    if(isEx)
    {
      PreInfo.upInfo(member,count,numSb.toString());
    }else
    {
      PreInfo.addInfo(member,count,numSb.toString());
    }
  }
//response.sendRedirect(nexturl);
request.getRequestDispatcher(nexturl).forward(request,response);
//response.sendRedirect("/jsp/community/test.jsp");

%>
<script type="">

//  window.location.href='<%=nexturl%>';

</script>

