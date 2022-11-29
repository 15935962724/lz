// Decompiled by DJ v2.9.9.60 Copyright 2000 Atanas Neshkov  Date: 2004-9-18 15:52:23
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3)
// Source File Name:   MemberOverview.java

package tea.ui.site;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.member.Profile;
import tea.html.*;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class MemberOverview extends TeaServlet
{

    public MemberOverview()
    {
    }

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/site/MemberOverview");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.sendRedirect("/jsp/site/MemberOverview.jsp");
        /*
        try
        {
            TeaSession teasession = new TeaSession(request);
            PrintWriter printwriter = response.getWriter();
            try
            {
                Table table = new Table();
                table.setCellPadding(5);
                table.setCaption(Profile.count() + " " + super.r.getString(teasession._nLanguage, "SignedUpMembers"));
                table.setTitle(super.r.getString(teasession._nLanguage, "Date") + "\n" + super.r.getString(teasession._nLanguage, "NewMembers") + "\n" + super.r.getString(teasession._nLanguage, "LoginMembers") + "\n");
                long l = System.currentTimeMillis();
                int i = 0;
                do
                {
                    Calendar calendar = Calendar.getInstance();
                    calendar.setTime(new Date(l - (long) i * 24L * 60L * 60L * 1000L));
                    calendar.set(11, 0);
                    calendar.set(12, 0);
                    calendar.set(13, 0);
                    Date date = calendar.getTime();
                    calendar.set(11, 23);
                    calendar.set(12, 59);
                    calendar.set(13, 59);
                    Date date1 = calendar.getTime();
                    Row row = new Row(new Cell(new Text(DateFormat.getDateInstance().format(date))));
                    Cell cell = new Cell(new Text(Profile.count(date, date1) + ""));
                    cell.setAlign(3);
                    row.add(cell);
                    Cell cell1 = new Cell(new Text(Log.count(date, date1) + ""));
                    cell1.setAlign(3);
                    row.add(cell1);
                    table.add(row);
                } while (++i < 7);
                printwriter.print(table);
            } catch (Exception exception1)
            {
                printwriter.print(exception1);
            } finally
            {
                printwriter.close();
            }
        } catch (Exception exception)
        {
            response.sendError(400, exception.toString());
            exception.printStackTrace();
        }*/
    }
}
