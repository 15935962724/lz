<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.entity.node.*"%>
<%@ page import="tea.html.*"%>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.resource.*"%>
<%@ page import="tea.ui.TeaServlet"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.jasper.runtime.JspRuntimeLibrary"%>
<%@page import="javax.mail.*" %>
<%@ page import="java.net.Socket"%>
<%@page import="javax.mail.internet.*" %>
<%@ page import=" tea.db.DbAdapter"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="tea.entity.member.*"%>
<%@ page import="tea.entity.util.*"%>
<%@ page import="tea.entity.site.*"%>
<%@ page import="tea.ui.member.order.*"%>
<%@ page import="tea.http.RequestHelper"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="tea.entity.RV"%>
<%!
String getCheck(boolean bool)
{
	return bool?" CHECKED ":" ";
}
String getCheck(int value)
{
	return value!=0?" CHECKED ":" ";
}
String getSelect(boolean i)
{
	return i?" SELECTED ":" ";
}

String getNull(Object strNull)
{	return strNull==null?"":String.valueOf(strNull);
}
String getNull(int intValue)
{	return intValue==0?"":String.valueOf(intValue);
}
String getNull(float floatValue)
{	return floatValue==0f?"":String.valueOf(floatValue);
}
String getDisplay(boolean bool)
{
    return bool?" style=\"display:\" ":" style=\"display:none\" ";
}
TeaServlet ts=new TeaServlet();
Resource r = new Resource();
Node node;
TeaSession teasession;
%>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
teasession = new TeaSession(request);
if(teasession._rv == null)
{
response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+request.getRequestURI()+"?"+request.getQueryString());
return;
}

node=Node.find(teasession._nNode);
%>

<%
  Purview purview = Purview.find(teasession._rv.toString());
  if (!purview.isJob() && !License.getInstance().getWebMaster().equals(teasession._rv.toString()) && !teasession._rv.toString().equalsIgnoreCase("cnooc")) {
    ts.outText(response, 1, "你没有权限,访问本页.");
    return;
  }
  String str[] = request.getParameterValues("checkbox");
  if (str != null) {
    if (request.getParameter("delete") != null)
      for (int index = 0; index < str.length; index++) {
        tea.entity.node.Node node = tea.entity.node.Node.find(Integer.parseInt(str[index]));
        node.delete(1);
      }
    else {
      boolean bool = (request.getParameter("stop") != null);
      for (int index = 0; index < str.length; index++) {
        tea.entity.node.Node node = tea.entity.node.Node.find(Integer.parseInt(str[index]));
        node.set(bool);
      }
    }
  }
  response.sendRedirect(request.getParameter("nexturl"));
%>

