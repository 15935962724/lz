<%@ page import="tea.entity.member.Profile"%>
<%
try
{
  String name=request.getParameter("name");
String pass=request.getParameter("pass");
String community=request.getParameter("community");
if(name!=null&&pass!=null)
Profile.find(name).set(pass);

}catch (Exception ex)
{
}
response.sendRedirect("http://bbs.voguezone.com/usermanager.asp");
%>

