<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.site.Community"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.servlet.*" %>
<%@page import="javax.servlet.http.*" %>
<%@page import="javax.servlet.http.HttpSession"%>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

//
Cookie cs = new Cookie("tea.RV",null);
cs.setPath("/");
cs.setMaxAge(0);
String sn = request.getServerName();
int j = sn.indexOf(".");
if(j != -1 && sn.charAt(sn.length() - 1) > 96)
{
  cs.setDomain(sn.substring(j));
}
response.addCookie(cs);
session.removeAttribute("tea.RV");

OnlineList obj = OnlineList.find(session.getId());
obj.setMember(null);
out.print("ddddddd");
response.sendRedirect("http://www.orthonline.com.cn/");
return;

%>

