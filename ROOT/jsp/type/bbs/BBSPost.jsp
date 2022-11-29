<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.resource.Resource" %>
<%@page import="tea.entity.node.*" %>
<%@page import="tea.entity.site.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.bbs.*" %>
<%@page import="java.io.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv != null)
{ 
	
	
	
	String member= teasession._rv._strR;
	Profile p = Profile.find(member);
	
	Node nobj = Node.find(teasession._nNode);
	//out.println(nobj.getFather()+"--"+nobj.getType()+"--"+p.getBbspermissions());
	if(nobj.getType()==1&&p.getBbspermissions()!=null && p.getBbspermissions().length()>2 && p.getBbspermissions().indexOf("/"+teasession._nNode+"/")!=-1)//只是类别 
	{
		out.print("<a href=\"/jsp/type/bbs/EditBBS.jsp?NewNode=ON&Type=57&TypeAlias=0\">");
		out.print("发帖");
		out.print("</a>");
	}
	if(nobj.getType()==57&&p.getBbspermissions()!=null && p.getBbspermissions().length()>2 && p.getBbspermissions().indexOf("/"+nobj.getFather()+"/")!=-1)
	{
		out.print("<a href=\"/jsp/type/bbs/EditBBS.jsp?NewNode=ON&Type=57&TypeAlias=0\">");
		out.print("发帖");
		out.print("</a>");
		out.print("<a href=\"/jsp/type/bbs/EditBBSReply.jsp\">");
		out.print("回复");
		out.print("</a>");
	}
	
 
}




%>
