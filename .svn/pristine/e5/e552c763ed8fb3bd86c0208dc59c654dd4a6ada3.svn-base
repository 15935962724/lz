<%@page contentType="text/html;charset=UTF-8"%><%@page import="tea.db.*" %><% request.setCharacterEncoding("UTF-8");
String driver=request.getParameter("driver");
if(driver==null||driver.length()==0)
{
  driver="com.microsoft.jdbc.sqlserver.SQLServerDriver";//"sun.jdbc.odbc.JdbcOdbcDriver";
}
String url=request.getParameter("url");
if(url==null||url.length()==0)
{
  url="jdbc:microsoft:sqlserver://127.0.0.1:1433;DatabaseName=edn";//"jdbc:odbc:ts1";
}
String user=request.getParameter("user");
if(user==null||user.length()==0)
{
  user="sa";
}
String password=request.getParameter("password");
if(password==null)
{
  password="";
}
String database=request.getParameter("database");
if(database==null)
{
  database="ts";
}
%>
<html>
<head>
<link href="/tea/CssJs/Home.css" rel="stylesheet" type="text/css">
<SCRIPT LANGUAGE=JAVASCRIPT SRC="/tea/tea.js" type=""></SCRIPT>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<form name="form1" method="post" action="">
<TABLE border="0" CELLPADDING="0" CELLSPACING="0" id="tablecenter">
  <tr>
    <td width="70">JdbcDriver</td>
    <td width="168">
      <input type="text" name="driver" value="<%=driver%>" size="60">
    </td>
  </tr>
  <tr>
    <td>Url</td>
    <td>
      <input type="text" name="url" value="<%=url%>" size="60">
    </td>
  </tr>
  <tr>
    <td>User</td>
    <td>
      <input type="text" name="user" value="<%=user%>">
    </td>
  </tr>
  <tr>
    <td>Password</td>
    <td>
      <input type="text" name="password" value="<%=password%>">
    </td>
  </tr>
    <tr>
    <td>Database</td>
    <td>
      <input type="text" name="database" value="<%=database%>">
    </td>
  </tr>
</table>
<input type="submit" value="提交">
<input type="reset" >
</form>
<%

if(request.getMethod().equals("POST"))
{
  Class.forName(driver);
  java.sql.Connection conn=java.sql.DriverManager.getConnection(url,user,password);
  java.sql.Statement statement=conn.createStatement();
  java.sql.ResultSet rs=statement.executeQuery("SELECT name,id,xtype FROM sysobjects WHERE xtype IN ('U')");
  DbAdapter db=new DbAdapter();
  db.executeQuery("SELECT name,id,xtype FROM sysobjects WHERE xtype IN ('U')");
  out.print("<TABLE border=0 CELLPADDING=0 CELLSPACING=0 id=tablecenter><tr><td colspan=3>不存在的表或过程");
  while(rs.next())
  {
    out.print("<tr><td>"+rs.getString(1)+"<TD>"+rs.getString(2));
  }
  out.print("</TABLE>");
  out.print("<TABLE border=0 CELLPADDING=0 CELLSPACING=0 id=tablecenter><tr><td colspan=3>不存在的列");
  rs= statement.executeQuery("SELECT name,id FROM sysobjects WHERE xtype IN ('U') AND name IN(SELECT name FROM "+database+".dbo.sysobjects WHERE xtype IN ('U')) ORDER BY name");
  while(rs.next())
  {
    String name=rs.getString(1);
    java.sql.Connection conn2=java.sql.DriverManager.getConnection(url,user,password);
    java.sql.Statement statement2=  conn2.createStatement();
//System.out.println("SELECT syscolumns.name,syscolumns.xtype,syscolumns.length FROM sysobjects,syscolumns,"+database+".dbo.sysobjects so,"+database+".dbo.syscolumns sc WHERE syscolumns.id=sysobjects.id AND sysobjects.name='"+name+"' AND so.id=sc.id AND so.name='"+name+"' AND syscolumns.name=sc.name AND (syscolumns.xtype!=sc.xtype OR syscolumns.length!=sc.length OR syscolumns.name NOT IN(SELECT sc.name FROM "+database+".dbo.sysobjects so,"+database+".dbo.syscolumns sc WHERE so.id=sc.id AND so.name='"+name+"') OR sc.name NOT IN(SELECT sc.name FROM sysobjects so,syscolumns sc WHERE so.id=sc.id AND so.name='"+name+"'))");
    java.sql.ResultSet resultset2=  statement2.executeQuery("SELECT syscolumns.name,syscolumns.xtype,syscolumns.length FROM sysobjects,syscolumns,"+database+".dbo.sysobjects so,"+database+".dbo.syscolumns sc WHERE syscolumns.id=sysobjects.id AND sysobjects.name='"+name+"' AND so.id=sc.id AND so.name='"+name+"' AND syscolumns.name=sc.name AND (syscolumns.xtype!=sc.xtype OR syscolumns.length!=sc.length OR syscolumns.name NOT IN(SELECT sc.name FROM "+database+".dbo.sysobjects so,"+database+".dbo.syscolumns sc WHERE so.id=sc.id AND so.name='"+name+"') OR sc.name NOT IN(SELECT sc.name FROM sysobjects so,syscolumns sc WHERE so.id=sc.id AND so.name='"+name+"'))");
    if(resultset2.next())
    {
      out.print("<tr><td>"+name);
      out.print("<tr><td>"+resultset2.getString(1)+"<TD>"+resultset2.getString(2)+"<TD>"+resultset2.getString(3));
      while(resultset2.next())
      {
        out.print("<tr><td>"+resultset2.getString(1)+"<TD>"+resultset2.getString(2)+"<TD>"+resultset2.getString(3));
      }
    }
    resultset2.close();
    statement2.close();
    conn2.close();
  }
  out.print("</TABLE>");

  rs.close();
  statement.close();
  conn.close();
}
%><%!

%>
</body>
</html>

