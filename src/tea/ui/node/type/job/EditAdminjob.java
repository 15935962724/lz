package tea.ui.node.type.job;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.*;
import tea.entity.site.*;
import tea.entity.admin.*;
import tea.entity.*;
import tea.entity.node.*;

public class EditAdminjob extends TeaServlet
{
    //Initialize global variables
    public void init() throws ServletException
    {
    }

    //Process the HTTP Get request
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Communityjob communityjob = Communityjob.find(teasession._strCommunity);
            AdminUsrRole aur = AdminUsrRole.find(teasession._strCommunity,teasession._rv._strV);
            String role = aur.getRole();
            if(role.indexOf("/" + communityjob.getRolejob() + "/") == -1 && !License.getInstance().getWebMaster().equals(teasession._rv.toString()) && !teasession._rv.toString().equals(communityjob.getJobmember()))
            {
                response.sendError(403);
                return;
            }
            String str[] = request.getParameterValues("checkbox");
            if(str != null)
            {
                Node node = null;
                if(request.getParameter("delete") != null)
                {
                    for(int index = 0;index < str.length;index++)
                    {
                        node = Node.find(Integer.parseInt(str[index]));
                        node.delete(teasession._nLanguage);
                    }
                } else
                {
                    boolean bool = (request.getParameter("stop") != null);
                    for(int index = 0;index < str.length;index++)
                    {
                        node = Node.find(Integer.parseInt(str[index]));
                        node.setHidden(bool);
                    }
                }
                delete(node);
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
        }
        response.sendRedirect(request.getParameter("nexturl"));
    }

    //Clean up resources
    public void destroy()
    {
    }
}
