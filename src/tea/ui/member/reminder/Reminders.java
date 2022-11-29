// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-18 11:52:41
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   Reminders.java

package tea.ui.member.reminder;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Enumeration;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Reminder;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Languages;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class Reminders extends TeaServlet
{

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/reminder/Reminders").add("tea/ui/member/profile/ProfileServlet");
    }

    public Reminders()
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
            String qs = request.getQueryString();
            qs = qs == null ? "" : "?" + qs;
            response.sendRedirect("/jsp/add/Reminders.jsp" + qs);
            /*
                        tea.entity.RV rv = teasession._rv;
                        Text text = new Text(hrefGlance(rv,request.getContextPath()) + ">" + new Anchor("Profile", super.r.getString(teasession._nLanguage, "Profile")) + ">" + super.r.getString(teasession._nLanguage, "Reminders"));
                        text.setId("PathDiv");
                        Form form = new Form("foDelete", "GET", "DeleteReminders");
                        Table table = new Table();
                        table.setCellPadding(3);
                        table.setBorder(1);
                        int i = Reminder.count(rv);
                        table.setCaption(i + " " + super.r.getString(teasession._nLanguage, "Reminders"));
                        if(i != 0)
                        {
                            table.setTitle("[]\n" + super.r.getString(teasession._nLanguage, "Subject") + "\n" + super.r.getString(teasession._nLanguage, "StartTime") + "\n" + super.r.getString(teasession._nLanguage, "StopTime") + "\n" + super.r.getString(teasession._nLanguage, "DeltaTime") + "(" + super.r.getString(teasession._nLanguage, "Days") + ")" + "\n" + super.r.getString(teasession._nLanguage, "RepeatTimes") + "\n" + super.r.getString(teasession._nLanguage, "Memo"));
                            Row row;
                            for(Enumeration enumeration = Reminder.find(rv); enumeration.hasMoreElements(); table.add(row))
                            {
                                int j = ((Integer)enumeration.nextElement()).intValue();
                                Reminder reminder = Reminder.find(j);
                                int k = reminder.getNode();
                                Node node = Node.find(k);
                                String s = node.getSubject(teasession._nLanguage);
                                row = new Row(new Cell(new CheckBox("Reminders", false, String.valueOf(j))));
                                row.add(new Cell(new Anchor("Node?node=" + k, s)));
                                row.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(reminder.getStartTime()) + "</font>")));
                                row.add(new Cell(new Text("<font>" + (new SimpleDateFormat("yyyy.MM.dd hh:mm")).format(reminder.getStopTime()) + "</font>")));
                                row.add(new Cell(new Text(" " + reminder.getDeltaTime())));
                                row.add(new Cell(new Text(" " + reminder.getRepeatTimes())));
                                row.add(new Cell(new Text("<font>" + super.r.getString(teasession._nLanguage, reminder.getNote()) + "</font>")));
                                row.add(new Cell(new Button(1, "CB", "CBEdit", super.r.getString(teasession._nLanguage, "CBEdit"), "window.open('EditReminder?Reminder=" + j + "', '_self');")));
                                row.add(new Cell(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "window.open('DeleteReminder?Reminder=" + j + "', '_self');")));
                            }

                        }
                        form.add(table);
                        PrintWriter printwriter = response.getWriter();
                        printwriter.print(text);
                        printwriter.print(form);
                        printwriter.print(new Button(1, "CB", "CBNew", super.r.getString(teasession._nLanguage, "CBNew"), "window.open('NewReminder', '_self');"));
                        printwriter.print(new Button(1, "CB", "CBDelete", super.r.getString(teasession._nLanguage, "CBDelete"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteSelected") + "')){window.open('javascript:foDelete.submit();" + "', '_self');}"));
                        printwriter.print(new Button(1, "CB", "CBDeleteAll", super.r.getString(teasession._nLanguage, "CBDeleteAll"), "if(confirm('" + super.r.getString(teasession._nLanguage, "ConfirmDeleteAll") + "')){window.open('DeleteAllReminders" + "', '_self');}"));
                        printwriter.print(new Languages(teasession._nLanguage, request));
                        printwriter.close();
                        return;
             */
        } catch(Exception ex)
        {
            ex.printStackTrace();
            response.sendError(500,ex.toString());
        }
    }
}
