
<%@page contentType="text/html;charset=UTF-8"  %>


<%
   request.setCharacterEncoding("UTF-8");
	
	//System.out.println("接受访问");
	//System.out.println(request.getParameter("act"));
	//成绩录入接受参数
	String xmlpassword = request.getParameter("xmlpassword");
	String xmlcontent  = request.getParameter("xmlcontent");
	
	
	 
	System.out.println("xmlpassword:"+xmlpassword);
	System.out.println("xmlcontent:"+xmlcontent);
	if(!"123456".equals(xmlpassword))
	{
		out.print("您的密码不正确，请确认密码!");
		
		return;
	}
	
	if(xmlcontent!=null && xmlcontent.length()>0)
	{
		System.out.println("接受成绩录入:");
		System.out.println(xmlcontent);
		out.print("成绩查询成功!");
		out.print("返回xml格式字符");
		return;
	}else
	{
		out.print("成绩查询的xml格式不正确!");
		return;
	}
	
	 
	
	/*
	 StringBuffer   sp   = new StringBuffer();
	 sp.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	 sp.append("<golfScore>");
	 sp.append("<DeviceID>S13002080912180010</DeviceID>");
	 sp.append("<DateTime>20100429095751</DateTime>");
	 sp.append("</golfScore>");
	 */
	/* sp.append("<HD>");
	 sp.append("<disk name=\"C\">");
	 sp.append("<capacity>8G</capacity>");
	 sp.append("<directories>200</directories>");
     sp.append("<files>1580</files>");
	 sp.append("</disk>");
	 sp.append("<disk name=\"D\"> ");
	 sp.append("<capacity>10G</capacity>");
	 sp.append("<directories>500</directories>");
	 sp.append("<files>3000</files> ");
	 sp.append("</disk>");
	 sp.append("</HD>");
	 */
	 
	//out.println(sp.toString());  
	//GolfSynchronous.getXML(sp.toString()); //tea.entity.golf.GolfSynchronous
	
%>


