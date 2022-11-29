package tea.ui.node.access;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import java.sql.SQLException;
import tea.entity.member.*;

public class DeleteGUser extends HttpServlet
{

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            if (request.getParameter("delete") != null)
            {
                String member[] = request.getParameterValues("flag");
                for (int loop = 0; loop < member.length; loop++)
                {
                    Groups.find(member[loop]).delete();
                }
            }
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect("/jsp/access/EditGroups.jsp?group=" + request.getParameter("group"));
    }

}
