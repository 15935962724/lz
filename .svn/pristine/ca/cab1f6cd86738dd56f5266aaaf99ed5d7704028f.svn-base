package tea.ui.node.listed;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteListed extends TeaServlet
{


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
            String nu = request.getParameter("nexturl");
            Listed listed = Listed.find(Integer.parseInt(request.getParameter("Listed")));
            Node node = Node.find(listed.getNode());
            if(!node.isCreator(teasession._rv) && AccessMember.find(node._nNode,teasession._rv._strV).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            int i = listed.getListing();
            listed.delete();
            ListingCache.expire(i);
            if(nu == null)
            {
                nu = "/jsp/listing/Listeds.jsp?node=" + teasession._nNode;
            }
            response.sendRedirect(nu);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
