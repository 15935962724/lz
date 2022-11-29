<%@ page contentType="text/html; charset=UTF-8" %>
<%
 request.setCharacterEncoding("UTF-8");
        int tid =Integer.parseInt(request.getParameter("tid"));

        try
        {
          tea.entity.member.Attenddance.delType(tid);
        } catch (java.sql.SQLException ex)
        {
          ex.getStackTrace();
        }
        response.sendRedirect("/jsp/profile/attendance/SelType.jsp");
%>
