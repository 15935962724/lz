<%@page import="tea.entity.plane.PlaneBooking"%>
<%@page import="java.util.Enumeration"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%
Http h=new Http(request);
%>
<%
 Enumeration e=PlaneBooking.find("", 0, 1000);
while(e.hasMoreElements()){
	int id=((Integer) e.nextElement()).intValue();
	PlaneBooking p=PlaneBooking.find(id);
%>
<a href="/mobjsp/plane/planeDatail.jsp?id=<%=p.id%>">
<span id="block">
<div class="name"><%=p.name %></div>
<div class="address"><%=p.address %></div>
</span>
</a>
<%
}
%>
<script src="/tea/mt.js"></script>