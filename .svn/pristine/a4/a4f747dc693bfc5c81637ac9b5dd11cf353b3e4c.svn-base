<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page  import="tea.entity.admin.sales.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%



response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");



TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
tea.resource.Resource r = new Resource() ;
%>
<html>
<head>
<%
int flowitem=0;
int workproject = 0;
String ItemName = r.getString(teasession._nLanguage,"项目管理") ;

if(request.getParameter("workproject")!=null)
{
 workproject = Integer.parseInt(request.getParameter("workproject")) ;
}

if(request.getParameter("flowitem")!=null)
{
  flowitem = Integer.parseInt(request.getParameter("flowitem"));
  Flowitem obj=Flowitem.find(flowitem);
  ItemName = obj.getName(teasession._nLanguage);
}

%>
</head>
<iframe src="/jsp/admin/workreport/Worklogs_5.jsp?workproject=<%=flowitem%>" width="49%" style="float:right;" height="99%">
</iframe>
<iframe src="/jsp/admin/workreport/Worklogs_12.jsp?flowitem=<%=flowitem%>" width="49%" style="float:left;" height="99%">
</iframe>
</html>
