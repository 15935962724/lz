<%@page import="tea.entity.MT"%>
<%@page import="sun.misc.BASE64Decoder"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
	<%
		Http h=new Http(request);
		String profile = h.get("profile");
		int pid = 0;
		try{
			pid = Integer.parseInt(MT.dec(profile));
		}catch(Exception e){
			out.print("未知错误");
			return;
		}
		Profile p = Profile.find(pid);
		if(p.profile>0){
			if(p.emailflag==1){
				p.setEmailflag(0);//激活成功
			}
			out.print("激活成功");
		}else{
			out.print("未知错误");
		}
	%>
</body>
</html>