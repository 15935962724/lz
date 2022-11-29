<%@page import="java.text.SimpleDateFormat"%>
<%@page import="tea.entity.plane.PlaneBooking"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.order.Order"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="tea.entity.Http"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%
Http h=new Http(request);
int id=h.getInt("id", 0);
SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
Order o=null;
String address="";
String mobile="";
if(id>0){
	o=Order.find(id);
	PlaneBooking p=PlaneBooking.find(o.planeId);
	address=p.address;
	mobile=p.mobile;
}else{ 
	o=new Order(id);
}
%>
<span class="sp1">恭喜您，预约成功！</span>
<p class="p1">工作人员将在一个工作日审核您预约坐班时间，并电话与您再次确认，如您预约的时间有变，请及时联系我们
<span class="sp2"><%=mobile %></span>
。感谢您的参与和支持！
</p>
<p class="p2">
<a href="/xhtml/flight737sim/folder/14040018-1.htm">返回首页</a>
</p>




