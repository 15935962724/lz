<%@page contentType="text/html;charset=UTF-8" %><%@page import="java.util.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.node.*" %><%@page import="tea.db.*" %><%

if(request.getMethod().equals("POST"))
{
  String communitys[]=request.getParameterValues("community");
  for(int j=0;j<communitys.length;j++)
  {
    String community=communitys[j];
    String url = null;
    java.util.Enumeration dns_enumer = DNS.findByCommunity(community);
    if (dns_enumer.hasMoreElements())
    {
      url = (String)dns_enumer.nextElement();
    }else
    {
      url ="___"+community;
    }
    out.print("<SPAN ID=count >0</SPAN><SCRIPT>var obj=document.getElementById('count');</SCRIPT>");
    java.io.FileWriter fw=new java.io.FileWriter(application.getRealPath("/res/"+url));
    DbAdapter dbadapter = new DbAdapter();
    try
    {
      dbadapter.executeQuery("SELECT node,type FROM Node WHERE hidden=0 AND finished=1 AND click>2 AND community='" + community + "'");
      for (int i=0; dbadapter.next();i++)
      {
        int node=dbadapter.getInt(1);
        int type=dbadapter.getInt(2);
        String name=(type>255?"Node":Node.NODE_TYPE[type]);
        fw.write(name+"="+node+"\r\n");
        if(i%10==0)
        {
          out.print("<SCRIPT>obj.innerText=\""+url+" : "+node+":"+i+"\";</SCRIPT>");
          out.flush();
        }
      }
    } finally
    {
      dbadapter.close();
      fw.close();
    }
  }
}

%>
<form name="form1" method="post" action="?">
<%
ArrayList al=Community.find("",0,Integer.MAX_VALUE);
for(int i=0;i<al.size();i++)
{
  Community cc=(Community)al.get(i);
  String community=cc.community;
  out.print("<input type=checkbox name=community checked value="+community+" >"+community+"<br>");

}
%>
<input type="submit" value="提交">
</form>

