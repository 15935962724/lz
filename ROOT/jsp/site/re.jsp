<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*"%><%@page import="tea.entity.*"%>
<%@page import="java.util.*"%><%@page import="tea.entity.node.*"%><%@page import="tea.entity.admin.*"%>
<%@page import="tea.ui.*"%><%@page import="tea.db.*"%><%@page import="tea.entity.site.*"%><%@page import="tea.entity.member.*"%><%
request.setCharacterEncoding("UTF-8");
String sn=request.getServerName();
String ip=request.getRemoteAddr();
String ua=request.getHeader("User-Agent");


//修复mysql表~
DbAdapter db = new DbAdapter(),d2 = new DbAdapter();
try
{
  db.executeQuery("SHOW TABLES");
  while(db.next())
  {
    String str=db.getString(1);
    System.out.println(str);
    out.println(str+"<br/>");
    out.flush();
    d2.executeUpdate("REPAIR TABLE " + str);
  }
} finally
{
  db.close();
  d2.close();
}

%>
ok
