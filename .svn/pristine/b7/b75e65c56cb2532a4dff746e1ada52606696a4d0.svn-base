<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.*" %>
<%

//删除会员重复投票，刷新sorting字段  测试不正确...
DbAdapter db=new DbAdapter(),d2=new DbAdapter(),d3=new DbAdapter();
//update PollResult  set temp=concat(poll,':',rmember)
try
{
  db.executeQuery("SELECT temp,COUNT(temp) FROM PollResult GROUP BY temp HAVING COUNT(temp)>1");
  while(db.next())
  {
    String tmp=db.getString(1);
    out.print("DEL:"+tmp+"<br/>");
    String[] arr=tmp.split(":");
    d2.executeQuery("SELECT pollresult FROM PollResult WHERE poll="+arr[0]+" AND rmember="+DbAdapter.cite(arr[1]));
    d2.next();
    while(d2.next())
    {
      d3.executeUpdate("DELETE FROM PollResult WHERE pollresult="+d2.getInt(1));
    }
  }
  db.executeQuery("SELECT id,poll,sorting FROM PollChoice");
  while(db.next())
  {
    int id=db.getInt(1),poll=db.getInt(2),sorting=db.getInt(3);
    d2.executeQuery("SELECT COUNT(*) FROM PollResult WHERE answer="+poll);
    if(d2.next())
    {
      out.print("UPDATE PollChoice SET sorting="+d2.getInt(1)+" WHERE id="+id+"<br/>");
      d3.executeUpdate("UPDATE PollChoice SET sorting="+d2.getInt(1)+" WHERE id="+id);
    }
  }
}finally
{
  db.close();
  d2.close();
  d3.close();
}
%>
