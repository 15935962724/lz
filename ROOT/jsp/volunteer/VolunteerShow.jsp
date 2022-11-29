<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.resource.Resource" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.ui.TeaSession" %>
<%@page import="tea.entity.*"%><%@page import="tea.entity.volunteer.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.resource.*" %><%@page import="java.io.*" %>
<%
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);
String community=teasession._strCommunity;
java.util.Date date = new java.util.Date();


%>

<%
java.util.Enumeration eu = Volunteer.findByCommunity(teasession._strCommunity," and type=1 ",0,100);
if(!eu.hasMoreElements())
{
  out.print("<li>暂时没有信息</li>");
}
for(int i=0;eu.hasMoreElements();i++)
{
  String member = String.valueOf(eu.nextElement());
  Volunteer vt  =  Volunteer.find(member);
  Profile pro = Profile.find(member);

  %>

    <li>
    <span id="min_tu"><img alt="" src="<%=pro.getPhotopath(teasession._nLanguage)%>"/></span>
    <span id="min_zi"><%=Common.CSVCITYS[pro.getProvince(teasession._nLanguage)][1]%><%=pro.getCity(teasession._nLanguage)%>----<%=pro.getName(teasession._nLanguage)%></span>
    </li>
  <%
  }
  %>
