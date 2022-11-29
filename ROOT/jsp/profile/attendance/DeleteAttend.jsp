<%@ page contentType="text/html; charset=UTF-8" %>
<%
 request.setCharacterEncoding("UTF-8");
        int id =Integer.parseInt(request.getParameter("id"));

        try
        {
          tea.entity.member.Attenddance.delAttend(id);
        } catch (java.sql.SQLException ex)
        {
          ex.getStackTrace();
        }
        response.sendRedirect("/jsp/profile/attendance/Shiftcharge.jsp");
%>
