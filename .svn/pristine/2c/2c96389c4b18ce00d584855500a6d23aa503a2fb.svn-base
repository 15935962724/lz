<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%
  //*****************查看用户上 次的登录时间************************
  request.setCharacterEncoding("UTF-8");
  response.setHeader("Expires", "0");
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Pragma", "no-cache");
  TeaSession teasession = new TeaSession(request);
  DbAdapter db = new DbAdapter();
  StringBuffer sql = new StringBuffer();
  String date = null;
  int nodeNum = 0;
  sql.append("select max(time) from log where time <(select max(time)from log where rmember='").append(teasession._rv._strR).append("')");
  try {
    db.executeQuery(sql.toString());
    if (db.next()) {
      java.util.Date current = db.getDate(1);
      java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
      date = sdf.format(current);
    }
  }
  catch (Exception s) {
  }
  finally {
    db.close();
  }
  out.print("您上次登录时间为：");
  out.print("<span id=logintime>");
  out.print(date);
  out.print("</span>");
%>
