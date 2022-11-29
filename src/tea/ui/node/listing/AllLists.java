package tea.ui.node.listing;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Listing;
import tea.entity.node.Node;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class AllLists extends TeaServlet
{

    public AllLists()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
//        request.setCharacterEncoding("UTF-8");
//        try
//        {
//            TeaSession teasession = new TeaSession(request);
//            int i = Integer.parseInt(request.getParameter("Listing"));
//            Listing listing = Listing.find(i);
//            String s = request.getParameter("Pos");
//            int j = s != null ? Integer.parseInt(s) : 0;
//            PrintWriter printwriter = response.getWriter();
//            printwriter.print(Node.find(teasession._nNode).getAncestor(teasession._nLanguage, "Path"));
//            //printwriter.print(getListingText(listing, i, teasession._rv, teasession._nNode, teasession._nLanguage, true, j, 25));
//            printwriter.print(getListingText(teasession, listing, true, 25,false));
//            printwriter.print(new FPNL(teasession._nLanguage, "AllLists?node=" + teasession._nNode + "&Listing=" + i + "&Pos=", j, listing.countItems(teasession._rv, teasession._nNode)));
//            printwriter.print(new Languages(teasession._nLanguage, request));
//            printwriter.close();
//        } catch (Exception exception)
//        {
//            response.sendError(400, exception.toString());
//            exception.printStackTrace();
//        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        r.add("tea/ui/node/listing/AllLists");
    }
}
