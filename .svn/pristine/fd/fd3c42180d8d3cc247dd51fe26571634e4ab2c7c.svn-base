<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="java.io.*"%>
<%@page import="tea.entity.node.*"%>
<%@page import="tea.ui.*"%>
<%@page import="tea.html.*"%>
<%//*****************查看当前用户当前节点有多少求职信************************
  request.setCharacterEncoding("UTF-8");
  response.setHeader("Expires", "0");
  response.setHeader("Cache-Control", "no-cache");
  response.setHeader("Pragma", "no-cache");
  TeaSession teasession = new TeaSession(request);
  DbAdapter db=new DbAdapter();
   int node=0;
   int num=0;
   StringBuffer sql=new StringBuffer();
  //// select count(*) from dbo.apply where corpnode in
//(select node from dbo.job where validitydate>getdate() and node in
 //(select node from dbo.node where rcreator='webmaster' and type = 50))

   sql.append("select count(*) from apply where corpnode in (select node from job where validitydate>getdate() and node in (select node from dbo.node where rcreator='").append(teasession._rv._strR).append("' and type = 50))");
   try{
     db.executeQuery(sql.toString());
     if(db.next()){
       num=db.getInt(1);
       System.out.print(num);
     }
   }catch(Exception e){
     e.printStackTrace();
   }finally{
     db.close();
   }
  %>
<html>
<head>
<title>
yingpin
</title>
</head>
<body>
   <%
    if(num!=0){
      out.print("还有<span id=logintime><a href=/jsp/type/resume/yjobapplymanage.jsp>"+num+"</a></span>封求职信");
    }
    %>
</body>
</html>
