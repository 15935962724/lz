<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%><%@page import="tea.entity.*"%><%@page import="tea.entity.sup.*"%><%@page import="tea.ui.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?node="+h.node);
  return;
}



%><html>
<head>
<title>图书分类</title>
</head>
<frameset border=0 framespacing=0 rows=* frameborder=yes cols=200,*>
  <frame name="qualification_tree" src="/jsp/sup/SupQualificationTree.jsp?qualifications=|" frameborder=no noresize scrolling=yes>
  <frame name="qualification_edit" src="/jsp/sup/SupQualificationList.jsp" noresize scrolling=yes>
</frameset>
</html>
