<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Http h=new Http(request,response);
if(h.member<1)
{
  response.sendRedirect("/servlet/StartLogin?community="+h.community);
  return;
}
Profile p=Profile.find(h.member);
if(request.getMethod().equals("POST")){
	int bookingemail=h.getInt("bookingemail");
	p.set("bookingemail", bookingemail);
	p.bookingemail=bookingemail;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>邮件订阅</title>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>
<form action="?" method="post" name="form1" onsubmit="return mt.check(this)">
<input name="bookingemail" type="hidden" value="1">
请输入您的邮箱<input name="email" alt="邮箱" value="<%=p.getEmail()%>">
<%
if(p.bookingemail==1){%>
<a href="###" onclick="form1.bookingemail.value=0;form1.onsubmit='';form1.submit();">取消订阅</a>
<%}
%>
<input type="submit" value="订阅">
</form>

</body>
</html>