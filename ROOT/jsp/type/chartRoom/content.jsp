
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
//return;
}
 %>
 <link href="/res/<%=teasession._strCommunity%>/cssjs/community.css" rel="stylesheet" type="text/css">

 <style>  
<!--
#conten_id font,#conten_id strong,#conten_id{font-size:14px;}
-->
</style>
<%

if(session.getAttribute("username").equals("null")){
	out.println("<script language='javascript'>alert('您还没有登录不能进入本聊天室');parent.location.href='login.html';</script>");
}
if(session.getAttribute("username").equals("request.getParameter("+request.getParameter("tempuser")+")")){
	out.println("<script language='javascript'>alert('请重新选择聊天对象');</script>");
} 
String message=request.getParameter("message");
String select=request.getParameter("selectwx");
String tempuser=request.getParameter("tempuser");
String color=request.getParameter("color");
if(message!=null&&tempuser!=null){
	if(message.startsWith("<")){
		out.print("<marquee direction='left' scrollamount='23'>"+
		"<font color='blue'>"+"请不要输入带有标记的特殊符号"+"</font>"+"</marquee>");
		return;
	}else if(message.endsWith(">")){
		out.print("<marquee direction='left' scrollamount='25'>"+
		"<font color='blue'>"+"请不要输入带有标记的特殊符号"+"</font>"+"</marquee>");
		return;
	}
	
	if(application.getAttribute("message")==null){	//第一个人说话时
		application.setAttribute("message","<br>"+"<font color='blue' style=font-size:14px;>"+
		"<strong>"+session.getAttribute("username")+"</strong>"+"</font>"+"<font color='#CC0000'>"+select+"</font>"+"对"+"<font color='green'>"+"["+tempuser+"]"+"</font>"+"说："+"<font color="+color+">"+message+"&nbsp;"+Entity.sdf2.format(new Date()));
	}else{
		application.setAttribute("message",application.getAttribute("message")+"<br><font color='blue' style=font-size:14px;>"+"<strong>"+session.getAttribute("username")+"</strong>"+"</font>"+"<font color='#CC0000'>"+select+"</font>"+"对"+"<font color='green' style=font-size:14px;>"+"["+tempuser+"]"+"</font>"+"说："+"<font color="+color+" style=font-size:14px;>"+message+"</font>&nbsp;"+Entity.sdf2.format(new Date()));
	}
	    

 

	String community = teasession._strCommunity;

 
    String attach = teasession.getParameter("attach");

	if(attach != null && attach != null)
	{
	    File f = new File(getServletContext().getRealPath(attach)); 
	    BufferedImage bi = ImageIO.read(f);
	    if(bi != null)
	    {
	        ZoomOut zo = new ZoomOut();
	        bi = zo.imageZoomOut(bi,300,200);
	        ImageIO.write(bi,"JPEG",f);
	    }
	} 

	
	
	
	
	 
 
  
	if(message.trim().length() != 0 ) 
	{
	    Chat.create(teasession._nNode,teasession._rv,0,teasession._rv,teasession._nLanguage,message,attach);
	}
	
	
	
	out.println("<p>"+application.getAttribute("message")+"<p>");
}else{
	if(application.getAttribute("message")==null){
		out.println("<font color='#cc0000'>"+application.getAttribute("ul")+"</font>"+"<font color='green'>"+"走进了网络聊天室"+"</font>");
		out.println("<br>"+"<center>"+"<font color='#aa0000''>"+"请各位聊友注意聊天室的规则,不要在本聊天室内发表反动言论及对他人进行人身攻击，不要随意刷屏。"+"</font>"+"</center>");
	}else{
	out.println("<span id=conten_id style=font-size:14px; line-height:180%;>"+application.getAttribute("message")+"</span><br><br><a name=topname></a>");
	}
} 
//out.print("<a name=topname></a>"); 
//out.print("<script  language='javascript'>window.location.href='/jsp/type/chartRoom/main.jsp#topname';</script>");
//response.sendRedirect("main.jsp#topname");
return; 
%>