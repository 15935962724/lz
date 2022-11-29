<%@page contentType="text/html;charset=UTF-8" %><%@ page import="java.util.*" %><%@ page import="java.math.*" %><%@ page import="tea.entity.member.*" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.resource.*" %><%@ page import="tea.entity.node.*" %><%@ page import="tea.entity.admin.*" %><%@ page import="tea.ui.*" %><%@ page import="tea.entity.site.*" %><%
request.setCharacterEncoding("UTF-8");
TeaSession teasession=new TeaSession(request);

String member = teasession.getParameter("member");
String paw =teasession.getParameter("paw");

String act = teasession.getParameter("act");
if("login".equals(act))
{

  if(Profile.isExist(member,paw))//判断用户
  {
    out.print("有这个用户");
   // System.out.println("有这个用户 ："+Profile.isExist(member,paw));
  }
  return;
}

%>

