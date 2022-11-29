<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="tea.entity.node.*" %>
<%@ page import="tea.ui.TeaSession"%>
<%
request.setCharacterEncoding("UTF-8");
 TeaSession teasession = new TeaSession(request);
 if(teasession._rv==null)
 {
   response.sendRedirect("/servlet/Node?node=14856&language=1");
   return ;
 }
String member = teasession.getParameter("member");
String YN = request.getParameter("yn");
String community = teasession._strCommunity;
Hotel_application host = Hotel_application.find(member);
  // 1 同意 0 不同意
  try{
  if(YN.equals("0"))
  {
    host.deleteById(member,teasession._nLanguage,community);
    response.sendRedirect("/jsp/registration/audits.jsp");
  }
  else if(YN.equals("1"))
  {
    host.upById(member);
    response.sendRedirect("/jsp/registration/audits.jsp");
  }}catch(Exception ex)
  {
    System.out.println(ex.toString());
  }

%>
