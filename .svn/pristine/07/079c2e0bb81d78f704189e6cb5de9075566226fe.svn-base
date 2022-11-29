<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter"%> 
<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import="java.io.*" %>
<%@ page import ="java.util.*" %>
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
%>

<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
</head>


<body>

<h1> 车辆预约情况图表</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	
  	<tr>
  		<td nowrap>车辆</td>
  		<td nowrap>预约状态</td>
  		<td nowrap>预约开始时间</td>
  		<td nowrap>预约结束时间</td>
  		<td nowrap>操作</td>
  	</tr>
  	<%
  	
  		java.util.Enumeration mame = Manage.findByCommunity(teasession._strCommunity," and id  in (select Applys.vehicle from Applys)");
  		while(mame.hasMoreElements())
  		{
  			int maid = ((Integer)mame.nextElement()).intValue();
  			Manage maobj = Manage.find(maid);
  		
  	 %>
  	<tr>
  		<td nowrap><%=maobj.getVehicle() %></td>
  		
  		<%
  			java.util.Enumeration apme = Applys.findByCommunity(teasession._strCommunity,"");
  			while(apme.hasMoreElements())
  			{
  				int apid = ((Integer)apme.nextElement()).intValue();
  				Applys apobj = Applys.find(apid);
  				if(apobj.getVehicle()==maid )
  				{
  					if(apobj.getType()==1 && apobj.getUses()==1){
  						out.print("<td >使用中</td>");
  						out.print("<td >"+apobj.getTimes1()+"</td>");
  						out.print("<td >"+apobj.getTimes2()+"</td>");
  						out.print("<td ><a href=\"/jsp/admin/vehicle/usage_detail.jsp?apid="+apid+"\"  target=\"_blank\"> 详细信息</a></td><br>");
  					} else if(apobj.getType()==-1){
  						out.print("<td >未批准</td>");
  						out.print("<td >无</td>");
  						out.print("<td n>无</td>");
  						out.print("<td >无</td>");
  					} else if(apobj.getUses()==0){
  						out.print("<td >待批</td>");
  						out.print("<td >"+apobj.getTimes1()+"</td>");
  						out.print("<td >"+apobj.getTimes2()+"</td>");
  						out.print("<td ><a href=\"/jsp/admin/vehicle/usage_detail.jsp?apid="+apid+"\"  target=\"_blank\"> 详细信息</a></td>");
  					} 
  				}
  					
  		 %>
  		 		
  		 <%		
  		 		}		
  					
  		  %>
  	</tr>
  	<%
  		
  		}
  	 %>
  	 
  	 <%
  	 	java.util.Enumeration mame1 = Manage.findByCommunity(teasession._strCommunity," and id not  in (select Applys.vehicle from Applys)");
  		while(mame1.hasMoreElements())
  		{
  			int maid1 = ((Integer)mame1.nextElement()).intValue();
  			Manage maobj1 = Manage.find(maid1);
  			out.print("<tr>");
  			out.print("<td>"+maobj1.getVehicle()+"</td>");
  			out.print("<td noerap>未使用</td>");
  			out.print("<td noerap>无</td>");
  			out.print("<td noerap>无</td>");
  			out.print("<td noerap>无</td>");
  			out.print("</tr>");
  		}
  	  %>
</table>



</body>
</html>



