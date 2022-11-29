<%@page contentType="text/html;charset=UTF-8" %><%@page import="tea.entity.node.type.mpoll.*" %><%@page import="tea.entity.*" %><%@page import="java.io.*" %><%@page import="java.util.*" %><%@page import="tea.html.*" %><%@page import="tea.entity.site.*" %><%@page import="tea.entity.admin.*" %><%@page import="java.math.*" %><%@page import="tea.entity.member.*" %><%@page import="tea.db.DbAdapter"%><%@page import="tea.resource.*" %><%@page import="tea.ui.*" %><% request.setCharacterEncoding("UTF-8");


//int min=0,max=0;
//DbAdapter db=new DbAdapter();
//try
//{
//  db.executeQuery("SELECT MIN(vote),MAX(vote) FROM MVote WHERE total=100 AND deleted=0");
//  if(db.next())
//  {
//    min=db.getInt(1);
//    max=db.getInt(2);
//  }
//}finally
//{
//  db.close();
//}
//
//ArrayList al=new ArrayList();
//for(int i=0;i<1000;i++)
//{
//  ArrayList vs=Vote.find(" AND vote>"+(min+(max-min)*Math.random()),0,1);
//  if(vs.size()>0)
//  {
//    al.add(vs.get(0));
//  }
//}


ArrayList al=Vote.find(" AND v.total=100 AND v.random>rand() ORDER BY v.random",0,1000);
for(int i=0;i<al.size();i++)
{
  Vote v=(Vote)al.get(i);
  HashMap hm=Answer.findByVote(v.vote);
  Answer a=(Answer)hm.get(new Integer(13104408));
  out.print("<li><span class='name'>"+a.getContent()+"</span>");

  a=(Answer)hm.get(new Integer(13104395));
  out.print("<span class='sex'>"+a.getContent()+"</span>");

  a=(Answer)hm.get(new Integer(13105109));
  out.print("<span class='area'>"+a.getContent()+"</span>");

  a=(Answer)hm.get(new Integer(13104399));
  out.print("<span class='style'>"+a.getContent()+"</span>");

  a=(Answer)hm.get(new Integer(13104405));
  out.print("<span class='number'>"+a.getContent()+"</span>");

  a=(Answer)hm.get(new Integer(13104394));
  out.println("<span class='pro'>"+a.getContent()+"</span></li>");

  //a=(Answer)hm.get(new Integer(13104409));
  //out.print("<span class='add'>"+a.getContent()+"</span>");

  //a=(Answer)hm.get(new Integer(13105054));
  //out.println("<span class='code'>"+a.getContent()+"</span>");
}

%>
ok


