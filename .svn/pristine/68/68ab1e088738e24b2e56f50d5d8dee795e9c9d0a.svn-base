package tea.ui.node.listing;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.htmlx.TypeSelection;
import tea.entity.node.*;
import tea.ui.TeaSession;
import tea.ui.TeaServlet;
import tea.entity.*;
import java.sql.SQLException;

public class EditListingShow extends TeaServlet
{

    // Initialize global variables
    public void init() throws ServletException
    {
    }

    // Process the HTTP Get request
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            int listing = Integer.parseInt(request.getParameter("Listing"));
            int j = Listing.find(listing).getNode();
            Node node = Node.find(j);
            if (!node.isCreator(teasession._rv) && AccessMember.find(j, teasession._rv._strV).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
            tea.entity.node.ListingShow ls_obj = tea.entity.node.ListingShow.find(id);
            if (request.getParameter("delete") != null)
            {
                ls_obj.delete();
            } else
            {
                int style = Integer.parseInt(request.getParameter("style"));
                int type = Integer.parseInt(request.getParameter("type"));
                int root = Integer.parseInt(request.getParameter("root"));
                ls_obj.set(listing, type, 0, style, root);
            }
            response.sendRedirect("Picks?node=" + teasession._nNode + "&Listing=" + listing);
        } catch (NumberFormatException ex)
        {
            ex.printStackTrace();
        } catch (IOException ex)
        {
            ex.printStackTrace();
        } catch (SQLException ex)
        {
            ex.printStackTrace();
        }
    }

    // Clean up resources
    public void destroy()
    {
    }
}
