package tea.ui.node.type.bargain;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.BargainPrice;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class BargainPrices extends TeaServlet
{

    public BargainPrices()
    {
    }

    public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            Node node = Node.find(teasession._nNode);
            if(!node.isCreator(teasession._rv) && AccessMember.find(teasession._nNode,teasession._rv._strV).getPurview() < 2)
            {
                response.sendError(403);
                return;
            }
            if(request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/type/bargain/BargainPrices.jsp" + qs);

                // Table table = new Table(super.r.getString(teasession._nLanguage, "BargainPrices"));
                // table.setTitle(super.r.getString(teasession._nLanguage, "Currency") + "\n" + super.r.getString(teasession._nLanguage, "BargainSupply") + "\n" + super.r.getString(teasession._nLanguage, "BargainList") + "\n" + super.r.getString(teasession._nLanguage, "BargainAsk") + "\n");
                // Row row;
                // for(Enumeration enumeration = BargainPrice.find(teasession._nNode); enumeration.hasMoreElements(); table.add(row))
                // {
                // int i = ((Integer)enumeration.nextElement()).intValue();
                // BargainPrice bargainprice = BargainPrice.find(teasession._nNode, i);
                // row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, Common.CURRENCY[i]))));
                // row.add(new Cell(new Text(bargainprice.getSupply().toString())));
                // row.add(new Cell(new Text(bargainprice.getList().toString())));
                // row.add(new Cell(new Text(bargainprice.getAsk().toString())));
                // row.add(new Cell(new Anchor("DeleteBargainPrice?node=" + teasession._nNode + "&Currency=" + i, super.r.getCommandImg(teasession._nLanguage, "Delete"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "'));")));
                // row.add(new Cell(new Anchor("EditBargainPrice?node=" + teasession._nNode + "&Currency=" + i, super.r.getCommandImg(teasession._nLanguage, "Edit"))));
                // }
                //
                // PrintWriter printwriter = response.getWriter();
                // printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                // printwriter.print(table);
                // printwriter.print(new Anchor("EditBargainPrice?node=" + teasession._nNode, super.r.getCommandImg(teasession._nLanguage, "New")));
                // Form form = new Form("foEdit", "POST", "BargainPrices");
                // form.add(new HiddenField("Node", Integer.toString(teasession._nNode)));
                // form.add(new Go(teasession._nLanguage, 1));
                // printwriter.print(form);
                // printwriter.print(new Languages(teasession._nLanguage, request));
                //                printwriter.close();
            } else
            if(request.getParameter("GoBack") != null)
                response.sendRedirect("EditBargain?node=" + teasession._nNode);
            else
            if(request.getParameter("GoFinish") != null)
                response.sendRedirect("Bargain?node=" + teasession._nNode + "&edit=ON");
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/node/type/bargain/BargainPrices");
    }
}
