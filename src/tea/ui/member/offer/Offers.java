package tea.ui.member.offer;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Offers extends TeaServlet
{

    public Offers()
    {
    }

    public void service(HttpServletRequest request,
                        HttpServletResponse response) throws
            ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/offer/Offers.jsp" + qs);
            /*
                        Text text = new Text(hrefGlance(teasession._rv) + ">" + super.r.getString(teasession._nLanguage, "Offers"));
                        text.setId("PathDiv");
                        List list = new List();
                        list.add(new ListItem(new Anchor("ShoppingCarts", new Text(Buy.countBuys(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "Buys")))));
                        list.add(new ListItem(new Anchor("Bids", new Text(Bid.countNodes(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "Bids")))));
                        list.add(new ListItem(new Anchor("Bargains", new Text(Bargain.countNodes(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "Bargains")))));
             PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(list);
             printwriter.print(new Languages(teasession._nLanguage, request));
                        printwriter.close();
             */
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/offer/Offers");
    }
}
