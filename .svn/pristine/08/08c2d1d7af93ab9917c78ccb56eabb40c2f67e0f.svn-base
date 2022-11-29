package tea.ui.member.reminder;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.StringTokenizer;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import tea.entity.RV;
import tea.entity.member.Profile;
import tea.entity.member.Reminder;
import tea.entity.node.Node;
import tea.entity.site.Community;
import tea.entity.site.Subscriber;
import tea.html.*;
import tea.htmlx.Languages;
import tea.htmlx.TimeSelection;
import tea.http.MultipartRequest;
import tea.resource.Resource;
import tea.ui.TeaServlet;
import tea.ui.TeaSession;

public class ReminderServlet extends TeaServlet
{

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("tea/ui/member/reminder/ReminderServlet");
	}

	public ReminderServlet()
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
			int i = 0;
			if (request.getMethod().equals("GET"))
			{
				String s = request.getRequestURI();
				boolean flag = s.endsWith("AddToReminder");
				boolean flag1 = s.substring(s.lastIndexOf("/") + 1).equals("NewReminder");

				StringBuilder sb = new StringBuilder("?");
				boolean bool = false;
				java.util.Enumeration enumeration = request.getParameterNames();
				while (enumeration.hasMoreElements())
				{
					String str = enumeration.nextElement().toString();
					if (str.equalsIgnoreCase("URI"))
					{
						bool = true;
						sb.append(str + "=" + s + "&");
					} else
					{
						sb.append(str + "=" + request.getParameter(str) + "&");
					}
				}
				if (!bool)
				{
					sb.append("URI=" + s);
				}
				response.sendRedirect("/jsp/add/AddToReminder.jsp" + sb.toString());

				//
				// if(flag)
				// {
				// if(Reminder.isExisted(rv, teasession._nNode))
				// {
				// int l = Reminder.find(rv, teasession._nNode);
				// Table table1 = new Table();
				// Row row1 = new Row();
				// row1.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "AlreadyInReminders"))));
				// table1.add(row1);
				// PrintWriter printwriter1 = beginOut(response, teasession);
				// printwriter1.print(table1);
				// printwriter1.print(new Anchor("NewReminder", super.r.getCommandImg(teasession._nLanguage, "New")));
				// printwriter1.print(new Anchor("EditReminder?Reminder=" + l, super.r.getCommandImg(teasession._nLanguage, "Edit")));
				// printwriter1.print(new Anchor("Reminders", super.r.getCommandImg(teasession._nLanguage, "EditAll")));
				// printwriter1.print(new Languages(teasession._nLanguage, request));
				// endOut(printwriter1, teasession);
				// return;
				// }
				// i = teasession._nNode;
				// }
				// if(flag1)
				// i = 0;
				// Form form = new Form("foNew", "POST", "AddToReminder");
				// form.setOnSubmit("return(submitInteger(this.Node, '" + super.r.getString(teasession._nLanguage, "InvalidNodeNumber") + "')" + ");");
				// Table table2 = new Table();
				// table2.setCellPadding(3);
				// Row row2 = new Row();
				// Cell cell = new Cell();
				// cell.add(new Text(super.r.getString(teasession._nLanguage, "Node") + ": "));
				// cell.add(new TextField("Node", i));
				// row2.add(cell);
				// Date date2 = new Date(System.currentTimeMillis());
				// Date date3 = new Date(System.currentTimeMillis() + 0x19bfcc00L);
				// Row row3 = new Row();
				// Cell cell1 = new Cell();
				// cell1.add(new Text(super.r.getString(teasession._nLanguage, "StartTime") + ": "));
				// cell1.add(new TimeSelection("Start", date2));
				// row3.add(cell1);
				// Row row4 = new Row();
				// Cell cell2 = new Cell();
				// cell2.add(new Text(super.r.getString(teasession._nLanguage, "StopTime") + ": "));
				// cell2.add(new TimeSelection("Stop", date3));
				// row4.add(cell2);
				// Row row5 = new Row();
				// Cell cell3 = new Cell();
				// cell3.add(new Text(super.r.getString(teasession._nLanguage, "DeltaTime") + ": "));
				// cell3.add(new TextField("DeltaTime", 0));
				// cell3.add(new Text(super.r.getString(teasession._nLanguage, "Days") + " --- "));
				// cell3.add(new Text(super.r.getString(teasession._nLanguage, "RepeatTimes") + ": "));
				// cell3.add(new TextField("RepeatTimes", 0));
				// row5.add(cell3);
				// Row row6 = new Row();
				// Cell cell4 = new Cell();
				// cell4.add(new Text(super.r.getString(teasession._nLanguage, "DeltaTimeRepeatTimesUsageNote")));
				// row6.add(cell4);
				// Row row7 = new Row();
				// Cell cell5 = new Cell();
				// cell5.add(new Text(super.r.getString(teasession._nLanguage, "AlsoRemindVia") + ":"));
				// row7.add(cell5);
				// Row row8 = new Row();
				// Cell cell6 = new Cell();
				// cell6.add(new CheckBox("ViaMessage", true));
				// cell6.add(new Text(super.r.getString(teasession._nLanguage, "ReminderOViaMessage")));
				// row8.add(cell6);
				// Row row9 = new Row();
				// Cell cell7 = new Cell();
				// cell7.add(new CheckBox("ViaEmail", true));
				// cell7.add(new Text(super.r.getString(teasession._nLanguage, "ReminderOViaEmail") + ": "));
				// Profile profile = Profile.find(rv._strV);
				// cell7.add(new TextField("ToEmail", profile.getEmail(teasession._nLanguage), 30));
				// row9.add(cell7);
				// Row row10 = new Row();
				// Cell cell8 = new Cell();
				// cell8.add(new Text(super.r.getString(teasession._nLanguage, "Memo") + ":"));
				// row10.add(cell8);
				// Row row11 = new Row();
				// Cell cell9 = new Cell();
				// cell9.add(new TextArea("Memo", "", 8, 60));
				// row11.add(cell9);
				// table2.add(row2);
				// table2.add(row3);
				// table2.add(row4);
				// table2.add(row5);
				// table2.add(row6);
				// table2.add(new Row(new Cell(new Text("<br>"))));
				// table2.add(row7);
				// table2.add(row8);
				// table2.add(row9);
				// table2.add(row10);
				// table2.add(row11);
				// form.add(table2);
				// form.add(new Button(super.r.getString(teasession._nLanguage, "Submit")));
				// PrintWriter printwriter2 = beginOut(response, teasession);
				// printwriter2.print(form);
				// printwriter2.print(new Languages(teasession._nLanguage, request));
				// endOut(printwriter2, teasession);

				return;
			}
			int j;
			Date date;
			Date date1;
			int i1;
			int k1;
			String s2;
			int l1;
			String s3;
			for (StringTokenizer stringtokenizer = new StringTokenizer(request.getParameter("Node"), " ,"); stringtokenizer.hasMoreTokens(); Reminder.create(rv, j, date, date1, i1, k1, s2, l1, s3))
			{
				j = Integer.parseInt(stringtokenizer.nextToken());
				if (j != 0 && !Node.isExisted(j))
				{
					outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidNodeNumber"));
					return;
				}
				if (j != 0 && Reminder.isExisted(rv, j))
				{
					int k = Reminder.find(rv, j);
					Table table = new Table();
					Row row = new Row();
					row.add(new Cell(new Text(super.r.getString(teasession._nLanguage, "AlreadyInReminders"))));
					table.add(row);
					PrintWriter printwriter = response.getWriter(); // beginOut(response, teasession);
					printwriter.print(table);
					printwriter.print(new Anchor("NewReminder", super.r.getCommandImg(teasession._nLanguage, "New")));
					printwriter.print(new Anchor("EditReminder?Reminder=" + k, super.r.getCommandImg(teasession._nLanguage, "Edit")));
					printwriter.print(new Anchor("Reminders", super.r.getCommandImg(teasession._nLanguage, "EditAll")));
					printwriter.print(new Languages(teasession._nLanguage, request));
					printwriter.close();
					return;
				}
				if (j != 0)
				{
					Node node = Node.find(j);
					String s1 = node.getCommunity();
					Community community = Community.find(s1);
					int j1 = community.getType();
					if (j1 == 0 && !Subscriber.isSubscriber(s1, teasession._rv))
					{
						outText(teasession, response, super.r.getString(teasession._nLanguage, "InvalidSubscriber"));
						return;
					}
				}
				date = TimeSelection.makeTime(teasession.getParameter("StartYear"), teasession.getParameter("StartMonth"), teasession.getParameter("StartDay"), teasession.getParameter("StartHour"), teasession.getParameter("StartMinute"));
				date1 = TimeSelection.makeTime(teasession.getParameter("StopYear"), teasession.getParameter("StopMonth"), teasession.getParameter("StopDay"), teasession.getParameter("StopHour"), teasession.getParameter("StopMinute"));
				i1 = Integer.parseInt(teasession.getParameter("DeltaTime"));
				k1 = Integer.parseInt(teasession.getParameter("RepeatTimes"));
				s2 = teasession.getParameter("ToEmail");
				l1 = 0;
				if (teasession.getParameter("ViaMessage") != null)
				{
					l1 += 2;
				}
				if (teasession.getParameter("ViaEmail") != null)
				{
					l1 += 4;
				}
				s3 = teasession.getParameter("Memo");
			}

			response.sendRedirect("Reminders");
			return;
		} catch (Exception exception)
		{
			response.sendError(400, exception.toString());
			exception.printStackTrace();
			return;
		}
	}
}
