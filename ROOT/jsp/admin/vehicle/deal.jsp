<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>

<%
request.setCharacterEncoding("UTF-8");


response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}
String community=teasession._strCommunity;

int apid = 0;
if(teasession.getParameter("apid")!=null && teasession.getParameter("apid").length()>0)
	apid = Integer.parseInt(teasession.getParameter("apid"));
String TYPE = teasession.getParameter("TYPE");
String types = "type";
if(TYPE!=null){
	if(TYPE.equals("1"))
	{
		Applys apobj = Applys.find(apid);
		apobj.set(types,1);
		response.sendRedirect("/jsp/admin/vehicle/dept_manage.jsp?ty=0");
		return;
	}
	if(TYPE.equals("-1"))
	{
		Applys apobj = Applys.find(apid);
		apobj.set(types,-1);
		response.sendRedirect("/jsp/admin/vehicle/dept_manage.jsp?ty=0");
		return;
		
	}
	if(TYPE.equals("0"))
	{
		Applys apobj = Applys.find(apid);
		apobj.set(types,0);
		response.sendRedirect("/jsp/admin/vehicle/dept_manage.jsp?ty=1");
		return;
	}
}
String USES = teasession.getParameter("USES");
String usess ="uses";
if(USES!=null){
		if(USES.equals("1"))
		{
			Applys apobj = Applys.find(apid);
			apobj.set(usess,1);
			response.sendRedirect("/jsp/admin/vehicle/checkup/query1.jsp?us=0");
			return;
		}
		if(USES.equals("-1"))
		{
			Applys apobj = Applys.find(apid);
			apobj.set(usess,-1);
			response.sendRedirect("/jsp/admin/vehicle/checkup/query1.jsp?us=0");
			return;
		}
		if(USES.equals("0"))
		{
			Applys apobj = Applys.find(apid);
			apobj.set(usess,0);
			response.sendRedirect("/jsp/admin/vehicle/checkup/query1.jsp?us=1");
			return;
		}
		if(USES.equals("2"))
		{
			Applys apobj = Applys.find(apid);
			apobj.set("type",0);
			apobj.set(usess,0);
				response.sendRedirect("/jsp/admin/vehicle/checkup/query1.jsp?us=0");
			return;
		}
		
}
String DELETE = teasession.getParameter("DELETE");
if(DELETE!=null)
{
	Applys apobj = Applys.find(apid);
	apobj.delete();
	response.sendRedirect("/jsp/admin/vehicle/checkup/query1.jsp?us=0");
		return;
}

if(teasession.getParameter("detele")!=null)
{
	Applys apobj = Applys.find(apid);
	apobj.delete();
	response.sendRedirect("/jsp/admin/vehicle/applying.jsp?us=2");
		return;
}

if(teasession.getParameter("madetele")!=null)
{
	int maids = Integer.parseInt(teasession.getParameter("maid"));
	Maintenance maobjs = Maintenance.find(maids);
	maobjs.delete();
	response.sendRedirect("/jsp/admin/vehicle/query1.jsp");
	return;
}

%>



	


