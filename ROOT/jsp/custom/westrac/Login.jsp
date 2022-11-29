<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
   Http http=new Http(request);
   String msg="";
   msg=(String)request.getAttribute("msg");
   String nexturl=http.get("nexturl", "/html/Home/folder/14050119-1.htm");
%>
<input type="hidden" name="nexturl" value="<%=nexturl %>" />
<ul class="listform">
        <li><span>用户名：</span><input class="input" alt="用户名" name="LoginId" type="text" /></li>
        <li><span>密码：</span><input class="input" type="password" name="Password" /></li>
		<li id="spanMsg" style="color: red"><%=MT.f(msg)%></li>
        <li class="lastli"><span>&nbsp;</span><input class="sub" type="submit" value="登录" style="margin-right:10px;" /><input class="sub" type="button" value="注册" onclick="location.href='/html/Home/folder/14050089-1.htm'"/>　</li>
</ul>
