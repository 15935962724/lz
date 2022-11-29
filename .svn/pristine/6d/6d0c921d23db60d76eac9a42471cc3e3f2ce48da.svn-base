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
     parent.menu_main.location="query.php?VU_STATUS=0";
   menu_id=1;
   menu_1.bgColor='#D9E8FF';
   menu_2.bgColor='#DDDDDD';
   menu_3.bgColor='#DDDDDD';
   menu_4.bgColor='#DDDDDD';
}

function view_menu2()
{
   parent.menu_main.location="query.php?VU_STATUS=1";
   menu_id=2;
   menu_1.bgColor='#DDDDDD';
   menu_2.bgColor='#D9E8FF';
   menu_3.bgColor='#DDDDDD';
   menu_4.bgColor='#DDDDDD';
}

function view_menu3()
{
   parent.menu_main.location="query.php?VU_STATUS=2";
   menu_id=3;
   menu_1.bgColor='#DDDDDD';
   menu_2.bgColor='#DDDDDD';
   menu_3.bgColor='#D9E8FF';
   menu_4.bgColor='#DDDDDD';
}

function view_menu4()
{
   parent.menu_main.location="query.php?VU_STATUS=3";
   menu_id=4;
   menu_1.bgColor='#DDDDDD';
   menu_2.bgColor='#DDDDDD';
   menu_3.bgColor='#DDDDDD';
   menu_4.bgColor='#D9E8FF';
}

</script>
</head>

<body topmargin="0" leftmargin="0" onload="view_menu1()">

<table class="big" cellspacing="0" height="100%" width="100%" bgcolor="#DDDDDD" border="1" cellpadding="1" bordercolorlight="#000000" bordercolordark="#FFFFFF">
 <tr>

   <td width="150" title="等待批准的车辆申请" id="menu_1" onclick="view_menu1()" onmouseover="setPointer(this, '#B3D1FF',1)" onmouseout="setPointer(this, '#DDDDDD',1)" style="cursor:hand">
       <b><font color="#000000"><a href="javascript:;" onClick="window.open('/jsp/admin/vehicle/checkup/query1.jsp?us=0','function_fun');" style="text-decoration:none"> 待批申请</a></font></b>
   </td>

   <td width="150" title="已经被批准的车辆申请" id="menu_2" onclick="view_menu2()" onmouseover="setPointer(this, '#B3D1FF',2)" onmouseout="setPointer(this, '#DDDDDD',2)" style="cursor:hand">
       <b><font color="#000000"><a href="javascript:;" onClick="window.open('/jsp/admin/vehicle/checkup/query1.jsp?us=1','function_fun');" style="text-decoration:none">  已准申请</a></font></b>
   </td>
   
   <td width="150" title="正在使用的车辆" id="menu_3" onclick="view_menu3()" onmouseover="setPointer(this, '#B3D1FF',3)" onmouseout="setPointer(this, '#DDDDDD',3)" style="cursor:hand">
       <b><font color="#000000"><a href="javascript:;" onClick="window.open('/jsp/admin/vehicle/checkup/query1.jsp?us=2','function_fun');" style="text-decoration:none">  使用中车辆</a></font></b>
   </td>
   
   <td width="150" title="未被批准的车辆申请" id="menu_4" onclick="view_menu4()" onmouseover="setPointer(this, '#B3D1FF',4)" onmouseout="setPointer(this, '#DDDDDD',4)" style="cursor:hand">
       <b><font color="#000000"><a href="javascript:;" onClick="window.open('/jsp/admin/vehicle/checkup/query1.jsp?us=-1','function_fun');" style="text-decoration:none">  未准申请</a></font></b>
   </td>
   <td>

   </td>
   </tr>
</TABLE>







</body>
</html>



