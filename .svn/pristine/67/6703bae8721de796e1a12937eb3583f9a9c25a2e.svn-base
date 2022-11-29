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
<script>
var menu_id=0;

function setPointer(theRow, thePointerColor,menu_id_over)
{
  if(menu_id!=menu_id_over)
     theRow.bgColor = thePointerColor;
}

function view_menu1()
{
  if(menu_id!=0)
     parent.menu_main.location="/jsp/admin/vehicle/manage1.jsp";
   menu_id=1;
   menu_1.bgColor='#D9E8FF';
   menu_2.bgColor='#DDDDDD';
}

function view_menu2()
{
   parent.menu_main.location="/jsp/admin/vehicle/newamnage.jsp";
   menu_id=2;
   menu_1.bgColor='#DDDDDD';
   menu_2.bgColor='#D9E8FF';
}

</script>


<body topmargin="0" leftmargin="0" onload="view_menu1()">


<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
 <tr>
	
		   <td align="center" width="150" title="车辆信息管理" id="menu_1" onclick="view_menu1()" onmouseover="setPointer(this, '#B3D1FF',1)" onmouseout="setPointer(this, '#DDDDDD',1)" style="cursor:hand">
		      <b><font color="#000000"><a href="javascript:;"  onClick="window.open('/jsp/admin/vehicle/manage1.jsp','function_fun');" style="text-decoration:none"> 车辆信息管理</a></font></b>
		   </td>
		
		   <td align="center" width="150" title="添加车辆" id="menu_2" onclick="view_menu2()" onmouseover="setPointer(this, '#B3D1FF',2)" onmouseout="setPointer(this, '#DDDDDD',2)" style="cursor:hand">
		       <b><font color="#000000"> <a href="javascript:;" onClick="window.open('/jsp/admin/vehicle/newamnage.jsp','function_fun');" style="text-decoration:none">添加车辆</a></font></b>
		   </td>
 </tr>
</TABLE>



</body>
</html>



