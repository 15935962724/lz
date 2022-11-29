package tea.ui.member.reminder;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import tea.entity.member.*;
import tea.resource.Resource;
import tea.ui.*;

public class DeleteReminders extends TeaServlet
{

	public void init(ServletConfig servletconfig) throws ServletException
	{
		super.init(servletconfig);
		super.r.add("tea/ui/member/reminder/DeleteReminders");
	}

	public DeleteReminders()
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
			tea.entity.RV rv = teasession._rv;
			String s = request.getRequestURI();
			boolean flag = s.substring(s.lastIndexOf("/") + 1).equals("DeleteAllReminders");
			if (flag)
			{
				Reminder.deleteAll(rv);
				response.sendRedirect("Reminders");
				return;
			}
			String as[] = request.getParameterValues("Reminders");
			if (as != null)
			{
				for (int i = 0; i < as.length; i++)
				{
					if (as[i] != null)
					{
						int j = Integer.parseInt((as[i]));
						Reminder reminder = Reminder.find(j);
						reminder.delete();
					}
				}
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
