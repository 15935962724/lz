<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %>
<%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.cio.*" %><%@page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String menuid=request.getParameter("id");
String nexturl=request.getParameter("nexturl");

String member=teasession._rv._strV;

int ciocompany=0;
String tmp=request.getParameter("ciocompany");
if(tmp!=null)
{
  ciocompany=Integer.parseInt(tmp);
}else
{
  ciocompany=CioCompany.findByMember(member);
  if(ciocompany<1)
  {
    response.sendRedirect("/jsp/info/Alert.jsp?info="+java.net.URLEncoder.encode("你不是代表","UTF-8"));
    return;
  }
}


CioCompany cc=CioCompany.find(ciocompany);

if(!cc.isReceipt())
{
  response.sendRedirect("/jsp/cio/InfoCioCompany.jsp?alert="+java.net.URLEncoder.encode("您的信息还没有被审核,暂时不能查看参会回执.","UTF-8"));
  return;
}

out.print(cc.getReceiptToHtml());
%>
