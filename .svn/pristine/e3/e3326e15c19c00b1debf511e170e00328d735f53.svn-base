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
int caid = 0;
if(teasession.getParameter("caid")!=null && teasession.getParameter("caid").length()>0)
	caid = Integer.parseInt(teasession.getParameter("caid"));
String cargenrename=null;
Cargenre caobj = Cargenre.find(caid);
if(caid>0)
{
	cargenrename = caobj.getCargenrename();
}
if(teasession.getParameter("delete")!=null)
{
	caobj.delete();
	response.sendRedirect("/jsp/admin/vehicle/cargenre.jsp");
	return;
}
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
<h1>车辆类型添加 </h1>
<div id="head6"><img height="6" src="about:blank"></div>
<br>
<form name=form1 METHOD=post  action="/servlet/EditCargenre" onsubmit="return sub(this);">
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
<input type="hidden" value="<%=caid %>" name="caid">

	<tr id="tableonetr">
	      <td nowrap align="center">类型：<input typ="text" value="<%if(cargenrename!=null)out.print(cargenrename); %>" name="cargenrename" size=25>&nbsp;<input type="submit" value="提交">&nbsp;<input type="button"  value="返回" class="BigButton" name="back" onClick="history.back();"> </td>
	     
	      
    </tr>

</TABLE>
</FORM>


</body>
</html>



