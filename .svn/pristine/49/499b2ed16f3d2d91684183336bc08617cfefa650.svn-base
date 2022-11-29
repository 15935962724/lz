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
  sql.append("select audit from expenserecord where  destine in(select destine from destine where member=").append(DbAdapter.cite(teasession._rv._strR)).append(")");
  try {
    db.executeQuery(sql.toString());
    while (db.next()) {
      if (db.getInt(1) == 1) {
        num++;
      }
      else {
        nonum++;
      }
    }
  }
  finally {
    db.close();
  }
  if (num != 0) {
    out.print("<p>您的消费记录有<span id=logintime><a href=/jsp/type/expenserecord/explist.jsp>" + num + "</a></span>条审核通过</p>");
  }
  if (nonum != 0) {
    out.print("<p>您的消费记录有<span id=logintime><a href=/jsp/type/expenserecord/explist.jsp>" + nonum + "</a></span>条审核未通过</p>");
  }
%>
