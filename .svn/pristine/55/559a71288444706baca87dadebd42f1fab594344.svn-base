package tea.ui.admin;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import tea.ui.TeaServlet;
import tea.entity.admin.*;
import java.util.Date;

public class EditDayOrder extends TeaServlet
{

	// Initialize global variables //response.sendRedirect
	public void init() throws ServletException
	{
	}

	// Process the HTTP Get request
	public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		request.setCharacterEncoding("UTF-8");
		tea.ui.TeaSession teasession = null;
		teasession = new tea.ui.TeaSession(request);
		try
		{
			int begintime = Integer.parseInt(teasession.getParameter("begintime"));
			int begintime1 = Integer.parseInt(teasession.getParameter("begintime1"));
			int endtime = Integer.parseInt(teasession.getParameter("endtime"));
			int endtime1 = Integer.parseInt(teasession.getParameter("endtime1"));
			int affairtype = Integer.parseInt(teasession.getParameter("affairtype"));
			String affaircontent = teasession.getParameter("affaircontent");

			String year = teasession.getParameter("year");
			String month = teasession.getParameter("month");
			String date = teasession.getParameter("date");
			Date time = DayOrder.sdf.parse(year + "-" + month + "-" + date);

			int id = Integer.parseInt(teasession.getParameter("ids"));
			Date d = new Date();
			String member = teasession._rv.toString();// 当前用户

			java.util.Enumeration au_enumer = AdminUsrRole.find(teasession._strCommunity, "", 0, Integer.MAX_VALUE);

			// while(au_enumer.hasMoreElements())
			// {

			// int ida=((Integer)au_enumer.nextElement()).intValue();
			// String mm = ((String)au_enumer.nextElement());
			AdminUsrRole au_obj = AdminUsrRole.find(teasession._strCommunity, teasession._rv.toString());

			// if(member.equals(au_obj.getMember()))
			// {

			if (id > 0)
			{
				DayOrder obj = DayOrder.find(id);
				obj.set(begintime, begintime1, endtime, endtime1, affairtype, affaircontent, time, teasession._strCommunity, teasession._rv,0, 0);
			} else
			{
				DayOrder.create(begintime, begintime1, endtime, endtime1, affairtype, affaircontent, time, teasession._strCommunity, teasession._rv, 0, 0);
			}
			// }
			// }
			response.sendRedirect("/jsp/admin/flow/Affair.jsp?year=" + year + "&month=" + month + "&date=" + date);

		} catch (Exception ex)
		{
			ex.printStackTrace();

		}

	}

	// Clean up resources
	public void destroy()
	{
	}
}
