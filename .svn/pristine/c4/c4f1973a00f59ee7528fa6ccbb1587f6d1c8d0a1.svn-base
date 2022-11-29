<%@page import="tea.entity.site.Community"%>
<%@page import="tea.entity.order.Order"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="tea.entity.Http"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
<%
Http h=new Http(request);
Community c=Community.find(h.community);
if(h.member<1)
{
  out.print("<script>location.href='/xhtml/"+h.community+"/folder/"+c.getLogin()+"-1.htm?nexturl=/xhtml/"+h.community+"/folder/"+h.node+"-1.htm';</script>");
  return;
}
Profile p=Profile.find(h.member);
%>
<p class="name"><%=p.getFirstName(h.language) %></p>
<p class="mobile"><%=p.getMobile() %></p>
<p class="email"><%=p.getEmail() %></p>

<div class="ord">
<a href="/xhtml/flight737sim/folder/14040068-1.htm" class="a1">我的订单</a>
</div>



<!--<div class="ord"><a href="/mobjsp/plane/MyOrder.jsp" class="a1">我的订单</a></div>-->