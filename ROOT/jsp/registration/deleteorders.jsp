<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="tea.ui.*,tea.entity.node.*" %>
<%
//删除 拒绝的 订单
 request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv.toString()==null)
{
  response.sendRedirect("/jsp/user/StartLogin.jsp");
  return ;
}
int destine = Integer.parseInt(teasession.getParameter("destine"));
String member = teasession._rv._strV;
Destine obj = Destine.find(destine);
obj.delete();
response.sendRedirect("/jsp/registration/orderprocessing.jsp");

%>
