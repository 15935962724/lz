<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import = "tea.entity.node.Sms" %>
<jsp:useBean id="sms" scope="page" class="tea.entity.node.Sms" />
<%
	         HttpSession httpsession = request.getSession(true);
            String phonenumber =(String)httpsession.getAttribute("sms.phonenumber");

			String name = request.getParameter("name");
			String mobile = request.getParameter("mobile");
			String telephone = request.getParameter("telephone");
			String email = request.getParameter("email");
			int groupid= Integer.parseInt(request.getParameter("groupid"));

			sms.phonebook_create(phonenumber,name,mobile ,telephone ,groupid,email);


%>
<jsp:forward page="groupmanage.htm">
</jsp:forward>

