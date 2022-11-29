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
{
	apid = Integer.parseInt(teasession.getParameter("apid"));
}

	Applys apobj = Applys.find(apid);
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

<h1>车辆使用详细信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
	<tr >
      <td nowrap >车牌号：</td>
      <%
      		Manage maobj = Manage.find(apobj.getVehicle());
       %>
      <td nowrap ><%=maobj.getVehicle() %></td>
  </tr>
  <tr >
      <td nowrap >司机：</td>
      <td nowrap ><%=apobj.getChauffeur() %></td>
  </tr>
  <tr class="TableLine2">
      <td nowrap >申请人：</td>
      <%
      		tea.entity.member.Profile pf_obj=tea.entity.member.Profile.find(apobj.getMember());
       %>
      <td nowrap ><%=pf_obj.getLastName(1)+pf_obj.getFirstName(1) %></td>
  </tr>
  <tr >
      <td nowrap >申请时间：</td>
      <td nowrap ><%=apobj.getTimes() %></td>
  </tr>
  <tr >
      <td nowrap >用车人：</td>
      <td nowrap ><%=apobj.getMan() %></td>
  </tr>
  <tr >
      <td nowrap >用车部门：</td>
      <%
      		AdminUnit obj_au=  AdminUnit.find(apobj.getUnit());
       %>
      <td nowrap ><%=obj_au.getName() %></td>
  </tr>
  <tr >
      <td nowrap >事由：</td>
      <td ><%=apobj.getCause() %></td>
  </tr>
  <tr >
      <td nowrap >开始时间：</td>
      <td nowrap ><%=apobj.getTimes1() %></td>
  </tr>
  <tr >
      <td nowrap >结束时间：</td>
      <td nowrap ><%=apobj.getTimes2() %></td>
  </tr>
  <tr >
      <td nowrap >目的地：</td>
      <td nowrap ><%=apobj.getDestination() %></td>
  </tr>
  <tr >
      <td nowrap >里程：</td>
      <td nowrap ><%=apobj.getMileage() %></td>
  </tr>
  <tr >
      <td nowrap >调度员：</td>
      <%
      		 tea.entity.member.Profile pf_obja=tea.entity.member.Profile.find(apobj.getAttemper());
       %>
      <td nowrap ><%=pf_obja.getLastName(1)+pf_obja.getFirstName(1) %></td>
  </tr>
  <tr >
      <td nowrap align="left" width="80" class="TableContent">部门审批人：</td>
      <%
      	 tea.entity.member.Profile pf_objs=tea.entity.member.Profile.find(apobj.getFindingmanid());
       %>
      <td nowrap ><%=pf_objs.getLastName(1)+pf_objs.getFirstName(1) %></td>
  </tr>
  <tr >
      <td nowrap >当前状态：</td>
      <td nowrap ><%
      	if(apobj.getType()==0)
      	{
      		out.print("待批");
      	}else{
      		if(apobj.getUses()==0){out.print("未使用");}
      	}
       %></td>
  </tr>
  <tr >
      <td nowrap >备注：</td>
      <td ><%=apobj.getRemark() %></td>
  </tr>
  <tr align="center" class="TableControl">
      <td colspan="2">
        <input type="button" value="打印" class="BigButton" onclick="document.execCommand('Print');" title="直接打印表格页面">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" value="关闭" class="BigButton" onClick="window.close();" title="关闭窗口">
      </td>
  </tr>
</TABLE>



</body>
</html>



