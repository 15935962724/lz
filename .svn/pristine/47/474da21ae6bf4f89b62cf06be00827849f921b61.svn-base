package tea.ui.node.type.job;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.SQLException;
import tea.ui.*;

public class DeleteEntSearch extends HttpServlet
{

    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new tea.ui.TeaSession(request);
            new tea.entity.node.EntSearch(request.getParameter("name"), teasession._nLanguage).delete();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect("/jsp/type/job/EditEntSearch.jsp");
    }

    //Clean up resources
    public void destroy()
    {
    }
}
