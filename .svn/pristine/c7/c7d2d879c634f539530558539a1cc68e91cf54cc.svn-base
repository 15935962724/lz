<%@page contentType="text/html;charset=UTF-8" %>
<%@include file="/jsp/Header.jsp"%>
<%
if(request.getMethod().equals("POST"))
{
  Properties properties = new Properties();
            //properties.load(new FileInputStream(new File(System.getProperty("user.path") + "/WEB-INF/db.properties")));
            properties.load(tea.db.ConnectionPool.class.getResource("/db.properties").openStream());
            try
            {
                Class.forName(properties.getProperty("JdbcDriver")).newInstance();
            } catch (Exception ex)
            {
                ex.printStackTrace();
            }
//            String _strUrl = properties.getProperty("Url");
            java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:inetdae:127.0.0.1:1433?database=" + request.getParameter("db") + "&sql7=true", properties.getProperty("UserId"), properties.getProperty("Password"));
            java.sql.Statement statement = conn.createStatement();
            java.sql.ResultSet resultset =statement.executeQuery("SELECT node,language,bigpicture,commendpicture FROM Goods");
            tea.db.DbAdapter dbadapter=new  tea.db.DbAdapter ();
            while(resultset.next())
            {
              dbadapter.executeUpdate("UPDATE Goods SET bigpicture="+dbadapter.cite(resultset.getString(3))+",commendpicture="+dbadapter.cite(resultset.getString(4))+" WHERE node="+resultset.getInt(1)+" AND language="+resultset.getInt(2));
            }
            dbadapter.close();
            resultset.close();
            statement.close();
            conn.close();
}
%>
<html>
<head>
<link href="/res/<%=node.getCommunity()%>/cssjs/community.css" rel="stylesheet" type="text/css">
<script src="/tea/tea.js" type="text/javascript"></script>
</head>
<body>
<h1><%=r.getString(teasession._nLanguage, "ReverGoodData")%></h1>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="pathdiv"><%=node.getAncestor(teasession._nLanguage)%></div>
<h2><%=r.getString(teasession._nLanguage, "Replace")%></h2>
<FORM name=foNew METHOD=POST action="" onSubmit="return(submitText(this.db,'大哥,你的库名输入错误.'));">
  <input type='hidden' name=Node VALUE="<%=teasession._nNode%>">
  <table>
    <tr>
      <td>源库名:</td>
      <td><input name="db" class="edit_input"  type="text"></td>
    </tr>
  </table>
  <input type="submit" class="edit_button" id="edit_submit"  value="<%=r.getString(teasession._nLanguage, "Submit")%>">
</FORM>
</body>
<SCRIPT>document.foNew.Template.focus();</SCRIPT>
<div id="head6"><img height="6" src="about:blank"></div>
<div id="language"><%=new Languages(teasession._nLanguage,request)%></div>
</html>

