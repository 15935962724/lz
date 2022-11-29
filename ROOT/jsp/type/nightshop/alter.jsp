<%@page contentType="text/html;charset=UTF-8" %>
<%
  /*
   JdbcDriver=com.inet.tds.TdsDriver
   Url=jdbc:inetdae:127.0.0.1:1433?database=ts&sql7=true
   UserId=sa
   Password=123
   MaxConnections=100
   */
  try {
    Class.forName("com.inet.tds.TdsDriver");
  }
  catch (Exception e) {
    e.printStackTrace();
  }
java.sql.Connection conn=  java.sql.DriverManager.getConnection("jdbc:inetdae:127.0.0.1:1433?database=ts&sql7=true","sa","123");
java.sql.Statement statement=conn.createStatement();
tea.db.DbAdapter dbadapter=new tea.db.DbAdapter();
java.sql.ResultSet resultset=statement.executeQuery("SELECT node,text FROM NodeLayer WHERE not NodeLayer.text is null AND node in(select node From Node Where type=45)");
while(resultset.next())
{
  int node=resultset.getInt(1);
  String text=resultset.getString(2);
 dbadapter.executeUpdate("UPDATE NodeLayer SET text="+dbadapter.cite(text)+" WHERE node="+node+" AND DATALENGTH(text)=0");
// dbadapter.executeUpdate("UPDATE NightShop SET Intro=(SELECT top 1 text FROM NodeLayer WHERE node="+node+" AND DATALENGTH(text)=0) WHERE node="+node);
}
dbadapter.close();



%>

