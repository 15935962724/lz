package tea.ui.node.type.conference;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;

public class EditConference extends HttpServlet
{
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
            tea.entity.node.Conference obj = tea.entity.node.Conference.find(Integer.parseInt(request.getParameter("conference")));
            if (request.getParameter("delete") != null)
            {
                obj.delete();
            } else
            {
                obj.setName(request.getParameter("name"));
                obj.setEname(request.getParameter("ename"));
                obj.setCommunity(tea.entity.node.Node.find(teasession._nNode).getCommunity());
                obj.set();
            }
            response.sendRedirect("/jsp/type/conference/EditConference.jsp");
        } catch (IOException ex)
        {
            ex.printStackTrace();
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
