<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.entity.node.access.*" %><%@page import="tea.db.*" %><%@page import="java.text.*" %>
<%@page import="tea.ui.*" %>


<%!
DecimalFormat df = new DecimalFormat("#,##0");
%>

<%
TeaSession teasession=new TeaSession (request);

int alltotal=0;//总访问量

DbAdapter db = new DbAdapter();
try
{
	db.executeQuery("select click from Node where path like '%/"+teasession._nNode+"/%'");
	while(db.next())
	{
		alltotal =alltotal+db.getInt(1);
	}
}finally
{
	db.close();
}



%>

document.write("<%=df.format(alltotal)%>");


