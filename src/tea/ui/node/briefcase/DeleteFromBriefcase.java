package tea.ui.node.briefcase;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class DeleteFromBriefcase extends TeaServlet
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
            String nexturl = request.getParameter("nexturl");
            Listed listed = Listed.find(Integer.parseInt(request.getParameter("listed")));
            int i = listed.getListing();
            Node node = Node.find(Listing.find(i).getNode());
            if(!node.isCreator(teasession._rv) && AccessMember.find(node._nNode,teasession._rv._strV).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            listed.delete();
            ListingCache.expire(i);
            if(nexturl == null)
            {
                nexturl = "/jsp/listing/BriefcaseItems.jsp?node=" + teasession._nNode + "&listing=" + i;
            }
            response.sendRedirect(nexturl);
        } catch(Exception exception)
        {
            response.sendError(400,exception.toString());
            exception.printStackTrace();
        }
    }
}
