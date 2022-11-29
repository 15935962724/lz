
<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*" errorPage="" %>
<%@ page import="java.io.*"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="java.util.Date"%>
<%@page import="tea.entity.RV"%>
<%@page import="tea.entity.Entity"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.entity.util.ZoomOut"%>
<%@page import="java.util.ArrayList" %>


<%@ page import="tea.resource.Resource"%>
<%@ page import="tea.entity.node.*"%>


<%
 	 request.setCharacterEncoding("UTF-8");
TeaSession teasession = new TeaSession(request);

if(teasession._rv == null)
{
response.sendRedirect("/servlet/StartLogin?node="+teasession._nNode+"&nexturl="+java.net.URLEncoder.encode(request.getRequestURI()+"?"+request.getQueryString(),"UTF-8"));
return;
}
 %>
 <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

 <style>  
<!--
#conten_id font,#conten_id strong,#conten_id{font-size:14px;}
-->
</style>
<%



	if(application.getAttribute("message")==null){
		out.println("<font color='#cc0000'>"+application.getAttribute("ul")+"</font>"+"<font color='green'>"+"走进了网络聊天室"+"</font>");
		out.println("<br>"+"<center>"+"<font color='#aa0000''>"+"请各位聊友注意聊天室的规则,不要在本聊天室内发表反动言论及对他人进行人身攻击，不要随意刷屏。"+"</font>"+"</center>");
	}else{
	out.println("<span id=conten_id style=font-size:14px; line-height:180%;>"+application.getAttribute("message")+"</span><br><br><a name=topname></a>");
	}


return; 
%>