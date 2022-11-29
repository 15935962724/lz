<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.site.License" %><%@ page  import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.map.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);

String area=request.getParameter("area");
String q=request.getParameter("q");
String curcurCityCode41=request.getParameter("curcurCityCode41");

//curpage
//http://channel.mapabc.com/channel/searchName.jsp?curpage=2&searchkey=百度&area=&curcurCityCode41=

StringBuffer sb=new StringBuffer();
URL u=new URL("http://channel.mapabc.com/channel/searchName.jsp?searchkey="+q+"&area="+area+"&curcurCityCode41=");
InputStream is=u.openStream();
int v=0;
while((v=is.read())!=-1)
{
	sb.append((char)v);
}
is.close();
String str=new String(sb.toString().getBytes("ISO-8859-1"),"GBK");

out.print(str);
%>
