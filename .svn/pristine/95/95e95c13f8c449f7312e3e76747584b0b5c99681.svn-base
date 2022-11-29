<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.io.*" %><%@page import="tea.entity.admin.*"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %><%@page import="tea.ui.*" %><%@page import="tea.db.*" %>

<span id="show">开始移动....</span>
<%



 
int i=1;
DbAdapter db = new DbAdapter();
try
{
	
}finally
{
	db.executeQuery("select flowbusiness,name from FlowbusinessLayer");
	while(db.next())
	{
		int flowbusiness = db.getInt(1);
		String name = db.getString(2);
		 DbAdapter db2 = new DbAdapter();
         try 
         { 
             db2.executeUpdate("update Flowbusiness set name = "+DbAdapter.cite(name)+" where flowbusiness= "+flowbusiness);
         }finally
         {
              db2.close(); 
         }
         out.print("<script> document.getElementById('show').innerHTML='<font color=red>"+i+"</font>："+name+"';</script>");
         out.flush();
         i++;
 
	}
}


%>
