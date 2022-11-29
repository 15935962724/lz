<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="tea.entity.Http" %>
<%@ page import="tea.resource.Resource" %>
<%@ page import="tea.entity.MT" %>
<%@ page import="tea.entity.Entity" %>
<%@ page import="tea.entity.member.Profile" %>
<%
	Http h=new Http(request); 
	if(h.member<1)
	{
	  response.sendRedirect("/servlet/StartLogin?community="+h.community);
	  return;
	}
	if(h.isIllegal())
	{
	  response.sendError(404,request.getRequestURI());
	  return;
	}
	
	String key=h.get("member");
	int member = key.length() < 1 ? 0 : Integer.parseInt(MT.dec(key));
	
	Profile p =Profile.find(member);
	
	
%>
<html>
<head>
<title>编辑名家信息</title>
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<script src="/tea/script/md5.js" type="text/javascript"></script>
<!--[if IE 6]><style>.tfont{font-family:宋体;}</style><![endif]-->
<style>
#tablecenter td table td{border:0}
</style>
</head>
<body>
<h1>会员信息</h1>
<div id="head6"><img height="6" src="about:blank"></div>
<table>
	<tr>
		<td class="td01">昵称：</td>
		<td><%=MT.f(p.getMember()) %></td>
	</tr>
	<tr>
		<td class="td01">姓名：</td>
		<td><%=MT.f(p.getName(h.language)) %></td>
	</tr>
	<tr>
		<td class="td01">性别：</td>
		<td><%=p.isSex()?"男":"女" %></td>
	</tr>
	<tr>
		<td class="td01">出生日期：</td>
		<td><%=p.getBirthToString() %></td>
	</tr>
	<tr>
		<td class="td01">手机号：</td>
		<td><%=MT.f(p.getMobile()) %></td>
	</tr>
	<tr>
		<td class="td01">邮箱：</td>
		<td><%=MT.f(p.getEmail()) %></td>
	</tr>
	
</table>
<div align="center"><input type="button" value="返回" onClick="window.history.back();"/></div>
</body>
</html>