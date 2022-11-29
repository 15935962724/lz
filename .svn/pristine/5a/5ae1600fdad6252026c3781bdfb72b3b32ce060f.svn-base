<%@page import="tea.entity.site.Community"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%

   Http h=new Http(request);
   String msg="";
   msg=(String)request.getAttribute("msg");
   String nexturl=h.get("nexturl", h.status==0?"/html/":"/xhtml/"+h.community+"");
%>
<form action="/Members.do?act=login" id="1193023168" method="post" name="foLogin" target="_ajax">
<input name="community" type="hidden" value="dandun" />
<input name="nexturl" type="hidden" value="<%=nexturl %>" />
<table border="0" cellpadding="0" cellspacing="0" class="logcon_middle_table">
	<tbody>
		<tr>
			<td>账号：</td>
			<td><input alt="账号" name="LoginId" type="text" /></td>
		</tr>
		<tr>
			<td>密码：</td>
			<td><input name="Password" type="password" /></td>
		</tr>
<!--
		<tr>
			<td>&nbsp;</td>
			<td><input name="Enter" src="/res/flight737sim/structure/1103995.jpg" type="image" value="ok" /></td>
		</tr>
-->
	</tbody>
</table>

<p class="p1"><input name="Enter" type="submit" value="登录" class="sub1" />
<input type="button" class="button" onclick="location.href='/xhtml/papc/folder/14058220-1.htm'" value="我要注册"></p>

</form>
