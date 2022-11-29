<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.westrac.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");



DbAdapter db=new DbAdapter(),d2=new DbAdapter();
d2.setAutoCommit(false);
try
{
  out.print("<hr>重定向：");
  db.executeQuery("SELECT node,redirecturl FROM Node WHERE "+db.length("redirecturl")+">0");
  while(db.next())
  {
    int node=db.getInt(1);
    out.print(node+",");
    out.flush();
    d2.executeUpdate("UPDATE NodeLayer SET clickurl="+DbAdapter.cite(db.getString(2))+" WHERE node="+node);
  }

  <input type="hidden" id="radiationSafetyUrl" name="radiationSafetyUrl" /> <input type="file" id="radiationSafety"  value="上传文件">print("<hr>友情链接：");
  db.executeQuery("SELECT node,language,url,logo FROM Link");
  while(db.next())
  {
    int node=db.getInt(1);
    int lang=db.getInt(2);
    out.print(node+",");
    out.flush();
    d2.executeUpdate("UPDATE NodeLayer SET clickurl="+DbAdapter.cite(db.getString(3))+",picture="+DbAdapter.cite(db.getString(4))+" WHERE node="+node+" AND language="+lang);
  }

  out.print("<hr>发生时间：");
  db.executeQuery("select node,issuetime from report WHERE issuetime IS NOT NULL");
  while(db.next())
  {
    int node=db.getInt(1);
    if(node%1000==0)
    {
      out.print(node+",");
      out.flush();
      d2.commit();
    }
    d2.executeUpdate("UPDATE Node SET starttime="+DbAdapter.cite(db.getDate(2))+" WHERE node="+node);
  }

  out.print("<hr>导语：");
  db.executeQuery("select node,language,logograph from ReportLayer where DATALENGTH(logograph)>0");
  while(db.next())
  {
    int node=db.getInt(1);
    int lang=db.getInt(2);
    if(node%1000==0)
    {
      out.print(node+",");
      out.flush();
      d2.commit();
    }
    d2.executeUpdate("UPDATE NodeLayer SET description="+DbAdapter.cite(db.getString(3))+" WHERE node="+node+" AND language="+lang);
  }
  d2.commit();
  d2.setAutoCommit(true);
}finally
{
  db.close();
  d2.close();
}

%>
ok
