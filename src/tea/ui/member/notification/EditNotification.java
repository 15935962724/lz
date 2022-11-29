package tea.ui.member.notification;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Notification;
import tea.entity.member.Trade;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditNotification extends TeaServlet
{

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/notification/EditNotification").add("tea/ui/member/message/MessageFolders").add("tea/ui/member/order/SaleOrders").add("tea/ui/member/order/PurchaseOrders").add("tea/ui/member/profile/ProfileServlet").add("tea/ui/member/request/Requests");
    }

    public EditNotification()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        request.setCharacterEncoding("UTF-8");
        try
        {
            TeaSession teasession = new TeaSession(request);
            if (teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            RV rv = teasession._rv;
            Notification notification = Notification.find(rv);
            int i = notification.getOptions();
            if (request.getMethod().equals("GET"))
            {
                String qs = request.getQueryString();
                qs = qs == null ? "" : "?" + qs;
                response.sendRedirect("/jsp/access/EditNotification.jsp" + qs);

                /*
                                Form form = new Form("foEdit", "POST", "EditNotification");
                                Table table = new Table();
                                table.setCellPadding(5);
                                Row row = new Row();
                                row.add(new Cell(new CheckBox("CheckList1", (i & 2) != 0)));
                                row.add(new Cell(new Anchor("Messages?Folder=Inbox", "_blank", new Text(super.r.getString(teasession._nLanguage, "InboxNewMessages")))));
                                table.add(row);
                                Row row1 = new Row();
                                row1.add(new Cell(new CheckBox("CheckList4", (i & 0x10) != 0)));
                                row1.add(new Cell(new Anchor("JoinRequestCommunities", "_blank", new Text(super.r.getString(teasession._nLanguage, "JoinRequestCommunities")))));
                                row1.add(new Cell(new Anchor("AccessRequestNodes", "_blank", new Text(super.r.getString(teasession._nLanguage, "AccessRequestNodes")))));
                                row1.add(new Cell(new Anchor("AdRequestNodes", "_blank", new Text(super.r.getString(teasession._nLanguage, "AdRequestNodes")))));
                                row1.add(new Cell(new Anchor("NodeRequestNodes", "_blank", new Text(super.r.getString(teasession._nLanguage, "NodeRequestNodes")))));
                                if(rv.isSupport())
                                    row1.add(new Cell(new Anchor("ProfileRequests", "_blank", new Text(super.r.getString(teasession._nLanguage, "ProfileRequests")))));
                                table.add(row1);
                                Row row2 = new Row();
                                row2.add(new Cell(new CheckBox("CheckList2", (i & 4) != 0)));
                                row2.add(new Cell(new Anchor("SaleOrders?Status=" + 0, "_blank", new Text(super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[0]) + " " + super.r.getString(teasession._nLanguage, "SaleOrders")))));
                                row2.add(new Cell(new Anchor("SaleOrders?Status=" + 4, "_blank", new Text(super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[4]) + " " + super.r.getString(teasession._nLanguage, "SaleOrders")))));
                                row2.add(new Cell(new Anchor("SaleOrders?Status=" + 6, "_blank", new Text(super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[6]) + " " + super.r.getString(teasession._nLanguage, "SaleOrders")))));
                                table.add(row2);
                                Row row3 = new Row();
                                row3.add(new Cell(new CheckBox("CheckList3", (i & 8) != 0)));
                                row3.add(new Cell(new Anchor("PurchaseOrders?Status=" + 3, "_blank", new Text(super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[3]) + " " + super.r.getString(teasession._nLanguage, "PurchaseOrders")))));
                                row3.add(new Cell(new Anchor("PurchaseOrders?Status=" + 7, "_blank", new Text(super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[7]) + " " + super.r.getString(teasession._nLanguage, "PurchaseOrders")))));
                                row3.add(new Cell(new Anchor("PurchaseOrders?Status=" + 10, "_blank", new Text(super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[10]) + " " + super.r.getString(teasession._nLanguage, "PurchaseOrders")))));
                                table.add(row3);
                                Row row4 = new Row();
                                row4.add(new Cell(new CheckBox("CheckList21", (i & 0x20) != 0)));
                                row4.add(new Cell(new Anchor("Reminders", "_blank", new Text(super.r.getString(teasession._nLanguage, "Reminders")))));
                                table.add(row4);
                                form.add(table);
                                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                PrintWriter printwriter1 = beginOut(response, teasession);
                                printwriter1.print(form);
                                printwriter1.print(new Languages(teasession._nLanguage, request));
                                endOut(printwriter1, teasession);*/
                return;
            }
            int j = 0;
            if (request.getParameter("CheckList1") != null)
            {
                j += 2;
            }
            if (request.getParameter("CheckList4") != null)
            {
                j += 16;
            }
            if (request.getParameter("CheckList2") != null)
            {
                j += 4;
            }
            if (request.getParameter("CheckList3") != null)
            {
                j += 8;
            }
            if (request.getParameter("CheckList21") != null)
            {
                j += 32;
            }
            notification.set(j);
            PrintWriter printwriter = response.getWriter();
            printwriter.print("<script>window.close();</script>");
            printwriter.close();
            return;
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
            return;
        }
    }
}
