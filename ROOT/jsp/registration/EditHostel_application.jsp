<%@ page contentType="text/html; charset=UTF-8" %><%@page import="tea.entity.node.*" %>
 <%
  String memberid = request.getParameter("memberid");
  int nodeid = Integer.parseInt(request.getParameter("nodeid"));
  String introduce = request.getParameter("introduce");
  String documents = request.getParameter("documents");
  Hostel_application hostel = new Hostel_application();
   try
    {
        if(!hostel.isExist(memberid))
      {
      hostel.setMemberid(memberid);
      hostel.setNodeid(nodeid);
      hostel.setIntroduce(introduce);
      hostel.setDocuments(documents);
      hostel.create(memberid,nodeid,introduce,documents);
      response.sendRedirect("/jsp/info/Succeed.jsp?info="+"registing ... ...please wait ... ...!");
    }
    else
    {
      response.sendRedirect("/jsp/info/Succeed.jsp?info="+"The name has exist!");
    }
  }catch(Exception ex)
  {
    out.print(ex.toString());
  }
%>
