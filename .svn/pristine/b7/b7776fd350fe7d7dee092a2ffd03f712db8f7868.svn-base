<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.DbAdapter" %><%@page import="tea.resource.Resource" %><%@page import="tea.entity.eon.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.*" %><%@page import="tea.ui.TeaSession" %><%@page import="java.text.*" %><%@page import="java.util.*" %><%@page import="tea.entity.admin.erp.*" %><%@page import="tea.entity.league.*" %><%@page import="java.math.BigDecimal" %> <%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);
String act =teasession.getParameter("act");
String member = teasession.getParameter("member");
if("cunzai".equals(act))
{
  if(Profile.isExisted(member))
  {
    out.print("此用户名以被占用！");
  }
  else
  {
    out.print("true");
  }
}

%>
