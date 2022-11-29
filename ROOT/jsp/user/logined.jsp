<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import = "tea.entity.node.Sms" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%
	String PhoneNumber = request.getParameter("PhoneNumber");
    String Password = request.getParameter("password");
    String s2 = request.getParameter("Node");
	if (sms.isPassword(PhoneNumber,Password))
{
            HttpSession httpsession = request.getSession(true);
            httpsession.setAttribute("sms.phonenumber" ,PhoneNumber);
response.sendRedirect("/servlet/Node?node="+s2);

  }
  else
  {response.sendRedirect("loginerror2.jsp");

  }
%>


