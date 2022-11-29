<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.resource.*"%>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.admin.*"%>
<%@page import="tea.entity.admin.orthonline.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Date"%>
<%@page import ="java.sql.SQLException" %>
<%@page import="java.math.BigDecimal"%>

<%



TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
 

DbAdapter db=new DbAdapter();

try
{
	db.executeQuery("select node from BBS ");
	while(db.next())
	{
		int nid = db.getInt(1);
		BBS bobj = BBS.find(nid,1);
		int c = BBSReply.count(nid,1);
		DbAdapter db2 = new DbAdapter();
        try
        {
            db2.executeUpdate("UPDATE BBS SET replycount=" + c+ " WHERE node=" + nid);
        } finally
        { 
            db2.close();
        }
		 
	}
}finally
{
	db.close();
}

	
	 		

%>





