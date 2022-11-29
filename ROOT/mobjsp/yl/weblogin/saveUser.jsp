<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.ui.TeaSession"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
</head>
<%
Http h=new Http(request,response);
TeaSession teasession=new TeaSession(request);
String name = h.get("name");
String pwd = h.get("pwd");
String act = h.get("act");
String access_token = h.get("access_token");
String openid = h.get("openid");
String member = (String)Profile.find(" AND  " + DbAdapter.cite(name) + " IN(member,mobile,email)", 0, 1).nextElement();
Profile p = Profile.find(member);
if(act.equals("qq")){
	p.setqqopenid(openid);
}else if(act.equals("wb")){
	p.setwbopenid(openid);
}else if(act.equals("wx")){
	p.setwxopenid(openid);
}
//out.print("<script>location='/';</script>");
out.print("<script>location='/html/folder/2695-1.htm';</script>");
%>
<body>

</body>
</html>