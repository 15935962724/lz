package tea.ui.member.order;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.html.*;
import tea.htmlx.Languages;
import tea.http.RequestHelper;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class TradeInvoice extends TeaServlet
{

    public TradeInvoice()
    {
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/order/PurchaseOrders").add("tea/ui/member/order/SaleOrders").add("tea/ui/member/order/TradeServlet");
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.sendRedirect("/jsp/order/TradeInvoice.jsp?" + request.getQueryString());
//
//            TeaSession teasession = new TeaSession(request);
//            if(teasession._rv == null)
//            {
//                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
//                return;
//            }
//            boolean flag = false;
//            Object obj = null;
//            try
//            {
//                String s = request.getParameter("Batch");
//                if(s != null && s.equalsIgnoreCase("true"))
//                    flag = true;
//            }
//            catch(Exception _ex) { }
//            if(!flag)
//            {
//                int i = Integer.parseInt(request.getParameter("Trade"));
//                int k = Integer.parseInt(request.getParameter("InvoiceFormat"));
//                PrintWriter printwriter1 = beginOut(response, teasession);
//                printwriter1.println("<div style=\"page-break-before:always\">  </div>");
//                String s1;
//                switch(k)
//                {
//                case 0: // '\0'
//                    printwriter1 = originalInvoice(printwriter1, i, teasession._nLanguage, teasession._rv);
//                    // fall through
//
//                case -1:
//                case 1: // '\001'
//                case 2: // '\002'
//                case 3: // '\003'
//                default:
//                    s1 = "Trade=" + i + "&" + "InvoiceFormat=" + k;
//                    break;
//                }
//                String s2 = request.getQueryString();
//                if(s2 != null && s2.indexOf(s1) >= 0)
//                    printwriter1.print(new Languages(teasession._nLanguage, request));
//                else
//                    printwriter1.print(new Languages(teasession._nLanguage, request, s1));
//                printwriter1.println("<div style=\"page-break-after:always\">  </div>");
//                endOut(printwriter1, teasession);
//                return;
//            }
//            int j = Integer.parseInt(request.getParameter("InvoiceFormat"));
//            PrintWriter printwriter = response.getWriter();
//            String as[] = request.getParameterValues("Trades");
//            if(as != null)
//            {
//                for(int l = 0; l < as.length; l++)
//                    if(as[l] != null)
//                    {
//                        int i1 = ((as[l])).intValue();
//                        printwriter.println("<div style=\"page-break-before:always\">  </div>");
//                        switch(j)
//                        {
//                        case 0: // '\0'
//                            printwriter = originalInvoice(printwriter, i1, teasession._nLanguage, teasession._rv);
//                            // fall through
//
//                        case -1:
//                        case 1: // '\001'
//                        case 2: // '\002'
//                        case 3: // '\003'
//                        default:
//                            printwriter.println("<div style=\"page-break-after:always\">  </div>");
//                            break;
//                        }
//                    }
//
//            }
//            printwriter.close();
//            return;
//        }
//        catch(Exception exception)
//        {
//            response.sendError(400, exception.toString());
//            exception.printStackTrace();
//            return;
//        }
//    }
//
//    public PrintWriter originalInvoice(PrintWriter printwriter, int i, int j, RV rv)
//        throws Exception
//    {
//        Trade trade = Trade.find(i);
//        RV rv1 = trade.getVendor();
//        RV rv2 = trade.getCustomer();
//        java.util.Date date = trade.getTime();
//        int k = trade.getType();
//        int l = trade.getStatus();
//        String s = trade.getbEmail();
//        String s1 = trade.getbFirstName(j);
//        String s2 = trade.getbLastName(j);
//        String s3 = RequestHelper.makeName(j, s1, s2);
//        String s4 = trade.getbOrganization(j);
//        String s5 = trade.getbAddress(j);
//        String s6 = trade.getbCity(j);
//        String s7 = trade.getbState(j);
//        String s8 = trade.getbZip();
//        String s9 = trade.getbCountry(j);
//        String s10 = trade.getbTelephone(j);
//        String s11 = trade.getbFax(j);
//        String s12 = trade.getsEmail();
//        String s13 = trade.getsFirstName(j);
//        String s14 = trade.getsLastName(j);
//        String s15 = RequestHelper.makeName(j, s13, s14);
//        String s16 = trade.getsOrganization(j);
//        String s17 = trade.getsAddress(j);
//        String s18 = trade.getsCity(j);
//        String s19 = trade.getsState(j);
//        String s20 = trade.getsZip();
//        String s21 = trade.getsCountry(j);
//        String s22 = trade.getsTelephone(j);
//        String s23 = trade.getsFax(j);
//        int i1 = trade.getCurrency();
//        int j1 = trade.getShipping();
//        String s24 = trade.getShippingText(j);
//        BigDecimal bigdecimal = trade.getSh();
//        BigDecimal bigdecimal1 = trade.getTax();
//        int k1 = trade.getCoupon();
//        String s25 = trade.getCouponText(j);
//        BigDecimal bigdecimal2 = trade.getDiscount();
//        String s26 = trade.getCText(j);
//        boolean flag = trade.getCVoiceFlag();
//        String s27 = trade.getVText(j);
//        boolean flag1 = trade.getVVoiceFlag();
//        Table table = new Table();
//        BigDecimal bigdecimal3 = new BigDecimal(0.0D);
//        String s28 = super.r.getString(j, Common.CURRENCY[i1]);
//        boolean flag2 = trade.isCustomer(rv);
//        boolean flag3 = trade.isVendor(rv);
//        boolean flag4 = flag2 && (l == 0 || l == 3 || l == 5);
//        boolean flag5 = flag3 && l != 1 && l != 5 && l != 9 && l != 8;
//        boolean flag6 = true;
//        if(flag2)
//            trade.customerRead();
//        if(flag3)
//            trade.vendorRead();
//
//        table.setCaption(super.r.getString(j, Trade.TRADE_TYPE[k]));
//        StringBuilder stringbuffer = new StringBuilder(super.r.getString(j, "Time") + "\n" + " &nbsp; " + "\n");
//        stringbuffer.append(super.r.getString(j, "TradeSubject") + "\n" + " &nbsp; " + "\n" + super.r.getString(j, "Price") + "\n" + super.r.getString(j, "OQuantity") + "\n" + super.r.getString(j, "SQuantity") + "\n" + super.r.getString(j, "Total") + "\n");
//        table.setTitle(stringbuffer.toString());
//        table.setCellSpacing(3);
//        int l1 = 0;
//        for(Enumeration enumeration = TradeItem.findByTrade(i); enumeration.hasMoreElements();)
//        {
//            int i2 = ((Integer)enumeration.nextElement()).intValue();
//            TradeItem tradeitem = TradeItem.find(i2);
//            java.util.Date date1 = tradeitem.getTime();
//            int j2 = tradeitem.getSubject();
//            int k2 = tradeitem.getSubjectx();
//            BigDecimal bigdecimal4 = tradeitem.getPrice();
//            int l2 = tradeitem.getOQuantity();
//            int i3 = tradeitem.getSQuantity();
//            BigDecimal bigdecimal5 = bigdecimal4.multiply(new BigDecimal(i3));
//            bigdecimal3 = bigdecimal3.add(bigdecimal5);
//            Row row13 = new Row(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date1) + "</font>")));
//            StringBuilder stringbuffer2 = new StringBuilder();
//            if(k == 1 || k == 2 || k == 3)
//            {
//                Node node = Node.find(j2);
//                Node node2 = Node.find(k2);
//                int k3 = node.getFather();
//                int i4 = Node.find(k3).getFather();
//                Node node3 = Node.find(i4);
//                if(node3.getType() == 12)
//                {
//                    Book book = Book.find(i4);
//                    String s41 = book.getPublisher(j);
//                    try
//                    {
//                        int j4 = Integer.parseInt(s41);
//                        stringbuffer2.append(Node.find(j4).getSubject(j));
//                    }
//                    catch(Exception _ex)
//                    {
//                        stringbuffer2.append(s41);
//                    }
//                    stringbuffer2.append("<BR>" + node3.getAnchor(j));
//                    stringbuffer2.append("<BR>" + book.getISBN());
//                } else
//                {
//                    stringbuffer2.append(node.getAnchor(j));
//                    stringbuffer2.append(node2.getAnchor(j));
//                }
//            } else
//            if(k == 7)
//            {
//                Aded aded = Aded.find(j2);
//                int j3 = aded.getNode();
//                int l3 = aded.getAding();
//                Ading ading = Ading.find(l3);
//                stringbuffer2.append(ading.getName(j));
//                stringbuffer2.append(" (" + new Anchor("Adeds?node=" + j3, Node.find(j3).getSubject(j)) + ")");
//            } else
//            if(k == 4)
//            {
//                Node node1 = Node.find(j2);
//                stringbuffer2.append(node1.getAnchor(j));
//            }
//            row13.add(new Cell(new Text("  ")));
//            row13.add(new Cell(new Text(stringbuffer2.toString())));
//            row13.add(new Cell(new Text("  ")));
//            row13.add(new Cell(new Text(s28 + bigdecimal4)));
//            Cell cell13 = new Cell(new Text(Integer.toString(l2)));
//            cell13.setAlign(2);
//            row13.add(cell13);
//            Cell cell14 = new Cell(new Text(Integer.toString(i3)));
//            cell14.setAlign(2);
//            row13.add(cell14);
//            Cell cell15 = new Cell(new Text(s28 + bigdecimal5));
//            cell15.setAlign(3);
//            row13.add(cell15);
//            row13.setId(flag6 ? "OddRow" : "EvenRow");
//            flag6 = !flag6;
//            table.add(row13);
//            l1++;
//        }
//
//        if(flag2 || flag3)
//        {
//            if(k == 1 || k == 2 || k == 3)
//            {
//                if(bigdecimal.compareTo(new BigDecimal(0.0D)) != 0)
//                {
//                    Row row = new Row();
//                    Cell cell1 = new Cell(new Text(super.r.getString(j, "Shipping") + ":"), 7);
//                    cell1.setAlign(3);
//                    row.add(cell1);
//                    Cell cell6 = new Cell(new Text(s28 + bigdecimal));
//                    cell6.setAlign(3);
//                    row.add(cell6);
//                    table.add(row);
//                }
//                if(bigdecimal1.compareTo(new BigDecimal(0.0D)) != 0)
//                {
//                    Row row1 = new Row();
//                    Cell cell2 = new Cell(new Text(super.r.getString(j, "Tax") + ":"), 7);
//                    cell2.setAlign(3);
//                    row1.add(cell2);
//                    Cell cell7 = new Cell(new Text(s28 + bigdecimal1));
//                    cell7.setAlign(3);
//                    row1.add(cell7);
//                    table.add(row1);
//                }
//            }
//            if(k1 != 0 && bigdecimal2.compareTo(new BigDecimal(0.0D)) != 0)
//            {
//                Row row2 = new Row();
//                Cell cell3 = new Cell(new Text(super.r.getString(j, "Discount") + ":"), 7);
//                cell3.setAlign(3);
//                row2.add(cell3);
//                Cell cell8 = new Cell(new Text(s28 + bigdecimal2));
//                cell8.setAlign(3);
//                row2.add(cell8);
//                table.add(row2);
//            }
//        } else
//        if(flag3 && (l == 0 || l == 3 || l == 4 || l == 10))
//        {
//            if(j1 != 0 && (k == 1 || k == 2 || k == 3))
//            {
//                Cell cell = new Cell(new Text(super.r.getString(j, "Shipping") + ":"), 7);
//                cell.setAlign(3);
//                Row row5 = new Row(cell);
//                row5.add(new Cell(new Text(s28 + new TextField("Sh", bigdecimal.toString(), 5))));
//                table.add(row5);
//                Row row6 = new Row();
//                Cell cell10 = new Cell(new Text(super.r.getString(j, "Tax") + ":"), 7);
//                cell10.setAlign(3);
//                row6.add(cell10);
//                row6.add(new Cell(new Text(s28 + new TextField("Tax", bigdecimal1.toString(), 5))));
//                table.add(row6);
//            } else
//            {
//                table.add(new HiddenField("Sh", bigdecimal));
//                table.add(new HiddenField("Tax", bigdecimal1));
//            }
//            if(k1 != 0)
//            {
//                Row row3 = new Row();
//                Cell cell4 = new Cell(new Text(super.r.getString(j, "Discount") + ":"), 7);
//                cell4.setAlign(3);
//                row3.add(cell4);
//                row3.add(new Cell(new Text(s28 + new TextField("Discount", bigdecimal2.toString(), 5))));
//                table.add(row3);
//            } else
//            {
//                table.add(new HiddenField("Discount", bigdecimal2));
//            }
//        }
//        Row row4 = new Row();
//        Cell cell5 = new Cell(new Text(super.r.getString(j, "Total") + ":"), 7);
//        cell5.setAlign(3);
//        row4.add(cell5);
//        Cell cell9 = new Cell(new Text(s28 + bigdecimal3.add(bigdecimal).add(bigdecimal1).add(bigdecimal2)));
//        cell9.setAlign(3);
//        row4.add(cell9);
//        table.add(row4);
//        if(j1 != 0)
//        {
//            Cell cell11 = new Cell(new Text(s24));
//            cell11.setColSpan(8);
//            table.add(new Row(cell11));
//        }
//        if(k1 != 0)
//        {
//            Cell cell12 = new Cell(new Text(s25));
//            cell12.setColSpan(8);
//            table.add(new Row(cell12));
//        }
//        Table table1 = new Table(super.r.getString(j, "VendorAddress"));
//        if(flag2)
//        {
//            Profile profile = Profile.find(rv1._strR);
//            String s29 = profile.getEmail();
//            String s30 = profile.getFirstName(j);
//            String s31 = profile.getLastName(j);
//            String s32 = RequestHelper.makeName(j, s30, s31);
//            String s33 = profile.getOrganization(j);
//            String s34 = profile.getAddress(j);
//            String s35 = profile.getCity(j);
//            String s36 = profile.getState(j);
//            String s37 = profile.getZip(j);
//            String s38 = profile.getCountry(j);
//            String s39 = profile.getTelephone(j);
//            String s40 = profile.getFax(j);
//            Row row27 = new Row(new Cell(new Text(super.r.getString(j, "Vendor") + ":"), true));
//
//            row27.add(new Cell(hrefGlance(rv1,""), 3));
//            table1.add(row27);
//            Row row29 = new Row(new Cell(new Text(super.r.getString(j, "EmailAddress") + ":"), true));
//            row29.add(new Cell(hrefNewMessage(s29), 3));
//            table1.add(row29);
//            Row row31 = new Row(new Cell(new Text(super.r.getString(j, "Name") + ":"), true));
//            row31.add(new Cell(hrefNewMessage(rv1.toString(), s32), 3));
//            table1.add(row31);
//            Row row33 = new Row(new Cell(new Text(super.r.getString(j, "Organization") + ":"), true));
//            row33.add(new Cell(new Text(s33), 3));
//            table1.add(row33);
//            Row row35 = new Row(new Cell(new Text(super.r.getString(j, "Address") + ":"), true));
//            row35.add(new Cell(new Text(s34), 3));
//            table1.add(row35);
//            Row row36 = new Row(new Cell(new Text(super.r.getString(j, "City") + ":"), true));
//            row36.add(new Cell(new Text(s35)));
//            row36.add(new Cell(new Text(super.r.getString(j, "State") + ":"), true));
//            row36.add(new Cell(new Text(s36)));
//            table1.add(row36);
//            Row row37 = new Row(new Cell(new Text(super.r.getString(j, "Zip") + ":"), true));
//            row37.add(new Cell(new Text(s37)));
//            row37.add(new Cell(new Text(super.r.getString(j, "Country") + ":"), true));
//            row37.add(new Cell(new Text(s38)));
//            table1.add(row37);
//            Row row38 = new Row(new Cell(new Text(super.r.getString(j, "Telephone") + ":"), true));
//            row38.add(new Cell(new Text(s39)));
//            row38.add(new Cell(new Text(super.r.getString(j, "Fax") + ":"), true));
//            row38.add(new Cell(new Text(s40)));
//            table1.add(row38);
//        }
//        Table table2 = new Table(super.r.getString(j, "BillingAddress"));
//        Table table3 = new Table(super.r.getString(j, "ShippingAddress"));
//        if(flag2 && (l == 0 || l == 3))
//        {
//            Row row7 = new Row(new Cell(new Text(super.r.getString(j, "Customer") + ":"), true));
//            row7.add(new Cell(new Text(rv2.toString()), 3));
//            table2.add(row7);
//            Row row9 = new Row(new Cell(new Text(super.r.getString(j, "EmailAddress") + ":"), true));
//            row9.add(new Cell(new TextField("bEmail", s, 40, 40), 3));
//            table2.add(row9);
//            Row row11 = new Row(new Cell(new Text(super.r.getString(j, "FirstName") + ":"), true));
//            row11.add(new Cell(new TextField("bFirstName", s1, 20, 20)));
//            row11.add(new Cell(new Text(super.r.getString(j, "LastName") + ":"), true));
//            row11.add(new Cell(new TextField("bLastName", s2, 20, 20)));
//            table2.add(row11);
//            Row row14 = new Row(new Cell(new Text(super.r.getString(j, "Organization") + ":"), true));
//            row14.add(new Cell(new TextField("bOrganization", s4, 40, 40), 3));
//            table2.add(row14);
//            Row row16 = new Row(new Cell(new Text(super.r.getString(j, "Address") + ":"), true));
//            row16.add(new Cell(new TextArea("bAddress", s5, 2, 40), 3));
//            table2.add(row16);
//            Row row18 = new Row(new Cell(new Text(super.r.getString(j, "City") + ":"), true));
//            row18.add(new Cell(new TextField("bCity", s6, 20, 20)));
//            row18.add(new Cell(new Text(super.r.getString(j, "State") + ":"), true));
//            row18.add(new Cell(new TextField("bState", s7, 20, 20)));
//            table2.add(row18);
//            Row row20 = new Row(new Cell(new Text(super.r.getString(j, "Zip") + ":"), true));
//            row20.add(new Cell(new TextField("bZip", s8, 20, 20)));
//            row20.add(new Cell(new Text(super.r.getString(j, "Country") + ":"), true));
//            row20.add(new Cell(new TextField("bCountry", s9, 20, 20)));
//            table2.add(row20);
//            Row row22 = new Row(new Cell(new Text(super.r.getString(j, "Telephone") + ":"), true));
//            row22.add(new Cell(new TextField("bTelephone", s10, 20, 20)));
//            row22.add(new Cell(new Text(super.r.getString(j, "Fax") + ":"), true));
//            row22.add(new Cell(new TextField("bFax", s11, 20, 20)));
//            table2.add(row22);
//            row7 = new Row(new Cell(new Text(super.r.getString(j, "EmailAddress") + ":"), true));
//            row7.add(new Cell(new TextField("sEmail", s12, 40, 40), 3));
//            table3.add(row7);
//            row9 = new Row(new Cell(new Text(super.r.getString(j, "FirstName") + ":"), true));
//            row9.add(new Cell(new TextField("sFirstName", s13, 20, 20)));
//            row9.add(new Cell(new Text(super.r.getString(j, "LastName") + ":"), true));
//            row9.add(new Cell(new TextField("sLastName", s14, 20, 20)));
//            table3.add(row9);
//            row11 = new Row(new Cell(new Text(super.r.getString(j, "Organization") + ":"), true));
//            row11.add(new Cell(new TextField("sOrganization", s16, 40, 40), 3));
//            table3.add(row11);
//            row14 = new Row(new Cell(new Text(super.r.getString(j, "Address") + ":"), true));
//            row14.add(new Cell(new TextArea("sAddress", s17, 2, 40), 3));
//            table3.add(row14);
//            row16 = new Row(new Cell(new Text(super.r.getString(j, "City") + ":"), true));
//            row16.add(new Cell(new TextField("sCity", s18, 20, 20)));
//            row16.add(new Cell(new Text(super.r.getString(j, "State") + ":"), true));
//            row16.add(new Cell(new TextField("sState", s19, 20, 20)));
//            table3.add(row16);
//            row18 = new Row(new Cell(new Text(super.r.getString(j, "Zip") + ":"), true));
//            row18.add(new Cell(new TextField("sZip", s20, 20, 20)));
//            row18.add(new Cell(new Text(super.r.getString(j, "Country") + ":"), true));
//            row18.add(new Cell(new TextField("sCountry", s21, 20, 20)));
//            table3.add(row18);
//            row20 = new Row(new Cell(new Text(super.r.getString(j, "Telephone") + ":"), true));
//            row20.add(new Cell(new TextField("sTelephone", s22, 20, 20)));
//            row20.add(new Cell(new Text(super.r.getString(j, "Fax") + ":"), true));
//            row20.add(new Cell(new TextField("sFax", s23, 20, 20)));
//            table3.add(row20);
//        } else
//        {
//            Row row8 = new Row(new Cell(new Text(super.r.getString(j, "Customer") + ":"), true));
//            row8.add(new Cell(new Text(rv2.toString()), 3));
//            table2.add(row8);
//            Row row10 = new Row(new Cell(new Text(super.r.getString(j, "EmailAddress") + ":"), true));
//            row10.add(new Cell(hrefNewMessage(s), 3));
//            table2.add(row10);
//            Row row12 = new Row(new Cell(new Text(super.r.getString(j, "Name") + ":"), true));
//            row12.add(new Cell(hrefNewMessage(rv2.toString(), s3), 3));
//            table2.add(row12);
//            Row row15 = new Row(new Cell(new Text(super.r.getString(j, "Organization") + ":"), true));
//            row15.add(new Cell(new Text(s4), 3));
//            table2.add(row15);
//            Row row17 = new Row(new Cell(new Text(super.r.getString(j, "Address") + ":"), true));
//            row17.add(new Cell(new Text(s5), 3));
//            table2.add(row17);
//            Row row19 = new Row(new Cell(new Text(super.r.getString(j, "City") + ":"), true));
//            row19.add(new Cell(new Text(s6)));
//            row19.add(new Cell(new Text(super.r.getString(j, "State") + ":"), true));
//            row19.add(new Cell(new Text(s7)));
//            table2.add(row19);
//            Row row21 = new Row(new Cell(new Text(super.r.getString(j, "Zip") + ":"), true));
//            row21.add(new Cell(new Text(s8)));
//            row21.add(new Cell(new Text(super.r.getString(j, "Country") + ":"), true));
//            row21.add(new Cell(new Text(s9)));
//            table2.add(row21);
//            Row row23 = new Row(new Cell(new Text(super.r.getString(j, "Telephone") + ":"), true));
//            row23.add(new Cell(new Text(s10)));
//            row23.add(new Cell(new Text(super.r.getString(j, "Fax") + ":"), true));
//            row23.add(new Cell(new Text(s11)));
//            table2.add(row23);
//            Row row24 = new Row(new Cell(new Text(super.r.getString(j, "EmailAddress") + ":"), true));
//            row24.add(new Cell(new Text(s12), 3));
//            table3.add(row24);
//            Row row25 = new Row(new Cell(new Text(super.r.getString(j, "Name") + ":"), true));
//            row25.add(new Cell(new Text(s15), 3));
//            table3.add(row25);
//            Row row26 = new Row(new Cell(new Text(super.r.getString(j, "Organization") + ":"), true));
//            row26.add(new Cell(new Text(s16), 3));
//            table3.add(row26);
//            Row row28 = new Row(new Cell(new Text(super.r.getString(j, "Address") + ":"), true));
//            row28.add(new Cell(new Text(s17), 3));
//            table3.add(row28);
//            Row row30 = new Row(new Cell(new Text(super.r.getString(j, "City") + ":"), true));
//            row30.add(new Cell(new Text(s18)));
//            row30.add(new Cell(new Text(super.r.getString(j, "State") + ":"), true));
//            row30.add(new Cell(new Text(s19)));
//            table3.add(row30);
//            Row row32 = new Row(new Cell(new Text(super.r.getString(j, "Zip") + ":"), true));
//            row32.add(new Cell(new Text(s20)));
//            row32.add(new Cell(new Text(super.r.getString(j, "Country") + ":"), true));
//            row32.add(new Cell(new Text(s21)));
//            table3.add(row32);
//            Row row34 = new Row(new Cell(new Text(super.r.getString(j, "Telephone") + ":"), true));
//            row34.add(new Cell(new Text(s22)));
//            row34.add(new Cell(new Text(super.r.getString(j, "Fax") + ":"), true));
//            row34.add(new Cell(new Text(s23)));
//            table3.add(row34);
//        }
//        Table table4 = new Table(super.r.getString(j, "CText"));
//        if(!flag4 && (s26.length() != 0 || flag))
//        {
//            table4.add(new Row(new Cell(new Text(s26), 2)));
//            if(flag)
//                table4.add(new Row(new Cell(new Anchor("TradeCVoice?Trade=" + i, super.r.getCommandImg(j, "Play")))));
//        }
//        Table table5 = new Table(super.r.getString(j, "VText"));
//        if(!flag5 && (s27.length() != 0 || flag1))
//        {
//            table5.add(new Row(new Cell(new Text(s27), 2)));
//            if(flag1)
//                table5.add(new Row(new Cell(new Anchor("TradeVVoice?Trade=" + i, super.r.getCommandImg(j, "Play")))));
//        }
//        StringBuilder stringbuffer1 = new StringBuilder(hrefGlance(rv,"") + ">");
//        if(flag2)
//            stringbuffer1.append(new Anchor("PurchaseOrders", super.r.getString(j, "PurchaseOrders")) + ">" + new Anchor("PurchaseOrders?Type=" + k, super.r.getString(j, Trade.TRADE_TYPE[k])) + ">" + new Anchor("PurchaseOrders?Type=" + k + "&Status=" + l, super.r.getString(j, Trade.TRADE_STATUS[l])) + ">");
//        else
//            stringbuffer1.append(new Anchor("SaleOrders", super.r.getString(j, "SaleOrders")) + ">" + new Anchor("SaleOrders?Type=" + k, super.r.getString(j, Trade.TRADE_TYPE[k])) + ">" + new Anchor("SaleOrders?Type=" + k + "&Status=" + l, super.r.getString(j, Trade.TRADE_STATUS[l])) + ">");
//        stringbuffer1.append("#" + i);
//        Text text = new Text(stringbuffer1.toString());
//        text.setId("PathDiv");
//        printwriter.print(text);
//        if(flag2)
//        {
//            printwriter.print(table1);
//            if(flag4)
//            {
//                Form form = new Form("foEdit", "POST", "EditPurchaseOrder");
//                form.setMultiPart(true);
//                form.add(table2);
//                form.add(new CheckBox("ShipToBilling", false));
//                form.add(new Text(super.r.getString(j, "TradeOShipToBilling")));
//                form.add(table3);
//                form.add(table);
//                form.add(table4);
//                form.add(table5);
//                form.add(new Break());
//                printwriter.print(form);
//            } else
//            {
//                printwriter.print(table2);
//                if(table3 != null)
//                    printwriter.print(table3);
//                printwriter.print(table);
//                printwriter.print(table4);
//                printwriter.print(table5);
//            }
//        } else
//        if(flag5)
//        {
//            printwriter.print(table2);
//            if(table3 != null)
//                printwriter.print(table3);
//            Form form1 = new Form("foProcess", "POST", "ProcessSaleOrder");
//            form1.setMultiPart(true);
//            form1.add(table);
//            form1.add(table4);
//            form1.add(table5);
//            form1.add(new Break());
//            printwriter.print(form1);
//        } else
//        {
//            printwriter.print(table2);
//            if(table3 != null)
//                printwriter.print(table3);
//            printwriter.print(table);
//            printwriter.print(table4);
//            printwriter.print(table5);
//        }
//        printwriter.print(super.r.getString(j, "LastUpdate") + "<font>:" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date) + "</font>");
//        return printwriter;
    }

    public static final String TRADEINVOICE_FORMAT[] =
            {
            " 0", " 1", " 2", " 3"
    };
    public static final int TRADEINVOICEF_0ORIGINAL = 0;
    public static final int TRADEINVOICEF_1 = 1;
    public static final int TRADEINVOICEF_2 = 2;
    public static final int TRADEINVOICEF_3 = 3;

}
