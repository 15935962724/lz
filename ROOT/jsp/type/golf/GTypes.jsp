<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.DbAdapter" %>
<%@page import="tea.entity.member.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.ui.TeaSession" %>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<% request.setCharacterEncoding("UTF-8");

Http h=new Http(request);

TeaSession teasession=new TeaSession(request);
if(teasession._rv == null)
{
  response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
  return;
}

Table.post(Table.GTYPE,h,response);


%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>球场类型管理</title>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<BODY>
<h1>球场类型管理</h1>
<div id="head6"><img height="6" src="about:blank"></div>


<%=Table.list(Table.GTYPE,h,"/jsp/type/golf/EditGType.jsp")%>

</BODY></html> 
