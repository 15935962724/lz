<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.member.*"%>
<%
  request.setCharacterEncoding("UTF-8");
  response.setHeader("Expires", "0");
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Pragma", "no-cache");
  TeaSession teasession = new TeaSession(request);
InCarteMethod icm = new InCarteMethod();
String cid = teasession.getParameter("cid");
int intCid = Integer.parseInt(cid);
if(cid!=null && cid.length()>0)
{
  int operValue = icm.findCarteOper(intCid);

    icm.updateCarteOper(intCid, 1);

    response.sendRedirect("/jsp/profile/receivecarte.jsp");
//  else
//  {
//    icm.updateCarteOper(intCid, 0);
//    out.print("<input type=button value='添加至公司名片库' onclick=\"c_jax('"+cid+"')\"/>");
//  }

}


%>

