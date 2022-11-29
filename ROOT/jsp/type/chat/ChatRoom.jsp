<%@page contentType="text/html;charset=UTF-8"  %>
<%@ page import="tea.ui.TeaSession"%>
<%@page import="java.util.ArrayList" %>
<%
request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);
if(teasession._rv == null)
{
response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
return;
}
%>

<html>
<head>
<META HTTP-EQUIV=Content-Type CONTENT="text/html; charset=UTF-8">
<link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js"></SCRIPT>
</head>
<%
 


ArrayList al_say=new ArrayList(); 


al_say=(ArrayList)application.getAttribute("accp"); 


for (int says=0;says<al_say.size();says++) 
{ 
%> 
<%=al_say.get(says)%><br /> 
<% 
}  
//www.deepteach.com 
%>
	
%>
 
