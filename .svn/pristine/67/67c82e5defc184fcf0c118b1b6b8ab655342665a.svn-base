<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%//**********************显示30天内更新情况************************************
  request.setCharacterEncoding("UTF-8");
  response.setHeader("Expires", "0");
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Pragma", "no-cache");
  TeaSession teasession = new TeaSession(request);
  DbAdapter db=new DbAdapter();
  StringBuffer sql=new StringBuffer();
  String date=null;
  int node=0;
  String title=null;
  String path=null;
  node=Integer.parseInt(teasession.getParameter("node"));

  int nodeNum=0;
  // sql.append("select max(time)from log where rmember='").append(teasession._rv._strR).append("'");
  try{
     Node node1=Node.find(node);
     path=node1.getPath();
     title=node1.getSubject(1);
   // db.executeQuery(sql.toString());

   // if(db.next()){

          java.util.Date current=new java.util.Date();
           java.text.SimpleDateFormat sdf=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
           date=sdf.format(current);



   // }
     sql=new StringBuffer();

     sql.append("select count(*) from node where path like'").append(path).append("/%' and time > = convert(DateTime,'").append(date).append("')-").append(30);

     db.executeQuery(sql.toString());
     if(db.next()){
       nodeNum=db.getInt(1);
     }

  }
  catch(Exception e){
    e.printStackTrace();
  }
   finally{
    db.close();
  }

%>


<%if(nodeNum>0)
{%>

<html>
   <head>
   </head>
   <body>
    <%="<span id=logintime>"%>
    <%=title%>
    <%="</span>共有<span id=logintime>"%>
    <a  href="/servlet/Node?Node=<%=node%>"  target="_blank"><%=nodeNum%></a>
    <%="</span>条更新" %>

<%}%>


   </body>
</html>


