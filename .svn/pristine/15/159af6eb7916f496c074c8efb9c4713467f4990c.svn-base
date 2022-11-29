package tea.ui.node.type.buy;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.node.BuyPrice;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Go;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class BuyPrices extends TeaServlet
{

    public BuyPrices()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            Node node = Node.find(teasession._nNode);
            if (teasession._rv == null)
            {
                if ((node.getOptions1() & 1) == 0)
                {
                    response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                    return;
                }
            } else
            {
                tea.entity.node.AccessMember obj_am = tea.entity.node.AccessMember.find(node._nNode, teasession._rv.toString());
                if (!node.isCreator(teasession._rv) && !obj_am.isProvider(4))
                {
                    response.sendError(403);
                    return;
                }
            }

            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/type/buy/BuyPrices.jsp" + qs);
                /*
                                 Table table = new Table(super.r.getString(teasession._nLanguage, "BuyPrices"));
                                 table.setCellSpacing(5);
                 table.setTitle(super.r.getString(teasession._nLanguage, "Currency") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Supply") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "List") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "OurPrice") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Point") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Relation") + "\n" + " &nbsp;" +
                             "\n" + super.r.getString(teasession._nLanguage, "ConvertCurrency") + "\n");
                                 Row row;
                                 for (Enumeration enumeration = BuyPrice.find(teasession._nNode); enumeration.hasMoreElements(); table.add(row))
                                 {
                  int i = ((Integer) enumeration.nextElement()).intValue();
                  BuyPrice buyprice = BuyPrice.find(teasession._nNode, i);
                  row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, Common.CURRENCY[i]))));
                  row.add(new Cell(new Text("  ")));
                  Cell cell = new Cell(new Text(buyprice.getSupply().toString()));
                  cell.setAlign(2);
                  row.add(cell);
                  row.add(new Cell(new Text("  ")));
                  Cell cell1 = new Cell(new Text(buyprice.getList().toString()));
                  cell1.setAlign(2);
                  row.add(cell1);
                  row.add(new Cell(new Text("  ")));
                  Cell cell2 = new Cell(new Text(buyprice.getPrice().toString()));
                  cell2.setAlign(2);
                  row.add(cell2);
                  row.add(new Cell(new Text("  ")));
                  Cell cell3 = new Cell(new Text(buyprice.getPoint().toString()));
                  cell3.setAlign(3);
                  row.add(cell3);
                  row.add(new Cell(new Text("  ")));
                  int j = buyprice.getOptions();
                  if (j == 0)
                  {
                      Cell cell4 = new Cell(new Text(" " + super.r.getString(teasession._nLanguage, "BaseOnRelation") + " "));
                      cell4.setAlign(2);
                      row.add(cell4);
                  }
                  if (j == 1)
                  {
                      Cell cell5 = new Cell(new Text(" " + super.r.getString(teasession._nLanguage, "BaseOnAmount") + " "));
                      cell5.setAlign(2);
                      row.add(cell5);
                  }
                  row.add(new Cell(new Text("  ")));
                  Cell cell6 = new Cell(new Text(super.r.getString(teasession._nLanguage, Common.CURRENCY[buyprice.getConvertCurrency()])));
                  cell6.setAlign(2);
                  row.add(cell6);
                  row.add(new Cell(new Anchor("EditBuyPrice?node=" + teasession._nNode + "&Currency=" + i, super.r.getCommandImg(teasession._nLanguage, "Edit"))));
                  row.add(new Cell(new Anchor("DeleteBuyPrice?node=" + teasession._nNode + "&Currency=" + i, super.r.getCommandImg(teasession._nLanguage, "Delete"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "'));")));
                                 }

                                 PrintWriter printwriter = response.getWriter();
                                 printwriter.print(node.getAncestor(teasession._nLanguage, "Path"));
                                 printwriter.print(table);
                                 printwriter.print(new Anchor("EditBuyPrice?node=" + teasession._nNode, super.r.getCommandImg(teasession._nLanguage, "New")));
                                 printwriter.print(new Languages(teasession._nLanguage, request));
                                 Form form = new Form("foEdit", "POST", "/servlet/BuyPrices");
                                 form.add(new HiddenField("Node", Integer.toString(teasession._nNode)));
                                 form.add(new Go(teasession._nLanguage, 1));
                                 printwriter.print(form);
                                 printwriter.close();*/
                return;
            }
            String nexturl = request.getParameter("nexturl");
            if (request.getParameter("GoBack") != null)
            {
                response.sendRedirect("EditBuy?node=" + teasession._nNode + (nexturl != null ? "&nexturl=" + nexturl : ""));
                return;
            }
            if (request.getParameter("GoFinish") != null)
            {
                node.finished(teasession._nNode);
                if (nexturl != null)
                {
                    response.sendRedirect(nexturl);
                } else
                {
                    response.sendRedirect("Node?node=" + teasession._nNode + "&edit=ON");
                }
                return;
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
//        super.r.add("tea/ui/node/type/buy/BuyPrices").add("tea/ui/node/type/buy/EditBuyPrice");
    }
}
