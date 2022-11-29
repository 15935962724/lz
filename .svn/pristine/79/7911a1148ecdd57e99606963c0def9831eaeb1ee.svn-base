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
  int nonum = 0;
  int nonum1 = 0;
  sql.append("select state from destine where  member=").append(DbAdapter.cite(teasession._rv._strR));
  try {
    db.executeQuery(sql.toString());
    while (db.next()) {
      if (db.getInt(1) == 1) {
        num++;
      }
      if (db.getInt(1) == 0) {
        nonum++;
      }
      if (db.getInt(1) == 2) {
        nonum1++;
      }
    }
  }
  finally {
    db.close();
  }
  if (num != 0) {
    out.print("<p>您的订单有<span id=logintime><a href=/jsp/registration/myorders.jsp>" + num + "</a>个</span>被审批</p>");
  }
  if (nonum != 0) {
    out.print("<p>您的订单有<span id=logintime><a href=/jsp/registration/myorders.jsp>" + nonum + "</a>个</span>未审批</p>");
  }
  if (nonum1 != 0) {
    out.print("<p>您的订单有<span id=logintime><a href=/jsp/registration/myorders.jsp>" + nonum1 + "</a>个</span>未通过审批</p>");
  }
%>
