<%@page import="tea.entity.MT"%>
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
	String email=h.get("email");
	p.set("emailbooking", email);
	p.set("bookingemail", bookingemail);
	p.bookingemail=bookingemail;
	p.emailbooking=email;
}
%>
<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>邮件订阅</title>
<script>
var ls=parent.document.getElementsByTagName("HEAD")[0];
document.write(ls.innerHTML);
var arr=parent.document.getElementsByTagName("LINK");
for(var i=0;i<arr.length;i++)
{
  document.write("<link href='"+arr[i].href+"' rel='"+arr[i].rel+"' type='text/css'>");
}
</script>
<script src="/tea/mt.js" type="text/javascript"></script>
</head>
<body>

<div class='Emailbox'><form action="?" method="post" name="form1" onsubmit="return mt.check(this)">
<input name="bookingemail" type="hidden" value="1">
<ul><li>请输入您的邮箱</li><li><input name="email" class='emailinput' alt="邮箱" value="<%=MT.f(p.emailbooking).length()>0?MT.f(p.emailbooking):MT.f(p.getEmail())%>"></li>
<%
if(p.bookingemail==1){%>
<li><a href="###" onclick="form1.bookingemail.value=0;form1.onsubmit='';form1.submit();">取消订阅</a>
<%}
%>
<input type="submit" value="订阅" class='subtn'></li>
</form>

</div>

</body>
</html>