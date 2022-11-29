package tea.ui.node.access;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.AccessPrice;
import tea.entity.node.Node;
import tea.html.*;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
import tea.entity.node.AccessMember;

public class AccessPrices extends TeaServlet
{

    public AccessPrices()
    {
    }

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
            Node node = Node.find(teasession._nNode);

            tea.entity.node.AccessMember obj_am = tea.entity.node.AccessMember.find(node._nNode,teasession._rv.toString());
            if(!node.isCreator(teasession._rv) && AccessMember.find(node._nNode,teasession._rv._strV).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            response.sendRedirect("/jsp/access/AccessPrices.jsp?node=" + teasession._nNode);

            /*
                        Table table = new Table();
                        table.setTitle(super.r.getString(teasession._nLanguage, "Currency") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Price") + "\n");
                        Row row;
                        for(Enumeration enumeration = AccessPrice.find(teasession._nNode); enumeration.hasMoreElements(); table.add(row))
                        {
                            int i = ((Integer)enumeration.nextElement()).intValue();
                            AccessPrice accessprice = AccessPrice.find(teasession._nNode, i);
                            row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, Common.CURRENCY[i]))));
                            row.add(new Cell(new Text("  ")));
                            row.add(new Cell(new Text("<font>" + accessprice.getPrice().toString() + "</font>")));
                            row.add(new Cell(new Text("  ")));
                            row.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditAccessPrice?node=" + teasession._nNode + "&Currency=" + i + "', '_self');")));
                            row.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "')){window.open('DeleteAccessPrice?node=" + teasession._nNode + "&Currency=" + i + "', '_self');}")));
                        }

                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                        printwriter.print(table);
                        printwriter.print(new Break());
                        printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('EditAccessPrice?node=" + teasession._nNode + "', '_self');"));
                        printwriter.close();*/
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/access/AccessPrices");
    }
}
