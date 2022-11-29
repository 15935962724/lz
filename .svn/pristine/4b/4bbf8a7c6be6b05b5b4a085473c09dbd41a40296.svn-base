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
      <td nowrap align="center">购置日期</td>
      <td nowrap align="center">状态</td>
      <td nowrap align="center">操作</td>
    </tr>
    <%
    	java.util.Enumeration maen = Manage.findByCommunity(teasession._strCommunity,"");
    
    	while(maen.hasMoreElements())
    	{
    		int maid = ((Integer)maen.nextElement()).intValue();
    		Manage maobj = Manage.find(maid);
    		
    
     %>
    <tr onMouseOver="javascript:this.bgColor='#BCD1E9'" onMouseOut="javascript:this.bgColor=''">
      <td nowrap align="center"><%=maobj.getFactory() %></td>
      <td nowrap align="center"><%=maobj.getVehicle() %></td>
      <td nowrap align="center"><%=maobj.getChauffeur() %></td>
      <td nowrap align="center">
      		<%
      			Cargenre caobj = Cargenre.find(maobj.getGenre());
      			out.print(caobj.getCargenrename());
      				
      		 %>
      </td>
      <td nowrap align="center" ><%=maobj.getTimes().toString().substring(0,10) %></td>
      <td nowrap align="center"><%
    		  if(maobj.getFettle()==1){out.print("可用");}
    		  if(maobj.getFettle()==2){out.print("损坏");}
    		  if(maobj.getFettle()==3){out.print("维修中");}
    		  if(maobj.getFettle()==4){out.print("报废");}
      %> 
      </td>
      <td nowrap align="center">
      <a href="/jsp/admin/vehicle/vehicle_detail.jsp?maid=<%=maid %>"  target="_blank">详细信息</a>&nbsp;&nbsp;&nbsp;
      <a href="/jsp/admin/vehicle/order_detail.jsp?apid=<%=maid %>&str=add" target="_blank">预定情况</a>&nbsp;&nbsp;&nbsp;
      <a href="/jsp/admin/vehicle/newamnage.jsp?maid=<%=maid %>">修改</a>&nbsp;&nbsp;&nbsp;
      <a href="/jsp/admin/vehicle/newamnage.jsp?maid=<%=maid %>&delete=delete" onClick="return window.confirm('您确定要删除车辆吗？');">删除</a>
      </td>
    </tr>
    <%
    		}
     %>
</TABLE>



</body>
</html>



