package tea.ui.member.notification;

import java.io.*;
//import java.text.DateFormat;
//import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import tea.entity.RV;
import tea.entity.member.*;
import tea.entity.node.*;
import tea.entity.site.JoinRequest;
/*import tea.html.*;
import tea.resource.Resource;
import tea.service.Robot;*/
import tea.ui.TeaServlet;
import tea.ui.TeaSession;
//import javax.servlet.http.HttpServlet;
public class NotificationServlet extends  TeaServlet
{

    public void init(ServletConfig servletconfig)
        throws ServletException
    {
        super.init(servletconfig);
       // super.r.add("tea/ui/member/notification/NotificationServlet").add("tea/ui/member/message/MessageFolders").add("tea/ui/member/order/SaleOrders").add("tea/ui/member/order/PurchaseOrders").add("tea/ui/member/profile/ProfileServlet").add("tea/ui/member/request/Requests");
    }

    public NotificationServlet()
    {
    }

    public void service(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException
    {
        try
        {

            TeaSession teasession = new TeaSession(request);
            if(teasession._rv == null)
            {
                response.sendRedirect("/servlet/StartLogin?node=" + teasession._nNode);
                return;
            }
            response.sendRedirect("/jsp/access/Notification.jsp?"+request.getQueryString());
/**
            RV rv = teasession._rv;
            Notification notification = Notification.find(rv);
            if(!notification.isExisted(rv))
                Notification.create(rv);
            Date date = Log.getLastTime(rv);
            int i = notification.getOptions();
            PrintWriter printwriter = response.getWriter();
            printwriter.print(super.r.getString(teasession._nLanguage, "LastLogin") + "<font>: " + (new SimpleDateFormat("yyyy.MM.dd HH:mm aaa")).format(date) + "</font>");
            printwriter.println("<hr width=50% /><br>");
            Table table = new Table();
            table.setCellPadding(3);
            if((i & 2) != 0)
            {
                int j = Message.countNew("Inbox", rv, date);
                if(j != 0)
                {
                    int k = 0;
                    for(Enumeration enumeration = Message.find(new String("Inbox"), rv); enumeration.hasMoreElements();)
                    {
                        int i1 = ((Integer)enumeration.nextElement()).intValue();
                        if(!MessageReader.isRead(i1, rv))
                            k++;
                    }

                    Row row1 = new Row();
                    row1.add(new Cell(new Anchor("Messages?Folder=Inbox", "_blank", new Text(j + "  " + super.r.getString(teasession._nLanguage, "InboxNewMessages")))));
                    row1.add(new Cell(new Anchor("Messages?Folder=Inbox", "_blank", new Text(k + "  " + super.r.getString(teasession._nLanguage, "InboxUnreadMessages")))));
                    table.add(row1);
                    printwriter.println("<EMBED SRC=\"/tea/audio/" + teasession._nLanguage + "/yougotmail.wav\" " + " AUTOSTART=true WIDTH=0 HEIGHT=0>");
                }
            }
            Table table1 = new Table();
            table1.setCellPadding(3);
            if((i & 0x10) != 0)
            {
                Row row = new Row();
                if(JoinRequest.countRequestCommunities(rv) != 0)
                    row.add(new Cell(new Anchor("JoinRequestCommunities", "_blank", new Text(JoinRequest.countRequestCommunities(rv) + " " + super.r.getString(teasession._nLanguage, "JoinRequestCommunities")))));
                if(AccessRequest.countNodes(rv) != 0)
                    row.add(new Cell(new Anchor("AccessRequestNodes", "_blank", new Text(AccessRequest.countNodes(rv) + " " + super.r.getString(teasession._nLanguage, "AccessRequestNodes")))));
                if(Aded.countRequestNodes(rv) != 0)
                    row.add(new Cell(new Anchor("AdRequestNodes", "_blank", new Text(Aded.countRequestNodes(rv) + " " + super.r.getString(teasession._nLanguage, "AdRequestNodes")))));
                if(Node.countRequestNodes(rv) != 0)
                    row.add(new Cell(new Anchor("NodeRequestNodes", "_blank", new Text(Node.countRequestNodes(rv) + " " + super.r.getString(teasession._nLanguage, "NodeRequestNodes")))));
                if(rv.isSupport() && ProfileRequest.countRequests(rv._strR) != 0)
                    row.add(new Cell(new Anchor("ProfileRequests", "_blank", new Text(ProfileRequest.countRequests(rv._strR) + " " + super.r.getString(teasession._nLanguage, "ProfileRequests")))));
                table1.add(row);
            }
            Table table2 = new Table();
            table2.setCellPadding(3);
            if((i & 4) != 0)
            {
                for(int l = 0; l < Trade.TRADE_TYPE.length; l++)
                {
                    int j1 = Trade.count(false, rv, l);
                    Row row2 = new Row();
                    if(j1 != 0)
                    {
                        int i2 = Trade.count(false, rv, l, 0);
                        int j2 = Trade.count(false, rv, l, 4);
                        int l2 = Trade.count(false, rv, l, 6);
                        if(i2 != 0)
                            row2.add(new Cell(new Anchor("SaleOrders?Type=" + l + "&Status=" + 0, "_blank", new Text(i2 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[0]) + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[l]) + " " + super.r.getString(teasession._nLanguage, "SaleOrders")))));
                        if(j2 != 0)
                            row2.add(new Cell(new Anchor("SaleOrders?Type=" + l + "&Status=" + 4, "_blank", new Text(j2 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[4]) + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[l]) + " " + super.r.getString(teasession._nLanguage, "SaleOrders")))));
                        if(l2 != 0)
                            row2.add(new Cell(new Anchor("SaleOrders?Type=" + l + "&Status=" + 6, "_blank", new Text(l2 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[6]) + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[l]) + " " + super.r.getString(teasession._nLanguage, "SaleOrders")))));
                        table2.add(row2);
                    }
                }

            }
            Table table3 = new Table();
            table3.setCellPadding(3);
            if((i & 8) != 0)
            {
                for(int k1 = 0; k1 < Trade.TRADE_TYPE.length; k1++)
                {
                    int l1 = Trade.count(true, rv, k1);
                    Row row3 = new Row();
                    if(l1 != 0)
                    {
                        int k2 = Trade.count(true, rv, k1, 3);
                        int i3 = Trade.count(true, rv, k1, 7);
                        int j3 = Trade.count(true, rv, k1, 10);
                        if(k2 != 0)
                            row3.add(new Cell(new Anchor("PurchaseOrders?Type=" + k1 + "&Status=" + 3, "_blank", new Text(k2 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[3]) + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[k1]) + " " + super.r.getString(teasession._nLanguage, "PurchaseOrders")))));
                        if(i3 != 0)
                            row3.add(new Cell(new Anchor("PurchaseOrders?Type=" + k1 + "&Status=" + 7, "_blank", new Text(i3 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[7]) + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[k1]) + " " + super.r.getString(teasession._nLanguage, "PurchaseOrders")))));
                        if(j3 != 0)
                            row3.add(new Cell(new Anchor("PurchaseOrders?Type=" + k1 + "&Status=" + 10, "_blank", new Text(j3 + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_STATUS[10]) + " " + super.r.getString(teasession._nLanguage, Trade.TRADE_TYPE[k1]) + " " + super.r.getString(teasession._nLanguage, "PurchaseOrders")))));
                        table3.add(row3);
                    }
                }

            }
            Form form = new Form("foDelete", "GET", "DeleteReminders");
            Table table4 = new Table();
            table4.setCellPadding(3);
            boolean flag = false;
            if((i & 0x20) != 0)
            {
                Date date1 = new Date(System.currentTimeMillis());
                Enumeration enumeration1 = Reminder.find(rv, date1);
                if(enumeration1.hasMoreElements())
                {
                    flag = true;
                    table4.setBorder(1);
                    table4.setCaption(" " + super.r.getString(teasession._nLanguage, "Reminders"));
                    table4.setTitle("[]\n" + super.r.getString(teasession._nLanguage, "Subject") + "\n" + super.r.getString(teasession._nLanguage, "StartTime") + "\n" + super.r.getString(teasession._nLanguage, "StopTime") + "\n" + super.r.getString(teasession._nLanguage, "DeltaTime") + "(" + super.r.getString(teasession._nLanguage, "Days") + ")" + "\n" + super.r.getString(teasession._nLanguage, "RepeatTimes") + "\n" + super.r.getString(teasession._nLanguage, "Memo"));
                    Row row4;
                    for(; enumeration1.hasMoreElements(); table4.add(row4))
                    {
                        int k3 = ((Integer)enumeration1.nextElement()).intValue();
                        Reminder reminder = Reminder.find(k3);
                        int i4 = reminder.getNode();
                        Node node = Node.find(i4);
                        String s = node.getSubject(teasession._nLanguage);
                        String s1 = s;
                        try
                        {
                            byte abyte0[] = s.getBytes();
                            s1 = new String(abyte0, "ISO-8859-1");
                        }
                        catch(Exception exception1) { }
                        String s2 = reminder.getNote();
                        String s3;
                        if(s != null)
                            s3 = s1;
                        else
                            s3 = s2;
                        int i5 = reminder.getOptions();
                        int j5 = reminder.getStatus();
                        String s4 = reminder.getToEmail();
                        Profile profile = Profile.find(rv._strV);
                        String s5 = profile.getEmail(teasession._nLanguage);
                        if((i5 & 2) != 0 && (j5 & 2) == 0)
                        {
                            String s6 = "<a href='/servlet/Node?node=" + i4 + "'>" + s3 + "</a><br>" + s2;
                            int k5 = Message.create(rv, null, 0, 0, 0, 0, teasession._nLanguage, s3, s6, null, null, "", null, rv._strR, "", "", null, null, 0, 0);
                            j5 += 2;
                            reminder.set(j5);
                        }
                        if((i5 & 4) != 0 && (j5 & 4) == 0)
                        {
                            String s7 = "<a href='http://" + request.getServerName() + "/servlet/Node?node=" + i4 + "'>" + s3 + "</a><br>" + s2;
                            int l5 = Message.create(rv, null, 0, 0, 2, 0, teasession._nLanguage, s3, s7, null, null, "", null, s4, "", "", null, null, 0, 0);
                            try
                            {
                                Robot.activateRobot(l5);
                            }
                            catch(Exception exception2) { }
                            j5 += 4;
                            reminder.set(j5);
                        }
                        row4 = new Row(new Cell(new CheckBox("Reminders", false, "" + k3)));
                        row4.add(new Cell(new Anchor("Node?node=" + i4, s)));
                        row4.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(reminder.getStartTime()) + "</font>")));
                        row4.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(reminder.getStopTime()) + "</font>")));
                        row4.add(new Cell(new Text(" " + reminder.getDeltaTime())));
                        row4.add(new Cell(new Text(" " + reminder.getRepeatTimes())));
                        row4.add(new Cell(new Text("<font>" + super.r.getString(teasession._nLanguage, reminder.getNote()) + "</font>")));
                        row4.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditReminder?Reminder=" + k3 + "', '_blank');")));
                        row4.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "window.open('DeleteReminder?Reminder=" + k3 + "', '_blank');")));
                    }

                    Row row5 = new Row();
                    Cell cell = new Cell();
                    cell.setColSpan(9);
                    cell.add(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                    cell.add(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('NewReminder', '_blank');"));
                    cell.add(new Button(1, "CB", "CBEditAll", super.r.getString(teasession._nLanguage, "CBEditAll"), "window.open('Reminders', '_blank');"));
                    row5.add(cell);
                    table4.add(row5);
                    form.add(table4);
                }
                Enumeration enumeration2 = Reminder.findPast(rv, date1);
                if(enumeration2.hasMoreElements())
                {
                    Reminder reminder1;
                    int k4;
                    Date date2;
                    Date date3;
                    int l4;
                    for(; enumeration2.hasMoreElements(); reminder1.set(date2, date3, k4, l4))
                    {
                        int l3 = ((Integer)enumeration2.nextElement()).intValue();
                        reminder1 = Reminder.find(l3);
                        int j4 = reminder1.getDeltaTime();
                        k4 = reminder1.getRepeatTimes();
                        date2 = reminder1.getStartTime();
                        date3 = reminder1.getStopTime();
                        date2 = new Date(date2.getTime() + (long)j4 * 0x5265c00L);
                        date3 = new Date(date3.getTime() + (long)j4 * 0x5265c00L);
                        k4--;
                        l4 = 0;
                    }

                }
            }
            if(table != null)
                printwriter.println(table);
            if(table1 != null)
                printwriter.println(table1);
            if(table2 != null)
                printwriter.println(table2);
            if(table3 != null)
                printwriter.println(table3);
            if(flag)
                printwriter.println(form);
            printwriter.println("<br><br>");
            printwriter.print(new Button("Submit", super.r.getString(teasession._nLanguage, "Edit"), "window.open('/servlet/EditNotification')"));
            printwriter.close();*/
        }
        catch(Exception ex)
{
  ex.printStackTrace();
  response.sendError(500,ex.toString());
}
    }

    public static boolean isNotifying(RV rv,String community)
        throws SQLException
    {
        boolean flag = false;
        try
        {
            Notification notification = Notification.find(rv);
            if(!notification.isExisted(rv))
            {
                Notification.create(rv);
                flag = true;
            }
            Date date = Log.getLastTime(rv);
            int i = notification.getOptions();
            if((i & 2) != 0)
            {
                int j = Message.countNew(community,"Inbox", rv, date);
                if(j != 0)
                    flag = true;
            }
            if((i & 0x10) != 0)
            {
                if(JoinRequest.countRequestCommunities(rv) != 0)
                    flag = true;
                if(AccessRequest.countNodes(rv) != 0)
                    flag = true;
                if(Aded.countRequestNodes(rv) != 0)
                    flag = true;
                if(Node.countRequestNodes(rv) != 0)
                    flag = true;
                if(rv.isSupport() && ProfileRequest.countRequests(rv._strR) != 0)
                    flag = true;
            }
            if((i & 4) != 0)
            {
                for(int k = 0; k < Trade.TRADE_TYPE.length; k++)
                {
                    int i1 = Trade.count(false, rv, k,community);
                    if(i1 != 0)
                    {
                        int k1 = Trade.count(false, rv, k, 0,community);
                        int i2 = Trade.count(false, rv, k, 4,community);
                        int k2 = Trade.count(false, rv, k, 6,community);
                        if(k1 != 0 || i2 != 0 || k2 != 0)
                            flag = true;
                    }
                }

            }
            if((i & 8) != 0)
            {
                for(int l = 0; l < Trade.TRADE_TYPE.length; l++)
                {
                    int j1 = Trade.count(true, rv, l,community);
                    if(j1 != 0)
                    {
                        int l1 = Trade.count(true, rv, l, 3,community);
                        int j2 = Trade.count(true, rv, l, 7,community);
                        int l2 = Trade.count(true, rv, l, 10,community);
                        if(l1 != 0 || j2 != 0 || l2 != 0)
                            flag = true;
                    }
                }

            }
            if((i & 0x20) != 0)
            {
                Date date1 = new Date(System.currentTimeMillis());
                Enumeration enumeration = Reminder.find(rv, date1);
                if(enumeration.hasMoreElements())
                    flag = true;
            }
        }
        catch(Exception exception)
        {
            System.err.println(exception);
        }
        return flag;
    }
}
