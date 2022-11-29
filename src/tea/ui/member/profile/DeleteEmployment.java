package tea.ui.member.profile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaSession;
import tea.entity.node.*;
import tea.entity.member.Employment;

public class DeleteEmployment extends HttpServlet
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

            Employment employment = Employment.find(id);
            if (!node.isCreator(teasession._rv) || (employment.getNode() != teasession._nNode))
            {
                response.sendError(403);
                return;
            }
            employment.delete();
            String nexturl = teasession.getParameter("nexturl");
           // response.sendRedirect(request.getContextPath() + "/jsp/type/resume/EditEmployment.jsp?node=" + teasession._nNode + "&nexturl=" + java.net.URLEncoder.encode(request.getParameter("nexturl"), "UTF-8"));
              //response.sendRedirect("/jsp/info/Succeed.jsp?info=" + java.net.URLEncoder.encode("删除成功", "UTF-8") + "&nexturl=" + java.net.URLEncoder.encode(request.getParameter("nexturl"), "UTF-8"));
                response.sendRedirect(nexturl+"&nexturl=" + java.net.URLEncoder.encode(nexturl, "UTF-8")+"&node="+teasession._nNode);
              return;//
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
