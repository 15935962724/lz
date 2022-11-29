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
import tea.entity.member.Trade;
import tea.html.*;
import tea.htmlx.FPNL;
import tea.htmlx.Languages;
import tea.resource.Common;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;


public class SaleOrders extends TeaServlet
{

    public SaleOrders()
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
            if(!teasession._rv.isAccountant())
            {
                response.sendError(403);
                return;
            }
            String s = request.getParameter("Type");
            if(s == null)
                s = request.getParameter("type"); //Dreamweaver �� Type �Զ��ı�� type
            String s1 = request.getParameter("Status");
            boolean flag = s == null;
            boolean flag1 = s != null && s1 == null;
            boolean flag2 = s != null && s1 != null;

            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            if(flag)
            {
                response.sendRedirect("/jsp/order/SaleOrders.jsp" + qs);
            } else
            if(flag1)
            {
                response.sendRedirect("/jsp/order/SaleOrders2.jsp" + qs);
            } else
            if(flag2)
            {
                response.sendRedirect("/jsp/order/SaleOrders3.jsp" + qs);
            }

            /*
                        boolean flag3 = teasession._rv.isReal() || teasession._rv.isAccountant();
                        if(flag)
                        {
                            Text text = new Text(hrefGlance(teasession._rv) + ">" + super.r.getString(teasession._nLanguage, "SaleOrders"));
                            text.setId("PathDiv");
                            List list = new List();
                            for(int l = 0; l < Trade.TRADE_TYPE.length; l++)
                            {
                                int i1 = Trade.count(false, teasession._rv, l);
                                if(i1 != 0)
                                    list.add(new ListItem(new Anchor("SaleOrders?Type=" + l, i1 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[l]) + " " + super.r.getString(teasession._nLanguage, "SaleOrders"))));
                            }

                            PrintWriter printwriter = response.getWriter();
                            printwriter.print(text);
                            printwriter.print(list);
                            printwriter.print(new Languages(teasession._nLanguage, request));
                            printwriter.close();
                            return;
                        }
                        if(flag1)
                        {
                            int i = Integer.parseInt(s);
                            Text text1 = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("SaleOrders", super.r.getString(teasession._nLanguage, "SaleOrders")) + ">" + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[i]));
                            text1.setId("PathDiv");
                            List list1 = new List();
                            for(int j1 = 0; j1 < Trade.TRADE_STATUS.length; j1++)
                            {
                                int k1 = Trade.count(false, teasession._rv, i, j1);
                                if(k1 != 0)
                                    list1.add(new ListItem(new Anchor("SaleOrders?Type=" + i + "&Status=" + j1, k1 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[j1]) + " " + super.r.getString(teasession._nLanguage, "SaleOrders"))));
                            }

                            PrintWriter printwriter1 = beginOut(response, teasession);
                            printwriter1.print(text1);
                            printwriter1.print(list1);
                            printwriter1.print(new Languages(teasession._nLanguage, request));
                            endOut(printwriter1, teasession);
                            return;
                        }
                        if(flag2)
                        {
                            int j = Integer.parseInt(s);
                            int k = Integer.parseInt(s1);
                            Text text2 = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("SaleOrders", super.r.getString(teasession._nLanguage, "SaleOrders")) + ">" + new Anchor("SaleOrders?Type=" + j, super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])) + ">" + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k]));
                            text2.setId("PathDiv");
                            String s2 = request.getParameter("Pos");
                            int l1 = s2 == null ? 0 : Integer.parseInt(s2);
                            Table table = new Table();
                            table.setCellPadding(5);
                            int i2 = Trade.count(false, teasession._rv, j, k);
                            table.setCaption(i2 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j]) + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k]) + " " + super.r.getString(teasession._nLanguage, "SaleOrders"));
                            if(i2 != 0)
                            {
                                Row row;
                                for(Enumeration enumeration = Trade.find(false, teasession._rv, j, k, l1, 100); enumeration.hasMoreElements(); table.add(row))
                                {
                                    int j2 = ((Integer)enumeration.nextElement()).intValue();
                                    Trade trade = Trade.find(j2);
                                    int k2 = trade.getCurrency();
                                    RV rv = trade.getVendor();
                                    row = new Row(new Cell(hrefGlance(rv,request.getContextPath())));
                                    row.add(new Cell(new Text("" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(trade.getTime()) + "")));
                                    row.add(new Cell(new Anchor("Trade?Trade=" + j2, new Text("#" + j2))));
                                    row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, Common.CURRENCY[k2]) + trade.getTotal().toString())));
                                    if(k == 2)
                                    {
                                        int l2 = trade.getOptions();
                                        if((l2 & 4) != 0)
                                        {
                                            Cell cell2 = new Cell(new Radio("Paid" + j2, j2, true));
                                            cell2.add(new Text(super.r.getString(teasession._nLanguage, "PaymentReceived")));
                                            if(flag3)
                                                cell2.add(new Button(1, "CB", "CBCorrect", super.r.getString(teasession._nLanguage, "CBCorrect"), "window.open('TradePayment?Type=" + j + "&Status=" + k + "&Unpaid=" + j2 + "', '_self');"));
                                            row.add(cell2);
                                        } else
                                        {
                                            Cell cell3 = new Cell(new CheckBox("Paid", false, String.valueOf(j2)));
                                            cell3.add(new Text(super.r.getString(teasession._nLanguage, "ConfirmPayment")));
                                            row.add(cell3);
                                        }
                                        if((l2 & 8) != 0)
                                        {
                                            Cell cell4 = new Cell(new Radio("Split" + j2, j2, true));
                                            cell4.add(new Text(super.r.getString(teasession._nLanguage, "OrderSplit")));
                                            if(flag3)
                                                cell4.add(new Button(1, "CB", "CBCorrect", super.r.getString(teasession._nLanguage, "CBCorrect"), "window.open('TradePayment?Type=" + j + "&Status=" + k + "&Unsplit=" + j2 + "', '_self');"));
                                            row.add(cell4);
                                        } else
                                        {
                                            Cell cell5 = new Cell(new CheckBox("Split", false, String.valueOf(j2)));
                                            cell5.add(new Text(super.r.getString(teasession._nLanguage, "SplitOrder")));
                                            row.add(cell5);
                                        }
                                    }
                                }

                            }
                            Form form = new Form("foPayment", "POST", "TradePayment");
                            if(k == 2)
                            {
                                form.add(table);
                                form.add(new HiddenField("Type", j));
                                form.add(new HiddenField("Status", k));
                                if(flag3)
                                    form.add(new Button(0, "CB", "CBSubmit", super.r.getString(teasession._nLanguage, "CBSubmit"), ""));
                            }
                            Table table1 = new Table();
                            Row row1 = new Row();
                            Cell cell = new Cell();
                            if(i2 != 0 && (j == 1 || j == 2 || j == 3) && (k == 2 || k == 5))
                            {
                                Form form1 = new Form("foDataOutput", "POST", "TradeDataOutput");
                                int i3;
                                for(Enumeration enumeration1 = Trade.find(false, teasession._rv, j, k, 0, i2); enumeration1.hasMoreElements(); form1.add(new HiddenField("Trades", i3)))
                                    i3 = ((Integer)enumeration1.nextElement()).intValue();

                                form1.add(new HiddenField("Batch", "true"));
                                form1.add(new HiddenField("Type", j));
                                form1.add(new HiddenField("Status", k));
                                form1.add(new Button(0, "CB", "CBDataOutput", super.r.getString(teasession._nLanguage, "CBDataOutput"), ""));
                                DropDown dropdown = new DropDown("Method", super.r.getString(teasession._nLanguage, "TradeDataOutputMethodDefault"));
                                dropdown.addOption("-1", super.r.getString(teasession._nLanguage, "None"));
                                for(int j3 = 0; j3 < TradeDataOutput.TRADEDATAOUTPUT_METHOD.length; j3++)
                                    dropdown.addOption(j3, super.r.getString(teasession._nLanguage, TradeDataOutput.TRADEDATAOUTPUT_METHOD[j3]));

                                form1.add(dropdown);
                                cell.add(form1);
                            }
                            Cell cell1 = new Cell();
                            if(i2 != 0)
                            {
                                Form form2 = new Form("foInvoice", "POST", "TradeInvoice");
                                form2.setTarget("_blank");
                                int k3;
                                for(Enumeration enumeration2 = Trade.find(false, teasession._rv, j, k, 0, i2); enumeration2.hasMoreElements(); form2.add(new HiddenField("Trades", k3)))
                                    k3 = ((Integer)enumeration2.nextElement()).intValue();

                                form2.add(new HiddenField("Batch", "true"));
                                form2.add(new HiddenField("Type", j));
                                form2.add(new HiddenField("Status", k));
                                form2.add(new Button(0, "CB", "CBInvoice", super.r.getString(teasession._nLanguage, "CBInvoice"), ""));
                                DropDown dropdown1 = new DropDown("InvoiceFormat", super.r.getString(teasession._nLanguage, "TradeInvoiceFormatDefault"));
                                for(int l3 = 0; l3 < TradeInvoice.TRADEINVOICE_FORMAT.length; l3++)
                                    dropdown1.addOption(l3, super.r.getString(teasession._nLanguage, TradeInvoice.TRADEINVOICE_FORMAT[l3]));

                                form2.add(dropdown1);
                                cell1.add(form2);
                            }
                            row1.add(cell);
                            row1.add(cell1);
                            table1.add(row1);
                            PrintWriter printwriter2 = beginOut(response, teasession);
                            printwriter2.print(text2);
                            if(k == 2)
                                printwriter2.print(form);
                            else
                                printwriter2.print(table);
                            printwriter2.print(new FPNL(teasession._nLanguage, "SaleOrders?Type=" + j + "&Status=" + k + "&Pos=", l1, i2));
                            printwriter2.print(table1);
                            printwriter2.print(new Languages(teasession._nLanguage, request));
                            endOut(printwriter2, teasession);
                            return;
                        }*/
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/order/SaleOrders").add("tea/ui/member/order/TradeServlet");
    }
}
