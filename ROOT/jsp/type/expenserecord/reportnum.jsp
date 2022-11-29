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
  sql.append("select count(*) from report where node in (select node from node where rcreator in(select rmember from favorite where rmember=").append(db.cite(teasession._rv._strR)).append("))");
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
    out.print("您收藏的酒店有新上传了<span id=logintime><a href=/jsp/node/FavoriteNodes.jsp>" + num + "</a></span>条新闻");
  }
%>
