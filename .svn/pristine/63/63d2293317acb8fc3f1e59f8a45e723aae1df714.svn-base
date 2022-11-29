<%@page import="tea.db.*" %><%


DbAdapter db=new DbAdapter();
DbAdapter db2=new DbAdapter();
DbAdapter db3=new DbAdapter();
try
{
  db.executeQuery("select id from listingdetail group by id having count(id)>1");
  while(db.next())
  {
    String id=db.getString(1);
    db2.executeQuery("SELECT id2 FROM listingdetail WHERE id="+db2.cite(id));
    db2.next();
    while(db2.next())
    {
      db3.executeUpdate("DELETE FROM listingdetail WHERE id2="+db2.getInt(1));
      System.out.println(id);
    }
  }
}catch(Exception ex)
{
  ex.printStackTrace();
}finally
{
  db.close();
  db2.close();
  db3.close();
}

%>
完成

