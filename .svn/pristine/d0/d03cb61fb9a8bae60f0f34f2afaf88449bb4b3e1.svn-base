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


<h1>修改密码</h1>

<form action="/Paimas.do" target="_ajax" onsubmit="return mt.check(this)" name="form2">
<input type="hidden" name="act" value="changpwd">
<input type="hidden" name="nexturl" value="">
<input type="hidden" name="member" value="<%=MT.enc(h.member)%>">
<table cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td class="th">昵称：</td>
		<td class="td01"><!-- <input type="text" name="username" min="3" alt="昵称" value="">  --><%=MT.f(p.getMember()) %></td>
	</tr>
	<tr>
		<td class="th">原密码：</td>
		<td class="td01"><input name="pwd" type="password" min="6" value="" size="26" alt="旧密码"></td>
	</tr>
	<tr>
		<td class="th">新密码：</td>
		<td class="td01"><input name="password" type="password" min="6" value="" size="26" alt="新密码"></td>
	</tr>
	<tr>
		<td class="th">确认新密码：</td>
		<td class="td01"><input name="password2" type="password" value="" size="26" alt="确认新密码"></td>
	</tr>
	<tr>
    	<td class="th"></td>
        <td><input type="submit" value="提交" style="width:203px;height:43px;border:none;background:url(/res/Home/structure/bg18.png) center no-repeat;color:#fff;font-size:16px;font-weight:bold;cursor:pointer;"></td>
    </tr>
</table>

</form>
