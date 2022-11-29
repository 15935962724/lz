<%@page contentType="text/html; charset=UTF-8" %><%@page import="tea.entity.node.*" %>
<%@page import="java.util.zip.*" %><%@page import="tea.db.*" %><%//@page import="org.apache.tools.zip.*" %><%@ page import="java.io.*" %><%@ page import="java.net.*" %><%@page import="sun.awt.shell.ShellFolder"%><%@page import="javax.swing.filechooser.FileSystemView"%><%@ page import="java.util.*"%><%@ page import="java.math.*"%><%@page import="java.awt.*" %><%@page import="java.awt.event.*" %><%@page import="java.awt.image.*"%><%@page import="javax.swing.*"%><%@page import="java.awt.datatransfer.*"%><%@page import="javax.imageio.*"%><%@page import="java.util.regex.*"%><%!
%>

<%
//删除垃圾留言
int last=1;
boolean flag=true;
DbAdapter db=new DbAdapter(),d2=new DbAdapter(),d3=new DbAdapter();
try
{
  d3.setAutoCommit(false);
  while(flag)
  {
    System.out.println(last);
    flag=false;
    db.executeQuery("SELECT node FROM node WHERE node>"+last+" AND type=73 ORDER BY node",0,200);
    while(db.next())
    {
      flag=true;
      last=db.getInt(1);
      d2.executeQuery("SELECT subject,content FROM NodeLayer WHERE node="+last+" AND language=1");
      if(d2.next())
      {
        String subj=d2.getString(1);
        String str=d2.getString(2);
        //subj==null||subj.length()==subj.getBytes().length
        if(str!=null&&str.split("http://").length<2)
        {
          continue;
        }
      }
      d3.executeUpdate("DELETE FROM NodeLayer WHERE node="+last);
      d3.executeUpdate("DELETE FROM Node WHERE node="+last);
      d3.executeUpdate("DELETE FROM MessageBoard WHERE node="+last);
    }
    d3.commit();
  }
}finally
{
  d3.setAutoCommit(true);
  db.close();
  d2.close();
  d3.close();
  System.out.println("DEL_ OK");
}

%>
