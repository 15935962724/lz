<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.member.Profile" %>
<jsp:useBean id="profile" scope="page" class="tea.entity.member.Profile" />
<%!
boolean isIdentifier(String sIdentifier)
{
	if (sIdentifier.length() < 3||sIdentifier.length()>18)
		return false;
	char c;
	for (int i = 0; i < sIdentifier.length(); i++) {
		c = sIdentifier.charAt(i);
		if (('_' == c) || ('-' == c) ||
			(('A' <= c) && (c <= 'Z')) ||
			(('a' <= c) && (c <= 'z')) ||
			(('0' <= c) && (c <= '9')))
			continue;
		else
			return false;
	}

	return true;
}
%>
<%//HttpSession httpsession = request.getSession(true);

String UserName = request.getParameter("UserName").trim();
String Name = request.getParameter("Name").trim();
String ConfirmPassword = request.getParameter("ConfirmPassword").trim();
String EnterPassword = request.getParameter("EnterPassword").trim();
String EmailAddress = request.getParameter("EmailAddress").trim();
String MobileNumber = request.getParameter("MobileNumber").trim();

session.setAttribute("UserName",UserName);
session.setAttribute("Name",Name);
session.setAttribute("EmailAddress",EmailAddress);
session.setAttribute("MobileNumber",MobileNumber);

if(Profile.isExisted(UserName))
{
%>
<jsp:forward page="KaputHotdog.jsp">
<jsp:param name="Node" value="<%=request.getParameter("Node")%>"/>
</jsp:forward>
<%
}else
if(!isIdentifier(UserName)||Name.length()<2||Name.length()>18||!ConfirmPassword.equals(EnterPassword)||MobileNumber.length()!=11||EmailAddress.length()<3||!MobileNumber.substring(0,2).equals("13"))
{
  response.sendRedirect("WarningHotdog.jsp?node="+request.getParameter("Node"));
}else
try
{
if(profile.create(UserName,Name,ConfirmPassword, EmailAddress,MobileNumber))
{
%>
<jsp:forward page="SucceedHotdog.jsp">
  <jsp:param name="Node" value="<%=request.getParameter("Node")%>"/>
</jsp:forward>
<%
}else
{
  response.sendRedirect("WarningHotdog.jsp?node="+request.getParameter("Node"));
}
}catch(Exception e)
{
  response.sendRedirect("WarningHotdog.jsp?node="+request.getParameter("Node"));
}
%>

