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
  sql.append("select count(*) from expenserecord where 1=1");
  sql.append(" and(");
  Citypopedom cobj = Citypopedom.find(teasession._rv.toString()); /*返回一个区域授权对像*/

  if (cobj.getCityid() == null) {
    response.sendError(403);
    return;
  }
  String cm[] = cobj.getCityid().split("/"); /*从区域授权对像中提取授权区域信息*/
  for (int i = 1; i < cm.length; i++) {
    if (cobj.getCityid() != null) {
      /*查看hostel在不在授权的区域中*/
      sql.append(cm[i]).append(" in(select h.city from hostel h,destine d where h.node=d.node and d.destine in (select destine from expenserecord))");
      if (i < cm.length - 1) {
        sql.append("or ");
      }
    }
  }
  sql.append(")");
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
    out.print("<p>还有<span id=logintime><a href=/jsp/type/expenserecord/audit.jsp >" + num + "</a></span>消费记录待审核");
  }
%>
