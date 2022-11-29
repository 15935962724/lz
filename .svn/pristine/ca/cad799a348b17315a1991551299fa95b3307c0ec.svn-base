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
  sql.append("SELECT count(*) FROM Node n,Citypopedom c,Hostel h WHERE n.rcreator = c.member and n.node=h.node and n.father=5 and n.hidden !=0");
  try {
    java.util.Enumeration ae = AdminUsrRole.find(teasession._strCommunity, " and member =" + DbAdapter.cite(teasession._rv.toString()) + " and role like " + DbAdapter.cite("%/" + 5 + "/%"), 0, Integer.MAX_VALUE);
    if (ae.hasMoreElements()) {
      Citypopedom cobj = Citypopedom.find(teasession._rv.toString());
      if (cobj.getCityid() == null) {
        response.sendError(403);
        return;
      }
      String cm[] = cobj.getCityid().split("/");
      sql.append("  and (");
      for (int i = 1; i < cm.length; i++) {
        if (cobj.getCityid() != null) {
          sql.append("  h.city =").append(Integer.parseInt(cm[i]));
        }
        if (cm.length - 1 > i) {
          sql.append("  or ");
        }
      }
      sql.append(")");
    }
    //out.print(sql.toString());
    db.executeQuery(sql.toString());
    if (db.next()) {
      num = db.getInt(1);
    }
  }
  finally {
    db.close();
  }
  if (num != 0) {
    out.println("<p>还有<span id=logintime><A href=/jsp/demo/hotelaudits.jsp?father=5>" + num + "</A></span>个酒店待审核</p>");
  }
%>
