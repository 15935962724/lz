package tea.ui.site;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.site.Aerodrome;

public class EditAerodrome extends TeaServlet
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
            int aerodrome = Integer.parseInt(teasession.getParameter("aerodrome"));
            Aerodrome a = Aerodrome.find(aerodrome);
            if (teasession.getParameter("delete") != null)
            {
                a.delete();
            } else
            {
                String community = teasession.getParameter("community");
                String name = teasession.getParameter("name");
                a.set(community, name, teasession._nLanguage);
            }
            response.sendRedirect("/jsp/type/flight/Aerodromes.jsp?node=" + teasession._nNode);
        } catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    //Clean up resources
    public void destroy()
    {
    }
}
