<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%//*******************查看XXX节点还有多少条信息待审核********************************
  request.setCharacterEncoding("UTF-8");
  response.setHeader("Expires", "0");
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Pragma", "no-cache");
  TeaSession teasession = new TeaSession(request);
  DbAdapter db=new DbAdapter();
  String title=null;
  int num=0;
  int node=0;
 node=Integer.parseInt(teasession.getParameter("node"));

  StringBuffer sql=new StringBuffer();
  Node node1=Node.find(node);

  try{
    title=node1.getSubject(1);
     String path=node1.getPath();
     sql.append("select count(*) from node where path like'").append(path).append("/%' and hidden =1");
     db.executeQuery(sql.toString());
      if(db.next()){
       num=db.getInt(1);
     }
  }
  catch(Exception e){
    e.printStackTrace();
  }

  %>
  <html>
    <head>
    </head>
    <body>
    <%
    if(num!=0){
      out.print("<span id=logintime>"+title+"</span>还有<span id=logintime><a href=/jsp/request/NodeRequests.jsp?node="+node+">"+num+"</a></span>条信息待审核");
    }
    %>

</body>
</html>
