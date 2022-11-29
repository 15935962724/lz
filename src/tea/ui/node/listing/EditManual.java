package tea.ui.node.listing;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.Listing;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditManual extends TeaServlet
{

    public EditManual()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            /*
                         TeaSession teasession = new TeaSession(request);
                         if(teasession._rv == null)
                         {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
                         }
                         int i = Integer.parseInt(request.getParameter("Listing"));
                         Listing listing = Listing.find(i);
                         Node node = Node.find(listing.getNode());
                         if(!node.isCreator(teasession._rv))
                         {
                response.sendError(403);
                return;
                         }
                         if(request.getMethod().equals("GET"))
                         {
                Form form = new Form("foEdit", "POST", "EditManual");
                form.add(new HiddenField("Node", teasession._nNode));
                form.add(new HiddenField("Listing", i));
                Table table = new Table();
                Row row = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "Pick") + ":"), true));
                Cell cell = new Cell(new CheckBox("PickManual", listing.getPick() == 0));
                cell.add(new Text(r.getString(teasession._nLanguage, "Manual")));
                row.add(cell);
                table.add(row);
                int l = listing.getTypeStyle();
                Row row1 = new Row(new Cell(new Text(r.getString(teasession._nLanguage, "TypeStyle") + ":"), true));
                Cell cell1 = new Cell();
                DropDown dropdown = new DropDown("TypeStyle", l);
                dropdown.addOption(255, r.getString(teasession._nLanguage, "AllTypes"));
                for(int i1 = 0; i1 < Node.NODE_TYPE.length; i1++)
                    dropdown.addOption(i1, r.getString(teasession._nLanguage, Node.NODE_TYPE[i1]));

                cell1.add(dropdown);
                row1.add(cell1);
                table.add(row1);
                form.add(table);
                form.add(new Go(teasession._nLanguage));
                PrintWriter printwriter = response.getWriter();
                printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                printwriter.print(form);
                printwriter.print(new Languages(teasession._nLanguage, request));
                printwriter.close();
                         } else
                         {
                int j = request.getParameter("PickManual") == null ? 1 : 0;
                int k = Integer.parseInt(request.getParameter("TypeStyle"));
                listing.set(j, k);
                String s = request.getParameter("Go");
                if(s.equals("GoBack"))
                    response.sendRedirect("EditListing?node=" + teasession._nNode + "&Listing=" + i);
                else
                if(s.equals("GoNext"))
                    response.sendRedirect("Picks?node=" + teasession._nNode + "&Listing=" + i);
                else
                if(s.equals("GoFinish"))
                    response.sendRedirect("Node?node=" + teasession._nNode);
                         }*/
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }
    }

    private static Resource r = new Resource();

}
