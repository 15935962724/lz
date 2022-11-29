package tea.ui.node.listed;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
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

public class Listeds extends TeaServlet
{

    public Listeds()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            response.sendRedirect("/jsp/listing/Listeds.jsp?" + request.getQueryString());
            /*
                         TeaSession teasession = new TeaSession(request);
                         if (teasession._rv == null)
                         {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
                         }

                         Table table = new Table();
                         int i = Listed.countListeds(teasession._nNode);
                         if (i != 0)
                         {
                table.setTitle(super.r.getString(teasession._nLanguage, "Listing") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "ListingNode") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Style") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "StopTime") + "\n");
                Row row;
                for (Enumeration enumeration = Listed.findListeds(teasession._nNode); enumeration.hasMoreElements(); table.add(row))
                {
                    int j = ((Integer) enumeration.nextElement()).intValue();
                    Listed listed = Listed.find(j);
                    int k = listed.getListing();
                    java.util.Date date = listed.getStopTime();
                    Listing listing = Listing.find(k);
                    row = new Row(new Cell(new Text("<font>" + listing.getName(teasession._nLanguage) + "</font>")));
                    row.add(new Cell(new Text("  ")));
                    row.add(new Cell(Node.find(listing.getNode()).getAnchor(teasession._nLanguage)));
                    row.add(new Cell(new Text("  ")));
                    row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Section.APPLY_STYLE[listing.getStyle()]))));
                    row.add(new Cell(new Text("  ")));
                    if (date == null)
                    {
                        row.add(new Cell(new Text("  ")));
                    } else
                    {
                        row.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date) + "</font>")));
                    }
                    row.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditListed?node=" + teasession._nNode + "&Listed=" + j + "', '_self');")));
                    row.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteListed?node=" + teasession._nNode + "&Listed=" + j + "', '_self');}")));
                }

                         }
                         PrintWriter printwriter = response.getWriter();
                         printwriter.print(Node.find(teasession._nNode).getAncestor(teasession._nLanguage, "Path"));
                         printwriter.print(table);
                         printwriter.print(new Break());
                         printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('NewListed?node=" + teasession._nNode + "', '_self');"));
                         printwriter.print(new Languages(teasession._nLanguage, request));
                         printwriter.close();
             */
        } catch (Exception exception)
        {
            exception.printStackTrace();
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/listed/Listeds").add("tea/ui/node/listed/NewListed");
    }
}
