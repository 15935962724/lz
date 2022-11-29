<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.*"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page  import="tea.htmlx.*" %>
<%@ page  import="tea.entity.admin.sales.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;

Resource r=new Resource("/tea/resource/Workreport");


java.util.Enumeration woem = Worklog.find(teasession._strCommunity,"",0,Integer.MAX_VALUE);
while(woem.hasMoreElements())
{
	int woid =((Integer)woem.nextElement()).intValue();
	Worklog woobj = Worklog.find(woid);
	//out.print(woobj.getWorkproject()+"<br>");
	java.util.Enumeration xme = XiangMuBiao.findBy(" where clientid="+woobj.getWorkproject());
	while(xme.hasMoreElements())
	{
		int xid = ((Integer)xme.nextElement()).intValue();
		XiangMuBiao xobj = XiangMuBiao.find(xid);
		
			out.print(xobj.getClientname()+"<br>");
			XiangMuBiao.set(xobj.getItemid(),woid);   
		
	}    
	
}


out.print("替换成功!!!!!!!!!");

%>






