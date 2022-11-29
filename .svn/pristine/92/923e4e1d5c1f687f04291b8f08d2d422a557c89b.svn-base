<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
//String community=teasession._strCommunity;
//java.util.Date date = new java.util.Date();

//int count=Volunteer.count(community,"");

%>

<%
//java.util.Enumeration eu = Volunteer.findByCommunityprofile(teasession._strCommunity," and  member in (select member from volunteer where  type=1 ) order by city desc  ",0,count);
//if(!eu.hasMoreElements())
//{
//  out.print("<li>暂时没有信息</li>");
//}
//for(int i=0;eu.hasMoreElements();i++)
//{
//  String member = String.valueOf(eu.nextElement());
//  Volunteer vt  =  Volunteer.find(member);
//  Profile pro = Profile.find(member);
//  String sexy = pro.isSex()?"男":"女";
for(int i=0;i<Volunteer.CITYS.length;i++)
{
  %>
  <li>
    <span id="xinmin"><a href="/jsp/volunteer/Volunteersearch.jsp?choose=4&num=<%=i%>"> <%=Volunteer.CITYS[i]%></a></span>
  </li>
  <%
  }
  %>
