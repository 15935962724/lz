<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.*" %><%@page import="tea.entity.admin.*"%><%

Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
String act=h.get("act");
if("action".equals(act))
{
  out.print("oper,reset,addkefu,");
  return;
}
int menuid=h.getInt("id");

%>
<html>
<head>
<title><%=AdminFunction.find(menuid).getName(h.language)%></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8">
<frameset border=0 frameSpacing=0 rows=* frameBorder=YES cols=280,*>
  <frame name=user_list src="/jsp/admin/popedom/DeptTree.jsp?community=<%=h.community%>&depts=&id=<%=menuid%>" frameBorder="NO" noResize scrolling="yes">
  <frame name=dept_user src="about:blank" noResize scrolling="yes">
</frameset>

</html>



