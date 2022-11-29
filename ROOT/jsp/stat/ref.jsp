<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.db.*" %><%@page import="java.util.*" %><%@page import="tea.entity.*" %><%@page import="tea.entity.stat.*" %><% request.setCharacterEncoding("UTF-8");

String community="Home";
int last=0;
DbAdapter db=new DbAdapter(8),d2=new DbAdapter(8);
try
{
  while(true)
  {
    db.executeQuery("SELECT id,ip FROM NodeAccessLastHistory WHERE id>"+last+" AND address IS NULL ORDER BY id",0,1);
    if(!db.next())break;
    last=db.getInt(1);
    String ip=db.getString(2);
    String addr=Ip.findByIp(ip);
    int j=addr.indexOf(" ");
    if(j!=-1)addr=addr.substring(0,j);
    out.print(ip+":"+addr+"<br/>");
    db.executeUpdate("UPDATE NodeAccessLastHistory SET address="+DbAdapter.cite(addr)+" WHERE ip="+DbAdapter.cite(ip));
  }

  Calendar c=Calendar.getInstance();
  c.setTime(MT.SDF[0].parse("2007-01-01"));
  long cur=System.currentTimeMillis();
  while(c.getTimeInMillis()<cur)
  {
    String time=DbAdapter.cite(c.getTime());
    out.print(time+"<br/>");
    String sql="SELECT address,COUNT(address) FROM NodeAccessLastHistory WHERE time>"+time;
    c.add(Calendar.DAY_OF_YEAR,1);
    sql+=" AND time<"+DbAdapter.cite(c.getTime());
    db.executeQuery(sql+" AND community="+DbAdapter.cite(community)+" GROUP BY address");
    while(db.next())
    {
      String addr=db.getString(1);
      int sum=db.getInt(2);
      d2.executeUpdate("INSERT INTO NodeAccessCity(community,sum,address,time)VALUES("+DbAdapter.cite(community)+","+sum+","+DbAdapter.cite(addr)+","+time+")");
    }
  }
}catch(Exception ex)
{
  out.print(ex.toString());
  ex.printStackTrace();
}finally
{
  db.close();
}

%>
刷新：地区统计
