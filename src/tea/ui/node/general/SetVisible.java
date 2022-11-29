package tea.ui.node.general;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tea.entity.node.AccessMember;
import tea.entity.node.Node;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class SetVisible extends TeaServlet
{

    public SetVisible()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        TeaSession teasession = new TeaSession(request);
        try
        {
            Node node = Node.find(teasession._nNode);
            AccessMember am = AccessMember.find(teasession._nNode,teasession._rv);
            boolean flag = teasession._rv != null && teasession._rv.isOrganizer(node.getCommunity());
            boolean flag1 = Node.find(node.getFather()).isCreator(teasession._rv);
            if(!am.isAuditing() && !flag && !flag1 && (!node.isCreator(teasession._rv) || node.isHidden()))
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if(request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/general/SetVisible.jsp?node=" + teasession._nNode);
            } else
            {
                node.setHidden(request.getParameter("NodeOHidden") != null);
                node.setUpdatetime(new Date());
                delete(node);
                if(request.getParameter("nexturl") != null)
                {
                    response.sendRedirect(request.getParameter("nexturl"));
                } else
                {
                    response.sendRedirect("Node?node=" + teasession._nNode);
                }
            }
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        // super.r.add("tea/ui/node/general/SetVisible");
    }
}
