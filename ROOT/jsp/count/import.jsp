<%@page contentType="text/html;charset=UTF-8"%>
<%
  String act = request.getParameter("act");
  if (act != null) {
    java.util.Enumeration enumer = tea.entity.site.Community.find("",0,1000);
    while (enumer.hasMoreElements()) {
      String community = (String) enumer.nextElement();
      tea.db.DbAdapter dbadapter2 = new tea.db.DbAdapter();
      dbadapter2.setAutoCommit(false);
      try {
        if (act.equals("day")) //日统计
          for (int index = 1; index <= 31; index++) {
            int count = dbadapter2.getInt("select count(NodeAccess.access_time) from NodeAccess,Node where NodeAccess.node=Node.node and Node.community='" + community + "' and DateDiff(dd,access_time,getdate())=" + index);
            dbadapter2.executeUpdate("insert into NodeAccessDay VALUES('" + community + "'," + index + ",'0'," + count + ",getdate())");
            java.lang.Thread.sleep(10000);
          }
        else
        if (act.equals("hour")) //24小时统计
          for (int index = 0; index <= 23; index++) {
            int count = dbadapter2.getInt("select count(NodeAccess.access_time) from NodeAccess,Node where NodeAccess.node=Node.node and Node.community='" + community + "' and DateDiff(hh,access_time,getdate())=" + index);
            dbadapter2.executeUpdate("insert into NodeAccessHour VALUES('" + community + "'," + index + ",'0'," + count + ",getdate())");
            java.lang.Thread.sleep(10000);
          }
        else
        if (act.equals("month")) //月统计
          for (int index = 1; index <= 12; index++) {
            int count = dbadapter2.getInt("select count(NodeAccess.access_time) from NodeAccess,Node where NodeAccess.node=Node.node and Node.community='" + community + "' and DateDiff(yy,access_time,getdate())=0 and DateDiff(mm,access_time,getdate())=" + index);
            int sum = dbadapter2.getInt("select count(NodeAccess.access_time) from NodeAccess,Node where NodeAccess.node=Node.node and Node.community='" + community + "' and DateDiff(mm,access_time,getdate())=" + index);
            dbadapter2.executeUpdate("insert into NodeAccessMonth VALUES('" + community + "'," + index + "," + count + "," + sum + ",getdate())");
            java.lang.Thread.sleep(10000);
          }
        else
        if (act.equals("where")) { //地区导入
          dbadapter2.executeQuery("select NodeAccess.IPaddress from NodeAccess,Node  where NodeAccess.node=Node.node and Node.community='" + community + "'");
          while (dbadapter2.next()) {
            tea.entity.node.NodeAccessWhere.set(community, dbadapter2.getString(1));
            java.lang.Thread.sleep(10000);
          }
        }
        dbadapter2.commit();
        out.print(community + "<hr><h1>完成</h1>");
        out.flush();
      }
      catch (Exception e) {
        e.printStackTrace();
        out.print(community + "<hr>" + e.getMessage());
        dbadapter2.rollback();
      }
      finally {
        dbadapter2.close();
      }
    }
  }
%>
<html>
<form method="POST">
<input type="submit" name="act" value="hour"/>
<input type="submit" name="act" value="day"/>
<input type="submit" name="act" value="month"/>
<input type="submit" name="act" value="where"/>
</form>
</html>


