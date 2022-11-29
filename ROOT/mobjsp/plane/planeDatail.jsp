<%@page import="tea.entity.plane.PlaneBooking"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%
Http h=new Http(request);
int id=h.getInt("id", 0);
PlaneBooking p=PlaneBooking.find(id);
if(p!=null){
%>

<!--<form action="/mobjsp/plane/reserve1.jsp" method="post">-->
<form action="/xhtml/flight737sim/folder/14040060-1.htm" method="post">

<input type="hidden" name="id" value="<%=p.id%>">
<h2>交通信息</h2>	
<p><%=p.address %></p>
<h2>特别提示</h2>	
<p><%=p.content %></p>
<p class="mob">预约电话：<span class="sp1"><%=p.mobile %></span></p>
<table class="tab">
<tr><th>时间（分钟）</th><th>价格（元）</th></tr>
<tr><td>30分钟</td><td><%=p.price30 %></td></tr>
<tr><td class="td1">45分钟</td><td class="td1"><%=p.price45%></td></tr>
<tr><td>60分钟</td><td><%=p.price60 %></td></tr>
<tr><td class="td1">90分钟</td><td class="td1"><%=p.price90 %></td></tr>
<tr><td>180分钟</td><td><%=p.price180 %></td></tr>
</table>
<div class="butt">
<input type="submit" value="预约体验" class="button" > 
</div>
</form>
<%	
}
%>