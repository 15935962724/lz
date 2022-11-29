<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="tea.htmlx.*"%>
<%@ page import="tea.ui.TeaSession"%>
<%@ page import="tea.resource.*" %>
<%@ page import="tea.entity.node.*" %>
<%@ page import="tea.db.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="tea.entity.member.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("progma","no-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires",0);
TeaSession teasession =new TeaSession(request);

String member = teasession.getParameter("member");
String act = teasession.getParameter("act");

String reg = teasession.getParameter("regs");
System.out.println(member+act+reg);

if(act.equals("condel")){
  ProfileZh.delete(member);
  ProfileZh.delAccess(member);
}else if(act.equals("app")){

  int regstyle =Integer.parseInt(reg);
  int pur = 64;
  if(regstyle == 1)
  {
    pur = 65;
  }
  if(regstyle == 2)
  {
    pur = 66;
  }
  if(regstyle == 3)
  {
    pur = 67;
  }
  AccessMember.create(pur,member,teasession._rv._strR,null,null,2,1,false,"/73/","/");
}else if(act.equals("napp")){
  ProfileZh.delAccess(member);
}else if(act.equals("upreg")){
  ProfileZh.setRegBuffer(member,1);
}else{
  //清除此会员的该社区
  ProfileZh.delAccess(member);
  DbAdapter db = new DbAdapter();
  try{
    db.executeUpdate("update profile set community='' where member="+db.cite(member));
  }catch(SQLException e){
    e.getMessage();
  }finally{
    db.close();
  }
}
response.sendRedirect("/jsp/user/ApprovalPer.jsp");
%>
