<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.member.Profile"%>
<%
    Http h2=new Http(request,response);
    int member2 = h2.member;
    if(member2<1)
    {
        response.sendRedirect("/servlet/StartLogin?community="+h.community);
        return;
    }
    Profile p2 = Profile.find(member2);
    %>
<div class="head-lan">
    <div class="head-inne">您的身份类型：<%= Profile.MEMBER_TYPE[p2.membertype] %></div>
</div>