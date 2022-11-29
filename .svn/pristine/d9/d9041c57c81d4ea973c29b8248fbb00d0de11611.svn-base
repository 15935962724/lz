<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="tea.entity.site.*"%>
<%@page import="tea.entity.admin.*"%>
<%
  request.setCharacterEncoding("UTF-8");
  response.setHeader("Expires", "0");
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Pragma", "no-cache");
  TeaSession teasession = new TeaSession(request);
  DbAdapter db = new DbAdapter();
  StringBuffer sql = new StringBuffer();
  int num = 0;
  sql.append("select count(*) from caller where type!=1");
  try {
    db.executeQuery(sql.toString());
    if (db.next()) {
      num = db.getInt(1);
    }
  }
  finally {
    db.close();
  }
  if (num != 0) {
    out.println("<p>还有<span id=logintime><A href=/jsp/registration/callertype.jsp>" + num + "</A></span>个话务员待审核</p>");
  }
%>
