package tea.ui.member.offer;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.BuyPoint;
import tea.entity.member.Shipping;
import tea.entity.node.Buy;
import tea.entity.node.Node;
import tea.html.*;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class CheckoutCart1 extends TeaServlet
{

    public CheckoutCart1()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            /*
             String qs=request.getQueryString();
             qs=qs==null?"":"?"+qs;
             response.sendRedirect("/jsp/offer/CheckoutCart1.jsp"+qs);*/

            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }

            if (request.getParameter("ChangeQuantity") != null)
            {
                int i = 0;
                do
                {
                    String s1 = request.getParameter("Buy" + i);
                    if (s1 != null)
                    {
                        int k = 0;
                        try
                        {
                            k = Integer.parseInt(request.getParameter("Quantity" + i));
                        } catch (Exception _ex)
                        {
                            outText(teasession,response, super.r.getString(teasession._nLanguage, "InvalidQuantity"));
                            return;
                        }
                        Buy buy = Buy.find(Integer.parseInt(s1));
                        buy.set(k);
                        i++;
                    } else
                    {
                        response.sendRedirect("ShoppingCarts");
                        return;
                    }
                } while (true);
            }
            String s = request.getParameter("Vendor");
            int j = Integer.parseInt(request.getParameter("Currency"));
            int l = 0;
            try
            {
                l = Integer.parseInt(request.getParameter("Shipping"));
            } catch (Exception _ex)
            {}
            BigDecimal bigdecimal = new BigDecimal(request.getParameter("SubTotal"));
            BigDecimal bigdecimal1 = new BigDecimal(request.getParameter("ListTotal"));

            String s2 = super.r.getString(teasession._nLanguage, Common.CURRENCY[j]);
            Form form = new Form("foCheckout", "POST", "CheckoutCart2");
            form.add(new HiddenField("Vendor", s));
            form.add(new HiddenField("Currency", j));
            form.add(new HiddenField("Shipping", l));
            form.add(new HiddenField("SubTotal", bigdecimal));
            form.add(new HiddenField("ListTotal", bigdecimal1));
            Table table = new Table();
            table.setCellSpacing(2);
            table.setTitle(super.r.getString(teasession._nLanguage, "TradeSubject") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Price") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Quantity") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Total") + "\n");
            BigDecimal bigdecimal2 = new BigDecimal(0.0D);
            int i1 = 0;
            int j1 = 0;
            do
            {
                String s3 = request.getParameter("Buy" + j1);
                if (s3 == null)
                {
                    break;
                }
                String s4 = request.getParameter("Node" + j1);
                String s5 = request.getParameter("Nodex" + j1);
                String s6 = request.getParameter("SKU" + j1);
                String s7 = request.getParameter("SerialNumber" + j1);
                int i2 = Integer.parseInt(request.getParameter("Quality" + j1));
                String s8 = request.getParameter("Subject" + j1);
                String s10 = request.getParameter("Subjectx" + j1);
                BigDecimal bigdecimal7 = new BigDecimal(request.getParameter("Price" + j1));
                int j2 = Integer.parseInt(request.getParameter("ConvertCurrency" + j1));
                BigDecimal bigdecimal8 = new BigDecimal(request.getParameter("ConvertPoint" + j1));
                int k2 = 0;
                try
                {
                    k2 = Integer.parseInt(request.getParameter("Quantity" + j1));
                } catch (Exception _ex)
                {
                    outText(teasession,response, super.r.getString(teasession._nLanguage, "InvalidQuantity"));
                    break;
                }
                BigDecimal bigdecimal10 = bigdecimal7.multiply(new BigDecimal(k2));
                bigdecimal2 = bigdecimal2.add(bigdecimal10);
                Row row7 = new Row();
                row7.add(new Cell("<font>" + (new Text(s8)).toString() + " &nbsp;" + (new Text(s10)).toString() + "</font>"));
                row7.add(new Cell(new Text("  ")));
                row7.add(new Cell(new Text(s2 + bigdecimal7)));
                row7.add(new Cell(new Text("  ")));
                Cell cell6 = new Cell(new Text(Integer.toString(k2)));
                cell6.setAlign(2);
                row7.add(cell6);
                row7.add(new Cell(new Text("  ")));
                row7.add(new Cell(new Text(s2 + bigdecimal10)));
                table.add(row7);
                form.add(new HiddenField("Buy" + j1, s3));
                form.add(new HiddenField("Node" + j1, s4));
                form.add(new HiddenField("Nodex" + j1, s5));
                form.add(new HiddenField("SKU" + j1, s6));
                form.add(new HiddenField("SerialNumber" + j1, s7));
                form.add(new HiddenField("Quality" + j1, Integer.toString(i2)));
                form.add(new HiddenField("Subject" + j1, s8));
                form.add(new HiddenField("Subjectx" + j1, s10));
                form.add(new HiddenField("Price" + j1, bigdecimal7.toString()));
                form.add(new HiddenField("Quantity" + j1, Integer.toString(k2)));
                form.add(new HiddenField("ConvertCurrency" + j1, Integer.toString(j2)));
                form.add(new HiddenField("ConvertPoint" + j1, bigdecimal8.toString()));
                j1++;
                Node node = Node.find(Integer.parseInt(s4));
                Node.find(Integer.parseInt(s5));
                if ((node.getOptions1() & 2) == 0)
                {
                    i1 += k2;
                }
            } while (true);
            if (bigdecimal2.compareTo(bigdecimal) != 0)
            {
                outText(teasession,response, super.r.getString(teasession._nLanguage, "InvalidSubTotal"));
                return;
            }
            boolean flag = bigdecimal.compareTo(new BigDecimal(0.0D)) == 0;
            if (l == 0)
            {
                Row row = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Shipping") + ":"), 6));
                row.add(new Cell(new Text(s2 + new TextField("Sh", "", 6))));
                table.add(row);
                if (flag)
                {
                    table.add(new HiddenField("Tax", "0"));
                } else
                {
                    Row row1 = new Row(new Cell(new Text(super.r.getString(teasession._nLanguage, "Tax") + ":"), 6));
                    row1.add(new Cell(new Text(s2 + new TextField("Tax", "", 6))));
                    table.add(row1);
                }
            } else
            {
                Shipping shipping = Shipping.find(l);
                int l1 = shipping.getOptions();
                BigDecimal bigdecimal3 = shipping.getPerShipment();
                BigDecimal bigdecimal4 = shipping.getPerItem();
                BigDecimal bigdecimal5 = shipping.getTaxRate();
                String s9 = shipping.getText(teasession._nLanguage);
                form.add(new Text(s9));
                BigDecimal bigdecimal6 = bigdecimal3;
                if ((l1 & 2) != 0)
                {
                    bigdecimal6 = bigdecimal6.add(bigdecimal1.multiply(bigdecimal4).divide(new BigDecimal(100D), 2, 4));
                } else
                {
                    bigdecimal6 = bigdecimal6.add(bigdecimal4.multiply(new BigDecimal(i1)));
                }
                Row row4 = new Row();
                Cell cell2 = new Cell(new Text(super.r.getString(teasession._nLanguage, "Shipping") + ":"), 6);
                cell2.setAlign(3);
                row4.add(cell2);
                Cell cell3 = new Cell(new Text(s2 + bigdecimal6));
                cell3.setAlign(3);
                row4.add(cell3);
                table.add(row4);
                table.add(new HiddenField("Sh", bigdecimal6));
                BigDecimal bigdecimal9 = new BigDecimal(0.0D);
                if ((l1 & 1) != 0 && !flag)
                {
                    bigdecimal9 = bigdecimal9.add(bigdecimal.multiply(bigdecimal5).divide(new BigDecimal(100D), 2, 4));
                    Row row5 = new Row();
                    Cell cell4 = new Cell(new Text(super.r.getString(teasession._nLanguage, "Tax") + "(" + bigdecimal5.toString() + "%)" + ":"), 6);
                    cell4.setAlign(3);
                    row5.add(cell4);
                    Cell cell7 = new Cell(new Text(s2 + bigdecimal9));
                    cell7.setAlign(3);
                    row5.add(cell7);
                    table.add(row5);
                    table.add(new HiddenField("Tax", bigdecimal9));
                } else
                {
                    table.add(new HiddenField("Tax", "0"));
                }
                Row row6 = new Row();
                Cell cell5 = new Cell(new Text(super.r.getString(teasession._nLanguage, "Total") + ":"), 6);
                cell5.setAlign(3);
                row6.add(cell5);
                Cell cell8 = new Cell(new Text(s2 + bigdecimal.add(bigdecimal6).add(bigdecimal9)));
                cell8.setAlign(3);
                row6.add(cell8);
                table.add(row6);
            }
            form.add(table);
            int k1 = Integer.parseInt(request.getParameter("BuyPoint"));
            BuyPoint buypoint = BuyPoint.find(k1);
            if (buypoint.getCurrentPoint().compareTo(new BigDecimal(0.0D)) == 1)
            {
                Table table1 = new Table();
                table1.setCellSpacing(4);
                Row row2 = new Row();
                Cell cell = new Cell(new Text(super.r.getString(teasession._nLanguage, "YourCurrentPoint") + ":  "), 4);
                cell.add(new Text("<font> " + buypoint.getCurrentPoint().toString() + "</font>"));
                row2.add(cell);
                Row row3 = new Row();
                Cell cell1 = new Cell(new Text(super.r.getString(teasession._nLanguage, "PayByPoint") + ":  "), 4);
                cell1.add(new Radio("PayByPoint", 0, true));
                cell1.add(new Text(super.r.getString(teasession._nLanguage, "Yes")));
                cell1.add(new Radio("PayByPoint", 1, false));
                cell1.add(new Text(super.r.getString(teasession._nLanguage, "No")));
                row3.add(cell1);
                table1.add(row2);
                table1.add(row3);
                table1.add(new HiddenField("BuyPoint", k1));
                form.add(table1);
            } else
            {
                form.add(new HiddenField("PayByPoint", 0));
                form.add(new HiddenField("BuyPoint", k1));
            }
            form.add(new Text("<br>"));
            form.add(new Text(super.r.getString(teasession._nLanguage, "CouponCode") + ":"));
            form.add(new TextField("CouponCode"));
            form.add(new Text("<br><br>"));
            form.add(new Button(super.r.getString(teasession._nLanguage, "Continue")));
            PrintWriter printwriter = response.getWriter();
            printwriter.print(form);
            printwriter.close();
            return;
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
            return;
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/offer/CheckoutCart1").add("tea/ui/member/offer/Offers");
    }
}
