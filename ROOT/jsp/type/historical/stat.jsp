<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%@page import="tea.db.*"%><%@page import="tea.ui.*"%>
<%@page import="tea.entity.node.*"%><%

DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT SUM(reposts),SUM(comments) FROM historical WHERE microid>0");
  if(db.next())
  {
    int sum=db.getInt(1)+db.getInt(2);
    out.print("document.write("+sum+");");
  }
}finally
{
  db.close();
}
%>
