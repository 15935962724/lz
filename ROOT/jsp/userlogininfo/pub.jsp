<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.node.*"%><%@page import="tea.entity.member.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>

<%//*****************查看用户上 次的登录时间************************
  request.setCharacterEncoding("UTF-8");
  response.setHeader("Expires", "0");
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Pragma", "no-cache");
  TeaSession teasession = new TeaSession(request);

  String date=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(Logs.getLastLogin(teasession._rv._strR));


%>


    <%
      out.print("您上次登录时间为：");
      out.print("<span id=logintime>");
      out.print(date);
      out.print("</span>");
    %>

