<%@ include file="/jsp/Header.jsp" %>
<%
tea.entity.member.Profile pf=tea.entity.member.Profile.find(teasession._rv.toString());
//out.print(teasession._rv);
//out.print(pf.getPassword());
response.sendRedirect("http://bbs.voguezone.com/login.asp?action=chk&username="+teasession._rv+"&password="+pf.getPassword()+"&CookieDate=1&userhidden=2&comeurl=index.asp");
%>

