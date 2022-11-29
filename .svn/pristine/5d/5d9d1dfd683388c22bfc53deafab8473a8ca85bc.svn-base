package tea.ui.node.briefcase;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class AddToBriefcase extends TeaServlet
{

    public AddToBriefcase()
    {
    }

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
            if (request.getMethod().equals("GET"))
            {
                response.sendRedirect("/jsp/add/AddToBriefcase.jsp?node=" + teasession._nNode);
                /*
                                 Table table = new Table();
                                 table.setTitle(super.r.getString(teasession._nLanguage, "Name") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "ListingNode") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Style") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Quantity") + "\n");
                                 Row row;
                                 for(Enumeration enumeration = Listing.findBriefcase(teasession._rv); enumeration.hasMoreElements(); table.add(row))
                                 {
                    int j = ((Integer)enumeration.nextElement()).intValue();
                    Listing listing1 = Listing.find(j);
                    row = new Row(new Cell(new Text("<font>" + listing1.getName(teasession._nLanguage) + "</font>")));
                    row.add(new Cell(new Text("  ")));
                    row.add(new Cell(Node.find(listing1.getNode()).getAnchor(teasession._nLanguage)));
                    row.add(new Cell(new Text("  ")));
                    row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Section.APPLY_STYLE[listing1.getStyle()]))));
                    row.add(new Cell(new Text("  ")));
                    row.add(new Cell(new Text(Integer.toString(listing1.getQuantity()))));
                    row.add(new Cell(new Text("  ")));
                    row.add(new Cell(new Button(1, "CB", "CBContinue", super.r.getString(teasession._nLanguage, "CBContinue"), "window.open('AddToBriefcase1?Listing=" + j + "&Node=" + teasession._nNode + "', '_self');")));
                                 }

                                 PrintWriter printwriter = response.getWriter();
                                 printwriter.print(Node.find(teasession._nNode).getAncestor(teasession._nLanguage, "Path"));
                                 printwriter.print(table);
                                 printwriter.print(new Languages(teasession._nLanguage, request));
                                 printwriter.close();*/
            } else
            {
                int i = Integer.parseInt(request.getParameter("Listing"));
                Listing listing = Listing.find(i);

                Node node = Node.find(listing.getNode());
                if (!node.isCreator(teasession._rv) && AccessMember.find(node._nNode, teasession._rv._strV).getPurview() < 2)
                {
                    response.sendError(403);
                    return;
                }
                Listed.create(teasession._nNode, i, null);
                ListingCache.expire(i);
                response.sendRedirect("/servlet/Node?node=" + teasession._nNode);
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
        super.r.add("tea/ui/node/briefcase/AddToBriefcase").add("tea/ui/node/listed/NewListed");
    }
}
