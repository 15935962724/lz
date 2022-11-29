<%@page import="tea.entity.member.WomenOptions"%>
<%@page import="tea.entity.member.Profile"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html;charset=UTF-8"  %>
<%@page import="java.util.*" %>
<%@page import="tea.entity.admin.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.ui.*" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.*" %>
<%@page import="tea.entity.node.*" %> 
<%@page import="tea.entity.node.Event"%>
<%@page import="tea.resource.Resource" %>
<%
request.setCharacterEncoding("UTF-8"); 
TeaSession teasession=new TeaSession(request);
Resource r = new Resource();
r.add("/tea/resource/fashionteam");
Http h=new Http(request);
int node = h.node;
%>
<div class="TypesACT">
<div class="title"><div class="left">查看周边</div></div>
<div class="con">
<a href="/html/folder/6-1.htm?nightshop=<%=node %>" target="_blank">好友</a> | 
<a href="/html/folder/393-1.htm?nightshop=<%=node %>" target="blank">教练</a> | 
<a href="/html/category/494-1.htm?act=&node=494&xpinpai=444&nightshop=<%=node %>" target="_blank">餐饮</a> | 
<a id="nightshopid" href="/html/category/33-1.htm?nightshop=<%=node %>" target="_blank">活动</a> | 
<a href="/html/category/494-1.htm?act=&node=494&xpinpai=447&nightshop=<%=node %>" target="_blank">休闲</a> | 
<a href="/html/category/494-1.htm?act=&node=494&xpinpai=473&nightshop=<%=node %>" target="_blank">地产</a> | 
<a href="/html/category/296-1.htm?nightshop=<%=node %>" target="_blank">球场</a>
</div>
</div>