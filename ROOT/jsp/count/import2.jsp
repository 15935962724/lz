<%@page contentType="text/html;charset=UTF-8"  %>
<%request.setCharacterEncoding("UTF-8");
if(request.getMethod().equals("POST"))
{
  Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
  java.sql.Connection conn=java.sql.DriverManager.getConnection("jdbc:odbc:"+request.getParameter("count"));
  java.sql.Statement statement=conn.createStatement();
  String community = request.getParameter("community");
  tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
  try {//日统计
  java.sql.ResultSet rs=statement.executeQuery("SELECT cDay,cTDC,cCDC,DMD FROM cD");
  while(rs.next())
  {
    int day=rs.getInt(1);
    int sum=rs.getInt(3);
    int count=rs.getInt(2);
    java.util.Date time=rs.getDate(4);
    dbadapter.executeUpdate("IF exists (SELECT * FROM NodeAccessDay WHERE community="+dbadapter.cite(community)+" AND [day]="+day+")"+
    "  UPDATE NodeAccessDay SET  [count]= "+count+",[sum]="+sum+",[time]="+dbadapter.cite( time)+" WHERE  community="+dbadapter.cite(community)+" AND [day]="+day+
    " ELSE "+
    "   INSERT INTO NodeAccessDay([community],[day]      ,[count]    ,[sum]      ,[time]  )VALUES("+dbadapter.cite(community)+","+day+","+count+","+sum+","+dbadapter.cite( time)+")");
  }
  rs.close();
  //小时统计
  rs=statement.executeQuery("SELECT cHour,cTHC,cCHC,HMD FROM cH");
  while(rs.next())
  {
    int hour=rs.getInt(1);
    int count=rs.getInt(2);
    int sum=rs.getInt(3);
    java.util.Date time=rs.getDate(4);
    dbadapter.executeUpdate("IF exists (SELECT * FROM NodeAccessHour WHERE community="+dbadapter.cite(community)+" AND [hour]="+hour+")"+
    "  UPDATE NodeAccessHour SET  [count]= "+count+",[sum]="+sum+",[time]="+dbadapter.cite( time)+" WHERE  community="+dbadapter.cite(community)+" AND [hour]="+hour+
    " ELSE "+
    " INSERT INTO NodeAccessHour(community,[hour],[count],[sum],[time])VALUES("+dbadapter.cite(community)+","+hour+","+count+","+sum+","+dbadapter.cite( time)+")");
  }
  rs.close();
  //月统计
  rs=statement.executeQuery("SELECT cMonth,cTMC,cCMC,MMD FROM cM");
  while(rs.next())
  {
    int month=rs.getInt(1);
    int count=rs.getInt(2);
    int sum=rs.getInt(3);
    java.util.Date time=rs.getDate(4);
    dbadapter.executeUpdate("IF exists (SELECT * FROM NodeAccessMonth WHERE community="+dbadapter.cite(community)+" AND [month]="+month+")"+
    "  UPDATE NodeAccessMonth SET  [count]= "+count+",[sum]="+sum+",[time]="+dbadapter.cite( time)+" WHERE  community="+dbadapter.cite(community)+" AND [month]="+month+
    " ELSE "+
    " INSERT INTO NodeAccessMonth(community,[month],[count],[sum],[time])VALUES("+dbadapter.cite(community)+","+month+","+count+","+sum+","+dbadapter.cite( time)+")");
  }
  rs.close();
  //来源统计
  rs=statement.executeQuery("SELECT cReferer,cCRC FROM cR");
  while(rs.next())
  {
    String referer=rs.getString(1);
    int sum=rs.getInt(2);
    java.util.Date time=new java.util.Date();//rs.getDate(3);
    dbadapter.executeUpdate("IF exists (SELECT * FROM NodeAccessReferer WHERE community="+dbadapter.cite(community)+" AND [referer]="+dbadapter.cite(referer)+")"+
    "  UPDATE NodeAccessReferer SET  [sum]="+sum+",[time]="+dbadapter.cite( time)+" WHERE  community="+dbadapter.cite(community)+" AND [referer]="+dbadapter.cite(referer)+
    " ELSE "+
    " INSERT INTO NodeAccessReferer(community,referer,[sum],[time])VALUES("+dbadapter.cite(community)+","+dbadapter.cite(referer)+","+sum+","+dbadapter.cite( time)+")");
  }
  rs.close();
  //地区统计
  rs=statement.executeQuery("SELECT cWhere,cCWC FROM cW");
  while(rs.next())
  {
    String where=rs.getString(1);
    if(where!=null)
    where=new String(where.getBytes("GB2312"),"ISO-8859-1");
    int sum=rs.getInt(2);
    java.util.Date time=new java.util.Date();
    dbadapter.executeUpdate("IF exists (SELECT * FROM NodeAccessWhere WHERE community="+dbadapter.cite(community)+" AND [where]="+dbadapter.cite(where)+")"+
    "  UPDATE NodeAccessWhere SET  [sum]="+sum+",[time]="+dbadapter.cite( time)+" WHERE  community="+dbadapter.cite(community)+" AND [where]="+dbadapter.cite(where)+
    " ELSE "+
    " INSERT INTO NodeAccessWhere(community,[where],[sum],[time])VALUES("+dbadapter.cite(community)+","+dbadapter.cite(where)+","+sum+","+dbadapter.cite( time)+")");
  }
  rs.close();
}catch (Exception e) {
     e.printStackTrace();
      out.print(community + "<hr>" + e.getMessage());
      dbadapter.rollback();
      return;
    }
    finally {
      dbadapter.close();
      statement.close();
      conn.close();
    }
    out.println("<script>alert('大功告成.');history.back();</script>");
    return;
}
%>
<html>
<head>
</head>
<body>
<form action="" method="post">
数据源:<input type="text" name="count"><br/>
社区名:<input type="text" name="community">
<input type="submit" name="Submit" value="Submit">
</form>
</body>
</html>


