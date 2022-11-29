package tea.ui.member.offer;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ShoppingCarts extends TeaServlet
{

    public ShoppingCarts()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/offer/ShoppingCarts.jsp" + qs);
            /*
                        TeaSession teasession = new TeaSession(request);
                         if(teasession._rv == null)
                         {
             response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
             return;
                         }
                         Text text = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("Offers", super.r.getString(teasession._nLanguage, "Offers")) + ">" + super.r.getString(teasession._nLanguage, "ShoppingCarts"));
                         text.setId("PathDiv");
                         response.setHeader("Expires", "0");
                         response.setHeader("Cache-Control", "no-cache");
                         response.setHeader("Pragma", "no-chache");
                         PrintWriter printwriter = response.getWriter();
                         printwriter.print(text);
                         printwriter.print(new Paragraph(Buy.countBuys(teasession._rv) + " " + super.r.getString(teasession._nLanguage, "Buys")));
                         int i = 0;
                         for(Enumeration enumeration = Buy.findCarts(teasession._rv); enumeration.hasMoreElements();)
                         {
             Cart cart = (Cart)enumeration.nextElement();
             String s = super.r.getString(teasession._nLanguage, Common.CURRENCY[cart._nCurrency]);
             Form form = new Form("foCheckout" + i, "POST", "CheckoutCart1");
             form.add(new HiddenField("Vendor", cart._strVendor));
             form.add(new HiddenField("Currency", cart._nCurrency));
             Table table = new Table();
             table.setCellPadding(3);
             table.setTitle(super.r.getString(teasession._nLanguage, "Time") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "TradeSubject") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "BuyPList") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "BuyPPrice") + "\n" + " &nbsp;" + "\n" + super.r.getString(teasession._nLanguage, "Quantity") + "\n" + super.r.getString(teasession._nLanguage, "Total") + "\n");
             int j = 0;
             BigDecimal bigdecimal = new BigDecimal(0.0D);
             BigDecimal bigdecimal1 = new BigDecimal(0.0D);
             for(Enumeration enumeration1 = Buy.findInCart(cart, teasession._rv); enumeration1.hasMoreElements();)
             {
                 int k = ((Integer)enumeration1.nextElement()).intValue();
                 Buy buy = Buy.find(k);
                 String s1 = null;
                 String s2 = null;
                 int l = buy.getNode();
                 int i1 = buy.getNodex();
                 Node node = Node.find(l);
                 Node node1 = Node.find(i1);
                 if((node.getOptions() & 0x40000) != 0)
                 {
                     Node node2 = Node.find(Node.find(node.getFather()).getFather());
                     s1 = node2.getSubject(teasession._nLanguage);
                 } else
                 {
                     s1 = node.getSubject(teasession._nLanguage);
                     s2 = node1.getSubject(teasession._nLanguage);
                 }
                 BuyPrice buyprice = BuyPrice.find(l, cart._nCurrency);
                 BigDecimal bigdecimal2 = buyprice.getList();
                 Commodity commodity = Commodity.find(l);
                 String s3 = commodity.getSKU();
                 String s4 = commodity.getSerialNumber();
                 int l1 = commodity.getQuality();
                 java.util.Date date = buy.getTime();
                 BigDecimal bigdecimal3 = buy.getPrice();
                 int j2 = buy.getQuantity();
                 BigDecimal bigdecimal4 = new BigDecimal(j2);
                 BigDecimal bigdecimal5 = bigdecimal3.multiply(bigdecimal4);
                 bigdecimal1 = bigdecimal1.add(bigdecimal5);
                 bigdecimal = bigdecimal.add(bigdecimal2.multiply(bigdecimal4));
                 BigDecimal bigdecimal6 = new BigDecimal(0.0D);
                 BigDecimal bigdecimal7 = buyprice.getPoint();
                 int k2 = buyprice.getConvertCurrency();
                 int l2 = buyprice.getOptions();
                 if(l2 == 0)
                     bigdecimal6 = bigdecimal6.add(bigdecimal3.multiply(bigdecimal4).multiply(bigdecimal7));
                 if(l2 == 1)
                     bigdecimal6 = bigdecimal6.add(bigdecimal7.multiply(bigdecimal4));
                 Row row5 = new Row(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date) + "</font>")));
                 row5.add(new Cell(new Text(" ")));
                 row5.add(new Cell((new Anchor("Node?node=" + l, new Text(s1))).toString() + (new Anchor("Node?node=" + i1, new Text(s2))).toString()));
                 row5.add(new Cell(new Text(" ")));
                 row5.add(new Cell(new Text(s + bigdecimal2)));
                 row5.add(new Cell(new Text(" ")));
                 row5.add(new Cell(new Text(s + bigdecimal3)));
                 row5.add(new Cell(new Text(" ")));
                 Cell cell7 = new Cell(new TextField("Quantity" + j, j2, 2));
                 cell7.setAlign(2);
                 row5.add(cell7);
                 row5.add(new Cell(new Text(s + bigdecimal5)));
                 row5.add(new Cell(new Anchor("DeleteCartItem?CartItem=" + k, super.r.getCommandImg(teasession._nLanguage, "Delete"), "return(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDelete") + "'));")));
                 table.add(row5);
                 form.add(new HiddenField("Buy" + j, k));
                 form.add(new HiddenField("Node" + j, l));
                 form.add(new HiddenField("Nodex" + j, i1));
                 form.add(new HiddenField("SKU" + j, s3));
                 form.add(new HiddenField("SerialNumber" + j, s4));
                 form.add(new HiddenField("Quality" + j, Integer.toString(l1)));
                 form.add(new HiddenField("Subject" + j, s1));
                 form.add(new HiddenField("Subjectx" + j, s2));
                 form.add(new HiddenField("Price" + j, bigdecimal3.toString()));
                 form.add(new HiddenField("ConvertCurrency" + j, Integer.toString(k2)));
                 form.add(new HiddenField("ConvertPoint" + j, bigdecimal6.toString()));
                 j++;
             }

             form.add(new HiddenField("SubTotal", bigdecimal1));
             Row row = new Row();
             Cell cell = new Cell(new Text(super.r.getString(teasession._nLanguage, "SubTotal") + ":"), 9);
             cell.setAlign(3);
             row.add(cell);
             Cell cell1 = new Cell(new Text(s + bigdecimal1));
             cell1.setAlign(3);
             row.add(cell1);
             table.add(row);
             form.add(new HiddenField("ListTotal", bigdecimal));
             Row row1 = new Row();
             Cell cell2 = new Cell(new Text(super.r.getString(teasession._nLanguage, "ListTotal") + ":"), 9);
             cell2.setAlign(3);
             row1.add(cell2);
             Cell cell3 = new Cell(new Text(s + bigdecimal));
             cell3.setAlign(3);
             row1.add(cell3);
             table.add(row1);
             if(bigdecimal.subtract(bigdecimal1).compareTo(new BigDecimal(0.0D)) == 1)
             {
                 Row row2 = new Row();
                 Cell cell4 = new Cell(new Text(super.r.getString(teasession._nLanguage, "YouSave") + ":"), 9);
                 cell4.setAlign(3);
                 row2.add(cell4);
                 Cell cell5 = new Cell(new Text(s + bigdecimal.subtract(bigdecimal1)));
                 cell5.setAlign(3);
                 row2.add(cell5);
                 table.add(row2);
             }
             new Row(new Cell(new Text("  "), 8));
             Row row3 = new Row(new Cell(new Text("  "), 8));
             row3.add(new Cell(new Button("ChangeQuantity", super.r.getString(teasession._nLanguage, "ChangeQuantity"), null)));
             table.add(row3);
             RV rv = new RV(cart._strVendor);
             int j1;
             BuyPoint buypoint;
             if(BuyPoint.isExisted(rv, teasession._rv, cart._nCurrency))
             {
                 j1 = BuyPoint.find(rv, teasession._rv, cart._nCurrency);
                 buypoint = BuyPoint.find(j1);
             } else
             {
                 j1 = BuyPoint.create(rv, teasession._rv, cart._nCurrency, new BigDecimal(0.0D), new BigDecimal(0.0D));
                 buypoint = BuyPoint.find(j1);
             }
             if(buypoint.getCurrentPoint().compareTo(new BigDecimal(0.0D)) == 1)
             {
                 Row row4 = new Row();
                 Cell cell6 = new Cell(new Text(super.r.getString(teasession._nLanguage, "YourCurrentPoint") + ":  "), 4);
                 cell6.add(new Text("<font> " + buypoint.getCurrentPoint().toString() + "</font>"));
                 row4.add(cell6);
                 table.add(row4);
             }
             table.add(new HiddenField("BuyPoint", j1));
             form.add(new Text("<br><br>"));
             form.add(table);
             int k1 = BuyInstruction.find(cart._strVendor, cart._nCurrency);
             if(k1 != 0)
             {
                 BuyInstruction buyinstruction = BuyInstruction.find(k1);
                 form.add(new Text(buyinstruction.getText(teasession._nLanguage)));
             }
             boolean flag = true;
             for(Enumeration enumeration2 = Shipping.find(cart._strVendor, cart._nCurrency, 8192); enumeration2.hasMoreElements();)
             {
                 int i2 = ((Integer)enumeration2.nextElement()).intValue();
                 Shipping shipping = Shipping.find(i2);
                 form.add(new Radio("Shipping", i2, flag));
                 form.add(new Text(shipping.getName(teasession._nLanguage)));
                 if(flag)
                     flag = false;
             }

             form.add(new Button("Checkout", super.r.getString(teasession._nLanguage, "Checkout"), null));
             printwriter.print(form);
             i++;
                         }

                         printwriter.print(new Languages(teasession._nLanguage, request));
                         printwriter.close();
                         return;*/
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
        super.r.add("tea/ui/member/offer/Offers").add("tea/ui/member/offer/ShoppingCarts");
    }
}
