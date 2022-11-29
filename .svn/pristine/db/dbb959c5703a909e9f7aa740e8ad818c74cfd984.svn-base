<%@page import="tea.entity.Entity"%>
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
<%@page import="tea.entity.admin.mov.*" %>


<%



TeaSession teasession = new TeaSession(request);
if (teasession._rv == null) {
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}
 

DbAdapter db = new DbAdapter();
try
{
	//修改 状态
	/*
	db.executeQuery("select node,audit from Node where type = 39");
	int i = 0;
	while(db.next())
	{
	 	int nid = db.getInt(1);
	 	int audit = db.getInt(2);
	 	Node nobj = Node.find(nid);
	 	nobj.setAudit(audit);
	 	System.out.println(i+":"+nid+":"+audit);
	 	i++;
	}
	*/
	//修改审核人员
	db.executeQuery("select node from Node where type = 39 and ( audits=2 or audits=3)  ");
	int i = 0;
	while(db.next())
	{
	 	int nid = db.getInt(1);
	 	
	 	Node nobj = Node.find(nid);
	 	Report robj = Report.find(nid);
	 	
	 	nobj.setAuditmember(robj.getEditmember(1));
	 	nobj.setAudittime(robj.getIssueTime());
	 	
	 	System.out.println(i+":"+nid+":"+robj.getEditmember(1)+":"+(robj.getIssueTime()==null?robj.getIssueTime():Entity.sdf.format(robj.getIssueTime())));
	 	i++;
	}
}finally
{
	db.close();	
}
 


 %>