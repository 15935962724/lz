<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.db.*" %>
<%@ page import="tea.entity.bpicture.*" %>
<%@ page import="tea.entity.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.entity.member.*" %>
<%@ page import="tea.service.SendEmaily"%>
<%
TeaSession teasession = new TeaSession(request);

String member = teasession.getParameter("member");

RV rv = new RV(member);
session = request.getSession(true);
session.setAttribute("tea.RV",rv);
session.setAttribute("LoginId",member);

String type = teasession.getParameter("type");

if(type.equals("1")){
  response.sendRedirect("/jsp/bpicture/");
}else{
  response.sendRedirect("/jsp/bpicture/saler/ChangePayment.jsp?type=1");
}

%>
