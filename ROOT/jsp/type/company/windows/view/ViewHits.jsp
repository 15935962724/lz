<%@page contentType="text/javascript; charset=UTF-8" %>
<%@page import="tea.db.*" %>
<%@page import="tea.entity.member.*" %>
<%@page import="tea.entity.node.*" %>
<%@page import="java.util.*" %>

document.write("<%
request.setCharacterEncoding("UTF-8");
String member=request.getParameter("member");
Date time=new Date(Long.parseLong(request.getParameter("time")));
String sn=request.getServerName();
int node;
DbAdapter db=new DbAdapter();
try
{
  node=db.getInt("SELECT node FROM Node WHERE vcreator="+DbAdapter.cite(member)+" AND type=21");
}finally
{
  db.close();
}
if(node>0)
{
  Node n=Node.find(node);
  Company c=Company.find(node);
  String logo=c.getLogo(1);
  if(logo==null||logo.length()<1)
  {
    logo="/tea/image/eyp/images/logo.jpg";
  }
  out.print("  <tr><td id=Visitors_td_left align=right rowspan=2><img src=http://"+sn+logo+"> </td><td id=Visitors_td_right><a href=javascript:f_show("+node+","+n.getClick()+",0,'"+sn+"')>"+n.getSubject(1)+"</a></td></tr>");
  out.print("  <tr><td id=Visitors_td_right>"+Node.sdf2.format(time)+"</td></tr>");
}
%>");
