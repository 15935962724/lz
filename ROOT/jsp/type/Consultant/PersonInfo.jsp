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
	Profile p =Profile.find(h.member);
	
	
%>
<h1><em class="em1">您好，<%=MT.f(p.getMember()) %>，欢迎您登陆拍马网！</em><em class="em2"> 您上次登陆时间：<%=Entity.sdf2.format(p.ltime[1]==null?p.ltime[0]:p.ltime[1]) %></em></h1>
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