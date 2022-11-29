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

<h1>修改基本信息</h1>

<form action="/Paimas.do" target="_ajax" onsubmit="return mt.check(this)" name="form2">
<input type="hidden" name="act" value="pmwEdit">
<input type="hidden" name="member" value="<%=MT.enc(h.member)%>">
<input type="hidden" name="nexturl" value="">
<table cellpadding="0" cellspacing="0" id="tablecenter">
	<tr>
		<td class="th">昵称：</td>
		<td class="td01"><!-- <input type="text" name="username" min="3" alt="昵称" value="">  --><%=MT.f(p.getMember()) %></td>
	</tr>
	<tr>
		<td class="th">姓名：</td>
		<td class="td01"><input name="name" type="text"  value="<%=MT.f(p.getName(h.language)) %>" size="40"></td>
	</tr>
	<tr>
		<td class="th">性别：</td>
		<td class="td01"><input type="radio" name="sex" <%if(p.isSex())out.print("checked"); %> value="true"><label>男</label><input type="radio" name="sex" value="false" <%if(!p.isSex())out.print("checked"); %>><label>女</label> </td>
	</tr>
	<tr>
		<td class="th">出生日期：</td>
		<td class="td01"><input name="ttime" class="date" onClick="mt.date(this,false,null)" value="<%=p.getBirthToString() %>" size="40" style="background:#f9f9f9 url(/res/Home/structure/list10.png) right center no-repeat;" >
		</td>
	</tr>
	<tr>
		<td class="th">手机号：</td>
		<td class="td01"><input name="mobile" type="text"  value="<%=MT.f(p.getMobile()) %>" size="40"></td>
	</tr>
	<tr>
		<td class="th">邮箱：</td>
		<td class="td01"><input name="email" type="text" value="<%=MT.f(p.getEmail()) %>" size="40" alt="邮箱"></td>
	</tr>
    <tr>
    	<td class="th"></td>
        <td><input type="submit" value="提交" style="width:203px;height:43px;border:none;background:url(/res/Home/structure/bg18.png) center no-repeat;color:#fff;font-size:16px;font-weight:bold;cursor:pointer;"></td>
    </tr>
	
</table>
	
</form>
