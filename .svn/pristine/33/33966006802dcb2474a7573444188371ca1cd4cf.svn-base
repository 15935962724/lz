package tea.ui.member.reminder;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Profile;
import tea.entity.member.Reminder;
import tea.entity.node.Node;
import tea.html.*;
import tea.htmlx.Languages;
import tea.htmlx.TimeSelection;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class EditReminder extends TeaServlet
{

    public void init(ServletConfig servletconfig) throws ServletException
    {
        super.init(servletconfig);
        super.r.add("tea/ui/member/reminder/EditReminder");
    }

    public EditReminder()
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
            if (request.getMethod().equals("GET"))
            {
                int i = Integer.parseInt(request.getParameter("Reminder"));
                Reminder reminder = Reminder.find(i);
                String s = request.getRequestURI();
                boolean flag = s.substring(s.lastIndexOf("/") + 1).equals("DeleteReminder");
                if (flag)
                {
                    if (!teasession._rv.equals(reminder.getRV()))
                    {
                        response.sendError(403);
                        return;
                    }
                    reminder.delete();
                    response.sendRedirect("Reminders");
                    return;
                }

                StringBuilder sb = new StringBuilder("?");
                java.util.Enumeration enumeration = request.getParameterNames();
                while (enumeration.hasMoreElements())
                {
                    String str = enumeration.nextElement().toString();
                    sb.append(str + "=" + request.getParameter(str) + "&");
                }
                response.sendRedirect("/jsp/add/EditReminder.jsp" + sb.toString());

                /*
                                int l = reminder.getNode();
                                Node node = Node.find(l);
                                String s1 = node.getSubject(teasession._nLanguage);
                                Form form = new Form("foEdit", "POST", "EditReminder");
                                form.setOnSubmit("return(submitInteger(this.Node, '" + super.r.getString(teasession._nLanguage, "InvalidNodeNumber") + "')" + ");");
                                form.add(new HiddenField("Reminder", i));
                                form.add(new HiddenField("Node", l));
                                Table table = new Table();
                                table.setCellPadding(3);
                                Row row = new Row();
                                Cell cell = new Cell();
                                cell.add(new Anchor("Node?node=" + l, s1));
                                cell.add(new Text(super.r.getString(teasession._nLanguage, "  Node") + "=" + l));
                                row.add(cell);
                                java.util.Date date2 = reminder.getStartTime();
                                java.util.Date date3 = reminder.getStopTime();
                                Row row1 = new Row();
                                Cell cell1 = new Cell();
                                cell1.add(new Text(super.r.getString(teasession._nLanguage, "StartTime") + ": "));
                                cell1.add(new TimeSelection("Start", date2));
                                row1.add(cell1);
                                Row row2 = new Row();
                                Cell cell2 = new Cell();
                                cell2.add(new Text(super.r.getString(teasession._nLanguage, "StopTime") + ": "));
                                cell2.add(new TimeSelection("Stop", date3));
                                row2.add(cell2);
                                Row row3 = new Row();
                                Cell cell3 = new Cell();
                                cell3.add(new Text(super.r.getString(teasession._nLanguage, "DeltaTime") + ": "));
                                cell3.add(new TextField("DeltaTime", reminder.getDeltaTime()));
                                cell3.add(new Text(super.r.getString(teasession._nLanguage, "Days") + "  ---  "));
                                cell3.add(new Text(super.r.getString(teasession._nLanguage, "RepeatTimes") + ": "));
                                cell3.add(new TextField("RepeatTimes", reminder.getRepeatTimes()));
                                row3.add(cell3);
                                Row row4 = new Row();
                                Cell cell4 = new Cell();
                                cell4.add(new Text(super.r.getString(teasession._nLanguage, "DeltaTimeRepeatTimesUsageNote")));
                                row4.add(cell4);
                                Row row5 = new Row();
                                Cell cell5 = new Cell();
                                cell5.add(new Text(super.r.getString(teasession._nLanguage, "AlsoRemindVia") + ":"));
                                row5.add(cell5);
                                Row row6 = new Row();
                                Cell cell6 = new Cell();
                                cell6.add(new CheckBox("ViaMessage", (reminder.getOptions() & 2) != 0));
                                cell6.add(new Text(super.r.getString(teasession._nLanguage, "ReminderOViaMessage")));
                                row6.add(cell6);
                                Row row7 = new Row();
                                Cell cell7 = new Cell();
                                cell7.add(new CheckBox("ViaEmail", (reminder.getOptions() & 4) != 0));
                                cell7.add(new Text(super.r.getString(teasession._nLanguage, "ReminderOViaEmail") + ": "));
                                Profile profile = Profile.find(rv._strV);
                                cell7.add(new TextField("ToEmail", reminder.getToEmail()));
                                row7.add(cell7);
                                Row row8 = new Row();
                                Cell cell8 = new Cell();
                                cell8.add(new Text(super.r.getString(teasession._nLanguage, "Memo") + ":"));
                                row8.add(cell8);
                                Row row9 = new Row();
                                Cell cell9 = new Cell();
                                cell9.add(new TextArea("Memo", super.r.getString(teasession._nLanguage, reminder.getNote()), 8, 60));
                                row9.add(cell9);
                                table.add(row);
                                table.add(row1);
                                table.add(row2);
                                table.add(row3);
                                table.add(row4);
                                table.add(new Row(new Cell(new Text("<br>"))));
                                table.add(row5);
                                table.add(row6);
                                table.add(row7);
                                table.add(row8);
                                table.add(row9);
                                form.add(table);
                                form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
                                PrintWriter printwriter = response.getWriter();
                                printwriter.print(form);
                                printwriter.print(new Languages(teasession._nLanguage, request));
                                printwriter.close();*/
            } else
            {
                int j = Integer.parseInt(teasession.getParameter("Reminder"));
                int k = Integer.parseInt(teasession.getParameter("Node"));
                java.util.Date date = TimeSelection.makeTime(teasession.getParameter("StartYear"), teasession.getParameter("StartMonth"), teasession.getParameter("StartDay"), teasession.getParameter("StartHour"), teasession.getParameter("StartMinute"));
                java.util.Date date1 = TimeSelection.makeTime(teasession.getParameter("StopYear"), teasession.getParameter("StopMonth"), teasession.getParameter("StopDay"), teasession.getParameter("StopHour"), teasession.getParameter("StopMinute"));
                int i1 = Integer.parseInt(teasession.getParameter("DeltaTime"));
                int j1 = Integer.parseInt(teasession.getParameter("RepeatTimes"));
                String s2 = teasession.getParameter("ToEmail");
                int k1 = 0;
                if (teasession.getParameter("ViaMessage") != null)
                {
                    k1 += 2;
                }
                if (teasession.getParameter("ViaEmail") != null)
                {
                    k1 += 4;
                }
                String s3 = teasession.getParameter("Memo");
                Reminder reminder1 = Reminder.find(j);
                int l1 = 0;
                reminder1.set(rv, k, date, date1, i1, j1, s2, k1, s3, l1);
                response.sendRedirect("Reminders");
            }
        } catch (Exception exception)
        {
            exception.printStackTrace();
            response.sendError(400, exception.toString());

        }
    }
}
