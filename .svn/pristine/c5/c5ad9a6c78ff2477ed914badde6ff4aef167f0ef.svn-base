<%@page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.db.DbAdapter" %>
<%@ page  import="tea.resource.Resource"  %>
<%@ page  import="tea.entity.admin.*" %>
<%@ page import="tea.ui.TeaSession" %>
<%@ page import ="java.util.Date" %>
<%
request.setCharacterEncoding("UTF-8");


TeaSession teasession=new TeaSession(request);
if(teasession._rv==null)
{
  response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode);
  return;
}

String community=teasession._strCommunity;
String year = teasession.getParameter("year");
String month = teasession.getParameter("month");
String date = teasession.getParameter("date");
int aaid =0;
if(teasession.getParameter("aid")!=null)
	aaid = Integer.parseInt(teasession.getParameter("aid"));
tea.entity.admin.DayOrder obj = tea.entity.admin.DayOrder.find(aaid);
%>


<html>
<head>
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">

</head>
  <title><%=obj.getAffaircontent() %></title>  
<body>
<br>
<%=year %>-<%=month %>-<%=date %>&nbsp;
<%
	if(obj.getBegintime()<10){
     	 		out.print("0"+obj.getBegintime()+":");
     	 	}else
     	 	{
     	 		out.print(obj.getBegintime()+":");
     	 	}
     	 	if(obj.getBegintime1()<10){
     	 		out.print("0"+obj.getBegintime1());
     	 	}else
     	 	{
     	 		out.print(obj.getBegintime1());
     	 	}
 %>
	：00
<div id="head6"><img height="6" src="about:blank"></div>
<table border="0" cellpadding="0" cellspacing="0" id="tablecenter">
    <tr id="tableonetr">
    	<td nowrap><%=obj.getAffaircontent() %></td>
    </tr>
</table>
 <input type="button" value="关闭"  onClick="javascript:window.close();">
<br>
<div id="head6"><img height="6" src="about:blank"></div>
</body>
</HTML>




