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
int vehicle =0;

if(teasession.getParameter("vehicle")!=null && teasession.getParameter("vehicle").length()>0)
{
	vehicle = Integer.parseInt(teasession.getParameter("vehicle"));
	if(vehicle>0){
		Manage vehobj = Manage.find(vehicle);

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
     <tr >
   		<td nowrap>型号：</td>
   		<td nowrap><%=vehobj.getVehicle() %> </td>
   		 <td  nowrap rowspan="6" ><center><%if(vehobj.getPic()!=null && vehobj.getPic().length()>0){ %>
	      <img src='<%=vehobj.getPic() %>' width='100' height='120' border=1> 
	      <%}else{out.print("暂无照片");} %>
	      
	      </center></td>
    </tr>
    <tr >
   		<td nowrap>车牌号：</td>
   		<td nowrap><%=vehobj.getVehicle()%></td>
    </tr>
    <tr>
    	 <td nowrap>司 机：</td>
        <td nowrap><%=vehobj.getChauffeur() %></td>
    </tr>
    <tr>
    	 <td nowrap > 车辆类型：</td>
    	 <td nowrap>建立了车辆类型表在实现动态</td>
     </tr>
   <tr>
   	  <td nowrap> 预定情况：</td>
	     <td nowrap> <a href="/jsp/admin/vehicle/order_detail.jsp?apid=<%=vehicle %>&str=add" target="_blank">共<%
	     
	     
	     		
	     		out.print(Applys.getCount(teasession._strCommunity,vehicle));
	     
	     	
	      %>条预定信息</a>      <a href="/jsp/admin/vehicle/order_detail.jsp?str=more " target="_blank">更多 …… </a></td>
   </tr>
      <tr>
	      <td nowrap > 当前状态:</td>
	      <td nowrap><%if(vehobj.getFettle()==1)out.print("可用"); %>
 		<%if(vehobj.getFettle()==2)out.print("损坏"); %>
 		<%if(vehobj.getFettle()==3)out.print("维修中"); %>
 		<%if(vehobj.getFettle()==4)out.print("报废"); %> </td> 
    </tr>
     <tr>
     	 <td nowrap> 备注：</td>
     	
     	 <td nowrap><%=vehobj.getRemark() %></td>
     </tr>
</table>
<%
	}else
	{
		out.print("请选择车辆");
	}
}
 %>
</body>
</html>



