package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class EditObjective extends HttpServlet
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
            tea.ui.TeaSession teasession = new tea.ui.TeaSession(request);
            tea.entity.member.Summary summary = tea.entity.member.Summary.find(teasession._rv.toString(), teasession._nLanguage);
            summary.setSelfValue(teasession.getParameter("SelfValueCN"));
            summary.setSelfAim(teasession.getParameter("ObjectCN"));
            summary.set();
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect("/jsp/profile/Resume7.jsp");
    }

    //Clean up resources
    public void destroy()
    {
    }
}
