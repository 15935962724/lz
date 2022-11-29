<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="java.io.*,java.util.*" %>
<%@page import="tea.ui.*" %>
 <%
 request.setCharacterEncoding("UTF-8");
 TeaSession teasession = new TeaSession(request);
 String path = request.getParameter("path");
 String filenamedownload = path;
 int i = path.lastIndexOf("/");
 StringBuffer strb = new StringBuffer();
 for(int j=i+1;j<path.length();j++)
 {
   strb.append(path.charAt(j));
 }
 String filenamedisplay = "c:/"+strb;
 String name = strb.toString();
response.setContentType("application/x-msdownload");
response.setHeader("Content-Disposition", "attachment; filename=" +new String(name.getBytes("GBK"),"ISO-8859-1"));
%><jsp:forward page="<%=path%>">
<jsp:param name="" value="vectory"/>
</jsp:forward>
