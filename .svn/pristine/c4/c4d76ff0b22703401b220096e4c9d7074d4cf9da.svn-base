<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %><%@ page import="java.math.*" %>
<%@ page import="tea.entity.*" %><%@ page import="tea.entity.member.*" %>
<%@ page import="tea.db.DbAdapter" %><%@ page  import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %><%@ page import="tea.ui.TeaSession" %>
<% request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String s ="Inbox";
int a =Message.countNew(teasession._strCommunity,teasession._rv._strV,0);


if(a>0)
{
  out.println("<a href=\"/jsp/message/Messages.jsp?folder=0&community="+teasession._strCommunity+" \"TARGET=\"_self\">您有<font color =red>"+a+"</font>封新邮件</a>");
}else
{
  out.println("<a href=\"/jsp/message/Messages.jsp?folder=0&community="+teasession._strCommunity+" \"TARGET=\"_blank\">站内信箱</a>");
}
%>


