<%@page contentType="text/html; charset=UTF-8"%><%@page import="java.util.*"%>
<%@page import="tea.entity.*"%><%
Http h=new Http(request,response);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'model.jsp' starting page</title>
    
	<link href="/res/<%=h.community%>/cssjs/community.css" rel="stylesheet" type="text/css">

  </head>
  
  <body>
    <button class="btn btn-default" type="submit">返回</button>
    <button class="btn btn-primary" type="submit">按钮</button>
    <button type="button" class="btn btn-link" onclick="">删除</button>
    
    <button class="btn btn-primary btn-xs" type="submit">选择弹出</button>
    <button class="btn btn-primary btn-sm" type="submit">查询</button>
  </body>
</html>
