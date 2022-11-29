<%@page import="tea.entity.Entity"%>
<%@page import="java.text.SimpleDateFormat"%>
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
TeaSession teasession=new TeaSession(request);
DbAdapter db = new DbAdapter();
try
{

	SimpleDateFormat sdfy = new SimpleDateFormat("yyyy");
	db.executeQuery("select p.member,m.memberorder from Profile p,MemberOrder m where p.member = m.member and m.becometime is not null    ");
	int i =1;
	while(db.next())
	{
		Profile pobj = Profile.find(db.getString(1));
		MemberOrder mobj = MemberOrder.find(db.getString(2));
		
		out.println((i++)+"："+pobj.getMember()+"<br>");
		
		
		 UpgradeMember.create(mobj.getMember(), mobj.getBecometime(), mobj.getPeriod(), mobj.getRemittance(), mobj.getRemtype(), mobj.getProxymembertype(), mobj.getProxymember(),mobj.getInvoiceremarks(),
				 mobj.getInvoicetype(),teasession._rv.toString(), mobj.getCommunity(),Entity.sdf.parse(Entity.sdf.format(mobj.getVerifgtime())),Integer.parseInt(sdfy.format(mobj.getVerifgtime())));
	}
}finally
{
	db.close();	
}

%> 
