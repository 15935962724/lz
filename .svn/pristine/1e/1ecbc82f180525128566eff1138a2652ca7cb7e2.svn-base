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



<body >


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
  <tr id="tableonetr">
      <td nowrap align="center">车牌号</td>
      <td nowrap align="center">用车人</td>
      <td nowrap align="center">开始时间</td>
      <td nowrap align="center">结束时间</td>
      <td nowrap align="center">操作</td>
    </tr>
    <%
    	String sql ="";
    	String ty = teasession.getParameter("ty");
    	if(ty.equals("1"))
    	{
    		sql = " and type = 1";
    	}
    	if(ty.equals("-1"))
    	{
    		sql = " and type =-1";
    	}
    	if(ty.equals("0"))
    	{
    		sql = " and type =0";
    	}
    	java.util.Enumeration apme = Applys.findByCommunity(teasession._strCommunity," and findingmanid ='"+teasession._rv+"' "+sql+"");
    	while(apme.hasMoreElements())
    	{
    		int apid = ((Integer)apme.nextElement()).intValue();
    		Applys apobj = Applys.find(apid);
    		Manage maobj = Manage.find(apobj.getVehicle());
    %>
     <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
     <td nowrap align="center"><a href="/jsp/admin/vehicle/vehicle_detail.jsp?maid=<%=apobj.getVehicle() %>" target="_blank"><%=maobj.getVehicle() %></a></td>
  <td nowrap align="center"><%=apobj.getMan() %></td>
      <td nowrap nowrap align="center"><%=apobj.getTimes1().toString().substring(0,16) %></td>
  <td nowrap align="center"><%=apobj.getTimes2().toString().substring(0,16)  %></td>
      <td nowrap align="center">
      <%
      		if(ty.equals("1")){
       %>
       		 <a href="/jsp/admin/vehicle/usage_detail.jsp?apid=<%=apid %>"  target="_blank">详细信息</a>&nbsp;
			<a href="/jsp/admin/vehicle/deal.jsp?TYPE=0&apid=<%=apid %>">撤销</a>
    
       <%
       			}
       			if(ty.equals("-1")){
        %>
     <a href="/jsp/admin/vehicle/usage_detail.jsp?apid=<%=apid %>"  target="_blank">详细信息</a>&nbsp;
	<a href="/jsp/admin/vehicle/deal.jsp?TYPE=1&apid=<%=apid %>"> 批准</a>
    <%
    	}
    	if(ty.equals("0")){
     %>
      <a href="/jsp/admin/vehicle/usage_detail.jsp?apid=<%=apid %>"  target="_blank">详细信息</a>&nbsp;
	<a href="/jsp/admin/vehicle/deal.jsp?TYPE=1&apid=<%=apid %>"> 批准</a>&nbsp;<a href="/jsp/admin/vehicle/deal.jsp?TYPE=-1&apid=<%=apid %>"> 不准</a>&nbsp;     
     <%
     	}
      %>
       </td>
    </tr>
<%
	}
 %>
</table>
</body>


</html>
	


