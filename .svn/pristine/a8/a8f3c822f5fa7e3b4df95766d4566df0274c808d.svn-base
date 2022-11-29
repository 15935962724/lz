<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms"/>
<%
//  HttpSession httpsession = request.getSession(true);
//  String phonenumber = (String) httpsession.getAttribute("sms.phonenumber");
  String as[] = request.getParameterValues("id");
  if (as != null) {
    for (int i = 0; i < as.length; i++) {
      tea.entity.node.SMSPhoneBook smspb = tea.entity.node.SMSPhoneBook.find(Integer.parseInt(as[i]));

      if (smspb.getPhonenumber().equals(teasession._rv.toString()))
      smspb.delete();
    }
  }
  response.sendRedirect("PhoneBookManage.jsp");
%>
<%--
  jsp:forward page="phonebook.jsp">
  </jsp:forward
--%>

