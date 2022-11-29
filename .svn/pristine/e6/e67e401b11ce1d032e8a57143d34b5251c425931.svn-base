<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="tea.db.*"%>
<%@page import="tea.entity.*"%>
<%@page import="tea.entity.util.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.entity.admin.earth.*"%>
<%@page import="java.util.*"%>
<%

Enumeration e=Node.find("",0,Integer.MAX_VALUE);
while (e.hasMoreElements())
{
  int node=((Integer)e.nextElement()).intValue();
  Node obj=Node.find(node);
  System.out.println("Node:"+node+"\tCommunity:"+obj.getCommunity());
  String subject=Lucene.htmlToText(obj.getSubject(1));
  if(subject.length()>200)
  subject=subject.substring(0,200);
  String content=Lucene.htmlToText(obj.getText(1));
  int en=EarthNode.findByNode(node,obj.getCommunity());
  if(en>0)
  {
    EarthNode enobj=EarthNode.find(en);
    enobj.set(subject,content,obj.getTime(),obj.getClick());
  }else
  {
    EarthNode.create(node,obj.getCommunity(),subject,content,obj.getTime(),obj.getClick());
  }
}

%>



