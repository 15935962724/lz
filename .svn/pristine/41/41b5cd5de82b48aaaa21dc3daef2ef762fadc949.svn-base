<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="tea.entity.member.*" %>
<%
   request.setCharacterEncoding("UTF-8");
   int language = Integer.parseInt(request.getParameter("Language"));
  String member = request.getParameter("member");
  String community = request.getParameter("community");
  String newpassword = request.getParameter("newpassword");
  int sex = Integer.parseInt(request.getParameter("sex"));
  String card = request.getParameter("card");
  int cardtype =Integer.parseInt( request.getParameter("cardtype"));
  String firstname = request.getParameter("firstname");
  String telephone = request.getParameter("telephone");
  String email = request.getParameter("email");
  try{
    Profile.update(member,community,newpassword,sex,card,cardtype,firstname,telephone,email,language);
    response.sendRedirect("/jsp/info/Succeed.jsp?info="+"Success!");
   }catch(Exception ex)
   {
      System.out.println(ex.toString());
   }
%>
