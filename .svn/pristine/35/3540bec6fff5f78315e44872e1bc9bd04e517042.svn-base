package tea.ui.node.listing;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.member.*;

public class DeleteListing extends TeaServlet
{

    public DeleteListing()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        request.setCharacterEncoding("UTF-8");
        TeaSession teasession = new TeaSession(request);
        if(teasession._rv == null)
        {
            response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
            return;
        }
        try
        {
            int i = Integer.parseInt(request.getParameter("listing"));
            Listing obj = Listing.find(i);
            int status = obj.getStatus();
            Node node = Node.find(obj.getNode());
            if(!node.isCreator(teasession._rv) && AccessMember.find(node._nNode,teasession._rv._strV).getPurview() < 3)
            {
                response.sendError(403);
                return;
            }
            obj.delete(teasession._nLanguage);
            Logs.create(teasession._strCommunity,teasession._rv,5,i,obj.getName(teasession._nLanguage));
            delete(node);
            response.sendRedirect("/jsp/listing/Listings.jsp?node=" + teasession._nNode + "&status=" + status);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
