<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%>
<%
  request.setCharacterEncoding("UTF-8");
  TeaSession teasession = new TeaSession(request);
  if(teasession._rv._strR==null)
  {

  }
  String member = teasession.getParameter("member");
  int language = teasession._nLanguage;
  try {
    Caller.delete(member, language);
    response.sendRedirect("/jsp/registration/caller.jsp?node=2221");
  }
  catch (Exception ex) {
    System.out.println(ex.toString());
  }
%>
