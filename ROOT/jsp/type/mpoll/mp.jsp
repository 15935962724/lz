<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.type.mpoll.*" %><%@page import="tea.entity.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");


DbAdapter db=new DbAdapter();
try
{
  db.executeQuery("SELECT answer,COUNT(answer) FROM mvote WHERE total=100 AND deleted=0 GROUP BY answer HAVING COUNT(answer)>1 ORDER BY COUNT(answer) DESC");
  while(db.next())
  {
    String str=db.getString(1);
    ArrayList al=Vote.find(" AND answer="+DbAdapter.cite(str),0,200);
    for(int i=1;i<al.size();i++)
    {
      Vote t=(Vote)al.get(i);
      t.delete();
    }
  }
}finally
{
  db.close();
}

int last=0;
db=new DbAdapter();
try
{
  db.setAutoCommit(false);
  while(last!=-1)
  {
    out.println(last);
    out.flush();

    ArrayList al=Vote.find(" AND vote>"+last+" AND random IS NULL ORDER BY vote",0,1000);
    if(al.size()<1)break;
    for(int i=0;i<al.size();i++)
    {
      Vote t=(Vote)al.get(i);
      last=t.vote;
      double r=0;
      do
      {
        r=Math.random();
        db.executeQuery("SELECT vote FROM "+Poll.PR+"Vote WHERE random="+r);
      }while(db.next());
      db.executeUpdate("UPDATE "+Poll.PR+"Vote SET random="+r+" WHERE vote="+t.vote);
    }
    db.commit();
  }
}finally
{
  db.setAutoCommit(true);
  db.close();
}

%>
ok

|13104408|13104395|13105109|13104399|13104405|13104394|13104409|13105054|
