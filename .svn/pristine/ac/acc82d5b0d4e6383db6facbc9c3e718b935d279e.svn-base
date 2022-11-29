package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.entity.*;
import tea.entity.member.Educate;
import tea.entity.node.Node;
import tea.ui.*;

public class DeleteEducate extends HttpServlet
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
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect(request.getContextPath() + "/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            int id = Integer.parseInt(teasession.getParameter("id"));
            Educate educate = Educate.find(id);
            if (!node.isCreator(teasession._rv) || educate.getNode() != teasession._nNode)
            {
                response.sendError(403);
                return;
            }
            educate.delete();

            String nexturl = request.getParameter("nexturl");
            //response.sendRedirect("/jsp/type/resume/EditEducate.jsp?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8"));
           response.sendRedirect(nexturl+"&nexturl=" + nexturl+"&node="+teasession._nNode);
           return;
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
