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
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

// Referenced classes of package tea.ui.member.order:
//            TradeInvoice

public class PurchaseOrders extends TeaServlet
{

    public PurchaseOrders()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            if (!teasession._rv.isPurchaser())
            {
                response.sendError(403);
                return;
            }
            response.sendRedirect("/jsp/order/PurchaseOrders.jsp?" + request.getQueryString());
            /*
                         String s = request.getParameter("Type");
                         String s1 = request.getParameter("Status");
                         boolean flag = s == null;
                         boolean flag1 = s != null && s1 == null;
                         boolean flag2 = s != null && s1 != null;
                         if(flag)
                         {
                Text text = new Text(hrefGlance(teasession._rv) + ">" + super.r.getString(teasession._nLanguage, "PurchaseOrders") + ">");
                text.setId("PathDiv");
                List list = new List();
                for(int l = 0; l < Trade.TRADE_TYPE.length; l++)
                {
                    int i1 = Trade.count(true, teasession._rv, l);
                    if(i1 != 0)
                        list.add(new ListItem(new Anchor("PurchaseOrders?Type=" + l, i1 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[l]) + " " + super.r.getString(teasession._nLanguage, "PurchaseOrders"))));
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
                Text text1 = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("PurchaseOrders", super.r.getString(teasession._nLanguage, "PurchaseOrders")) + ">" + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[i]));
                text1.setId("PathDiv");
                List list1 = new List();
                for(int j1 = 0; j1 < Trade.TRADE_STATUS.length; j1++)
                {
                    int k1 = Trade.count(true, teasession._rv, i, j1);
                    if(k1 != 0)
                        list1.add(new ListItem(new Anchor("PurchaseOrders?Type=" + i + "&Status=" + j1, k1 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[j1]) + " " + super.r.getString(teasession._nLanguage, "PurchaseOrders"))));
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
                Text text2 = new Text(hrefGlance(teasession._rv) + ">" + new Anchor("PurchaseOrders", super.r.getString(teasession._nLanguage, "PurchaseOrders")) + ">" + new Anchor("PurchaseOrders?Type=" + j, super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j])) + ">" + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k]));
                text2.setId("PathDiv");
                String s2 = request.getParameter("Pos");
                int l1 = s2 == null ? 0 : Integer.parseInt(s2);
                Table table = new Table();
                table.setCellPadding(5);
                int i2 = Trade.count(true, teasession._rv, j, k);
                table.setCaption(i2 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[j]) + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[k]) + " " + super.r.getString(teasession._nLanguage, "PurchaseOrders"));
                if(i2 != 0)
                {
                    Row row;
                    for(Enumeration enumeration = Trade.find(true, teasession._rv, j, k, l1, 25); enumeration.hasMoreElements(); table.add(row))
                    {
                        int j2 = ((Integer)enumeration.nextElement()).intValue();
                        Trade trade = Trade.find(j2);
                        RV rv = trade.getVendor();
                        row = new Row(new Cell(hrefGlance(rv,request.getContextPath())));
                        row.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(trade.getTime()) + "</font>")));
                        row.add(new Cell(new Anchor("Trade?Trade=" + j2, new Text("#" + j2))));
                        row.add(new Cell(new Text(trade.getTotal().toString())));
                    }

                }
                Table table1 = new Table();
                Row row1 = new Row();
                Cell cell = new Cell();
                if(i2 != 0)
                {
                    Form form = new Form("foInvoice", "POST", "TradeInvoice");
                    form.setTarget("_blank");
                    int k2;
                    for(Enumeration enumeration1 = Trade.find(true, teasession._rv, j, k, 0, i2); enumeration1.hasMoreElements(); form.add(new HiddenField("Trades", k2)))
                        k2 = ((Integer)enumeration1.nextElement()).intValue();

                    form.add(new HiddenField("Batch", "true"));
                    form.add(new HiddenField("Type", j));
                    form.add(new HiddenField("Status", k));
                    form.add(new Button(super.r.getString(teasession._nLanguage, "Invoice")));
                    DropDown dropdown = new DropDown("InvoiceFormat", super.r.getString(teasession._nLanguage, "TradeInvoiceFormatDefault"));
                    for(int l2 = 0; l2 < TradeInvoice.TRADEINVOICE_FORMAT.length; l2++)
                        dropdown.addOption(l2, super.r.getString(teasession._nLanguage, TradeInvoice.TRADEINVOICE_FORMAT[l2]));

                    form.add(dropdown);
                    cell.add(form);
                }
                row1.add(cell);
                table1.add(row1);
                PrintWriter printwriter2 = beginOut(response, teasession);
                printwriter2.print(text2);
                printwriter2.print(table);
                printwriter2.print(new FPNL(teasession._nLanguage, "PurchaseOrders?Type=" + j + "&Status=" + k + "&Pos=", l1, i2));
                printwriter2.print(table1);
                printwriter2.print(new Languages(teasession._nLanguage, request));
                endOut(printwriter2, teasession);
                return;
                         }
             */
        } catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/order/PurchaseOrders").add("tea/ui/member/order/TradeServlet");
    }
}
