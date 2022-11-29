<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN">
<html>
<head>
<TITLE>员工管理</TITLE>
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<LINK href="user.files/style.css" type=text/css rel=stylesheet>
<META content="MSHTML 6.00.2600.0" name=GENERATOR>
</head>
<FRAMESET border=0 frameSpacing=0 rows=* frameBorder=YES cols=200,*>
  <FRAME name=user_list SRC="/jsp/type/waiter/WaiterZoneList.jsp?node=<%=teasession._nNode%>" frameBorder=NO noResize scrolling=yes>
  <FRAME name="dept_user" SRC="/jsp/type/waiter/WaiterList.jsp?node=<%=teasession._nNode%>&zone=0" noResize scrolling=yes>
</FRAMESET>
</html>

