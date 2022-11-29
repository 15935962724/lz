package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.*;

public class EditPdf extends TeaServlet
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
            String community = teasession.getParameter("community");
            tea.entity.site.Pdf obj = tea.entity.site.Pdf.find(community);
            byte by[] = teasession.getBytesParameter("header");
            String header, footer;
            if (by == null)
            {
                header = obj.getHeader();
            } else
            {
                header = write(community, by,".gif");
            }

            by = teasession.getBytesParameter("footer");
            if (by == null)
            {
                footer = obj.getHeader();
            } else
            {
                footer = write(community, by,".gif");
            }

            obj.set(header, footer);
            response.sendRedirect("/jsp/info/Succeed.jsp");
        } catch (Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500);
        }

    }

    //Clean up resources
    public void destroy()
    {
    }
}
