<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.member.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Expires", "0");
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");

String strPage = request.getParameter("strPage");
String cardtypeid = request.getParameter("cardtypeid");

DbAdapter db = new DbAdapter();

db.executeQuery("select * from storecarte ORDER BY idate DESC");

response.sendRedirect("/jsp/profile/cartewarehouse.jsp?cardtypeid=" + cardtypeid + "&strPage=" + strPage);
%>
