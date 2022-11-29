package tea.ui.node.listing;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.entity.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditPickNews extends TeaServlet
{
    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        Http h = new Http(request,response);
        try
        {
            TeaSession teasession = new TeaSession(request);

            int listing = h.getInt("listing");
            int picknews = h.getInt("picknews");
            PickNews obj = null;
            if(picknews > 0)
            {
                obj = PickNews.find(picknews);
                listing = obj.listing;
            }

            int realnode = Listing.find(listing).getNode();
            if(realnode > 0 && !Node.find(realnode).isCreator(teasession._rv) && AccessMember.find(realnode,teasession._rv).getPurview() < 2)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String act = request.getParameter("act");
            if("delete".equals(act))
            {
                obj.delete();
            } else
            {
                PickNews pn = PickNews.find(picknews);
                pn.listing = listing;
                pn.issueTerm = h.getInt("IssueTerm");
                pn.set();
                ListingCache.expire(listing);
            }
            response.sendRedirect("/jsp/listing/Picks.jsp?node=" + teasession._nNode + "&listing=" + listing);
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/listing/EditPickNews");
    }
}
