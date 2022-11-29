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


<body>

<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr id="tableonetr">
	      <td nowrap align="center">厂牌型号</td>
	      <td nowrap align="center">车牌号</td>
	      <td nowrap align="center">司机</td>
	      <td nowrap align="center">类型</td>
	      <td nowrap align="center">操作</td>
    </tr>
    <%
    		java.util.Enumeration mame = Manage.findByCommunity(teasession._strCommunity," and id not in (select Applys.vehicle from Applys)");
    		while(mame.hasMoreElements())
    		{
    			int maid = ((Integer)mame.nextElement()).intValue();
    		
    				Manage maobj = Manage.find(maid);
     %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
		  <td nowrap ><%=maobj.getFactory() %></td>
	      <td nowrap ><%=maobj.getVehicle() %></td>
	      <td nowrap ><%=maobj.getChauffeur() %></td>
	      <td nowrap ><%=maobj.getGenre() %>卡车</td>
	      <td nowrap >
	      <a href="/jsp/admin/vehicle/vehicle_detail.jsp?maid=<%=maid %>"  target="_blank">详细信息</a>&nbsp;
	      </td>
    </tr>
     <%
   			
     		
     	}
      %>
</TABLE>



</body>
</html>



